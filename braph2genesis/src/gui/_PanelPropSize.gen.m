%% ¡header!
PanelPropSize < PanelProp (pr, panel property size) plots the panel of a property size.

%%% ¡description!
PanelPropSize plots the panel for a SIZE property with a numeric edit field.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uieditfield

%% ¡properties!
p
editfield
axes
line

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the size property.
    %
    % DRAW(PR) draws the panel of the size property.
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
    
    if ~check_graphics(pr.editfield, 'uieditfield')
        pr.editfield = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'editfield', ...
            'Limits', [0 +Inf], ...
            'LowerLimitInclusive', false, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_editfield} ...
            );
    end

    function cb_editfield(~, ~) % (src, event)
        pr.cb_editfield()
    end

    if ~check_graphics(pr.axes, 'axes')
        pr.axes = uiaxes( ...
            'Parent', pr.p, ...
            'Tag', 'axes' ...
            );
        axis(pr.axes, 'off')
        pr.axes.Toolbar.Visible = 'off';
        pr.axes.Interactions = [];
    end
    if ~check_graphics(pr.line, 'line')
        pr.line = plot(pr.axes, ...
            [-100 0 100], ...
            [0 0 0], ...
            'Marker', 's', ...
            'Color', 'k');
        xlim(pr.axes, [-1 1])        
        ylim(pr.axes, [-1 1])
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the edit field.
    %
    % UPDATE(PR) updates the content and permissions of the edit field.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.editfield, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.editfield, 'Value', el.get(prop))
            set(pr.line, ...
                'LineWidth', el.get(prop), ...
                'MarkerSize', el.get(prop) ...
                )

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.editfield, 'Value', el.get(prop))
            set(pr.line, ...
                'LineWidth', el.get(prop), ...
                'MarkerSize', el.get(prop) ...
                )

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.editfield, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.editfield, ...
                    'Value', el.getPropDefault(prop), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.line, ...
                    'LineWidth', el.getPropDefault(prop), ...
                    'MarkerSize', el.getPropDefault(prop) ...
                )
            else
                set(pr.editfield, ...
                    'Value', el.get(prop), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.line, ...
                    'LineWidth', el.get(prop), ...
                    'MarkerSize', el.get(prop) ...
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
    
    set(pr.editfield, 'Position', [s(.3) s(.3) .15*w(pr.p, 'pixels') s(1.75)])
    
    set(pr.axes, 'InnerPosition', [s(.3)+.15*w(pr.p, 'pixels')+s(.6) s(.3) .70*w(pr.p, 'pixels') s(1.7)])
end
function cb_editfield(pr)
    %CB_EDITFIELD executes callback for the edit field.
    %
    % CB_EDITFIELD(PR) executes callback for the edit field.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.set(prop, get(pr.editfield, 'Value'))

    pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropSize and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et = ETA();
props = [et.PROP_SIZE_M et.PROP_SIZE_P et.PROP_SIZE_D et.PROP_SIZE_F et.PROP_SIZE_G et.PROP_SIZE_R et.PROP_SIZE_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropSize('EL', et, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)