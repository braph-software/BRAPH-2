%% ¡header!
PlotPropMeasureEnsembleBinodal < PlotPropMatrix (pr, plot binodal measure ensemble) represents the binodal measure ensemble.

%%% ¡description!
PlotPropMeasureEnsembleBinodal represents the binodal measure ensemble.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, AnalyzeEnsemble, MeasureEnsemble.

%% ¡properties!
p
table_value

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws a table with the binodal measure.
    %
    % DRAW(PR) draws the property panel a table with the structural data of 
    %  a subject.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the panel 
    %  with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, settings, uipanel.
    
    pr.p = draw@PlotPropMatrix(pr, varargin{:});

    % retrieves the handle of the table
    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uitable')
            pr.table_value = children(i);
        end
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content of the property panel and its graphical objects.
    %
    % UPDATE(PR) updates the content of the property panel and its graphical objects.
    %
    % Important note:
    % 1. UPDATE() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % See also draw, redraw, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.getr(prop);
    
    g_dict = el.get('A').get('G_DICT');
    graph = g_dict.getItem(1);
    br_dict = graph.get('BRAINATLAS').get('BR_DICT');

    br_ids = cell(br_dict.length(), 1);
    for i = 1:1:br_dict.length()
        br = br_dict.getItem(i);
        br_id = br.get(BrainRegion.ID);
        if length(br_id) > 10
            br_id = [br_id(1:8) '..'];
        end
        br_ids{i} = br_id;
    end

    if iscell(value)
        value = value{1};
    end
    if isa(value, 'NoValue')
        set(pr.table_value, ...
            'ColumnName', {}, ...
            'RowName', br_ids ...
            )
    else
        set(pr.table_value, ...
            'Data', value, ...
            'ColumnName', {}, ...
            'RowName', br_ids ...
            )
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
    %  - HEIGHT=1.4 characters.
    %
    % See also draw, update, PlotElement.
    
    pr.redraw@PlotPropMatrix(varargin{:});
end