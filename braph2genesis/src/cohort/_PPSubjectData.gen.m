%% ¡header!
PPSubjectData < PlotProp (pl, plot property of subject data) is a plot of a subject data.

%%% ¡description!
PPSubjectData plots an adequate representation of the Subject data.

%%% ¡seealso!
GUI, PlotElement, PlotProp, Subejct, SubjectST, SubjectFUN, SubjectCON.

%% ¡properties!
pp
table_values

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

    el = pl.get('EL');
    prop = pl.get('PROP');
    sub_data = el.getr(prop);   
    sub_data_format = el.getPropFormat(prop);
    sub_data_tag = el.getPropTag(prop);
    sub_ba = el.getr('BA'); 

    pl.pp = draw@PlotProp(pl, varargin{:});

    if isempty(pl.table_values) || ~isgraphics(pl.table_values, 'uitable')
        % construct a data holder
        value_subject_data = sub_data;
        br_idict = sub_ba.getr('BR_DICT');
        brs_labels = cellfun(@(x) x.get('Label'), br_idict.getItems());

        pl.table_values = uitable();
        set( pl.table_values, ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .96 .7], ...
            'ColumnName', brs_labels, ...
            'ColumnFormat', {'numeric'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', true, ...
            'CellEditCallback', {@cb_table_values} ...
            );

        if ~isequal(value_subject_data, NoValue)            
            set(pl.table_values, 'Data', value_subject_data);
            set(pl.table_values, 'ColumnWidth', 'auto')
        end
    end

    % callbacks
        function cb_table_values(~, event)
            m = event.Indices(1);
            col = event.Indices(2);
            sub_data(m, col) = event.NewData;
            el.set('sub_data_tag');
            pl.update()
        end        

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

    value = el.getr(prop);


    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        %
    else

        if isempty(pl.table_values)
            pl.table_values = cell(size(value, 1), size(value, 2));
        end

        set(pl.table_values, ...
            'Data', value, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)] ...
            )

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

    pl.redraw@PlotProp('Height', 20, varargin{:});
end
function selected = getSelected(pl)
    selected = pl.selected;
end