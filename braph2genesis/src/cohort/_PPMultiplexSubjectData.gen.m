%% ¡header!
PPMultiplexSubjectData < PlotProp (pl, plot property of multiplex subject data) is a plot of a multiplex subject data.

%%% ¡description!
PPMultiplexSubjectData plots an adequate representation of the Multiplex Subject data.

%%% ¡seealso!
GUI, PlotElement, PlotProp, Subejct, SubjectST_MP, SubjectFUN_MP, SubjectCON_FUN_MP.

%% ¡properties!
pp
table_value_cell

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the idict for brain atlas property graphical panel.
    %
    % DRAW(PL) draws the idict property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the idict property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    pl.pp = draw@PlotProp(pl, varargin{:});
    
    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, redraw, refresh.

    update@PlotProp(pl)

    el = pl.get('EL');
    prop = pl.get('PROP');
    sub_br_dict = el.get('BA').get('BR_DICT');

    value = el.getr(prop);
    
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        %
    else
        value_cell = el.get(prop);
        if isempty(pl.table_value_cell)
            pl.table_value_cell = cell(size(value_cell));
        end
        brs_labels = cellfun(@(x) x.get('ID'), sub_br_dict.getItems(), 'UniformOutput', false);
        for i = 1:1:size(pl.table_value_cell, 1)
            for j = 1:1:size(pl.table_value_cell, 2)
                if isempty(pl.table_value_cell{i, j}) || ~isgraphics(pl.table_value_cell{i, j}, 'uitable')
                    pl.table_value_cell{i, j} = uitable('Parent', pl.pp);
                end
                if isequal(upper(el.getPropTag(prop)), 'ST_MP')
                    val = value_cell{i, j};
                    value_cell{i, j} = val';
                end
                set(pl.table_value_cell{i, j}, ...
                    'Data', value_cell{i, j}, ...
                    'ColumnName', brs_labels, ...
                    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                    'CellEditCallback', {@cb_matrix_value, i, j} ...
                    )
            end
        end        
    end
    function cb_matrix_value(src, event, i, j)
        value = el.get(prop);
        value_ij = value{i, j};
        value_ij(event.Indices(1), event.Indices(2)) = event.NewData;
        value{i, j} = value_ij;
        el.set(prop, value)
        
        pl.update()
    end
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.

    el = pl.get('EL');
    prop = pl.get('PROP');
    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pl.redraw@PlotProp('Height', 1.8, varargin{:})
    else
        value_cell = el.get(prop);
        
        if isempty(value_cell)
            pl.redraw@PlotProp('Height', 1.8, varargin{:})
        else
            pl.redraw@PlotProp('Height', 21.8, varargin{:})
        end
        
        for i = 1:1:size(value_cell, 1)
            for j = 1:1:size(value_cell, 2)
                set(pl.table_value_cell{i, j}, ...
                    'Units', 'character', ...
                    'Position', ...
                    [ ...
                    (0.01 + (i - 1) * 0.98 / size(pl.table_value_cell, 1)) * Plot.w(pl.pp) ...
                    (0.01 + (j - 1) * 0.98 / size(pl.table_value_cell, 2)) * (Plot.h(pl.pp) - 1.8) ...
                    0.98 / size(pl.table_value_cell, 1) * Plot.w(pl.pp) ...
                    0.98 / size(pl.table_value_cell, 2) * (Plot.h(pl.pp) - 1.8) ...
                    ] ...
                    )
            end
        end
    end
end
function selected = getSelected(pl)
    selected = pl.selected;
end