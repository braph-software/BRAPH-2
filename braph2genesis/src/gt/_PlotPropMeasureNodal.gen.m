%% ¡header!
PlotNodalMeasure < PlotPropMatrix (pl, plot nodal measure) represents the nodal measure.

%%% ¡description!
PlotNodalMeasure represents the nodal measure.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, PPMeasure_M.

%% ¡properties!
p
table_value

% FIXME: PL > PR, pl > pr

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws a table with the nodal measure.
    %
    % DRAW(PL) draws the property panel a table with the structural data of 
    %  a subject.
    %
    % H = DRAW(PL) returns a handle to the property panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the panel 
    %  with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, settings, uipanel.
    
    pl.p = draw@PlotPropMatrix(pl, varargin{:});

    % retrieves the handle of the table
    children = get(pl.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uitable')
            pl.table_value = children(i);
        end
    end

    % output
    if nargout > 0
        h_panel = pl.p;
    end
end
function update(pl, layer)
    %UPDATE updates the content of the property panel and its graphical objects.
    %
    % UPDATE(PL) updates the content of the property panel and its graphical objects.
    %
    % Important note:
    % 1. UPDATE() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % See also draw, redraw, PlotElement.

    update@PlotProp(pl)
    
    el = pl.get('EL');
    prop = pl.get('PROP');
    value = el.getr(prop);
    
    measure = pl.get('EL');
    br_dict = measure.get('G').get('BRAINATLAS').get('BR_DICT');

    br_ids = cell(br_dict.length(), 1);
    for i = 1:1:br_dict.length()
        br = br_dict.getItem(i);
        br_id = br.get(BrainRegion.ID);
        if length(br_id) > 10
            br_id = [br_id(1:8) '..'];
        end
        br_ids{i} = br_id;
    end

    set(pl.table_value, ...
        'Data', value{layer}, ...
        'ColumnName', {}, ...
        'RowName', br_ids ...
        )
end
function redraw(pl, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PL) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PL, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=1.4 characters.
    %
    % See also draw, update, PlotElement.
    
    pl.redraw@PlotPropMatrix(varargin{:});
end