%% ¡header!
PanelElement < Panel (pe, panel element) plots the panel of an element.

%%% ¡description!
PanelElement plots all properties of an element in a panel P, 
 which contains a series of stacked property panels,
 one for each property of the element EL being plotted.

Importnat notes:
1. The key methods that need to be called are draw() and reinit().
2. The methods update() and redraw() are used internally by PanelElement 
  and typically do not need to be called explicitly.

CONSTRUCTOR - To construct a PanelElement use the constructor:

    pe = PanelElement(''EL'', <element>)
    
DRAW - To create the element panel, call pe.draw():

    p = pe.<strong>draw</strong>();
    p = pe.<strong>draw</strong>(''Parent'', f);
 
 Typically, f is a figure where the panel is plotted.
 It is also possible to use pe.draw() to get the parent panel handle
  and to set its properties (as in the case of Panel and PanelProp).

REINIT - To reinitialize the element plot with a new element, call:

    pe.reinit(<new element>)

 This function resets both the element and the panel using the new element.
 Importantly, the new element must be of exactly the same class as the old element.

CALLBACK - These are the callback functions:

    pe.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the element panel and its dependent figures
    pe.<strong>cb_hide</strong>() - hides the figure with the element panel and its dependent figures
    pe.<strong>cb_close</strong>() - closes the figure with the element panel and its dependent figures

%%% ¡seealso!
GUI, GUIElement, PanelProp

%% ¡props!

%%% ¡prop!
EL (metadata, item) is the element to be plotted.

%%% ¡prop!
PR_DICT (result, idict) is a dictionary of the property plots.
%%%% ¡settings!
'PanelProp'
%%%% ¡calculate!
el = pe.get('EL');

[order, title, visible] = load_layout(el);
number_visible_prop = sum(visible);

pr_list = cell(1, number_visible_prop);
for prop = 1:1:el.getPropNumber()
    if visible(prop)
        switch el.getPropCategory(prop)
            case Category.METADATA
                color = BRAPH2.COL_M;
            case Category.PARAMETER
                color = BRAPH2.COL_P;
            case Category.DATA
                color = BRAPH2.COL_D;
            case Category.RESULT
                color = BRAPH2.COL_R;
            case Category.FIGURE
                color = BRAPH2.COL_F;
            case Category.GUI
                color = BRAPH2.COL_G;
        end

        pr_list{order(prop)} = el.getPanelProp(prop, ...
            'ID', el.getPropTag(prop), ...
            'TITLE', title{prop}, ...
            'BKGCOLOR', color);
    end
end

value = IndexedDictionary( ...
    'ID', el.tostring(), ...
    'IT_CLASS', 'PanelProp', ...
    'IT_KEY', 1, ...
    'IT_LIST', pr_list ...
    );

%%% ¡prop!
DW (gui, size) is the margin along the width in pixels.
%%%% ¡default!
5

%%% ¡prop!
DH (gui, size) is the margin along the height in pixels.
%%%% ¡default!
5

%%% ¡prop!
WSLIDER (gui, size) is the slider width in pixels.
%%%% ¡default!
12

%%% ¡prop!
MIN_WIDTH (gui, size) is the minimal panel width in pixels.
%%%% ¡default!
300

%% ¡properties!
p % handle for scrollable panel
pr_list % list of handles for prop panels

%% ¡methods!
function p_out = draw(pe, varargin)
    %DRAW draws the element panel.
    %
    % DRAW(PE) draws the element panel.
    %
    % P = DRAW(PE) returns a handle to the element parent panel.
    %
    % DRAW(PE, 'Property', VALUE, ...) sets the properties of the parent
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the parent panel.
    %
    % See also update, redraw, reinit, uipanel.

    pe.p = draw@Panel(pe, ...
        varargin{:}, ...
        'AutoResizeChildren', 'off' ...
        );

    if isempty(pe.pr_list) || any(cellfun(@(x) ~check_graphics(x, 'uipanel'), pe.pr_list))
        pe.pr_list = cellfun(@(x) x.draw('Parent', pe.p), pe.memorize('PR_DICT').getItems(), 'UniformOutput', false);
    end

    pe.update()
    pe.redraw()    
    
    % output
    if nargout > 0
        p_out = pe.p;
    end
end
function update(pe)
    %UPDATE updates the content of the prop panels and their graphical objects.
    %
    % UPDATE(PE) updates the content of the prop panels and their graphical objects.
    %
    % Important note:
    %  UPDATE() does not need to be explicitly called from outside code,
    %  as it is called internally by PanelElement when needed.
    %
    % See also draw, redraw.

    for prop = 1:1:pe.get('PR_DICT').length()
        pe.get('PR_DICT').getItem(prop).update()
    end
end
function redraw(pe, varargin)
    %REDRAW resizes and repositions the prop panels.
    %
    % REDRAW(PE) resizes the property panels and repositions their graphical objects.
    %
    % REDRAW(PL, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT is set automatically
    % 
    % Important note:
    %  REDRAW() does not need to be explicitly called from outside code,
    %  as it is called internally by PanelElement when needed.
    %
    % See also draw, update.

    p = pe.p;
    pr_list = pe.pr_list;

    % get panel (p) position
    % repositions the panel
    x0_p = ceil(get_from_varargin(x0(p, 'pixels'), 'X0', varargin));
    y0_p = ceil(get_from_varargin(y0(p, 'pixels'), 'Y0', varargin));
    w_p = ceil(max(get_from_varargin(w(p, 'pixels'), 'Width', varargin), pe.get('MIN_WIDTH')));
    % h_p will be calculated later
    
    % graphics constants
    dh = ceil(pe.get('DH') * BRAPH2.S);
    dw = ceil(pe.get('DW') * BRAPH2.S);
    w_s = ceil(pe.get('WSLIDER') * BRAPH2.S);

    % redraw prop panels (following update)
    w_pp = w_p - 2 * dw - w_s;
    for prop = 1:1:length(pr_list)
        pe.get('PR_DICT').getItem(prop).redraw('Width', w_pp)
    end
    
    % calculate position prop panels (pp)
    x0_pp = dw;
    h_pp = cellfun(@(x) h(x, 'pixels'), pr_list);
    y0_pp = sum(h_pp + dh) - cumsum(h_pp + dh) + dh;
    
    % reposition prop panels
    for prop = 1:1:length(pr_list)
        pr = pr_list{prop};
        set(pr, 'Position', [x0_pp y0_pp(prop) w(pr) h(pr)])
    end
    
    % calculate and set height panel (p)
    h_p = sum(h_pp + dh) + dh;

    set(p, ...
        'Units', 'pixels', ...
        'Position', [x0_p y0_p w_p h_p] ...
        )
end
function reinit(pe, el)
    %REINIT resets the element, and updates and redraws the element plot.
    %
    % REINIT(PE, EL) reinitializes the plot element.Specifically:
    %  1. sets EL as the new element of the PanelElement
    %  2. reinizalizes PR_DICT
    %  3. deletes all prop panels
    %  4. draws anew, updates and redraws
    % 
    % Important note:
    %  EL must be of the same class as the previous element in the
    %  PanelElement, otherwise an error is thrown.
    %  Error id: [BRAPH2:PanelElement:WrongInput].
    %
    % See also update, draw, redraw.

    assert( ...
        strcmp(pe.get('EL').getClass(), el.getClass()), ...
        [BRAPH2.STR ':PanelElement:' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':PanelElement:' BRAPH2.WRONG_INPUT ' ' ...
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
    %  all the PanelProp panels of the PanelElement.
    %  
    % Note that it will draw a new the figure if the element panel is currently not plotted. 
    %
    % See also cb_hide, cb_close.

    pe.cb_bring_to_front@Panel();
    
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
    %  by calling the methods cb_hide() for all the PanelProp panels of the PanelElement.
    %  
    % See also cb_bring_to_front, cb_close.

    pe.cb_hide@Panel();
    
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
    %  by calling the methods cb_close() for all the PanelProp panels of the PanelElement.
    %  
    % See also cb_bring_to_front, cb_hide.

    pe.cb_close@Panel();
    
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
fig1 = uifigure('Scrollable', 'on', 'AutoResizeChildren', 'off');
b2 = BRAPH2Constants();
pe1 = PanelElement('EL', b2);
set(fig1, 'SizeChangedFcn', 'pe1.redraw(''Width'', w(fig1, ''pixels''))')
p1 = pe1.draw('Parent', fig1, 'Units', 'pixels', 'Position', [0 0 w(fig1, 'pixels') h(fig1, 'pixels')], 'BackgroundColor', 'k');
close(fig1)

fig2 = uifigure('Scrollable', 'on');
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
    'PROP_CLASS_D', 'PanelElement', ...
    'PROP_CLASSLIST_M', {'ETA'}, ...
    'PROP_CLASSLIST_P', {'Element', 'ETA', 'PanelElement'}, ...
    'PROP_CLASSLIST_D', {}, ...
    'PROP_ITEM_M', ETA('PROP_STRING_M', 'ETA trial'), ...
    'PROP_ITEM_P', ETB('ID', 'BR trial 2'), ...
    'PROP_ITEM_D', ETB('ID', 'BR trial 3'), ...
    'PROP_ITEMLIST_M', {ETA('PROP_STRING_M', 'ETA trial 1'), ETA('PROP_STRING_M', 'ETA trial 2'), ETA('PROP_STRING_M', 'ETA trial 3')}, ...
    'PROP_ITEMLIST_P', {ETB('ID', 'BR trial 1'), ETB('ID', 'BR trial 2'), ETB('ID', 'BR trial 3')}, ...
    'PROP_ITEMLIST_D', {}, ...
    'PROP_IDICT_M', IndexedDictionary('IT_CLASS', 'ETA', 'IT_KEY', ETA.getPropProp('PROP_STRING_D')), ...
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
pe2 = PanelElement('EL', et);
p2 = pe2.draw('Parent', fig2);
close(fig2)

%%% ¡test!
%%%% ¡name!
Callbacks
%%%% ¡code!
fig = uifigure();
pe = PanelElement('EL', ETA());
pe.draw('Parent', fig)
pe.cb_hide()
pe.cb_bring_to_front()
pe.cb_close()