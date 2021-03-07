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
WSLIDER (metadata, scalar) is the slider width in character units.
%%%% ¡default!
5

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
    
    pp_list{prop} = el.getPlotProp(prop, ...
        'BKGCOLOR', color);
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
    % see also redraw, slide, settings, uipanel, isgraphics.

    % initialization
    pl.f = draw@Plot(pl, ...
        'Visible', 'off', ...
        varargin{:}, ...
        'SizeChangedFcn', {@redraw} ...
        );
    function redraw(~, ~)
        pl.redraw()
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
            'Callback', {@slide} ...
            );
    end
    function slide(~, ~)
        pl.slide()
    end

    if isempty(pl.pp_list) || any(cellfun(@(x) ~isgraphics(x, 'uipanel'), pl.pp_list))
        pl.pp_list = cellfun(@(x) x.draw( ...
            'Parent', pl.p, ...
            'Units', 'character' ...
            ), ...
            pl.memorize('PP_DICT').getItems(), 'UniformOutput', false);
    end
    
    set(pl.f, ...
        'UserData', 'update', ... % calls update(), through redraw()
        'Visible', 'on' ... % calls redraw() and slide()
        )
    
    % output
    if nargout > 0
        h_panel = pl.f;
    end
end
function update(pl)
    %UPDATE updates the prop panels and their value.
    %
    % UPDATE(PL) updates the prop panels and their value.
    %
    % See also draw, redraw, slide.

    for prop = 1:1:pl.get('PP_DICT').length()
        pl.get('PP_DICT').getItem(prop).update()
    end
end
function redraw(pl)
    %RESIZE redraws the element graphical panel.
    %
    % RESIZE(PL) redraws (includign resizing) the plot PL.
    %
    % See also draw, update, slide.

    f = pl.f;
    pp_list = pl.pp_list;
    
    units = get(f, 'Units');
    set(f, 'Units', 'character')    

    if strcmpi(get(f, 'UserData'), 'ignore')
        set(f, 'UserData', [])
        return
    elseif strcmpi(get(f, 'UserData'), 'update')
        set(f, 'UserData', [])
        pl.update()
    end
    
    % redraw prop panels
    dw = pl.get('DW');   
    w_s = pl.get('WSLIDER');
    for prop = 1:1:length(pp_list)
        pl.get('PP_DICT').getItem(prop).redraw('Width', w(f) - 2 * dw - w_s)
    end
    
    % redraw panel and place prop panels
    dh = pl.get('DH');

    h_pp = cellfun(@(x) h(x), pp_list);
    x0_pp = dw;
    y0_pp = sum(h_pp + dh) - cumsum(h_pp + dh) + dh;

    % p, s
    h_p = sum(h_pp + dh) + dh;
    if h_p > h(f)
        for prop = 1:1:length(pp_list)
            pp = pp_list{prop};
            set(pp, 'Position', [x0_pp y0_pp(prop) w(pp) h(pp)])
        end
    else
        for prop = 1:1:length(pp_list)
            set(pp_list{prop}, 'Position', [x0_pp y0_pp(prop)+h(f)-h_p w(pp) h(pp)])
        end
    end    
    
    % slide and adjust panel
    pl.slide()
    
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
function slide(pl)
    %SLIDE slides the panel vertically.
    %
    % SLIDE(PL) slides the panel vertically, without redrawing the prop panels.
    %
    % See also draw, update, redraw.

    f = pl.f;
    p = pl.p;
	s = pl.s;
    pp_list = pl.pp_list;

    units = get(f, 'Units');
    set(f, 'Units', 'character')
    
    w_s = pl.get('WSLIDER');

    dh = pl.get('DH');
    h_pp = cellfun(@(x) h(x), pp_list);
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
    else
        set(p, 'Position', [0 0 w(f) h(f)])

        set(s, 'Visible', 'off')            
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
    'PROP_LOGICAL_M', true, ...
    'PROP_LOGICAL_P', false, ...
    'PROP_LOGICAL_D', false, ...
    'PROP_OPTION_M', 'two', ... 
    'PROP_OPTION_P', 'three', ...
    'PROP_OPTION_D', '', ...
    'PROP_CLASS_M', 'ETA', ...
    'PROP_CLASS_P', 'ETA', ...
    'PROP_CLASS_D', 'PlotElement', ...
    'PROP_CLASSLIST_M', {'ETA'}, ...
    'PROP_CLASSLIST_P', {'Element', 'ETA', 'PlotElement'}, ...
    'PROP_CLASSLIST_D', {}, ...
    'PROP_ITEM_M', ETA('PROP_STRING_M', 'ETA trial'), ...
    'PROP_ITEM_P', BrainRegion('ID', 'BR trial 2'), ...
    'PROP_ITEM_D', BrainRegion('ID', 'BR trial 3'), ...
    'PROP_ITEMLIST_M', {ETA('PROP_STRING_M', 'ETA trial 1'), ETA('PROP_STRING_M', 'ETA trial 2'), ETA('PROP_STRING_M', 'ETA trial 3')}, ...
    'PROP_ITEMLIST_P', {BrainRegion('ID', 'BR trial 1'), BrainRegion('ID', 'BR trial 2'), BrainRegion('ID', 'BR trial 3')}, ...
    'PROP_ITEMLIST_D', {}, ...
    'PROP_IDICT_M', IndexedDictionary('IT_CLASS', 'ETA', 'IT_KEY', 32), ...
    'PROP_IDICT_P', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', {BrainRegion('ID', 'BR trial A'), BrainRegion('ID', 'BR trial B'), BrainRegion('ID', 'BR trial C')}), ...
    'PROP_IDICT_D', IndexedDictionary(), ...
    'PROP_SCALAR_M', 1, ...
    'PROP_SCALAR_P', 3, ...
    'PROP_SCALAR_D', 10, ...
    'PROP_RVECTOR_M', ones(1, 10), ...
    'PROP_RVECTOR_P', zeros(1, 10), ...
    'PROP_RVECTOR_D', rand(1, 10), ...
    'PROP_CVECTOR_M', ones(10, 1), ...
    'PROP_CVECTOR_P', zeros(10, 1), ...
    'PROP_CVECTOR_D', rand(10, 1), ...
    'PROP_MATRIX_M', zeros(8,10), ...
    'PROP_MATRIX_P', randn(10), ...
    'PROP_MATRIX_D', rand(12), ...
    'PROP_SMATRIX_M', eye(4), ...
    'PROP_SMATRIX_P', randn(3), ...
    'PROP_SMATRIX_D', rand(5), ...
    'PROP_CELL_M', {randn(4), randn(4), randn(4); randn(4), randn(4), randn(4); randn(4), randn(4), randn(4)}, ...
    'PROP_CELL_P', {eye(10)}, ...
    'PROP_CELL_D', {randn(2), randn(2); randn(2), randn(2)} ...
    );

pl = PlotElement('EL', et);
pl.draw()

close(fig)