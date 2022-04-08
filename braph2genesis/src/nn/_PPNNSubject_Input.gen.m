%% ¡header!
PPNNSubject_Input < PlotPropCell (pl, plot subject input data) represents the input data of a NN subject.

%%% ¡description!
PPSubjectCON_CON represents the connnectivity data of a subject.

%%% ¡seealso!
GUI, PlotElement, PlotPropCell, Subject.

%% ¡properties!
p
table_value_cell

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws a table with the connectivity data of a subject.
    %
    % DRAW(PR) draws the property panel a table with the connectivity data of 
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
    
    pr.p = draw@PlotPropCell(pr, varargin{:});

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
    % See also draw, redraw, refresh, PlotElement.

    update@PlotProp(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        % don't plot anything for a result not yet calculated
    else
        value_cell = el.get(prop);
        if isempty(pr.table_value_cell) || ~isequal(size(pr.table_value_cell), size(value_cell))
            pr.table_value_cell = cell(size(value_cell));
        end
        for r = 1:1:size(pr.table_value_cell, 1)
            for c = 1:1:size(pr.table_value_cell, 2)
                if ~check_graphics(pr.table_value_cell{r, c}, 'uitable')
                    pr.table_value_cell{r, c} = uitable('Parent', pr.p);
                end
                set(pr.table_value_cell{r, c}, ...
                    'Data', value_cell{r, c}, ...
                    'Tooltip', [num2str(r) ' ' num2str(c)], ...
                    'FontUnits', BRAPH2.FONTUNITS, ...
                    'FontSize', BRAPH2.FONTSIZE, ...
                    'ColumnEditable', true, ...
                    'CellEditCallback', {@cb_table_value_cell, r, c} ...
                    )
            end
        end

    end

    function cb_table_value_cell(~, event, r, c) % (src, event)
        pr.cb_table_value_cell(r, c, event.Indices(1), event.Indices(2), event.NewData)
    end

pp_el = pr.get('EL');
br_dict = pp_el.get('BA').get('br_dict');

br_ids = cell(br_dict.length(), 1);
for i = 1:1:br_dict.length()
    br = br_dict.getItem(i);
    br_id = br.get(BrainRegion.ID);
    if length(br_id) > 10
        br_id = [br_id(1:8) '..'];
    end
    br_ids{i} = br_id;
end
if any(ismember(subclasses('Graph'), pp_el.get('INPUT_LABEL')))
    set(pr.table_value_cell{1}, ...
        'ColumnName', br_ids, ...
        'RowName', br_ids ...
        )
elseif any(ismember(subclasses('Measure'), pp_el.get('INPUT_LABEL')))
    mlist = pp_el.get('INPUT_LABEL');
    mlist_nodal = [];
    mlist_global = [];
    mlist_binodal = [];
    for i = 1:length(mlist)
        if Measure.is_nodal(mlist{i})
            mlist_nodal = [mlist_nodal; mlist(i)];
        elseif Measure.is_global(mlist{i})
            mlist_global = [mlist_global; mlist(i)];
        else
            mlist_binodal = [mlist_binodal; mlist(i)];
        end
    end
    %global
    set(pr.table_value_cell{1}, ...
        'ColumnName', mlist_global, ...
        'RowName', 'global' ...
        )
    %nodal
    set(pr.table_value_cell{2}, ...
        'ColumnName', mlist_nodal, ...
        'RowName', br_ids ...
        )
    %binodal
    mlist_integrated_binodal = [];
    for i = 1:length(mlist_binodal)
        mlist_integrated_binodal = [mlist_integrated_binodal cellfun(@(x) x + string([' - ' mlist_binodal{i}]), br_ids, 'UniformOutpu', false)];
    end
    set(pr.table_value_cell{3}, ...
        'ColumnName', mlist_integrated_binodal, ...
        'RowName', br_ids ...
        )

elseif pp_el.get('INPUT_LABEL') == "ST"
    for i = 1:1:length(pr.table_value_cell)
        set(pr.table_value_cell{i}, ...
            'RowName', br_ids ...
            )
    end
else %% do nothing

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
    
    pr.redraw@PlotProp(varargin{:});

    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
    [Dh, varargin] = get_and_remove_from_varargin(20, 'DHeight', varargin);
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PlotProp('Height', h, varargin{:})
    else
        value_cell = el.get(prop);
        if isempty(value_cell)
            pr.redraw@PlotProp('Height', h, varargin{:})
        else
            pr.redraw@PlotProp('Height', h + Dh, varargin{:})
        end
        
        for r = 1:1:size(value_cell, 1)
            for c = 1:1:size(value_cell, 2)
                table_w = (.98 - .01) / size(value_cell, 2);
                table_h = (Dh / (h + Dh) - .02) / size(value_cell, 1);
                set(pr.table_value_cell{r, c}, ...
                    'Units', 'normalized', ...
                    'Position', ...
                        [ ...
                            .01 + (c - 1) * table_w ...
                            .02 + (size(value_cell, 1) - r) * table_h ...
                            table_w ...
                            table_h ...
                        ] ...
                    )
            end
        end
    end    
end