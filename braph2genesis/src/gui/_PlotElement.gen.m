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
    f = draw@Plot(pl, varargin{:}, 'SizeChangedFcn', {@resize});

    if isempty(pl.p) || ~isgraphics(pl.p, 'uipanel')
        pl.p = uipanel('Parent', f);
    end

    if isempty(pl.s) || ~isgraphics(pl.s, 'slider')    
        pl.s = uicontrol( ...
            'Style', 'slider', ...
            'Parent', f, ....
            'Min', -eps, ...
            'Max', 0, ...
            'Value', 0, ...            
            'Callback', {@resize} ...
            );
    end

    if isempty(pl.pp_list) || any(cellfun(@(x) ~isgraphics(x, 'uipanel'), pl.pp_list))
        pl.pp_list = cellfun(@(x) x.draw('Parent', pl.p), pl.memorize('PP_DICT').getItems(), 'UniformOutput', false);
    end
        
    resize()

    function resize(~, ~)
        pl.resize()
    end

    % output
    if nargout > 0
        h_panel = f;
    end
end
function resize(pl)
    %RESIZE resizes the element graphical panel.
    %
    % RESIZE(PL) resizes the plot PL.
    %
    % See also draw.

    f = get(pl.p, 'Parent');
    p = pl.p;
	s = pl.s;
    pp_list = pl.pp_list;

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
        set(p, ...
            'Units', 'character', ...
            'Position', [0 h(f)-h_p-offset w(f) h_p], ...
            'BackgroundColor', pl.get('BKGCOLOR'), ...
            'BorderType', 'none' ...
            );

        set(s, ...
            'Units', 'character', ...
            'Position', [w(f)-w_s 0 w_s h(f)], ...
            'Visible', 'on', ...
            'Min', h(f) - h(p), ...
            'Value', max(get(s, 'Value'), h(f) - h(p)) ...
            );

        for prop = 1:1:length(pp_list)
            set(pp_list{prop}, ...
                'Units', 'character', ...
                'Position', [x0_pp y0_pp(prop) w_pp h_pp(prop)] ...
                )
        end
    else
        set(p, ...
            'Units', 'character', ...
            'Position', [0 0 w(f) h(f)], ...
            'BackgroundColor', pl.get('BKGCOLOR'), ...
            'BorderType', 'none' ...
            );

        set(s, 'Visible', 'off')            

        for prop = 1:1:length(pp_list)
            set(pp_list{prop}, ...
                'Units', 'character', ...
                'Position', [x0_pp y0_pp(prop)+h(f)-h_p w_pp h_pp(prop)] ...
                )
        end
    end
    
    % auxiliary functions
    function r = x0(h)
        r = PlotElement.x0(h);
    end
    function r = y0(h)
        r = PlotElement.y0(h);
    end
    function r = w(h)
        r = PlotElement.w(h);
    end
    function r = h(h)
        r = PlotElement.h(h);
    end
end

%% ¡staticmethods!
function r = x0(h)
    %X0 returns the position of the left edge of a graphical element in character units.
    %
    % R = X0(H) is the distance from the inner left edge of the parent
    %  container to the outer left edge of the graphical element H.
    % 
    % See also y0, w, h.

    units = get(h, 'Units');
    set(h, 'Units', 'character')
    r = x0@Plot(h);
    set(h, 'Units', units)
end
function r = y0(h)
    %Y0 returns the position of the bottom edge of a graphical element in character units.
    %
    % R = Y0(H) is the distance from the inner bottom edge of the parent 
    %  container to the outer bottom edge of the graphical element H.
    %
    % See also x0, w, h.

    units = get(h, 'Units');
    set(h, 'Units', 'character')
    r = y0@Plot(h);
    set(h, 'Units', units)
end
function r = w(h)
    %W returns the width of a graphical element in character units.
    %
    % R = W(H) is the distance between the right and left outer edges of the
    %   graphical element H.
    % 
    % See also x0, y0, h.

    units = get(h, 'Units');
    set(h, 'Units', 'character')
    r = w@Plot(h);
    set(h, 'Units', units)
end
function r = h(h)
    %H returns the height of a graphical element in character units.
    %
    % R = H(H) is the distance between the top and bottom outer edges of the
    %  graphical element H.
    % 
    % See also x0, y0, w.

    units = get(h, 'Units');
    set(h, 'Units', 'character')
    r = h@Plot(h);
    set(h, 'Units', units)
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