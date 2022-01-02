%% ¡header!
PlotPropClassList < PlotProp (pr, plot property class list) is a plot of a class-list property.

%%% ¡description!
PlotPropClassList plots a CLASSLIST property of an element in a list box.
It works for all categories.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
listbox_value

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the class-list property.
    %
    % DRAW(PR) draws the panel of the class-list property.
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
    
    if ~check_graphics(pr.listbox_value, 'listbox') 
        pr.listbox_value = uicontrol( ...
            'Style', 'listbox', ...
            'Tag', 'listbox_value', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'String', subclasses(el.getPropSettings(prop), [], [], true), ...
            'Max', 2, ...
            'HorizontalAlignment', 'left', ...
            'BackgroundColor', 'w', ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Callback', {@cb_listbox_value} ...
            );
    end

    % callback
    function cb_listbox_value(~, ~) % (src, event)
        pr.cb_listbox_value()
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the listbox.
    %
    % UPDATE(PR) updates the content and permissions of the listbox.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.listbox_value, 'Enable', pr.get('ENABLE'))
    end

    classes = subclasses(el.getPropSettings(prop), [], [], true);
    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.listbox_value, 'Value', find(cellfun(@(x) any(strcmpi(el.get(prop), x)), classes)))

        case {Category.PARAMETER, Category.DATA}
            set(pr.listbox_value, 'Value', find(cellfun(@(x) any(strcmpi(el.get(prop), x)), classes)))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.listbox_value, 'Enable', pr.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.listbox_value, ...
                    'Value', find(cellfun(@(x) any(strcmpi(el.getPropDefault(prop), x)), classes)), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.listbox_value, ...
                    'Value', find(cellfun(@(x) any(strcmpi(el.get(prop), x)), classes)), ...
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
    %  - HEIGHT=10 characters.
    %
    % See also draw, update, refresh, PlotElement.
    
    [h, varargin] = get_and_remove_from_varargin(10, 'Height', varargin);

    pr.redraw@PlotProp('Height', h, varargin{:})

    set(pr.listbox_value, 'Position', [.01 .10 .98 (h-2)/h]) % the listbox height is set to the panel height minus 2 characters
    
end
function cb_listbox_value(pr)
    el = pr.get('EL');
    prop = pr.get('PROP');

    options = subclasses(el.getPropSettings(prop), [], [], true);
    el.set(prop, options(get(pr.listbox_value, 'Value')))

    pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PlotPropClassList and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PlotElement() and GUI()
figure()
et = ETA();
props = [et.PROP_CLASSLIST_M et.PROP_CLASSLIST_P et.PROP_CLASSLIST_D et.PROP_CLASSLIST_R et.PROP_CLASSLIST_R_CALC];
for i = 1:1:length(props)
    pr{i} = PlotPropClassList('EL', et, 'PROP', props(i));
    pr{i}.draw('BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)])
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * Plot.h(gcf, 'characters'), 'Height', 5)
end
close(gcf)

% minimal working version for category RESULT
figure()
p = uipanel('Parent', gcf); % needed for the function refresh that is called when the result is calculated
set(gcf, 'SizeChangedFcn', 'pr_res.update()') % callback to update panel when figure is resized (in refresh)
et = ETA();
pr_res = PlotPropClassList('EL', et, 'PROP', et.PROP_CLASSLIST_R_CALC);
pr_res.draw('Parent', p, 'BackgroundColor', [.8 .5 .2])
pr_res.update()
pr_res.redraw()
close(gcf)    