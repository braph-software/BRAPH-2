%% ¡header!
PanelProp < Panel (pr, panel property) is a panel of a property.

%%% ¡description!
PanelProp plots a property of an element in a panel. 
 It contains a text with the prop tag and a tooltip with the prop description.
 For parameter, data, figure and gui callbacks, it also features a callback button.
 For results, it features calculate and delete buttons.
 It is typically employed in one of its derived forms, 
 where also the contents of the element property are shown.

Important notes:
1. PanelProp is intimately connected with GUIElement (cb_button_cb) and 
 PanelElement (update, redraw).
2. The method redraw() is used internally by PanelElement
 and typically does not need to be explicitly called in children of PanelProp, 
 while update() is typically called in callbacks to update the contents.
3. Children of PanelProp should implement the methods:
  - draw() to initially create the panel and its graphical objects
  - update() to update the information content of the panel and of the element
  - redraw() to resize the panel and reposition its graphical objcts

CONSTRUCTOR - To construct a PanelProp use the constructor:

    pr = Panel(''EL'', <element>, ''PROP'', prop);
    pr = Panel(''EL'', <element>, ''PROP'', prop, ''ID'', ''id string'', ''TITLE'', ''title string'');
    
DRAW - To create the initial graphical objects in the property panel 
 (title text and buttons), call pr.draw():

    p = pr.<strong>draw</strong>();
    p = pr.<strong>draw</strong>(''Parent'', pp);

 It is also possible to use pr.draw() to get the property panel handle
  and to set its properties (as in the case of Panel).

UPDATE - Updates the information content of the panel and of the element.
  Typically, it does not need to be called explicitly.
  It is internally called by PanelElement when needed.

REDRAW - Resizes the panel and repositions its graphical objcts.
  Typically, it does not need to be called explicitly.
  It is internally called by PanelElement when needed.

%%% ¡seealso!
GUI, GUIElement, PanelElement

%% ¡props!

%%% ¡prop!
EL (metadata, item) is the element.

%%% ¡prop!
PROP (data, scalar) is the property number.

%%% ¡prop!
TITLE (gui, string) is the property title.

%%% ¡prop!
ENABLE (gui, logical) switches between active and inactive ui components.

%%% ¡prop!
WAITBAR (gui, logical) determines whether to show the waitbar when executing calculations.

%% ¡properties!
p % panel
label_tag
button_cb % only for PARAMETER, DATA, FIGURE and GUI
button_calc % only for RESULT
button_del % only for RESULT

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the property panel.
    %
    % DRAW(PR) draws the property panel with its title and
    %  action buttons (callback for PARAMETER, DATA, FIGURE, and GUI; 
    %  calculate and delete for RESULT).
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the panel 
    %  with custom Name-Value pairs.
    %  All standard panel properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.

    pr.p = draw@Panel(pr, varargin{:});

    el = pr.get('EL');
    prop = pr.get('PROP');

    if ~check_graphics(pr.label_tag, 'uilabel')
        if ~isempty(pr.get('TITLE'))
            pr_string_title = pr.get('TITLE');
        else
            pr_string_title = upper(el.getPropTag(prop));
        end
        
        pr.label_tag =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_tag', ...
            'Text', pr_string_title, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'left', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            %
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            if ~check_graphics(pr.button_cb, 'uibutton')
                pr.button_cb = uibutton( ...
                    'Parent', pr.p, ...
                    'Tag', 'button_cb', ...
                    'Text', '@', ...
                    'FontWeight', 'bold', ...
                    'ButtonPushedFcn', {@cb_button_cb} ...
                    );
            end
            
        case Category.RESULT
            if ~check_graphics(pr.button_calc, 'uibutton')
                pr.button_calc = uibutton( ...
                    'Parent', pr.p, ...
                    'Tag', 'button_calc', ...
                    'Text', 'C', ...
                    'FontWeight', 'bold', ...
                    'Tooltip', 'Calculate', ...
                    'ButtonPushedFcn', {@cb_button_calc} ...
                    );
            end
            if ~check_graphics(pr.button_del, 'uibutton')
                pr.button_del = uibutton( ...
                    'Parent', pr.p, ...
                    'Tag', 'button_del', ...
                    'Text', 'D', ...
                    'FontWeight', 'bold', ...
                    'Tooltip', 'Delete', ...
                    'ButtonPushedFcn', {@cb_button_del} ...
                    );
            end
    end
    
    function cb_button_cb(~, ~) % (src, event)
        pr.cb_button_cb()
    end
    function cb_button_calc(~, ~) % (src, event)
        pr.cb_button_calc()
    end
    function cb_button_del(~, ~) % (src, event)
        pr.cb_button_del()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content of the property panel and its graphical objects.
    %
    % UPDATE(PR) updates the content of the property panel and its graphical objects.
    %
    % Important note:
    %  UPDATE() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % See also draw, redraw, PanelElement.

    el = pr.get('EL');
    prop = pr.get('PROP');

    switch el.getPropCategory(prop)
        case Category.METADATA
            %

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.button_cb, ...
                    'Tooltip', value.tostring(), ...
                    'Visible', 'on' ...
                    )
            else
                set(pr.button_cb, ...
                    'Visible', 'off' ...
                    )
            end

        case Category.RESULT
            value = el.getr(prop);
            if isa(value, 'NoValue')
                set(pr.button_calc, 'Enable', 'on')
                set(pr.button_del, 'Enable', 'off')
            else
                set(pr.button_calc, 'Enable', 'off')
                set(pr.button_del, 'Enable', 'on')
            end
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'pixels' for panel. 
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PL, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = 2 * BRAPH2.FONTSIZE * BRAPH2.S.
    %
    % See also draw, update, PanelElement, BRAPH2.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    p = pr.p;

    % repositions the panel
    x0_p = ceil(get_from_varargin(x0(p, 'pixels'), 'X0', varargin));
    y0_p = ceil(get_from_varargin(y0(p, 'pixels'), 'Y0', varargin));
    w_p = ceil(get_from_varargin(w(p, 'pixels'), 'Width', varargin));
    h_p = ceil(get_from_varargin(2 * BRAPH2.FONTSIZE * BRAPH2.S, 'Height', varargin));
    set(p, ...
        'Units', 'pixels', ...
        'Position', [x0_p y0_p w_p h_p] ...
        )

    % places label_tag to the top
    s2 = ceil(2 * BRAPH2.S);
    s16 = ceil(16 * BRAPH2.S);
    set(pr.label_tag, 'Position', [s2 h_p-s16 w_p s16])

    % places the relevant buttons (depening on category)
    switch el.getPropCategory(prop)
        case Category.METADATA
            %

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            s20 = ceil(20 * BRAPH2.S);
            s22 = ceil(22 * BRAPH2.S);
            s25 = ceil(25 * BRAPH2.S);
            set(pr.button_cb, 'Position', [w_p-s25 h_p-s22 s20 s20])

        case Category.RESULT
            s20 = ceil(20 * BRAPH2.S);
            s22 = ceil(22 * BRAPH2.S);
            s25 = ceil(25 * BRAPH2.S);
            s50 = ceil(50 * BRAPH2.S);
            set(pr.button_calc, 'Position', [w_p-s50 h_p-s22 s20 s20])
            set(pr.button_del, 'Position', [w_p-s25 h_p-s22 s20 s20])
    end
end
function cb_button_cb(pr)
    %CB_BUTTON_CB executes callback for button callback.
    %
    % CB_BUTTON_CB(PR) executes callback for button callback.
    % 
    % See also GUIElement.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    GUIElement('EL', el.getr(prop).get('EL')) 
% % %TODO: check that this is working once GUIElement is complete
% % %TODO: check also that this is managed correctly by the various callbacks (front, hide, close)
end
function cb_button_calc(pr)
    %CB_BUTTON_CALC executes callback for button calculate.
    %
    % CB_BUTTON_CALC(PR) executes callback for button calculate.
    %
    % See also cb_button_del.

    el = pr.get('EL');
    prop = pr.get('PROP');

    el.memorize(prop);

    % updates and redraws the parent PanelElement as well as all siblings PanelProp's
    pe = get(get(pr.p, 'Parent'), 'UserData');
    pe.update()
    pe.redraw()
end
function cb_button_del(pr)
    %CB_BUTTON_DEL executes callback for button delete.
    %
    % CB_BUTTON_DEL(PR) executes callback for button delete.
    %
    % See also cb_button_calc.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.set(prop, NoValue.getNoValue())

    % updates and redraws the parent PanelElement as well as all siblings PanelProp's
    pe = get(get(pr.p, 'Parent'), 'UserData');
    pe.update()
    pe.redraw()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%% ¡code!
% draws PanelProp's at once
fig1 = uifigure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1]);
et1 = ETA();
for category = 1:1:Element.getCategoryNumber() + 1
    for format = 1:1:Element.getFormatNumber()
        prop = (category - 1) * Element.getFormatNumber() + format;
        prs{category, format} = PanelProp('EL', et1, 'PROP', prop);
        prs{category, format}.draw( ...
            'Parent', fig1, ...
            'Units', 'normalized', ...
            'Position', [ ...
                (category-1)/(Element.getCategoryNumber()+1) ...
                1-format/Element.getFormatNumber() ...
                .9/(Element.getCategoryNumber()+1) ...
                .9/Element.getFormatNumber() ...
                ], ...
            'BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1] ...
            )
        drawnow()
    end
end
close(fig1)

% draws PanelProp's with multiple calls to draw()
fig2 = uifigure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1]);
et2 = ETA();
for category = 1:1:Element.getCategoryNumber() + 1
    for format = 1:1:Element.getFormatNumber()
        prop = (category - 1) * Element.getFormatNumber() + format;
        prs{category, format} = PanelProp('EL', et2, 'PROP', prop);
        prs{category, format}.draw('Parent', fig2)
        prs{category, format}.draw('Units', 'normalized')
        prs{category, format}.draw('Position', [ ...
                (category-1)/(Element.getCategoryNumber()+1) ...
                1-format/Element.getFormatNumber() ...
                .9/(Element.getCategoryNumber()+1) ...
                .9/Element.getFormatNumber() ...
                ])
        prs{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])
        drawnow()
    end
end
close(fig2)

% calls redraw() to resize the property panel and reposition its text
fig3 = uifigure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1]);
drawnow() % to ensure the figure is stable under drawnow()
et3 = ETA();
for category = 1:1:Element.getCategoryNumber() + 1
    for format = 1:1:Element.getFormatNumber()
        prop = (category - 1) * Element.getFormatNumber() + format;
        prs{category, format} = PanelProp('EL', et3, 'PROP', prop);
        prs{category, format}.draw('Parent', fig3)
        prs{category, format}.draw('Units', 'normalized')
        prs{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])

        prs{category, format}.redraw( ...
            'X0', (category - 1) / (Element.getCategoryNumber() + 1) * w(fig3, 'pixels'), ...
            'Y0', (1 - format / Element.getFormatNumber()) * h(fig3, 'pixels'), ...
            'Width', .9 / (Element.getCategoryNumber() + 1) * w(fig3, 'pixels'), ...
            'Height', .9 / Element.getFormatNumber() * h(fig3, 'pixels') ...
            )
        drawnow()
    end
end
close(fig3)

% calls update() and redraw()
% note that it doesn't work because it needs to be used with PanelElement() and GUI()
fig4 = uifigure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1]);
drawnow() % to ensure the figure is stable under drawnow()
et3 = ETA();
for category = 1:1:Element.getCategoryNumber() + 1
    for format = 1:1:Element.getFormatNumber()
        prop = (category - 1) * Element.getFormatNumber() + format;
        prs{category, format} = PanelProp('EL', et3, 'PROP', prop);
        prs{category, format}.draw('Parent', fig4)
        prs{category, format}.draw('Units', 'normalized')
        prs{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])

       prs{category, format}.update()
        
        prs{category, format}.redraw( ...
            'X0', (category - 1) / (Element.getCategoryNumber() + 1) * w(fig4, 'pixels'), ...
            'Y0', (1 - format / Element.getFormatNumber()) * h(fig4, 'pixels'), ...
            'Width', .9 / (Element.getCategoryNumber() + 1) * w(fig4, 'pixels'), ...
            'Height', .9 / Element.getFormatNumber() * h(fig4, 'pixels') ...
            )
        drawnow()
    end
end
close(fig4)