%% ¡header!
PlotProp < Plot (pr, plot property) is a plot of a property.

%%% ¡description!
PlotProp plots a property of an element in a panel. 
 It contains a text with the prop tag and a tooltip with the prop description.
 For parameter and data callback, it also features a callback button.
 For results, it features calculate and delete buttons.
 It typically is employed in one of its derived forms, 
 where also the contents of the element property are shown.

Important notes:
1. PlotProp is intimately connected with GUI (cb_button_cb) and 
 PlotElement (update, redraw, refresh).
2. The methods redraw() and refresh() are used internally by PlotElement
 and typically do not need to be explicitly called in children of PlotProp, 
 while update() is typically called in callbacks to update the contents.
3. Children of PlotProp should implement the methods:
  - draw() to initially create the panel and its graphical objects
  - update() to update the information content of the panel and of the element
  - redraw() to resize the panel and reposition its graphical objcts

CONSTRUCTOR - To construct a PlotProp use the constructor:

    pr = Plot(''EL'', <element>, ''PROP'', prop);
    pr = Plot(''EL'', <element>, ''PROP'', prop, ''ID'', ''id string'', ''TITLE'', ''title string'');
    
DRAW - To create the initial graphical objects in the property panel 
 (title text and buttons), call pr.draw():

    p = pr.<strong>draw</strong>();
    p = pr.<strong>draw</strong>(''Parent'', pp);

 It is also possible to use pr.draw() to get the property panel handle
  and to set its properties (as in the case of Plot).

UPDATE - Updates the information content of the panel and of the element.
  Typically, it does not need to be called explicitly.
  It is internally called by PlotElement when needed.

REDRAW - Resizes the panel and repositions its graphical objcts.
  Typically, it does not need to be called explicitly.
  It is internally called by PlotElement when needed.

REFRESH - Updates and resizes the panel and also its parent and siblings.
  Typically, it does not need to be called explicitly.
  It is internally called by PlotElement when needed.

%%% ¡seealso!
GUI, PlotElement

%% ¡props!

%%% ¡prop!
EL (metadata, item) is the element.

%%% ¡prop!
PROP (data, scalar) is the property number.

%%% ¡prop!
TITLE (metadata, string) is the property title.

%%% ¡prop!
ENABLE (metadata, option) switches between off and inactive fields.
%%%% ¡settings!
{'inactive' 'off'}

%% ¡properties!
p % panel (it is h_panel in Plot)
text_tag
button_cb % only for PARAMETER and DATA
button_calc % only for RESULT
button_del % only for RESULT

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the property panel.
    %
    % DRAW(PL) draws the property panel with its title and
    %  action buttons (callback for PARAMETER and DATA; calculate and
    %  delete for RESULT).
    %
    % H = DRAW(PL) returns a handle to the property panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the panel 
    %  with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, refresh, settings, uipanel.
disp('d') % FIXME

    pr.p = draw@Plot(pr, varargin{:});

    el = pr.get('EL');
    prop = pr.get('PROP');

    if ~check_graphics(pr.text_tag, 'text')
        if ~isempty(pr.get('TITLE'))
            pr_string_title = pr.get('TITLE');
        else
            pr_string_title = upper(el.getPropTag(prop));
        end
        
        pr.text_tag =  uicontrol( ...
            'Style', 'text', ...
            'Tag', 'text_tag', ...
            'Parent', pr.p, ...
            'Units', 'characters', ...
            'String', pr_string_title, ...
            'HorizontalAlignment', 'left', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            %
            
        case {Category.PARAMETER, Category.DATA}
            if ~check_graphics(pr.button_cb, 'pushbutton')
                pr.button_cb = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Tag', 'button_cb', ...
                    'Parent', pr.p, ...
                    'Units', 'characters', ...
                    'String', '@', ...
                    'HorizontalAlignment', 'left', ...
                    'FontWeight', 'bold', ...
                    'Callback', {@cb_button_cb} ...
                    );
            end
            
        case Category.RESULT
            if ~check_graphics(pr.button_calc, 'pushbutton')
                pr.button_calc = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Tag', 'button_calc', ...
                    'Parent', pr.p, ...
                    'Units', 'characters', ...
                    'String', 'C', ...
                    'HorizontalAlignment', 'left', ...
                    'FontWeight', 'bold', ...
                    'Tooltip', 'Calculate', ...
                    'Callback', {@cb_button_calc} ...
                    );
            end
            if ~check_graphics(pr.button_del, 'pushbutton')
                pr.button_del = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Tag', 'button_del', ...
                    'Parent', pr.p, ...
                    'Units', 'characters', ...
                    'String', 'D', ...
                    'HorizontalAlignment', 'left', ...
                    'FontWeight', 'bold', ...
                    'Tooltip', 'Delete', ...
                    'Callback', {@cb_button_del} ...
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
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content of the property panel and its graphical objects.
    %
    % UPDATE(PL) updates the content of the property panel and its graphical objects.
    %
    % Important note:
    % 1. UPDATE() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % See also draw, redraw, refresh, PlotElement.
disp('u') % FIXME

    el = pr.get('EL');
    prop = pr.get('PROP');

    switch el.getPropCategory(prop)
        case Category.METADATA
            %

        case {Category.PARAMETER, Category.DATA}
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
    % REDRAW(PL) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PL, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=1.4 characters.
    %
    % See also draw, update, refresh, PlotElement.
disp('r') % FIXME

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    p = pr.p;

    % resizes the width (w) and height (h) of the panel
    % keeps its initial position (x0, y0) unchanged.
    x0_p = get_from_varargin(x0(p), 'X0', varargin);
    y0_p = get_from_varargin(y0(p), 'Y0', varargin);
    w_p = get_from_varargin(w(p), 'Width', varargin);
    h_p = get_from_varargin(1.4, 'Height', varargin);
    set(p, ...
        'Units', 'characters', ...
        'Position', [x0_p y0_p w_p h_p] ...
        )

    % places text_tag to the top
    set(pr.text_tag, ...
        'Units', 'characters', ...
        'Position', [0 h(p)-1 w(p) 1] ...
        )

    % places the relevant buttons (depening on category)
    switch el.getPropCategory(prop)
        case Category.METADATA
            %

        case {Category.PARAMETER, Category.DATA}
            set(pr.button_cb, ...
                'Units', 'characters', ...
                'Position', [w(p)-4 h(p)-1.2 3 1] ...
                )

        case Category.RESULT
            set(pr.button_calc, ...
                'Units', 'characters', ...
                'Position', [w(p)-7.5 h(p)-1.2 3 1] ...
                )
            set(pr.button_del, ...
                'Units', 'characters', ...
                'Position', [w(p)-4 h(p)-1.2 3 1] ...
                )
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
function refresh(pr)
    %REFRESH updates and resizes parent and siblings.
    %
    % REFRESH(PL) updates and resizes parent and siblings.
    %
    % Important note:
    % 1. UPDATE() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % See also draw, update, redraw, PlotElement.
disp('f') % FIXME

    p = pr.p;
    pp = get(p, 'Parent');
    if check_graphics(pp, 'uipanel')
        f = get(pp, 'Parent');
        backup_units = get(f, 'Units');
        backup_position = get(f, 'Position');
        backup_userdata = get(f, 'UserData'); % FIXME: addition - check
        set(f, 'Units', 'pixels') 
        set(f, 'UserData', 'ignore', 'Position', get(f, 'Position') + [0 0 0 -10])
        set(f, 'UserData', 'update', 'Units', backup_units, 'Position', backup_position) % triggers call to calls update() and redraw() on f
        set(f, 'UserData', backup_userdata) % FIXME: addition - check
% FIXME: check this code carefully once PlotElement is ready        
    end
end
function cb_button_cb(pr)
    %CB_BUTTON_CB executes callback for button callback.
    %
    % CB_BUTTON_CB(PL) executes callback for button callback.
    % 
    % See also GUI.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    GUI('EL', el.getr(prop).get('EL')) 
% FIXME: check that this is working once GUI is complete
end
function cb_button_calc(pr)
    %CB_BUTTON_CALC executes callback for button calculate.
    %
    % CB_BUTTON_CALC(PL) executes callback for button calculate.
    %
    % See also cb_button_del.

    el = pr.get('EL');
    prop = pr.get('PROP');

    el.memorize(prop);

    pr.refresh() % includes pr.update() and pr.redraw(), also one level up
end
function cb_button_del(pr)
    %CB_BUTTON_DEL executes callback for button delete.
    %
    % CB_BUTTON_DEL(PL) executes callback for button delete.
    %
    % See also cb_button_calc.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.set(prop, NoValue.getNoValue())

    pr.refresh() % includes pr.update() and pr.redraw(), also one level up
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PlotProp's at once
figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
et1 = ETA();
for category = 1:1:Element.getCategoryNumber() + 1
    for format = 1:1:Element.getFormatNumber()
        prop = (category - 1) * Element.getFormatNumber() + format;
        pr{category, format} = PlotProp('EL', et1, 'PROP', prop);
        pr{category, format}.draw( ...
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
close(gcf)

% draws PlotProp's with multiple calls to draw()
figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
et2 = ETA();
for category = 1:1:Element.getCategoryNumber() + 1
    for format = 1:1:Element.getFormatNumber()
        prop = (category - 1) * Element.getFormatNumber() + format;
        pr{category, format} = PlotProp('EL', et2, 'PROP', prop);
        pr{category, format}.draw()
        pr{category, format}.draw('Units', 'normalized')
        pr{category, format}.draw('Position', [ ...
                (category-1)/(Element.getCategoryNumber()+1) ...
                1-format/Element.getFormatNumber() ...
                .9/(Element.getCategoryNumber()+1) ...
                .9/Element.getFormatNumber() ...
                ])
        pr{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])
        drawnow()
    end
end
close(gcf)

% calls redraw() to resize the property panel and reposition its text
figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
drawnow() % to solve ensure the figure is stable under drawnow()
et3 = ETA();
for category = 1:1:Element.getCategoryNumber() + 1
    for format = 1:1:Element.getFormatNumber()
        prop = (category - 1) * Element.getFormatNumber() + format;
        pr{category, format} = PlotProp('EL', et3, 'PROP', prop);
        pr{category, format}.draw()
        pr{category, format}.draw('Units', 'normalized')
        pr{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])

        pr{category, format}.redraw( ...
            'X0', (category - 1) / (Element.getCategoryNumber() + 1) * Plot.w(gcf, 'characters'), ...
            'Y0', (1 - format / Element.getFormatNumber()) * Plot.h(gcf, 'characters'), ...
            'Width', .9 / (Element.getCategoryNumber() + 1) * Plot.w(gcf, 'characters'), ...
            'Height', .9 / Element.getFormatNumber() * Plot.h(gcf, 'characters') ...
            )
        drawnow()
    end
end
close(gcf)

% calls update() and redraw()
% note that it doesn't work because it needs to be used with PlotElement() and GUI()
figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
drawnow() % to solve ensure the figure is stable under drawnow()
et3 = ETA();
for category = 1:1:Element.getCategoryNumber() + 1
    for format = 1:1:Element.getFormatNumber()
        prop = (category - 1) * Element.getFormatNumber() + format;
        pr{category, format} = PlotProp('EL', et3, 'PROP', prop);
        pr{category, format}.draw()
        pr{category, format}.draw('Units', 'normalized')
        pr{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])

        pr{category, format}.update()
        
        pr{category, format}.redraw( ...
            'X0', (category - 1) / (Element.getCategoryNumber() + 1) * Plot.w(gcf, 'characters'), ...
            'Y0', (1 - format / Element.getFormatNumber()) * Plot.h(gcf, 'characters'), ...
            'Width', .9 / (Element.getCategoryNumber() + 1) * Plot.w(gcf, 'characters'), ...
            'Height', .9 / Element.getFormatNumber() * Plot.h(gcf, 'characters') ...
            )
        drawnow()
    end
end
close(gcf)