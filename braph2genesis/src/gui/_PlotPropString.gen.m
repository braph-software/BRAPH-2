%% ¡header!
PlotPropString < PlotProp (pr, plot property string) is a plot of a string property.

%%% ¡description!
PlotPropString plots a STRING property of an element in an edit field.
It works for all categories.
It has the following additional properties:
- ''Max'', 1 (single-line edit field, default) or 2 (multi-line edit field).
- ''EditPosition'' with the normalized position of the edit field.

%%% ¡seealso!
GUI, PlotElement, PlotProp, PlotPropText

%% ¡properties!
p
edit_value

%% ¡props!

%%% ¡prop!
MAX (metadata, option) switches between single- and multi-line edit field.
%%%% ¡settings!
{'1', '2'}

%%% ¡prop!
EDITPOS (metadata, rvector) is the normalized position of the edit field.
%%%% ¡check_prop!
check = length(value) == 4;
%%%% ¡default!
[.01 .10 .98 .45]

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the string property.
    %
    % DRAW(PR) draws the panel of the string property.
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
    
    if ~check_graphics(pr.edit_value, 'edit')
        pr.edit_value = uicontrol( ...
            'Style', 'edit', ...
            'Tag', 'edit_value', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'Position', pr.get('EDITPOS'), ... % position defined here because it's always the same
            'HorizontalAlignment', 'left', ...
            'BackgroundColor', 'w', ...
            'Min', 0, ...
            'Max', str2num(pr.get('MAX')), ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Callback', {@cb_edit_value} ...
            );
    end

    function cb_edit_value(~, ~) % (src, event)
        pr.cb_edit_value()
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the edit field.
    %
    % UPDATE(PR) updates the content and permissions of the edit field.
    %
    % See also draw, resize, refresh, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.edit_value, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.edit_value, 'String', el.get(prop))

        case {Category.PARAMETER, Category.DATA}
            set(pr.edit_value, 'String', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.edit_value, 'Enable', pr.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.edit_value, ...
                    'String', el.getPropDefault(prop), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.edit_value, ...
                    'String', el.get(prop), ...
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
    %  - HEIGHT=3.33 characters.
    %
    % See also draw, update, refresh, PlotElement.
    
    [h, varargin] = get_and_remove_from_varargin(3.33, 'Height', varargin);

    pr.redraw@PlotProp('Height', h, varargin{:})
end
function cb_edit_value(pr)
    %CB_EDIT_VALUE executes callback for the edit value.
    %
    % CB_EDIT_VALUE(PR) executes callback for the edit value.

    el = pr.get('EL');
    prop = pr.get('PROP');

    el.set(prop, get(pr.edit_value, 'String'))

    pr.update()
end
  
%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PlotPropString and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PlotElement() and GUI()
figure()
et = ETA();
props = [et.PROP_STRING_M et.PROP_STRING_P et.PROP_STRING_D et.PROP_STRING_R et.PROP_STRING_R_CALC];
for i = 1:1:length(props)
    pr{i} = PlotPropString('EL', et, 'PROP', props(i));
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
pr_res = PlotPropString('EL', et, 'PROP', et.PROP_STRING_R_CALC, 'MAX', '2', 'EDITPOS', [.01 .10 .48 .45]);
pr_res.draw('Parent', p, 'BackgroundColor', [.8 .5 .2])
pr_res.update()
pr_res.redraw()
close(gcf)
