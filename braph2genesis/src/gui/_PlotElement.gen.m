%% ¡header!
PlotElement < Plot (pe, plot element) is a plot of an element.

%%% ¡description!
PlotElement plots all properties of an element in a resizable scrollable panel.
 The high-level parent panel PP has fixed dimensions and contains a scollable panel
 (i.e., a panel P and a slider S). P contains a series of stacked property panels,
 one for each property of the element EL being plotted.
 Each time that PP is resized or S scrolled, all contents of P are resized as well.

Importnat notes:
1. The key methods that need to be called are draw() and reinit().
2. The methods update(), redraw() and slide() are used internally by PlotElement 
  and typically do not need to be called explicitly.

CONSTRUCTOR - To construct a PlotElement use the constructor:

    pe = PlotElement(''EL'', <element>)
    
DRAW - To create the element panel, call pe.draw():

    pp = pe.<strong>draw</strong>();
    pp = pe.<strong>draw</strong>(''Parent'', f);
 
 Here, pp is the parent panel (see above).
 Typically, f is a figure where the parent panel is plotted.
 It is also possible to use pr.draw() to get the parent panel handle
  and to set its properties (as in the case of Plot and PlotProp).

REINIT - To reinitialize the element plot with a new element, call:

    pe.reinit(<new element>)

 This function resets both the element and the panel using the new element.
 Importnatly, the new element must be of exactly the same class as the old element.


CALLBACK - This is a callback function:

    pe.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the element panel and its dependent figures
    pe.<strong>cb_hide</strong>() - hides the figure with the element panel and its dependent figures
    pe.<strong>cb_close</strong>() - closes the figure with the element panel and its dependent figures
 
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
BRAPH2.COL_M

%%% ¡prop!
PCOLOR (metadata, rvector) is background color of the parameter properties.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
BRAPH2.COL_P

%%% ¡prop!
DCOLOR (metadata, rvector) is background color of the data properties.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
BRAPH2.COL_D

%%% ¡prop!
RCOLOR (metadata, rvector) is background color of the result properties.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
BRAPH2.COL_R

%%% ¡prop!
EL (metadata, item) is the element to be plotted.

%%% ¡prop!
PR_DICT (result, idict) is a dictionary of the property plots.
%%%% ¡settings!
'PlotProp'
%%%% ¡calculate!
el = pe.get('EL');

[order, title, visible] = load_layout(el);
number_visible_prop = sum(visible);

pr_list = cell(1, number_visible_prop);
for prop = 1:1:el.getPropNumber()
    if visible(prop)
        switch el.getPropCategory(prop)
            case Category.METADATA
                color = pe.get('MCOLOR');
            case Category.PARAMETER
                color = pe.get('PCOLOR');
            case Category.DATA
                color = pe.get('DCOLOR');
            case Category.RESULT
                color = pe.get('RCOLOR');
        end

        pr_list{order(prop)} = el.getPlotProp(prop, ...
            'ID', el.getPropTag(prop), ...
            'TITLE', title{prop}, ...
            'BKGCOLOR', color);
    end
end

value = IndexedDictionary( ...
    'ID', el.tostring(), ...
    'IT_CLASS', 'PlotProp', ...
    'IT_KEY', 1, ...
    'IT_LIST', pr_list ...
    );

%% ¡properties!
pp % handle for outer (parent) panel
p % handle for scrollable panel
s % handle for slider
pr_list % list of handles for prop panels

%% ¡methods!
function h_panel = draw(pe, varargin)
    %DRAW draws the element panel.
    %
    % DRAW(PE) draws the element parent panel, which contains a panel that
    %  is crollable using a slider.
    %
    % H = DRAW(PE) returns a handle to the element parent panel.
    %
    % DRAW(PE, 'Property', VALUE, ...) sets the properties of the parent
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the parent panel.
    %
    % See also update, redraw, slide, reinit, uipanel.

    % initialization
    pe.pp = draw@Plot(pe, ...
        'Visible', 'off', ...
        varargin{:}, ...
        'SizeChangedFcn', {@redraw} ...
        );
    function redraw(~, ~)
        pe.redraw()
    end

    if ~check_graphics(pe.p, 'uipanel')
        pe.p = uipanel( ...
            'Parent', pe.pp, ...
            'Tag', 'scrollable panel', ...
            'Units', 'character', ...
            'BackgroundColor', pe.get('BKGCOLOR'), ...
            'BorderType', 'none' ...
            );
    end

    if isempty(pe.s) || ~isgraphics(pe.s, 'uicontrol') || ~strcmpi(get(pe.s, 'Style'), 'slider')
        pe.s = uicontrol( ...
            'Style', 'slider', ...
            'Tag', 'scrollable panel slider', ...
            'Parent', pe.pp, ....
            'Units', 'character', ...
            'Min', -eps, ...
            'Max', 0, ...
            'Value', 0, ...            
            'Callback', {@slide} ...
            );
    end
    function slide(~, ~)
        pe.slide()
    end

    if isempty(pe.pr_list) || any(cellfun(@(x) ~check_graphics(x, 'uipanel'), pe.pr_list))
        pe.pr_list = cellfun(@(x) x.draw( ...
            'Parent', pe.p, ...
            'Units', 'character' ...
            ), ...
            pe.memorize('PR_DICT').getItems(), 'UniformOutput', false);
    end

    pe.update()
    set(pe.pp, 'Visible', 'on') % calls also redraw() and slide()
    
    % output
    if nargout > 0
        h_panel = pe.pp;
    end
end
function update(pe)
    %UPDATE updates the content of the prop panels and their graphical objects.
    %
    % UPDATE(PE) updates the content of the prop panels and their graphical objects.
    %
    % Important note:
    % 1. UPDATE() does not need to be explicitly called from outside code,
    %  as it is called internally by PlotElement when needed.
    %
    % See also draw, redraw, slide.

    for prop = 1:1:pe.get('PR_DICT').length()
        pe.get('PR_DICT').getItem(prop).update()
    end
end
function redraw(pe)
    %RESIZE resizes, repositions and slides the prop panels.
    %
    % RESIZE(PE) resizes the property panels and repositions their
    %  graphical objects, and slides the element panel.
    %
    % Important note:
    % 1. REDRAW() does not need to be explicitly called from outside code,
    %  as it is called internally by PlotElement when needed.
    %
    % See also draw, update, slide.

    pp = pe.pp;
    pr_list = pe.pr_list;
    
    % redraw prop panels
    dw = pe.get('DW');   
    w_s = pe.get('WSLIDER');
    for prop = 1:1:length(pr_list)
        pe.get('PR_DICT').getItem(prop).redraw('Width', w(pp) - 2 * dw - w_s)
    end
    
    % redraw panel and place prop panels
    dh = pe.get('DH');

    h_pp = cellfun(@(x) h(x), pr_list);
    x0_pp = dw;
    y0_pp = sum(h_pp + dh) - cumsum(h_pp + dh) + dh;

    % p, s
    h_p = sum(h_pp + dh) + dh;
    if h_p > h(pp)
        for prop = 1:1:length(pr_list)
            pr = pr_list{prop};
            set(pr, 'Position', [x0_pp y0_pp(prop) w(pr) h(pr)])
        end
    else
        for prop = 1:1:length(pr_list)
            pr = pr_list{prop};
            set(pr, 'Position', [x0_pp y0_pp(prop)+h(pp)-h_p w(pr) h(pr)])
        end
    end    
    
    % slide and adjust panel
    pe.slide()
    
    % auxiliary functions
    function r = x0(h)
        r = Plot.x0(h, 'characters');
    end
    function r = y0(h)
        r = Plot.y0(h, 'characters');
    end
    function r = w(h)
        r = Plot.w(h, 'characters');
    end
    function r = h(h)
        r = Plot.h(h, 'characters');
    end
end
function slide(pe)
    %SLIDE slides the panel vertically.
    %
    % SLIDE(PE) slides the panel vertically, without redrawing the prop panels.
    %
    % Important note:
    % 1. SLIDE() does not need to be explicitly called from outside code,
    %  as it is called internally by PlotElement when needed.
    %
    % See also draw, update, redraw.

    pp = pe.pp;
    p = pe.p;
	s = pe.s;
    pr_list = pe.pr_list;

    w_s = pe.get('WSLIDER');

    dh = pe.get('DH');
    h_pp = cellfun(@(x) h(x), pr_list);
    h_p = sum(h_pp + dh) + dh;

    if h_p > h(pp)
        offset = get(s, 'Value');
        set(p, 'Position', [0 h(pp)-h_p-offset w(pp) h_p])

        set(s, ...
            'Position', [w(pp)-w_s 0 w_s h(pp)], ...
            'Visible', 'on', ...
            'Min', h(pp) - h(p), ...
            'Value', max(get(s, 'Value'), h(pp) - h(p)) ...
            );
    else
        set(p, 'Position', [0 0 w(pp) h(pp)])

        set(s, 'Visible', 'off')            
    end
    
    % auxiliary functions
    function r = x0(h)
        r = Plot.x0(h, 'characters');
    end
    function r = y0(h)
        r = Plot.y0(h, 'characters');
    end
    function r = w(h)
        r = Plot.w(h, 'characters');
    end
    function r = h(h)
        r = Plot.h(h, 'characters');
    end
end
function reinit(pe, el)
    %REINIT resets the element, updates and redraws the element plot.
    %
    % REINIT(PE, EL) reinitializes the plot element.Specifically:
    %  1. sets EL as the new element of the PlotElement
    %  2. reinizalizes PR_DICT
    %  3. deletes all prop panels
    %  4. draws anew, updates and redraws
    % 
    % Important note:
    % 1. EL must be of the same class as the previous element in the
    %  PlotElement, otherwise an error is thrown.
    %  Error id: [BRAPH2:PlotElement:WrongInput].
    %
    % See also update, draw, redraw.

    assert( ...
        strcmp(pe.get('EL').getClass(), el.getClass()), ...
        [BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT ' ' ...
        'The class of the new element (' el.getClass() ') must be exactly the same as that of the old element (' pe.get('EL').getClass() ').'] ...
        )    

    pe.set('EL', el)
    pe.set('PR_DICT', NoValue.getNoValue())

    delete(get(pe.p, 'Children'))

    pe.draw()
    pe.update()
    pe.redraw()
end
function cb_bring_to_front(pe)
    %CB_BRING_TO_FRONT brings to front the figure with the element panel and its dependent figures.
    %
    % CB_BRING_TO_FRONT(PE) brings to front the figure with the element and
    %  its dependent figures by calling the methods cb_bring_to_front() for
    %  all the PlotProp panels of the PlotElement.
    %  
    % Note that it will draw a new the figure if the element panel is
    %  currently not plotted. 
    %
    % See also cb_hide, cb_close.

    pe.cb_bring_to_front@Plot();
    
    pr_dict = pe.get('PR_DICT');
    for prop = 1:1:pr_dict.length()
        pr = pr_dict.getItem(prop);
        pr.cb_bring_to_front()
    end
end
function cb_hide(pe)
    %CB_HIDE hides the figure with the element panel and its dependent figures.
    %
    % CB_HIDE(PE) hides the figure with the element panel and its dependent figures 
    %  by calling the methods cb_hide() for all the PlotProp panels of the PlotElement.
    %  
    % See also cb_bring_to_front, cb_close.

    pe.cb_hide@Plot();
    
    pr_dict = pe.get('PR_DICT');
    for prop = 1:1:pr_dict.length()
        pr = pr_dict.getItem(prop);
        pr.cb_hide()
    end
end
function cb_close(pe)
    %CB_CLOSE closes the figure with the element panel and its dependent figures.
    %
    % CB_CLOSE(PE) closes the figure with the element panel and its dependent figures 
    %  by calling the methods cb_close() for all the PlotProp panels of the PlotElement.
    %  
    % See also cb_bring_to_front, cb_hide.

    pe.cb_close@Plot();
    
    pr_dict = pe.get('PR_DICT');
    for prop = 1:1:pr_dict.length()
        pr = pr_dict.getItem(prop);
        pr.cb_close()
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
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
    'PROP_ITEM_P', ETB('ID', 'BR trial 2'), ...
    'PROP_ITEM_D', ETB('ID', 'BR trial 3'), ...
    'PROP_ITEMLIST_M', {ETA('PROP_STRING_M', 'ETA trial 1'), ETA('PROP_STRING_M', 'ETA trial 2'), ETA('PROP_STRING_M', 'ETA trial 3')}, ...
    'PROP_ITEMLIST_P', {ETB('ID', 'BR trial 1'), ETB('ID', 'BR trial 2'), ETB('ID', 'BR trial 3')}, ...
    'PROP_ITEMLIST_D', {}, ...
    'PROP_IDICT_M', IndexedDictionary('IT_CLASS', 'ETA', 'IT_KEY', 32), ...
    'PROP_IDICT_P', IndexedDictionary('IT_CLASS', 'ETB', 'IT_LIST', {ETB('ID', 'BR trial A'), ETB('ID', 'BR trial B'), ETB('ID', 'BR trial C')}), ...
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

pe = PlotElement('EL', et);
pe.draw()

close(fig)

%%% ¡test!
%%%% ¡name!
Callbacks
%%%% ¡code!
pe = PlotElement('EL', ETA());
pe.draw()
pe.cb_hide()
pe.cb_bring_to_front()
pe.cb_close()
