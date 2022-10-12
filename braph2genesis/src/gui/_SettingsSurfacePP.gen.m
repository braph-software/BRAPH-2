%% ¡header!
SettingsSurfacePP < PanelProp (pr, settings surface panel) is the panel with surface settings.

%%% ¡description!
SettingsSurfacePP plots the panel for surface settings
including face color, face alpha, edge color, and edge alpha.
It works for all categories.

%%% ¡seealso!
SettingsPosition, uipushbutton, uieditfield, uislider

%% ¡properties!
p
button_facecolor
editfield_facealpha
slider_facealpha
button_edgecolor
editfield_edgealpha
slider_edgealpha

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of surface settings.
    %
    % DRAW(PR) draws the panel of surface settings.
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
    
    if ~check_graphics(pr.button_facecolor, 'uibutton')
        pr.button_facecolor = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'button_facecolor', ...
            'Text', 'face', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACECOLOR')) ' ' el.get(prop).getPropDescription('FACECOLOR')], ...
            'ButtonPushedFcn', {@cb_button_facecolor} ...
            );
    end
    function cb_button_facecolor(~, ~) % (src, event)
        pr.cb_button_facecolor()
    end

    if ~check_graphics(pr.editfield_facealpha, 'uieditfield')
        pr.editfield_facealpha = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'editfield_facealpha', ...
            'Limits', [0 1], ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACEALPHA')) ' ' el.get(prop).getPropDescription('FACEALPHA')], ...
            'ValueChangedFcn', {@cb_editfield_facealpha} ...
            );
    end
    function cb_editfield_facealpha(~, ~) % (src, event)
        pr.cb_editfield_facealpha()
    end

    if ~check_graphics(pr.slider_facealpha, 'uislider')
        pr.slider_facealpha = uislider( ...
            'Parent', pr.p, ...
            'Tag', 'slider_facealpha', ...
            'Limits', [0 1], ...
            'FontSize', BRAPH2.FONTSIZE / 2, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACEALPHA')) ' ' el.get(prop).getPropDescription('FACEALPHA')], ...
            'ValueChangedFcn', {@cb_slider_facealpha} ...
            );
    end
    function cb_slider_facealpha(~, ~) % (src, event)
        pr.cb_slider_facealpha()
    end

    if ~check_graphics(pr.button_edgecolor, 'uibutton')
        pr.button_edgecolor = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'button_edgecolor', ...
            'Text', 'edge', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGECOLOR')) ' ' el.get(prop).getPropDescription('EDGECOLOR')], ...
            'ButtonPushedFcn', {@cb_button_edgecolor} ...
            );
    end
    function cb_button_edgecolor(~, ~) % (src, event)
        pr.cb_button_edgecolor()
    end

    if ~check_graphics(pr.editfield_edgealpha, 'uieditfield')
        pr.editfield_edgealpha = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'editfield_edgealpha', ...
            'Limits', [0 1], ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGEALPHA')) ' ' el.get(prop).getPropDescription('EDGEALPHA')], ...
            'ValueChangedFcn', {@cb_editfield_edgealpha} ...
            );
    end
    function cb_editfield_edgealpha(~, ~) % (src, event)
        pr.cb_editfield_edgealpha()
    end

    if ~check_graphics(pr.slider_edgealpha, 'uislider')
        pr.slider_edgealpha = uislider( ...
            'Parent', pr.p, ...
            'Tag', 'slider_edgealpha', ...
            'Limits', [0 1], ...
            'FontSize', BRAPH2.FONTSIZE / 2, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGEALPHA')) ' ' el.get(prop).getPropDescription('EDGEALPHA')], ...
            'ValueChangedFcn', {@cb_slider_edgealpha} ...
            );
    end
    function cb_slider_edgealpha(~, ~) % (src, event)
        pr.cb_slider_edgealpha()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the surface settings.
    %
    % UPDATE(PR) updates the content and permissions of the surface settings.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.button_facecolor, 'Enable', pr.get('ENABLE'))
        set(pr.editfield_facealpha, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.slider_facealpha, 'Enable', pr.get('ENABLE'))
        set(pr.button_edgecolor, 'Enable', pr.get('ENABLE'))
        set(pr.editfield_edgealpha, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.slider_edgealpha, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.button_facecolor, 'BackgroundColor', el.get(prop).get('FACECOLOR'))
            set(pr.editfield_facealpha, 'Value', el.get(prop).get('FACEALPHA'))
            set(pr.slider_facealpha, 'Value', el.get(prop).get('FACEALPHA'))
            set(pr.button_edgecolor, 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
            set(pr.editfield_edgealpha, 'Value', el.get(prop).get('EDGEALPHA'))
            set(pr.slider_edgealpha, 'Value', el.get(prop).get('EDGEALPHA'))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.button_facecolor, 'BackgroundColor', el.get(prop).get('FACECOLOR'))
            set(pr.editfield_facealpha, 'Value', el.get(prop).get('FACEALPHA'))
            set(pr.slider_facealpha, 'Value', el.get(prop).get('FACEALPHA'))
            set(pr.button_edgecolor, 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
            set(pr.editfield_edgealpha, 'Value', el.get(prop).get('EDGEALPHA'))
            set(pr.slider_edgealpha, 'Value', el.get(prop).get('EDGEALPHA'))

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACECOLOR'), 'Callback')
                set(pr.button_facecolor, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACEALPHA'), 'Callback')
                set(pr.editfield_facealpha, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_facealpha, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGECOLOR'), 'Callback')
                set(pr.button_edgecolor, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGEALPHA'), 'Callback')
                set(pr.editfield_edgealpha, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_edgealpha, 'Enable', pr.get('ENABLE'))
            end
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')

            else
                set(pr.button_facecolor, ...
                    'BackgroundColor', el.get(prop).get('FACECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.editfield_facealpha, ...
                    'Value', el.get(prop).get('FACEALPHA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_facealpha, ...
                    'Value', el.get(prop).get('FACEALPHA'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.button_edgecolor, ...
                    'BackgroundColor', el.get(prop).get('EDGECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.editfield_edgealpha, ...
                    'Value', el.get(prop).get('EDGEALPHA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_edgealpha, ...
                    'Value', el.get(prop).get('EDGEALPHA'), ...
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
    %  - HEIGHT = s(6.7)
    %
    % See also draw, update, PanelElement, s.

    [h_p, varargin] = get_and_remove_from_varargin(s(6.7), 'Height', varargin);
    
    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.button_facecolor,    'Position', [s(.3)                              s(3.2)  .20*w(pr.p, 'pixels')   s(1.7)])
    set(pr.editfield_facealpha, 'Position', [s(.6)+.20*w(pr.p, 'pixels')        s(3.2)  .15*w(pr.p, 'pixels')   s(1.7)])
    set(pr.slider_facealpha,    'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(4.75) .50*w(pr.p, 'pixels')   3]) % the height of a slider cannot be changed
    set(pr.button_edgecolor,    'Position', [s(.3)                              s(.7)   .20*w(pr.p, 'pixels')   s(1.7)])
    set(pr.editfield_edgealpha, 'Position', [s(.6)+.20*w(pr.p, 'pixels')        s(.7)   .15*w(pr.p, 'pixels')   s(1.7)])
    set(pr.slider_edgealpha,    'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(2.25) .50*w(pr.p, 'pixels')   3]) % the height of a slider cannot be changed
end
function cb_button_facecolor(pr)
    %CB_BUTTON_FACECOLOR executes callback for the face color button.
    %
    % CB_BUTTON_FACECOLOR(PR) executes callback for the face color button.

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('FACECOLOR'));
    if ~isequal(new_color, el.get(prop).get('FACECOLOR'))
        el.get(prop).set('FACECOLOR', new_color)

        pr.update()
    end
end
function cb_editfield_facealpha(pr)
    %CB_EDITFIELD_FACEALPHA executes callback for the face alpha edit field.
    %
    % CB_EDITFIELD_FACEALPHA(PR) executes callback for the face alpha edit field.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('FACEALPHA', get(pr.editfield_facealpha, 'Value'))

	pr.update()
end
function cb_slider_facealpha(pr)
    %CB_SLIDER_FACEALPHA executes callback for the face alpha slider.
    %
    % CB_SLIDER_FACEALPHA(PR) executes callback for the face alpha slider.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('FACEALPHA', get(pr.slider_facealpha, 'Value'))

    pr.update()
end
function cb_button_edgecolor(pr)
    %CB_BUTTON_EDGECOLOR executes callback for the edge color button.
    %
    % CB_BUTTON_EDGECOLOR(PR) executes callback for the edge color button.

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('EDGECOLOR'));
    if ~isequal(new_color, el.get(prop).get('EDGECOLOR'))
        el.get(prop).set('EDGECOLOR', new_color)

        pr.update()
    end
end
function cb_editfield_edgealpha(pr)
    %CB_EDITFIELD_EDGEALPHA executes callback for the edge alpha edit field.
    %
    % CB_EDITFIELD_EDGEALPHA(PR) executes callback for the edge alpha edit field.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('EDGEALPHA', get(pr.editfield_edgealpha, 'Value'))

    pr.update()
end
function cb_slider_edgealpha(pr)
    %CB_SLIDER_EDGEALPHA executes callback for the edge alpha slider.
    %
    % CB_SLIDER_EDGEALPHA(PR) executes callback for the edge alpha slider.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('EDGEALPHA', get(pr.slider_edgealpha, 'Value'))

    pr.update()
end