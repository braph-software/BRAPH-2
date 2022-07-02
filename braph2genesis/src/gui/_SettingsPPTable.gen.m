%% ¡header!
SettingsPPTable < PanelProp (pr, settings text panel) plots the panel with text settings.

%%% ¡description!
PanelPropIDictTable plots the panel of a ITEM property containing a Settings element with a 1-row table.
It works for all categories.

It provides some standard basic functionalities.
It can be personalized with the following props:
 COLS - Numerical array with the columns to be visualized.
 ROWNAME - Code to generate the row names as per uitable format.
 COLUMNAME - Code to generate the column names as per uitable format.
 COLUMNWIDTH - Code to determine the cloumn width as per uitable format.
 COLUMNEDITABLE - Code to determine the cloumn editability as per uitable format.
 COLUMNFORMAT - Code to determine the cloumn format as per uitable format.
 CB_TAB_EDIT - Code in a cell array for the edit callback to be evaluated 
  by the table edit callback. It can refer to the variables:
   el, prop, dict, it_class, pr, i, col, newdata
  and use the standard callback function:
   cb_table_edit_default()
   
%%% ¡seealso!
Settings, uitable

%% ¡props!

%%% ¡prop!
TAB_H (gui, size) is the height of the table in fontsize units.
%%%% ¡default!
5

%%% ¡prop!
COLS (gui, rvector) is the ordered list of columns.
%%%% ¡conditioning!
if iscolumn(value)
    value = value';
end

%%% ¡prop!
ROWNAME (gui, string) determines the table row names (to be evaluated).

%%% ¡prop!
COLUMNNAME (gui, string) determines the table column names (to be evaluated).

%%% ¡prop!
COLUMNWIDTH (gui, string) determines the column widths (to be evaluated).

%%% ¡prop!
COLUMNEDITABLE (gui, string) determines whether the columns are editable (to be evaluated).

%%% ¡prop!
COLUMNFORMAT (gui, string) determines the columns formats (to be evaluated).

%%% ¡prop!
CB_TAB_EDIT (gui, string) is executed when a cell is updated (to be evaluated).
%%%% ¡conditioning!
if iscell(value)
    value = sprintf('%s;', value{:});
end

%% ¡properties!
p
table

%% ¡methods!
function p_out = draw(pr, varargin)
    
    pr.p = draw@PanelProp(pr, varargin{:});
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    st = el.get(prop);

    if ~check_graphics(pr.table, 'uitable')
        pr.table = uitable( ...
            'Parent', pr.p, ...
            'Tag', 'table', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'ColumnSortable', false, ...
            'CellEditCallback', {@cb_table_edit} ...
            );       
    end
    function cb_table_edit(~, event) % (src, event)
        cols = pr.get('COLS');
        pr.cb_table_edit(event.Indices(1), cols(event.Indices(2)), event.NewData) % cols(event.Indices(1)) == 1
    end
    
    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    st = el.get(prop);
    
    function set_table()

        if isempty(pr.get('COLS'))
            pr.set('COLS', st.getProps(Category.FIGURE));
        end
        cols = pr.get('COLS');

        data = cell(1, length(cols));
        for c = 1:1:length(cols)
            col = cols(c);
            switch st.getPropFormat(col)
                % % % case Format.EMPTY

                case Format.STRING
                    data{1, c} = st.get(col);

                case Format.LOGICAL
                    data{1, c} = st.get(col);

                case Format.OPTION
                    data{1, c} = st.get(col);

                % % % case Format.CLASS

                % % % case Format.CLASSLIST

                case Format.ITEM
                    data{1, c} = st.get(col).tostring();

                % % % case Format.ITEMLIST

                % % % case Format.IDICT

                case Format.SCALAR
                    data{1, c} = st.get(col);

                case {Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
                    prop_value = st.get(col);
                    data{1, c} = [int2str(size(prop_value, 1)) ' x ' int2str(size(prop_value, 2))];

                % % % case Format.CELL

                % % % case Format.NET

                case Format.COLOR
                    rgb = st.get(col);
                    data{1, c} = [dec2hex(round(rgb(1) * 255), 2) dec2hex(round(rgb(2) * 255), 2) dec2hex(round(rgb(3) * 255), 2)];

                case Format.ALPHA
                    data{1, c} = st.get(col);

                case Format.SIZE
                    data{1, c} = st.get(col);

                case Format.MARKER
                    data{1, c} = st.get(col);

                case Format.LINE
                    data{1, c} = st.get(col);
            end
        end

        if ~isempty(pr.get('ROWNAME'))
            rowname = eval(pr.get('ROWNAME'));
        else
            rowname = '';
        end

        if ~isempty(pr.get('COLUMNNAME'))
            columnname = eval(pr.get('COLUMNNAME'));
        else
            columnname = repmat({''}, 1, length(cols));
            for c = 1:1:length(cols)
                col = cols(c);
                columnname{c} = st.getPropTag(col);
            end
        end

        if ~isempty(pr.get('COLUMNWIDTH'))
            columnwidth = eval(pr.get('COLUMNWIDTH'));
        else
            columnwidth = 'auto';
        end

        if ~isempty(pr.get('COLUMNEDITABLE'))
            columneditable = eval(pr.get('COLUMNEDITABLE'));
        else
            columneditable = false(1, length(cols));
            for c = 1:1:length(cols)
                col = cols(c);
                if ~el.isLocked(prop)
                    switch st.getPropFormat(col)
                        % % % case Format.EMPTY

                        case Format.STRING 
                            columneditable(c) = true;

                        case Format.LOGICAL 
                            columneditable(c) = true;

                        case Format.OPTION 
                            columneditable(c) = true;

                        % % % case Format.CLASS

                        % % % case Format.CLASSLIST

                        case Format.ITEM
                            columneditable(c) = false;

                            % % % case Format.ITEMLIST

                            % % % case Format.IDICT

                        case Format.SCALAR 
                            columneditable(c) = true;

                        case {Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
                            columneditable(c) = false;

                            % % % case Format.CELL

                            % % % case Format.NET

                        case Format.COLOR 
                            columneditable(c) = true;

                        case Format.ALPHA 
                            columneditable(c) = true;

                        case Format.SIZE 
                            columneditable(c) = true;

                        case Format.MARKER 
                            columneditable(c) = true;

                        case Format.LINE 
                            columneditable(c) = true;
                    end                        
                end
            end
        end

        if ~isempty(pr.get('COLUMNFORMAT'))
            columnformat = pr.get('COLUMNFORMAT');
        else
            columnformat = repmat({''}, 1, length(cols));
            for c = 1:1:length(cols)
                col = cols(c);
                switch st.getPropFormat(col)
                    % % % case Format.EMPTY

                    case Format.STRING
                        columnformat{c} = 'char';

                    case Format.LOGICAL
                        columnformat{c} = 'logical';

                    case Format.OPTION
                        columnformat{c} = st.getPropSettings(col);

                    % % % case Format.CLASS

                    % % % case Format.CLASSLIST

                    case Format.ITEM
                        columnformat{c} = 'char';

                    % % % case Format.ITEMLIST

                    % % % case Format.IDICT

                    case Format.SCALAR
                        columnformat{c} = 'numeric';

                    case {Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
                        columnformat{c} = 'char';

                    % % % case Format.CELL

                    % % % case Format.NET

                    case Format.COLOR
                        columnformat{c} = 'char';

                    case Format.ALPHA
                        columnformat{c} = 'numeric';

                    case Format.SIZE
                        columnformat{c} = 'numeric';

                    case Format.MARKER
                        columnformat{c} = st.getPropSettings(col);

                    case Format.LINE
                        columnformat{c} = st.getPropSettings(col);
                end            
            end
        end

        set(pr.table, ...
            'Data', data, ...
            'RowName', rowname, ...
            'ColumnName', columnname, ...
            'ColumnWidth', columnwidth, ...
            'ColumnEditable', columneditable, ...
            'ColumnFormat', columnformat ...
            )
        
        % style COLOR
        styles_cell = find(pr.table.StyleConfigurations.Target == 'cell');
        if isempty(styles_cell)
            for c = 1:1:length(cols)
                col = cols(c);
                if col > 0 && isequal(st.getPropFormat(col), Format.COLOR)
                    addStyle(pr.table, ...
                        uistyle('FontColor', st.get(col)), ...
                        'cell', [1, c] ...
                        )
                end
            end
        else
            for c = 1:1:length(cols)
                col = cols(c);
                if col > 0 && isequal(st.getPropFormat(col), Format.COLOR)
                    cell_to_be_removed = find(cellfun(@(x) isequal(x, [1, c]), pr.table.StyleConfigurations.TargetIndex));
                    if ~isempty(cell_to_be_removed)
                        current_rgb = pr.table.StyleConfigurations.Style(cell_to_be_removed).FontColor;
                        new_rgb = st.get(col);
                        if ~isequal(current_rgb, new_rgb)
                            removeStyle(pr.table, cell_to_be_removed)
                            addStyle(pr.table, ...
                                uistyle('FontColor', new_rgb), ...
                                'cell', [1, c] ...
                                )
                        end
                    end
                end
            end
        end
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set_table()

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set_table()
            
            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.table, 'ColumnEditable', false)
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                % don't plot anything for a result not yet calculated
                set(pr.table, 'Visible', 'off')
            else
                set_table()
                set(pr.table, 'Visible', 'on')
            end
    end   
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel. 
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(30)
    %
    % See also draw, update, PanelElement, s.

    [h, varargin] = get_and_remove_from_varargin(s(2), 'Height', varargin);
    Dh = s(pr.get('TAB_H'));
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PanelProp('Height', h, varargin{:})
    else
        pr.redraw@PanelProp('Height', h + Dh, varargin{:})
        drawnow()
        
        set(pr.table, ...
            'Units', 'pixels', ...
            'Position', [s(.3) s(.3) w(pr.p, 'pixels')-s(.6) Dh-s(.6)] ...
            )
    end
end
function cb_table_edit(pr, i, col, newdata)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    st = el.get(prop);
    
    if ~isempty(pr.get('CB_TAB_EDIT'))
        eval(pr.get('CB_TAB_EDIT'))
    else
        cb_table_edit_default()
    end
    function cb_table_edit_default()

        switch st.getPropFormat(col)
            % % % case Format.EMPTY

            case Format.STRING
                st.set(col, newdata)

            case Format.LOGICAL
                st.set(col, newdata)

            case Format.OPTION
                st.set(col, newdata)

            % % % case Format.CLASS

            % % % case Format.CLASSLIST

            case Format.ITEM
                %

            % % % case Format.ITEMLIST

            % % % case Format.IDICT

            case Format.SCALAR
                st.set(col, newdata)

            case {Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
                %

            % % % case Format.CELL

            % % % case Format.NET

            case Format.COLOR
                try
                    rgb = [hex2dec(newdata(1:2))/255 hex2dec(newdata(3:4))/255 hex2dec(newdata(5:6))/255];
                    st.set(col, rgb)
                catch
                    %
                end

            case Format.ALPHA
                st.set(col, min(abs(newdata), 1))

            case Format.SIZE
                st.set(col, abs(newdata))

            case Format.MARKER
                st.set(col, newdata)

            case Format.LINE
                st.set(col, newdata)
        end
    end
    
    pr.update()
end