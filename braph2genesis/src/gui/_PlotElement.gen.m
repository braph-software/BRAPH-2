%% ¡header!
PlotElement < Plot (pl, plot element) is a plot of an element.

%%% ¡description!
PlotElement plots all properties of an element in a resizable scrollable panel.
The high-level graphical panel F has fixed dimensions and contains a scollable panel
(i.e., a panel P and a slider S). P contains a series of stacked property panels,
one for each property of the element EL being plotted.
Each time that F is resized or S scrolled, all contents of P are resized as well.

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
        case Format.SCALAR
            pp_list{prop} = PlotPropScalar( ...
                'ID', el.getPropTag(prop), ...
                'EL', el, ...
                'PROP', prop, ...
                'BKGCOLOR', color);            
        case Format.RVECTOR
            pp_list{prop} = PlotPropMatrix( ...
                'ID', el.getPropTag(prop), ...
                'EL', el, ...
                'PROP', prop, ...
                'BKGCOLOR', color);
        case Format.CVECTOR
            pp_list{prop} = PlotPropMatrix( ...
                'ID', el.getPropTag(prop), ...
                'EL', el, ...
                'PROP', prop, ...
                'BKGCOLOR', color);
        case Format.MATRIX
            pp_list{prop} = PlotPropMatrix( ...
                'ID', el.getPropTag(prop), ...
                'EL', el, ...
                'PROP', prop, ...
                'BKGCOLOR', color);
        case Format.SMATRIX
            pp_list{prop} = PlotPropMatrix( ...
                'ID', el.getPropTag(prop), ...
                'EL', el, ...
                'PROP', prop, ...
                'BKGCOLOR', color);
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
    
    pl.update()

    set(pl.f, 'Visible', 'on') % calls resize()
    
    % callbacks
    function resize(~, ~)
        pl.resize()
    end
    
    % output
    if nargout > 0
        h_panel = pl.f;
    end
end
function update(pl)

    for prop = 1:1:pl.get('PP_DICT').length()
        pl.get('PP_DICT').getItem(prop).update()
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

    if strcmpi(get(f, 'UserData'), 'ignore')
        set(f, 'UserData', [])
        return
    elseif strcmpi(get(f, 'UserData'), 'update')
        set(f, 'UserData', [])
        pl.update()
    end
    
    units = get(f, 'Units');
    set(f, 'Units', 'character')
    
    dw = pl.get('DW');
    dh = pl.get('DH');
    w_s = 5; % defines slider width

    % prop panels
    for prop = 1:1:length(pp_list)
        pl.get('PP_DICT').getItem(prop).resize()
    end
    w_pp = w(f) - 2 * dw - w_s;
    h_pp = cellfun(@(x) h(x), pp_list);
    x0_pp = dw;
    y0_pp = sum(h_pp + dh) - cumsum(h_pp + dh) + dh;

    % p, s
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
            set(pp_list{prop}, 'Position', [x0_pp y0_pp(prop) w_pp h_pp(prop)])
        end
    else
        set(p, 'Position', [0 0 w(f) h(f)])

        set(s, 'Visible', 'off')            

        for prop = 1:1:length(pp_list)
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

et = ETA( ...
    'PROP_STRING_M', 'mmm', ...
    'PROP_STRING_P', 'ppp', ...
    'PROP_STRING_D', 'ddd', ...
    'PROP_SCALAR_M', 1, ...
    'PROP_SCALAR_P', 3, ...
    'PROP_SCALAR_D', 10, ...
    'PROP_RVECTOR_M', ones(1, 10), ...
    'PROP_RVECTOR_P', zeros(1, 10), ...
    'PROP_CVECTOR_D', rand(1, 10), ...
    'PROP_CVECTOR_M', ones(10, 1), ...
    'PROP_CVECTOR_P', zeros(10, 1), ...
    'PROP_RVECTOR_D', rand(10, 1), ...
    'PROP_MATRIX_M', zeros(8,10), ...
    'PROP_MATRIX_P', randn(10), ...
    'PROP_MATRIX_D', rand(12), ...
    'PROP_SMATRIX_M', eye(4), ...
    'PROP_SMATRIX_P', randn(3), ...
    'PROP_SMATRIX_D', rand(5) ...
    );

pl = PlotElement('EL', et);
pl.draw()
% pl.settings()

% close(fig)