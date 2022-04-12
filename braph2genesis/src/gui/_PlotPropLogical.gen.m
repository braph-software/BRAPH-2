%% ¡header!
PlotPropLogical < PlotProp (pr, plot property logical) is a plot of a property logical.

%%% ¡description!
PlotPropLogical plots a LOGICAL property of an element in a checkbox.
It works for all categories.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
checkbox_value

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the logical property.
    %
    % DRAW(PR) draws the panel of the logical property.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, refresh, uipanel.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PlotProp(pr, varargin{:});
    
    if ~check_graphics(pr.checkbox_value, 'checkbox') 
        pr.checkbox_value = uicontrol( ...
            'Style', 'checkbox', ...
            'Tag', 'checkbox_value', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'Position', [.01 .10 .29 .40], ... % position defined here because it's always the same
            'HorizontalAlignment', 'center', ...
            'BackgroundColor', pr.get('BKGCOLOR'), ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Callback', {@cb_checkbox_value} ...
            );
    end

    % callback
    function cb_checkbox_value(~, ~) % (src, event)
        pr.cb_checkbox_value()
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the checkbox.
    %
    % UPDATE(PR) updates the content and permissions of the checkbox.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.checkbox_value, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.checkbox_value, 'Value', el.get(prop))

        case {Category.PARAMETER, Category.DATA}
            set(pr.checkbox_value, 'Value', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.checkbox_value, 'Enable', pr.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.checkbox_value, ...
                    'Value', el.getPropDefault(prop), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
            set(pr.checkbox_value, ...
                'Value', el.get(prop), ...
                'Enable', pr.get('ENABLE') ...
                )
            end
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=2.5 characters.
    %
    % See also draw, update, refresh, PlotElement.
    
    [h, varargin] = get_and_remove_from_varargin(2.5, 'Height', varargin);

    pr.redraw@PlotProp('Height', h, varargin{:})
end
function cb_checkbox_value(pr)
    %CB_CHECKBOX_VALUE executes callback for the checkbox value.
    %
    % CB_CHECKBOX_VALUE(PR) executes callback for the checkbox value.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.set(prop, logical(get(pr.checkbox_value, 'Value')))
   
    pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PlotPropLogical and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PlotElement() and GUI()
figure()
et = ETA();
props = [et.PROP_LOGICAL_M et.PROP_LOGICAL_P et.PROP_LOGICAL_D et.PROP_LOGICAL_R et.PROP_LOGICAL_R_CALC];
for i = 1:1:length(props)
    pr{i} = PlotPropLogical('EL', et, 'PROP', props(i));
    pr{i}.draw('BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)])
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * Plot.h(gcf, 'characters'))
end
close(gcf)

% minimal working version for category RESULT
figure()
p = uipanel('Parent', gcf); % needed for the function refresh that is called when the result is calculated
set(gcf, 'SizeChangedFcn', 'pr_res.update()') % callback to update panel when figure is resized (in refresh)
et = ETA();
pr_res = PlotPropLogical('EL', et, 'PROP', et.PROP_LOGICAL_R_CALC);
pr_res.draw('Parent', p, 'BackgroundColor', [.8 .5 .2])
pr_res.update()
pr_res.redraw()
close(gcf)