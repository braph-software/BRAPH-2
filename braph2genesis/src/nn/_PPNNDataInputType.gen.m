%% ¡header!
PPNNDataInputType < PanelPropOption (pr, panel property option) is an optioin panel for data input type.

%%% ¡description!
PPNNData_Input_Type

%%% ¡seealso!
% % % GUI, PlotElement, PlotProp

%% ¡properties!
p
list_tbl
selected

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the graph property and the measure table.
    %
    % DRAW(PR) draws the panel of the graph property and the measure table.
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

    pr.p = draw@PanelPropOption(pr, varargin{:});

    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uidropdown')
            pr.list_tbl = children(i);
            break
        end
    end
    
    set(pr.list_tbl, 'ValueChangedFcn', {@cb_item_list});
    
    function cb_item_list(~, ~)
        val = get(pr.list_tbl, 'Value');
        el = pr.get('el');
        prop = pr.get('prop');
        el.set(prop, val)
        pr.update();
        pr.lock_measures_prop();
    end
    
    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the pushbutton.
    %
    % UPDATE(PR) updates the content and permissions of the pushbutton.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PanelPropOption(pr)
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

    pr.redraw@PanelPropOption(varargin{:})
end
function lock_measures_prop(pr)
    pe = ancestor(pr.p, 'figure').UserData.get('PE');
    measure_panel = pe.get('pr_dict').getItem('measures');
    measure_panel.update();
end