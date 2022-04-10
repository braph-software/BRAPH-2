%% ¡header!
PPNNData_Input_Type < PlotPropOption (pr, plot property graph) is a for yuwei.

%%% ¡description!
PPNNData_Input_Type represents Yuwei.

%%% ¡seealso!
GUI, PlotElement, PlotProp

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

    pr.p = draw@PlotPropOption(pr, varargin{:});

    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'popupmenu')
            pr.list_tbl = children(i);
        end
    end
    
    set(pr.list_tbl, 'Callback', {@cb_item_list});
    
    function cb_item_list(~, ~)
        val = get(pr.list_tbl, 'Value');
        str = get(pr.list_tbl, 'String');

        el = pr.get('el');
        prop = pr.get('prop');
        str = str{val};
        el.set(prop, str)
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

    update@PlotPropOption(pr)
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

    pr.redraw@PlotPropOption(varargin{:})
end
function lock_measures_prop(pr)
    pe =  ancestor(pr.p, 'figure').UserData.get('PE');
    measure_panel =  pe.get('pr_dict').getItem('measures');
    val = get(pr.list_tbl, 'Value');
    str = get(pr.list_tbl, 'String');
    str = str{val};
    if strcmp(str, 'graph_measures')
        measure_panel.cb_show_table();
    else
        measure_panel.cb_hide_table();
    end
    pe.redraw();
end