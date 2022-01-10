%% ¡header!
PPSubjectFUN_FUN < PlotPropMatrix (pl, plot subject functional data) represents the functional data of a subject.

%%% ¡description!
PPSubjectFUN_FUN represents the functional data of a subject.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, Subject, SubjectFUN.

%% ¡properties!
p
table_value

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws a table with the functional data of a subject.
    %
    % DRAW(PR) draws the property panel a table with the functional data of 
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
    % See also update, redraw, uipanel.
    
    pr.p = draw@PlotPropMatrix(pr, varargin{:});

    % retrieves the handle of the table
    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uitable')
            pr.table_value = children(i);
        end
    end
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    data = el.get(prop);
    % change columns for rows
    set(pr.table_value, ...
                'Data', data', ...

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content of the panel and its graphical objects.
    %
    % UPDATE(PR) updates the content of the panel and its graphical objects.
    %
    % Important note:
    % 1. UPDATE() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % See also draw, redraw, PlotElement.

    update@PlotPropMatrix(pr)
    
    pp_el = pr.get('EL');
    br_dict = pp_el.get('BA').get('br_dict');
    
    br_ids = cell(br_dict.length(), 1);
    time_stamps = cell(1, br_dict.length());
    for i = 1:1:br_dict.length()
        br = br_dict.getItem(i);
        br_id = br.get(BrainRegion.ID);
        if length(br_id) > 10
            br_id = [br_id(1:8) '..'];
        end
        br_ids{i} = br_id;
        time_stamps{i} = ['T:' num2str(i)];
    end
    
    set(pr.table_value, ...
        'ColumnName', time_stamps, ...
        'RowName', br_ids ...
        )
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
    % See also draw, update, PlotElement.
    
    pr.redraw@PlotPropMatrix(varargin{:});
end