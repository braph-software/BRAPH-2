%% ¡header!
PPSubject_ID < PlotProp (pr, plot property string) is a plot of a string property with a callback to update group.

%%% ¡description!
PPSubject_ID plots a STRING property of an element in an edit field with a callback to update group.
It works for all categories.
It has the following additional properties:
- ''Lines'', ''single'' (single-line edit field, default) or ''multi'' (multi-line edit field).
- ''EditHeight'' with the height of the edit field in characters.

%%% ¡seealso!
GUI, PlotElement, PlotProp, PlotPropText

%% ¡properties!
p
edit_value

%% ¡props!

%%% ¡prop!
LINES (metadata, option) switches between single- and multi-line edit field.
%%%% ¡settings!
{'single', 'multi'}

%%% ¡prop!
EDITHEIGHT (metadata, scalar) is the height of the edit field in characters.
%%%% ¡check_prop!
check = value > 0;
%%%% ¡default!
1.5

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
            'HorizontalAlignment', 'left', ...
            'BackgroundColor', 'w', ...
            'Min', 0, ...
            'Max', find(strcmpi(pr.getPropSettings('LINES'), pr.get('LINES'))), ...
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
    
    h = pr.get('EDITHEIGHT');
    
    set(pr.edit_value, 'Position', [.01 .33/(1.83+h) .98 h/(1.83+h)])
    
    pr.redraw@PlotProp('Height', 1.83 + h, varargin{:})
end
function cb_edit_value(pr)
    %CB_EDIT_VALUE executes callback for the edit value.
    %
    % CB_EDIT_VALUE(PR) executes callback for the edit value.

    el = pr.get('EL');
    prop = pr.get('PROP');

    el.set(prop, get(pr.edit_value, 'String'))

    pr.update()
    pr.update_group()
end
function update_group(pr)
    figure_h = ancestor(pr.p, 'figure');
    gui_user_data = get(figure_h, 'UserData');
    cohort_panel = gui_user_data{2};
    cohort_panel.update();
end