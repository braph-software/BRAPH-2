%% ¡header!
PanelPropCell < PanelProp (pr, panel property cell) plots the panel of a cell property in a table with sliders.

%%% ¡description!
PanelPropCell plots the panel of a CELL property with a table with sliders.
It works for all categories.

% % % It can be personalized with the following props:
% % %  ROWNAME - Code to generate the row names as per uitable format.
% % %  COLUMNAME - Code to generate the column names as per uitable format.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uitable, uislider

%% ¡props!

%%% ¡prop!
TAB_H (gui, size) is the height of the table in font size units.
%%%% ¡default!
20

%%% ¡prop!
XSLIDER (gui, logical) determines whether to show the xslider.
%%%% ¡default!
true

%%% ¡prop!
XSLIDERLABELS (gui, string) determines the xslider labels (to be evaluated).
%%%% ¡default!
'cellfun(@(x) tostring(x), num2cell([1:1:C]), ''UniformOutput'', false)'

%%% ¡prop!
XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.
%%%% ¡default!
3

%%% ¡prop!
YSLIDER (gui, logical) determines whether to show the yslider.
%%%% ¡default!
true

%%% ¡prop!
YSLIDERLABELS (gui, string) determines the yslider labels (to be evaluated).
%%%% ¡default!
'cellfun(@(x) tostring(x), num2cell([R:-1:1]), ''UniformOutput'', false)'

%%% ¡prop!
YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.
%%%% ¡default!
3

%%% ¡prop!
XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.
%%%% ¡default!
false

%%% ¡prop!
ROWNAME (gui, string) determines the table row names (to be evaluated).
%%%% ¡default!
'''numbered'''

%%% ¡prop!
COLUMNNAME (gui, string) determines the table column names (to be evaluated).
%%%% ¡default!
'''numbered'''

%%% ¡prop!
MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
%%%% ¡default!
true

%% ¡properties!
p
table
xslider
yslider

contextmenu
%
menu_export_to_xls

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the cell property.
    %
    % DRAW(PR) draws the panel of the cell property.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard panel properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});
    
    if ~check_graphics(pr.table, 'uitable')
        pr.table = uitable( ...
            'Tag', 'table', ...
            'Parent', pr.p, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'CellEditCallback', {@cb_cell_value} ...
            );
    end
    function cb_cell_value(~, event) % (src, event)
        pr.cb_cell_value(event.Indices(1), event.Indices(2), event.NewData)
    end

    if ~check_graphics(pr.xslider, 'uislider')
        pr.xslider = uislider( ...
            'Parent', pr.p, ...
            'Tag', 'xslider', ...
            'MajorTicksMode', 'manual', ...
            'MajorTickLabelsMode', 'manual', ...
            'MinorTicksMode', 'manual', ...
            'MinorTicks', [], ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_xslider} ...
            );
    end
    function cb_xslider(~, ~) % (src, event)
        pr.cb_xslider()
    end
    
    if ~check_graphics(pr.yslider, 'uislider')
        pr.yslider = uislider( ...
            'Parent', pr.p, ...
            'Tag', 'yslider', ...
            'Orientation', 'vertical', ...
            'MajorTicksMode', 'manual', ...
            'MajorTickLabelsMode', 'manual', ...
            'MinorTicksMode', 'manual', ...
            'MinorTicks', [], ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_yslider} ...
            );
    end
    function cb_yslider(~, ~) % (src, event)
        pr.cb_yslider()
    end

    if ~check_graphics(pr.contextmenu, 'uicontextmenu')
        pr.contextmenu = uicontextmenu(...
            'Parent', ancestor(pr.p, 'figure'), ...
            'Tag', 'contextmenu');
        if pr.get('MENU_EXPORT')
            pr.menu_export_to_xls = uimenu( ...
                'Parent', pr.contextmenu, ...
                'Tag', 'menu_export_to_xls', ...
                'Text', 'Export to XLS', ...
                'MenuSelectedFcn', {@cb_export_to_xls});
        end
    end
    function cb_export_to_xls(~, ~)
        pr.cb_export_to_xls();
    end

    if pr.get('MENU_EXPORT')
        set(pr.table, 'ContextMenu', pr.contextmenu)
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the table and sliders.
    %
    % UPDATE(PR) updates the content and permissions of the table and sliders.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)

    function value = set_sliders_and_get_value()
            value = el.get(prop);
            if isempty(value)
                set(pr.xslider, ...
                    'Limits', [.6 1.4], ...
                    'MajorTicks', [1], ...
                    'Value', 1, ...
                    'Visible', pr.get('XSLIDER') ...
                    )
                set(pr.yslider, ...
                    'Limits', [.6 1.4], ...
                    'MajorTicks', [1], ...
                    'Value', 1, ...
                    'Visible', pr.get('YSLIDER') ...
                    )
            else
                [R, C] = size(value);
                set(pr.xslider, ...
                    'Limits', [.6 C+.4], ...
                    'MajorTicks', [1:1:C], ...
                    'MajorTickLabels', eval(pr.get('XSLIDERLABELS')), ...
                    'Value', max(1, min(round(get(pr.xslider, 'Value'), C))), ...
                    'Visible', pr.get('XSLIDER') ...
                    )
                set(pr.yslider, ...
                    'Limits', [.6 R+.4], ...
                    'MajorTicks', [1:1:R], ...
                    'MajorTickLabels', eval(pr.get('YSLIDERLABELS')), ...
                    'Value', max(1, min(round(get(pr.yslider, 'Value'), R))), ...
                    'Visible', pr.get('YSLIDER') ...
                    )

                if pr.get('XYSLIDERLOCK')
                    set(pr.yslider, 'Value', R + 1 - get(pr.xslider, 'Value'))
                end
                
                value = value{R + 1 - get(pr.yslider, 'Value'), get(pr.xslider, 'Value')};
            end            
    end
    
    function pval = get_p_value()
        value = el.get('P2');
        [R, ~] = size(value);
        pval = value{R + 1 - get(pr.yslider, 'Value'), get(pr.xslider, 'Value')};
    end
   
    
    set(pr.table, ...
        'RowName', eval(pr.get('ROWNAME')), ...
        'ColumnName', eval(pr.get('COLUMNNAME')) ...
        );

    el = pr.get('EL');
    prop = pr.get('PROP');
    
% % %     if el.isLocked(prop)
% % %         set(pr.table, 'ColumnEditable', false)
% % %     end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.table, ...
                'Data', set_sliders_and_get_value(), ... % % % 'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                'ColumnEditable', ~el.isLocked(prop) ... % % % true ...
                )

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.table, ...
                'Data', set_sliders_and_get_value(), ... % % % 'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                'ColumnEditable', ~el.isLocked(prop) ... % % % true ...
                )
            
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
                set(pr.table, ...
                    'Data', set_sliders_and_get_value(), ... % % % 'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                    'ColumnEditable', false, ...
                    'Visible', 'on' ...
                    )
                
                
                
                if (isa(el, 'ComparisonGroup') | isa(el, 'ComparisonEnsemble')) && el.existsTag('QVALUE')
                    
                    tmp_data = get_p_value();
                    
                    if size(tmp_data, 1) > size(tmp_data, 2)
                        tmp_data = tmp_data';
                    end
                    
                    [~, mask] = fdr(tmp_data, el.get('QVALUE'));
                    [cols, rows] = find(mask);
                    
                    if ~isempty(rows) && ~isempty(cols)
                        s = uistyle('BackgroundColor',[146/255 179/255 175/255]);
                        addStyle(pr.table, s, 'cell', [rows', cols']);
                    else
                        non_sign = ones(size(mask));
                        [cols, rows] = find(non_sign - mask);
                        s = uistyle('BackgroundColor', [1 1 1]); % default color, no significance
                        addStyle(pr.table, s, 'cell', [rows', cols']);
                    end
                end
            end
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
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT, 'DHeight', DHEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(2) (header height)
    % The table height is set by the property TAB_H.
    % The slider space is set by the properties XSLIDERHEIGHT and YSLIDERWIDTH.
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
        
        if ~pr.get('XSLIDER') && ~pr.get('YSLIDER')
            set(pr.table, ...
                'Units', 'pixels', ...
                'Position', [s(.3) s(.3) w(pr.p, 'pixels')-s(.6) Dh-s(.6)] ...
                )
        elseif pr.get('XSLIDER') && ~pr.get('YSLIDER')
            set(pr.table, ...
                'Units', 'pixels', ...
                'Position', [s(.3) s(.3) w(pr.p, 'pixels')-s(.6) Dh-s(.6)-s(pr.get('XSLIDERHEIGHT'))] ...
                )
            set(pr.xslider, 'Position', [s(.3) Dh-s(.3) w(pr.p, 'pixels')-s(.6) 3])
        elseif ~pr.get('XSLIDER') && pr.get('YSLIDER')
            set(pr.table, ...
                'Units', 'pixels', ...
                'Position', [s(.3)+s(pr.get('YSLIDERWIDTH')) s(.3) w(pr.p, 'pixels')-s(.6)-s(pr.get('YSLIDERWIDTH')) Dh-s(.6)] ...
                )
            set(pr.yslider, 'Position', [s(.3) s(.3) 3 Dh])            
        else % pr.get('XSLIDER') && pr.get('YSLIDER')
            set(pr.table, ...
                'Units', 'pixels', ...
                'Position', [s(.3)+s(pr.get('YSLIDERWIDTH')) s(.3) w(pr.p, 'pixels')-s(.6)-s(pr.get('YSLIDERWIDTH')) Dh-s(.6)-s(pr.get('XSLIDERHEIGHT'))] ...
                )
            set(pr.xslider, 'Position', [s(.3)+s(pr.get('YSLIDERWIDTH')) Dh-s(.3) w(pr.p, 'pixels')-s(.6)-s(pr.get('YSLIDERWIDTH')) 3])
            set(pr.yslider, 'Position', [s(.3) s(.3) 3 Dh-s(.6)-s(pr.get('XSLIDERHEIGHT'))])
        end            
    end  
end
function cb_cell_value(pr, i, j, newdata)
    %CB_CELL_VALUE executes callback for the cell table.
    %
    % CB_CELL_VALUE(PR, I, J, NEWDATA) executes callback for the matrix table.
    %  It updates the matrix at position (I,J) with NEWDATA. 
    %  It gets the current submatrix from the values of the sliders.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    value = el.get(prop);
    [R, C] = size(value);
    
    r = R + 1 - get(pr.yslider, 'Value');
    c = get(pr.xslider, 'Value');
    
    value_rc = value{r, c};
    value_rc(i, j) = newdata;
    value{r, c} = value_rc;
    el.set(prop, value)

% % %     pr.update()
end
function cb_xslider(pr)

    set(pr.xslider, 'Value', round(get(pr.xslider, 'Value')))
    
% % %     if pr.get('XYSLIDERLOCK')
% % %         el = pr.get('EL');
% % %         prop = pr.get('PROP');
% % %         value = el.get(prop);
% % %         [R, C] = size(value);
% % % 
% % %         R = max(R, 1); % to manage the case in which C = R = 0 (empty cell)
% % % 
% % %         set(pr.yslider, 'Value', R + 1 - get(pr.xslider, 'Value'))
% % %     end
    
    pr.update()
end
function cb_yslider(pr)
    
    set(pr.yslider, 'Value', round(get(pr.yslider, 'Value')))
    
    if pr.get('XYSLIDERLOCK')
        el = pr.get('EL');
        prop = pr.get('PROP');
        value = el.get(prop);
        [R, C] = size(value);
        
        C = max(C, 1); % to manage the case in which C = R = 0 (empty cell)

        set(pr.xslider, 'Value', C + 1 - get(pr.yslider, 'Value'))
    end

    pr.update()
end
function cb_export_to_xls(pr)
    %CB_EXPORT_TO_XLS exports data from uitable.
    %
    % CB_EXPORT_TO_XLS(PR) exports the uitable data to an XLSX file.
    
    data = pr.table.Data;
    columns = pr.table.ColumnName;
    rows = pr.table.RowName;
    if isequal(rows, 'numbered')
        rows = cellfun(@(x) num2str(x), num2cell([1:size(data, 1)]), 'UniformOutput', false);
    end
    if isempty(columns)
        columns = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:size(data, 2)]), 'UniformOutput', false);
    end
    
    t = array2table(data, ...
        'VariableNames', columns, ...
        'RowNames', rows);

    % save file
    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        writetable(t, file, 'WriteRowNames', true);
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropCell and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure('Units', 'normalized', 'Position', [0 .5 1 .5]);
et = ETA( ...
    'PROP_CELL_M', {}, ...
    'PROP_CELL_P', {
        [1 1; 1 1] [1 2; 1 2] [1 3; 1 3]
        [2 1; 2 1] [2 2; 2 2] [2 3; 2 3]
        [3 1; 3 1] [3 2; 3 2] [3 3; 3 3]
        }, ...
    'PROP_CELL_D', {}, ...
    'PROP_CELL_F', {}, ...
    'PROP_CELL_G', {
        rand(3) rand(3, 2) []
        rand(2, 3) rand(2) rand(2, 4)
        [] rand(4, 2) rand(4)
        } ...
    );
props = [et.PROP_CELL_M et.PROP_CELL_P et.PROP_CELL_D et.PROP_CELL_F et.PROP_CELL_G et.PROP_CELL_R et.PROP_CELL_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropCell('EL', et, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('X0', (i-1)/length(props) * w(fig1, 'pixels'), ...
        'Width', 1/length(props) * w(fig1, 'pixels'))
end
close(fig1)