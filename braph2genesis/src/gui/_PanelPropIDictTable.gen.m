%% ¡header!
PanelPropIDictTable < PanelProp (pr, panel property idict) plots the panel of a property idict in a table.

%%% ¡description!
PanelPropIDictTable plots the panel of an IDICT property with a table.
It works for all categories.

It provides some standard basic dunctionalities.
It can be personalized with the following props:
 COLS - Numerical array with the columns to be visualized. It can include 
  PanelPropIDictTable.SELECTOR and/or prop numbers of the item class.
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

%%% ¡prop!
MENU_OPEN (gui, logical) determines whether to show the context menu to open the items.
%%%% ¡default!
false

%%% ¡prop!
MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
%%%% ¡default!
true

%% ¡properties!
p
table
selected

contextmenu
%
menu_select_all
menu_clear_selection
menu_invert_selection
%
menu_apply_to_selection
%
menu_open_selection
menu_hide_selection
menu_hide_all
%
menu_colorize_table
% 
menu_export_to_xls

f_its % figures for items

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
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    dict = el.get(prop);
    it_class = dict.get('IT_CLASS');
    
    if ~check_graphics(pr.contextmenu, 'uicontextmenu')
        pr.contextmenu = uicontextmenu( ...
            'Parent', ancestor(pr.p, 'figure'), ...
            'Tag', 'contextmenu' ...
            );
        pr.menu_select_all = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_select_all', ...
            'Text', 'Select All', ...
            'MenuSelectedFcn', {@cb_select_all} ...
            );
        pr.menu_clear_selection = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_clear_selection', ...
            'Text', 'Clear Selection', ...
            'MenuSelectedFcn', {@cb_clear_selection} ...
            );
        pr.menu_invert_selection = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_invert_selection', ...
            'Text', 'Invert Selection', ...
            'MenuSelectedFcn', {@cb_invert_selection} ...
            );
        pr.menu_apply_to_selection = uimenu( ...
            'Separator', 'on', ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_apply_to_selection', ...
            'Text', 'Apply to Selection', ...
            'Checked', false, ...
            'MenuSelectedFcn', {@cb_apply_to_selection} ...
            );
        if pr.get('MENU_OPEN')
            pr.menu_open_selection = uimenu( ...
                'Separator', 'on', ...
                'Parent', pr.contextmenu, ...
                'Tag', 'menu_open_selection', ...
                'Text', 'Open Selection', ...
                'MenuSelectedFcn', {@cb_open_selection} ...
                );
            pr.menu_hide_selection = uimenu( ...
                'Parent', pr.contextmenu, ...
                'Tag', 'menu_hide_selection', ...
                'Text', 'Hide Selection', ...
                'MenuSelectedFcn', {@cb_hide_selection} ...
                );
            pr.menu_hide_all = uimenu( ...
                'Parent', pr.contextmenu, ...
                'Tag', 'menu_hide_all', ...
                'Text', 'Hide all', ...
                'MenuSelectedFcn', {@cb_hide_all} ...
                );
        end
        if (isempty(pr.get('COLS')) && any(cellfun(@(prop) isequal(Element.getPropFormat(it_class, prop), Format.COLOR), num2cell(Element.getProps(it_class))))) ...
                || any(cellfun(@(prop) prop > 0 && isequal(Element.getPropFormat(it_class, prop), Format.COLOR), num2cell(pr.get('COLS'))))
            pr.menu_colorize_table = uimenu( ...
                'Separator', 'on', ...
                'Parent', pr.contextmenu, ...
                'Tag', 'menu_colorize_table', ...
                'Text', 'Colorize Table', ...
                'Checked', false, ...
                'MenuSelectedFcn', {@cb_colorize_table} ...
                );
        end
        if pr.get('MENU_EXPORT')
            pr.menu_export_to_xls = uimenu( ...
                'Separator', 'on', ...
                'Parent', pr.contextmenu, ...
                'Tag', 'menu_export_to_xls', ...
                'Text', 'Export to XLS', ...
                'MenuSelectedFcn', {@cb_export_to_xls});
        end
    end
    function cb_select_all(~, ~) 
        pr.cb_select_all()
    end
    function cb_clear_selection(~, ~) 
        pr.cb_clear_selection()
    end
    function cb_invert_selection(~, ~) 
        pr.cb_invert_selection()
    end
    function cb_apply_to_selection(~, ~) 
        if get(pr.menu_apply_to_selection, 'Checked')
            pr.cb_apply_to_selection(false)
        else
            pr.cb_apply_to_selection(true)
        end
    end
    function cb_open_selection(~, ~) 
        pr.cb_open_selection()
    end
    function cb_hide_selection(~, ~) 
        pr.cb_hide_selection()
    end
    function cb_hide_all(~, ~) 
        pr.cb_hide_all()
    end
    function cb_colorize_table(~, ~) 
        if get(pr.menu_colorize_table, 'Checked')
            pr.cb_colorize_table(false)
        else
            pr.cb_colorize_table(true)
        end
    end
    function cb_export_to_xls(~, ~)
        pr.cb_export_to_xls()
    end

    if ~check_graphics(pr.table, 'uitable')
        pr.table = uitable( ...
            'Parent', pr.p, ...
            'Tag', 'table', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'ColumnSortable', true, ...
            'CellEditCallback', {@cb_table_edit} ...
            );       
    end
    if isempty(pr.get('COLS')) || ismember(pr.SELECTOR, pr.get('COLS'))
        set(pr.table, 'ContextMenu', pr.contextmenu)
    end
    function cb_table_edit(~, event) % (src, event)
        if ~get(pr.menu_apply_to_selection, 'Checked')
            cols = pr.get('COLS');
            pr.cb_table_edit(event.Indices(1), cols(event.Indices(2)), event.NewData)
        else
            cols = pr.get('COLS');

            % adds current item to selected
            if cols(event.Indices(2)) == pr.SELECTOR
                pr.cb_table_edit(event.Indices(1), pr.SELECTOR, event.NewData)
            else
                pr.cb_table_edit(event.Indices(1), pr.SELECTOR, true)
            end
            
            % updates all selected
            for s = 1:1:length(pr.selected)
                pr.cb_table_edit(pr.selected(s), cols(event.Indices(2)), event.NewData)
            end
        end
        
        pr.update() % placed here for numerical efficiency
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
    
    function set_table()
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
                    switch Element.getPropFormat(it_class, col)
                        % % % case Format.EMPTY

                        case Format.STRING
                            data{i, c} = dict.getItem(i).get(col);

                        case Format.LOGICAL
                            data{i, c} = dict.getItem(i).get(col);

                        case Format.OPTION
                            data{i, c} = dict.getItem(i).get(col);

                        % % % case Format.CLASS

                        % % % case Format.CLASSLIST

                        case Format.ITEM
                            data{i, c} = dict.getItem(i).get(col).tostring();

                        % % % case Format.ITEMLIST

                        % % % case Format.IDICT

                        case Format.SCALAR
                            data{i, c} = dict.getItem(i).get(col);

                        case {Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
                            prop_value = dict.getItem(i).get(col);
                            data{i, c} = [int2str(size(prop_value, 1)) ' x ' int2str(size(prop_value, 2))];

                        % % % case Format.CELL

                        % % % case Format.NET

                        case Format.COLOR
                            rgb = dict.getItem(i).get(col);
                            data{i, c} = [dec2hex(round(rgb(1) * 255), 2) dec2hex(round(rgb(2) * 255), 2) dec2hex(round(rgb(3) * 255), 2)];

                        case Format.ALPHA
                            data{i, c} = dict.getItem(i).get(col);

                        case Format.SIZE
                            data{i, c} = dict.getItem(i).get(col);

                        case Format.MARKER
                            data{i, c} = dict.getItem(i).get(col);

                        case Format.LINE
                            data{i, c} = dict.getItem(i).get(col);
                    end            
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

        if ~isempty(pr.get('COLUMNEDITABLE'))
            columneditable = eval(pr.get('COLUMNEDITABLE'));
        else
            columneditable = false(1, length(cols));
            for c = 1:1:length(cols)
                col = cols(c);
                if col == pr.SELECTOR
                    columneditable(c) = true; % always true
                else
                    if ~el.isLocked(prop)
                        switch Element.getPropFormat(it_class, col)
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
                            columnformat{c} = Element.getPropSettings(it_class, col);

                        case Format.LINE
                            columnformat{c} = Element.getPropSettings(it_class, col);
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
        
        % style SELECTED
        styles_row = find(pr.table.StyleConfigurations.Target == 'row');
        if ~isempty(styles_row)
            removeStyle(pr.table, styles_row)
        end
        if ~isempty(pr.selected)
            addStyle(pr.table, uistyle('FontWeight', 'bold'), 'row', pr.selected)
        end
        
        % style COLOR
        styles_cell = find(pr.table.StyleConfigurations.Target == 'cell');
        if get(pr.menu_colorize_table, 'Checked')
            if isempty(styles_cell)
                for c = 1:1:length(cols)
                    col = cols(c);
                    if col > 0 && isequal(Element.getPropFormat(it_class, col), Format.COLOR)                            
                        for i = 1:1:dict.length()
                            addStyle(pr.table, ...
                                uistyle('FontColor', dict.getItem(i).get(col)), ...
                                'cell', [i, c] ...
                                )
                        end
                    end
                end
            else
                for c = 1:1:length(cols)
                    col = cols(c);
                    if col > 0 && isequal(Element.getPropFormat(it_class, col), Format.COLOR)
                        for i = 1:1:dict.length()
                            cell_to_be_removed = find(cellfun(@(x) isequal(x, [i, c]), pr.table.StyleConfigurations.TargetIndex));
                            if ~isempty(cell_to_be_removed)
                                current_rgb = pr.table.StyleConfigurations.Style(cell_to_be_removed).FontColor;
                                new_rgb = dict.getItem(i).get(col);
                                if ~isequal(current_rgb, new_rgb)
                                    removeStyle(pr.table, cell_to_be_removed)
                                    addStyle(pr.table, ...
                                        uistyle('FontColor', new_rgb), ...
                                        'cell', [i, c] ...
                                        )
                                end
                            end
                        end
                    end
                end
            end
        else
            if ~isempty(styles_cell)
                removeStyle(pr.table, styles_cell)
            end
        end
    end

% % %     if el.isLocked(prop)
% % %         set(pr.table, 'ColumnEditable', false)
% % % % % %         set(pr.table, ...
% % % % % %             'Enable', pr.get('ENABLE'), ...
% % % % % %             'ColumnEditable', false ...
% % % % % %             )
% % %     end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set_table()

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set_table()
            
            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.table, 'ColumnEditable', false)
% % %                 set(pr.table, ...
% % %                     'Enable', pr.get('ENABLE'), ...
% % %                     'ColumnEditable', false ...
% % %                     )
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                % don't plot anything for a result not yet calculated
                set(pr.table, 'Visible', 'off')
            else
                set_table()
                set(pr.table, 'Visible', 'on')
% % %                 set(pr.table, ...
% % %                     'Enable', pr.get('ENABLE'), ...
% % %                     'ColumnEditable', false, ...
% % %                     'Visible', 'on' ...
% % %                     )                
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
                    if col == dict.get('IT_KEY')
                        if ~dict.containsKey(newdata)
                            % change brain region id
                            dict.getItem(i).set('ID', newdata)
                            % change brain region key in idict
                            oldkey = dict.getKey(i);
                            dict.replaceKey(dict.getKey(i), newdata);
                        end
                    else
                        dict.getItem(i).set(col, newdata)
                    end
                    
                case Format.LOGICAL
                    dict.getItem(i).set(col, newdata)

                case Format.OPTION
                    dict.getItem(i).set(col, newdata)

                % % % case Format.CLASS

                % % % case Format.CLASSLIST

                case Format.ITEM
                    %

                % % % case Format.ITEMLIST

                % % % case Format.IDICT

                case Format.SCALAR
                    dict.getItem(i).set(col, newdata)

                case {Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
                    %

                % % % case Format.CELL

                % % % case Format.NET

                case Format.COLOR
                    try
                        rgb = [hex2dec(newdata(1:2))/255 hex2dec(newdata(3:4))/255 hex2dec(newdata(5:6))/255];
                        dict.getItem(i).set(col, rgb)
                    catch
                        %
                    end

                case Format.ALPHA
                    dict.getItem(i).set(col, min(abs(newdata), 1))

                case Format.SIZE
                    if newdata ~= 0
                        dict.getItem(i).set(col, abs(newdata))
                    end

                case Format.MARKER
                    dict.getItem(i).set(col, newdata)

                case Format.LINE
                    dict.getItem(i).set(col, newdata)
            end
        end        
    end
    
    % pr.update() % placed above for numerical efficiency
end
function cb_select_all(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
    dict = el.get(prop);

    pr.selected = [1:1:dict.length()];

    pr.update()
end
function cb_clear_selection(pr)

    pr.selected = [];

    pr.update()
end
function cb_invert_selection(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
    dict = el.get(prop);

    selected_tmp = [1:1:dict.length()];
    selected_tmp(pr.selected) = [];
    pr.selected = selected_tmp;

    pr.update()
end
function cb_apply_to_selection(pr, checked)

    set(pr.menu_apply_to_selection, 'Checked', checked)
end
function cb_open_selection(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
    it_dict = el.get(prop);

    f = ancestor(pr.p, 'figure'); % parent GUI 
    N = ceil(sqrt(it_dict.length())); % number of row and columns of figures
    
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);

        it = it_dict.getItem(pr.selected(s));
        if length(pr.f_its) < i || ~check_graphics(pr.f_its{i}, 'figure')
            pr.f_its{i} = GUIElement( ...
                'PE', it, ... 
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
                    ], ...
                'CLOSEREQ', false ...
                ).draw();
        else
            figure(pr.f_its{i})
        end
    end
end
function cb_hide_selection(pr)

    % hides selected subfigures
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        f_it = pr.f_its{i};
        if check_graphics(f_it, 'figure')
            gui = get(f_it, 'UserData');
            gui.cb_hide()
        end
    end
end
function cb_hide_all(pr)

    % hides subfigures
    for i = 1:1:length(pr.f_its)
        f_it = pr.f_its{i};
        if check_graphics(f_it, 'figure')
            gui = get(f_it, 'UserData');
            gui.cb_hide()
        end
    end
end
function cb_colorize_table(pr, checked)

    set(pr.menu_colorize_table, 'Checked', checked)
    
    pr.update()    
end
function cb_export_to_xls(pr)
    %CB_EXPORT_DATA exports selected data from uitable to an XLSX file.
    
    if isempty(pr.selected)
        el = pr.get('EL');
        prop = pr.get('PROP');
        dict = el.get(prop);

        selected = [1:1:dict.length()];
    else
        selected = pr.selected;
    end
    
    % create data table
    data = pr.table.Data(selected, :);
    columns = pr.table.ColumnName;
    rows = pr.table.RowName;
    % special rules: selection column, numbered rownames.
    if isempty(columns{1})
        columns{1} = 'sel';
    end
    if isequal(rows, 'numbered')
        rows = cellfun(@(x) num2str(x), num2cell(selected), 'UniformOutput', false)';
    elseif length(selected) ~= length(rows)
        rows = rows(reshape(selected, [1 length(selected)]));
    end
    
    t = cell2table(data, ...
        'VariableNames', columns, ...
        'RowNames', rows);

    % save file
    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        writetable(t, file, 'WriteRowNames', true);
    end
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to front the table figure and its subfigures.
    %
    % CB_BRING_TO_FRONT(PR) brings to front the table figure and its subfigures.
    %
    % See also cb_hide, cb_close.

    % brings to front settings panel
    pr.cb_bring_to_front@PanelProp();

    % brings to front subfigures
    for i = 1:1:length(pr.f_its)
        f_it = pr.f_its{i};
        if check_graphics(f_it, 'figure')
            gui = get(f_it, 'UserData');
            gui.cb_bring_to_front()
        end
    end
end
function cb_hide(pr)
    %CB_HIDE hides the table figure and its subfigures.
    %
    % CB_HIDE(PR) hides the table figure and its subfigures.
    %
    % See also cb_bring_to_front, cb_close.

    % hides settings panel
    pr.cb_hide@PanelProp();

    % hides subfigures
    for i = 1:1:length(pr.f_its)
        f_it = pr.f_its{i};
        if check_graphics(f_it, 'figure')
            gui = get(f_it, 'UserData');
            gui.cb_hide()
        end
    end
end
function cb_close(pr)
    %CB_CLOSE closes the table figure and its subfigures.
    %
    % CB_CLOSE(PR) closes the table figure and its subfigures.
    %
    % See also cb_bring_to_front, cb_hide.

    % closes settings panel
    pr.cb_close@PanelProp();

    % closes subfigures
    for i = 1:1:length(pr.f_its)
        f_it = pr.f_its{i};
        if check_graphics(f_it, 'figure')
            gui = get(f_it, 'UserData');
            gui.cb_close()
        end
    end
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