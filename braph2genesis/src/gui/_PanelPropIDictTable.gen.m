%% ¡header!
PanelPropIDictTable < PanelProp (pr, panel property idict) plots the panel of a property idict in a table.

%%% ¡description!
% % % 

%%% ¡seealso!
GUI, PanelPropIDict, uitable

%% ¡props!

%%% ¡prop!
TAB_H (gui, size) is the height of the table in fontsize units.
%%%% ¡default!
30

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
selected

%% ¡constants!
SELECTOR = -1

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the idict property.
    %
    % DRAW(PR) draws the panel of the idict property.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.
    
    pr.p = draw@PanelProp(pr, varargin{:});

    if ~check_graphics(pr.table, 'uitable')
        pr.table = uitable( ...
            'Parent', pr.p, ...
            'Tag', 'table', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'ColumnSortable', true, ...
            'CellEditCallback', {@cb_table_edit} ...
            );
    end
    
    function cb_table_edit(~, event) % (src, event)
        cols = pr.get('COLS');
        pr.cb_table_edit(event.Indices(1), cols(event.Indices(2)), event.NewData)
    end
    
    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the table.
    %
    % UPDATE(PR) updates the content and permissions of the table.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    dict = el.get(prop);
    it_class = dict.get('IT_CLASS');

    % columns to be to be shown in the table
    % col = pr.SELECTOR for the selector column
    % col = prop for the prop columns
    if isempty(pr.get('COLS'))
        pr.set('COLS', [pr.SELECTOR; Element.getProps(it_class)]);
    end
    cols = pr.get('COLS');
    
    data = cell(dict.length(), length(cols));
    for i = 1:1:dict.length()
        for c = 1:1:length(cols)
            col = cols(c);
            if col == pr.SELECTOR
                if any(pr.selected == i)
                    data{i, c} = true;
                else
                    data{i, c} = false;
                end
            elseif Element.existsProp(it_class, col) % prop = col;
                data{i, c} = dict.getItem(i).get(col);
            end
        end
    end

    if ~isempty(pr.get('ROWNAME'))
        rowname = eval(pr.get('ROWNAME'));
    else
        rowname = cellfun(@(it) it.get(dict.get('IT_KEY')), dict.get('IT_LIST'), 'UniformOutput', false);
    end
    
    if ~isempty(pr.get('COLUMNNAME'))
        columnname = eval(pr.get('COLUMNNAME'));
    else
        columnname = repmat({''}, 1, length(cols));
        for c = 1:1:length(cols)
            col = cols(c);
            if col == pr.SELECTOR
                columnname{c} = '';
            elseif Element.existsProp(it_class, col) % prop = col;
                columnname{c} = Element.getPropTag(it_class, col);
            end
        end
    end

    if ~isempty(pr.get('COLUMNWIDTH'))
        columnwidth = eval(pr.get('COLUMNWIDTH'));
    else
        columnwidth = 'auto';
    end
    
    if ~isempty(pr.get('COLUMNWIDTH'))
        columneditable = eval(pr.get('COLUMNEDITABLE'));
    else
        columneditable = true(1, length(cols));
    end
    
    if ~isempty(pr.get('COLUMNFORMAT'))
        columnformat = pr.get('COLUMNFORMAT');
    else
        columnformat = repmat({''}, 1, length(cols));
        for c = 1:1:length(cols)
            col = cols(c);
            if col == pr.SELECTOR
                columnformat{c} = 'logical';
            elseif Element.existsProp(it_class, col) % prop = col;
                switch Element.getPropFormat(it_class, col)
                    % % % case Format.EMPTY
                    
                    case Format.STRING
                        columnformat{c} = 'char';

                    case Format.LOGICAL
                        columnformat{c} = 'logical';

                    case Format.OPTION
                        columnformat{c} = Element.getPropSettings(it_class, col);

                    % % % case Format.CLASS
                    
                    % % % case Format.CLASSLIST
                    
                    % % % case Format.ITEM
                    
                    % % % case Format.ITEMLIST
                    
                    % % % case Format.IDICT
                    
                    case Format.SCALAR
                        columnformat{c} = 'numeric';

                    % % % case Format.RVECTOR
                    
                    % % % case Format.CVECTOR
                    
                    % % % case Format.MATRIX
                    
                    % % % case Format.SMATRIX
                    
                    % % % case Format.CELL
                    
                    % % % case Format.NET
                    
                    % % % case Format.COLOR
                    
                    % % % case Format.ALPHA
                    % % %     columnformat{c} = 'numeric';
                    
                    % % % case Format.SIZE
                    % % %     columnformat{c} = 'numeric';
                    
                    % % % case Format.MARKER
                    % % %     columnformat{c} = Element.getPropSettings(it_class, col);
                    
                    % % % case Format.LINE
                    % % %     columnformat{c} = Element.getPropSettings(it_class, col);
                end            
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

% % % % % %     if el.isLocked(prop)
% % % % % %         set(pr.table, ...
% % % % % %             'Enable', pr.get('TAB_ENABLE'), ...
% % % % % %             'ColumnEditable', false ...
% % % % % %             )
% % % % % %     end
% % % % % % 
% % % % % %     switch el.getPropCategory(prop)
% % % % % %         case Category.METADATA
% % % % % %             set(pr.table, ...
% % % % % %                 'Data', el.get(prop), ...
% % % % % %                 'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
% % % % % %                 'ColumnEditable', true)
% % % % % % 
% % % % % %         case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
% % % % % %             set(pr.table, ...
% % % % % %                 'Data', el.get(prop), ...
% % % % % %                 'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
% % % % % %                 'ColumnEditable', true)
% % % % % %             
% % % % % %             value = el.getr(prop);
% % % % % %             if isa(value, 'Callback')
% % % % % %                 set(pr.table, ...
% % % % % %                 'Enable', pr.get('TAB_ENABLE'), ...
% % % % % %                 'ColumnEditable', false ...
% % % % % %                 )
% % % % % %             end
% % % % % % 
% % % % % %         case Category.RESULT
% % % % % %             value = el.getr(prop);
% % % % % % 
% % % % % %             if isa(value, 'NoValue')
% % % % % %                 % don't plot anything for a result not yet calculated
% % % % % %                 set(pr.table, 'Visible', 'off')
% % % % % %             else
% % % % % %                 set(pr.table, ...
% % % % % %                     'Data', el.get(prop), ...
% % % % % %                     'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
% % % % % %                     'Enable', pr.get('TAB_ENABLE'), ...
% % % % % %                     'ColumnEditable', false, ...
% % % % % %                     'Visible', 'on' ...
% % % % % %                     )
% % % % % %             end
% % % % % %     end   
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
    Dh = s(get(pr, 'TAB_H'));
    
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
    dict = el.get(prop);
    it_class = dict.get('IT_CLASS');
    
    if ~isempty(pr.get('CB_TAB_EDIT'))
        eval(pr.get('CB_TAB_EDIT'))
    else
        cb_table_edit_default()
    end
    function cb_table_edit_default()
        if col == pr.SELECTOR
            if newdata == 1
                pr.selected = sort(unique([pr.selected(:); i]));
            else
                pr.selected = pr.selected(pr.selected ~= i);
            end
        elseif Element.existsProp(it_class, col) % prop = col;
            switch Element.getPropFormat(it_class, col)
                % % % case Format.EMPTY

                case Format.STRING
                    dict.getItem(i).set(col, newdata)

                case Format.LOGICAL
                    dict.getItem(i).set(col, newdata)

                case Format.OPTION
                    dict.getItem(i).set(col, newdata)

                % % % case Format.CLASS

                % % % case Format.CLASSLIST

                % % % case Format.ITEM

                % % % case Format.ITEMLIST

                % % % case Format.IDICT

                case Format.SCALAR
                    dict.getItem(i).set(col, newdata)

                % % % case Format.RVECTOR

                % % % case Format.CVECTOR

                % % % case Format.MATRIX

                % % % case Format.SMATRIX

                % % % case Format.CELL

                % % % case Format.NET

                % % % case Format.COLOR

                % % % case Format.ALPHA
                % % %     dict.getItem(i).set(col, newdata)

                % % % case Format.SIZE
                % % %     dict.getItem(i).set(col, newdata)

                % % % case Format.MARKER
                % % %     dict.getItem(i).set(col, newdata)

                % % % case Format.LINE
                % % %     dict.getItem(i).set(col, newdata)
            end
        end        
    end
    
    pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% % % % % % % draws PanelPropIDictTable and calls update() and redraw()
% % % % % % % note that it doesn't work for category RESULT 
% % % % % % % because it needs to be used with PanelElement() and GUI()
% % % % % % fig1 = uifigure();
% % % % % % et = ETA();
% % % % % % props = [et.PROP_IDICT_M et.PROP_IDICT_P et.PROP_IDICT_D et.PROP_IDICT_F et.PROP_IDICT_G et.PROP_IDICT_R et.PROP_IDICT_R_CALC];
% % % % % % for i = 1:1:length(props)
% % % % % %     pr{i} = PanelPropIDictTable('EL', et, 'PROP', props(i));
% % % % % %     pr{i}.draw( ...
% % % % % %         'Parent', fig1, ...
% % % % % %         'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
% % % % % %         )
% % % % % %     pr{i}.update()
% % % % % %     pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
% % % % % % end
% % % % % % close(fig1)