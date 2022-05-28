%% ¡header!
PanelPropClass < PanelProp (pr, panel property class) plots the panel of a property class.

%%% ¡description!
PanelPropClass plots the panel for a CLASS property with a drop-down list.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uidropdown

%% ¡properties!
p
dropdown

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the class property.
    %
    % DRAW(PR) draws the panel of the class property.
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
    
    if ~check_graphics(pr.dropdown, 'uidropdown')
        pr.dropdown = uidropdown( ...
            'Parent', pr.p, ...
            'Tag', 'dropdown', ...
            'Items', subclasses(el.getPropSettings(prop), [], [], true), ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_dropdown} ...
            );
    end

    function cb_dropdown(~, ~) % (src, event)
        pr.cb_dropdown()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permission of the drop down.
    %
    % UPDATE(PR) updates the content and permission of the drow down.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.dropdown, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.dropdown, 'Value', el.get(prop))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.dropdown, 'Value', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.dropdown, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
 
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.dropdown, ...
                    'Value', el.getPropDefault(prop), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.dropdown, ...
                    'Value', el.get(prop), ...
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
    %  - HEIGHT = s(3.5)
    %
    % See also draw, update, PanelElement, s.
    
    [h_p, varargin] = get_and_remove_from_varargin(s(3.5), 'Height', varargin);

    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.dropdown, 'Position', [s(.3) s(.25 * BRAPH2.FONTSIZE * BRAPH2.S) .70*w(pr.p, 'pixels') s(1.7)])    
end
function cb_dropdown(pr)
    %CB_POPUPMENU_VALUE executes callback for the popupmenu.
    %
    % CB_POPUPMENU_VALUE(PR) executes callback for the popupmenu.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.set(prop, get(pr.dropdown, 'Value'))

    pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropClass and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et = ETA();
props = [et.PROP_CLASS_M et.PROP_CLASS_P et.PROP_CLASS_D et.PROP_CLASS_F et.PROP_CLASS_G et.PROP_CLASS_R et.PROP_CLASS_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropClass('EL', et, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)