%% ¡header!
PlotElement < Plot (pl, plot element) is a plot of an element.

%%% ¡description!
PlotElement plots all properties of an element in a resizable scrollable panel.

%%% ¡seealso!
GUI, PlotProp

%% ¡props!

%%% ¡prop!
DW (metadata, scalar) is the margin along the width in character units.
%%%% ¡default!
1

%%% ¡prop!
DH (metadata, scalar) is the margin along the height in character units.
%%%% ¡default!
.5

%%% ¡prop!
MCOLOR (metadata, rvector) is background color of the metadata properties.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
[.87 .95 .85]

%%% ¡prop!
PCOLOR (metadata, rvector) is background color of the parameter properties.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
[.86 .92 .97]

%%% ¡prop!
DCOLOR (metadata, rvector) is background color of the data properties.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
[1 .96 .79]

%%% ¡prop!
RCOLOR (metadata, rvector) is background color of the result properties.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
[1 .89 .84]

%%% ¡prop!
EL (metadata, item) is the element to be plotted.

%%% ¡prop!
PP_DICT (result, idict) is a dictionary of the property plots.
%%%% ¡settings!
'PlotProp'
%%%% ¡calculate!
el = pl.get('EL');
pp_list = cell(1, el.getPropNumber());
for prop = 1:1:el.getPropNumber()
    switch el.getPropCategory(prop)
        case Category.METADATA
            color = pl.get('MCOLOR');
        case Category.PARAMETER
            color = pl.get('PCOLOR');
        case Category.DATA
            color = pl.get('DCOLOR');
        case Category.RESULT
            color = pl.get('RCOLOR');
    end
    
    switch el.getPropFormat(prop)
%         case Format.EMPTY
        case Format.STRING
            pp_list{prop} = PlotPropString( ...
                'ID', el.getPropTag(prop), ...
                'EL', el, ...
                'PROP', prop, ...
                'BKGCOLOR', color);
%         case Format.LOGICAL
%         case Format.OPTION
%         case Format.CLASS
%         case Format.CLASSLIST
%         case Format.ITEM
%         case Format.ITEMLIST
%         case Format.IDICT
%         case Format.SCALAR
%         case Format.RVECTOR
%         case Format.CVECTOR
%         case Format.MATRIX
%         case Format.SMATRIX
%         case Format.CELL
        otherwise
            pp_list{prop} = PlotProp( ...
                'ID', el.getPropTag(prop), ...
                'EL', el, ...
                'PROP', prop, ...
                'BKGCOLOR', color);
    end            
end
value = IndexedDictionary( ...
    'ID', el.tostring(), ...
    'IT_CLASS', 'PlotProp', ...
    'IT_KEY', 1, ...
    'IT_LIST', pp_list ...
    );

%% ¡properties!
f % handle for outer panel
p % handle for scrollable
s % handle for slider
pp_list % list of handles for prop panels

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the element graphical panel.
    %
    % DRAW(PL) draws the element graphical panel.
    %
    % H = DRAW(PL) returns a handle to the element graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also resize, settings, uipanel, isgraphics.

    % initialization
    pl.f = draw@Plot(pl, ...
        'Visible', 'off', ...
        varargin{:}, ...
        'SizeChangedFcn', {@resize} ...
        );

    function resize(~, ~)
        pl.resize()
    end

    if isempty(pl.p) || ~isgraphics(pl.p, 'uipanel')
        pl.p = uipanel( ...
            'Parent', pl.f, ...
            'Units', 'character', ...
            'BackgroundColor', pl.get('BKGCOLOR'), ...
            'BorderType', 'none' ...
            );
    end

    if isempty(pl.s) || ~isgraphics(pl.s, 'slider')    
        pl.s = uicontrol( ...
            'Style', 'slider', ...
            'Parent', pl.f, ....
            'Units', 'character', ...
            'Min', -eps, ...
            'Max', 0, ...
            'Value', 0, ...            
            'Callback', {@resize} ...
            );
    end

    if isempty(pl.pp_list) || any(cellfun(@(x) ~isgraphics(x, 'uipanel'), pl.pp_list))
        pl.pp_list = cellfun(@(x) x.draw( ...
            'Parent', pl.p, ...
            'Units', 'character' ...
            ), ...
            pl.memorize('PP_DICT').getItems(), 'UniformOutput', false);
    end

    set(pl.f, 'Visible', 'on')
    
    % output
    if nargout > 0
        h_panel = pl.f;
    end
end
function resize(pl)
    %RESIZE resizes the element graphical panel.
    %
    % RESIZE(PL) resizes the plot PL.
    %
    % See also draw.

    f = pl.f;
    p = pl.p;
	s = pl.s;
    pp_list = pl.pp_list;

    units = get(f, 'Units');
    set(f, 'Units', 'character')
    
    dw = pl.get('DW');
    dh = pl.get('DH');
    w_s = 5; % defines slider width

    w_pp = w(f) - 2 * dw - w_s;
    h_pp = cellfun(@(x) h(x), pp_list);
    x0_pp = dw;
    y0_pp = sum(h_pp + dh) - cumsum(h_pp + dh) + dh;

    h_p = sum(h_pp + dh) + dh;
    if h_p > h(f)
        offset = get(s, 'Value');
        set(p, 'Position', [0 h(f)-h_p-offset w(f) h_p])

        set(s, ...
            'Position', [w(f)-w_s 0 w_s h(f)], ...
            'Visible', 'on', ...
            'Min', h(f) - h(p), ...
            'Value', max(get(s, 'Value'), h(f) - h(p)) ...
            );

        for prop = 1:1:length(pp_list)
            pl.get('PP_DICT').getItem(prop).resize()
            set(pp_list{prop}, 'Position', [x0_pp y0_pp(prop) w_pp h_pp(prop)])
        end
    else
        set(p, 'Position', [0 0 w(f) h(f)])

        set(s, 'Visible', 'off')            

        for prop = 1:1:length(pp_list)
            pl.get('PP_DICT').getItem(prop).resize()
            set(pp_list{prop}, 'Position', [x0_pp y0_pp(prop)+h(f)-h_p w_pp h_pp(prop)])
        end
    end
    
    set(f, 'Units', units)
    
    % auxiliary functions
    function r = x0(h)
        r = Plot.x0(h);
    end
    function r = y0(h)
        r = Plot.y0(h);
    end
    function r = w(h)
        r = Plot.w(h);
    end
    function r = h(h)
        r = Plot.h(h);
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
fig = figure();

et = ETA();
pl = PlotElement('EL', et);
pl.draw()
pl.settings()

% close(fig)