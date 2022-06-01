%% ¡header!
SettingsAxisPP < PanelProp (pr, settings axis panel) is the panel with axis settings.

%%% ¡description!
SettingsAxisPP plots the panel for axis settings including 
a button for the axis color and checkboxes for axis on/off, grid on/off,, equal on/off, and tight on/off.
It works for all categories.

%%% ¡seealso!
SettingsPosition, uicheckbox, uipushbutton

%% ¡properties!
p
button_axiscolor
checkbox_axis
checkbox_grid
checkbox_equal
checkbox_tight

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of axis settings.
    %
    % DRAW(PR) draws the panel of axis settings.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard panel properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});
    
    if ~check_graphics(pr.button_axiscolor, 'uibutton')
        pr.button_axiscolor = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'button_axiscolor', ...
            'Text', '', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AXISCOLOR')) ' ' el.get(prop).getPropDescription('AXISCOLOR')], ...
            'ButtonPushedFcn', {@cb_button_axiscolor} ...
            );
    end
    function cb_button_axiscolor(~, ~) % (src, event)
        pr.cb_button_axiscolor()
    end
    
    if ~check_graphics(pr.checkbox_axis, 'uicheckbox')
        pr.checkbox_axis = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_axis', ...
            'Text', 'axis', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AXIS')) ' ' el.get(prop).getPropDescription('AXIS')], ...
            'ValueChangedFcn', {@cb_checkbox_axis} ...
            );
    end
    function cb_checkbox_axis(~, ~) % (src, event)
        pr.cb_axis()
    end

    if ~check_graphics(pr.checkbox_grid, 'uicheckbox')
        pr.checkbox_grid = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_grid', ...
            'Text', 'grid', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('GRID')) ' ' el.get(prop).getPropDescription('GRID')], ...
            'ValueChangedFcn', {@cb_checkbox_grid} ...
            );
    end
    function cb_checkbox_grid(~, ~) % (src, event)
        pr.cb_axis()
    end

    if ~check_graphics(pr.checkbox_equal, 'uicheckbox')
        pr.checkbox_equal = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_equal', ...
            'Text', 'equal', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EQUAL')) ' ' el.get(prop).getPropDescription('EQUAL')], ...
            'ValueChangedFcn', {@cb_checkbox_equal} ...
            );
    end
    function cb_checkbox_equal(~, ~) % (src, event)
        pr.cb_axis()
    end

    if ~check_graphics(pr.checkbox_tight, 'uicheckbox')
        pr.checkbox_tight = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_tight', ...
            'Text', 'tight', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('TIGHT')) ' ' el.get(prop).getPropDescription('TIGHT')], ...
            'ValueChangedFcn', {@cb_checkbox_tight} ...
            );
    end
    function cb_checkbox_tight(~, ~) % (src, event)
        pr.cb_axis()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the axis settings.
    %
    % UPDATE(PR) updates the content and permissions of the axis settings.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.button_axiscolor, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_axis, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_grid, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_equal, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_tight, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.button_axiscolor, 'BackgroundColor', el.get(prop).get('AXISCOLOR'))
            set(pr.checkbox_axis, 'Value', el.get(prop).get('AXIS'))
            set(pr.checkbox_grid, 'Value', el.get(prop).get('GRID'))
            set(pr.checkbox_equal, 'Value', el.get(prop).get('EQUAL'))
            set(pr.checkbox_tight, 'Value', el.get(prop).get('TIGHT'))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.button_axiscolor, 'BackgroundColor', el.get(prop).get('AXISCOLOR'))
            set(pr.checkbox_axis, 'Value', el.get(prop).get('AXIS'))
            set(pr.checkbox_grid, 'Value', el.get(prop).get('GRID'))
            set(pr.checkbox_equal, 'Value', el.get(prop).get('EQUAL'))
            set(pr.checkbox_tight, 'Value', el.get(prop).get('TIGHT'))

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AXISCOLOR'), 'Callback')
                set(pr.button_axiscolor, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AXIS'), 'Callback')
                set(pr.checkbox_axis, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('GRID'), 'Callback')
                set(pr.checkbox_grid, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EQUAL'), 'Callback')
                set(pr.checkbox_equal, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('TIGHT'), 'Callback')
                set(pr.checkbox_tight, 'Enable', pr.get('ENABLE'))
            end
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.button_axiscolor, ...
                    'BackgroundColor', el.get(prop).getPropDefault('AXISCOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_axis, ...
                    'Value', el.get(prop).getPropDefault('AXIS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_grid, ...
                    'Value', el.get(prop).getPropDefault('GRID'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_equal, ...
                    'Value', el.get(prop).getPropDefault('EQUAL'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_tight, ...
                    'Value', el.get(prop).getPropDefault('TIGHT'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.button_axiscolor, ...
                    'BackgroundColor', el.get(prop).get('AXISCOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_axis, ...
                    'Value', el.get(prop).get('AXIS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_grid, ...
                    'Value', el.get(prop).get('GRID'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_equal, ...
                    'Value', el.get(prop).get('EQUAL'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_tight, ...
                    'Value', el.get(prop).get('TIGHT'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
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
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(5.5)
    %
    % See also draw, update, PanelElement, s.

    [h_p, varargin] = get_and_remove_from_varargin(s(5.5), 'Height', varargin);
    
    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.button_axiscolor, 'Position', [s(.9)+.60*w(pr.p, 'pixels') s(2.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.checkbox_axis, 'Position', [s(.3) s(2.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.checkbox_grid, 'Position', [s(.6)+.30*w(pr.p, 'pixels') s(2.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.checkbox_equal, 'Position', [s(.3) s(.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.checkbox_tight, 'Position', [s(.6)+.30*w(pr.p, 'pixels') s(.3) .30*w(pr.p, 'pixels') s(1.7)])
end
function cb_axis(pr)
    %CB_AXIS executes callback for all checkboxes.
    %
    % CB_AXIS(PR) executes callback for all checkboxes.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set( ...
        'AXIS', get(pr.checkbox_axis, 'Value'), ...
        'GRID', get(pr.checkbox_grid, 'Value'), ...
        'EQUAL', get(pr.checkbox_equal, 'Value'), ...
        'TIGHT', get(pr.checkbox_tight, 'Value') ...
        )

% % %     pr.update()
end
function cb_button_axiscolor(pr)
    %CB_BUTTON_AXISCOLOR executes callback for the button.
    %
    % CB_BUTTON_AXISCOLOR(PR) executes callback for the button.

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('AXISCOLOR'));
    if ~isequal(new_color, el.get(prop).get('AXISCOLOR'))
        el.get(prop).set('AXISCOLOR', new_color)

% % %         pr.update()
    end
end