%% ¡header!
PanelPropLogical < PanelProp (pr, panel property logical) plots the panel of a property logical.

%%% ¡description!
PanelPropLogical plots the panel for a LOGICAL property with a checkbox.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uicheckbox

%% ¡properties!
p
checkbox

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the logical property.
    %
    % DRAW(PR) draws the panel of the logical property.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});
    
    if ~check_graphics(pr.checkbox, 'uicheckbox') 
        pr.checkbox = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox', ...
            'Text', '', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_checkbox} ...
            );
    end

    function cb_checkbox(~, ~) % (src, event)
        pr.cb_checkbox()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the checkbox.
    %
    % UPDATE(PR) updates the content and permissions of the checkbox.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.checkbox, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.checkbox, 'Value', el.get(prop))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.checkbox, 'Value', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.checkbox, 'Enable', pr.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.checkbox, ...
                    'Value', el.getPropDefault(prop), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
            set(pr.checkbox, ...
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
    
    [h_p, varagin] = get_and_remove_from_varargin(s(3.5), 'Height', varargin);

    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.checkbox, 'Position', [s(.3) s(.3) .70*w(pr.p, 'pixels') s(1.7)])
end
function cb_checkbox(pr)
    %CB_CHECKBOX executes callback for the checkbox.
    %
    % CB_CHECKBOX(PR) executes callback for the checkbox.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.set(prop, logical(get(pr.checkbox, 'Value')))
   
% % %     pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropString and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et1 = ETA();
props = [et1.PROP_LOGICAL_M et1.PROP_LOGICAL_P et1.PROP_LOGICAL_D et1.PROP_LOGICAL_F et1.PROP_LOGICAL_G et1.PROP_LOGICAL_R et1.PROP_LOGICAL_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropLogical('EL', et1, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)