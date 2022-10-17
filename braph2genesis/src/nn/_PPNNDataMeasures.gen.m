%% ¡header!
PPNNDataMeasures < PanelProp (pr, panel property graph) is a plot of a graph property.

%%% ¡description!
PPAnalyzeGroup_G plots a table of the measures associated with the graph of the group analysis.

% % % CALLBACKS - These are callback functions:
% % % 
% % %     pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
% % %     pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
% % %     pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, AnalyzeGroup, uitable

%% ¡props!

%%% ¡prop!
TAB_H (gui, size) is the height of the table in fontsize units.
%%%% ¡default!
30

%% ¡properties!
p
table
mlist
selected
contextmenu
menu_select_all
menu_clear_selection
menu_invert_selection
menu_set_selection
%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the graph property and the measure table.
    %
    % DRAW(PR) draws the panel of the graph property and the measure table.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, refresh, uipanel.

    pr.p = draw@PanelProp(pr, varargin{:});

    el = pr.get('EL');
    prop = pr.get('PROP');
    g = el.get(prop);

    pr.mlist = Graph.getCompatibleMeasureList(g);
    pr.selected = find(ismember(pr.mlist, el.get('Measures')));

    if ~check_graphics(pr.contextmenu, 'uicontextmenu')
        pr.contextmenu = uicontextmenu( ...
            'Parent', ancestor(pr.p, 'figure'), ...
            'Tag', 'contextmenu' ...
            );
        pr.menu_select_all = uimenu( ...
            'Separator', 'on', ...
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
        pr.menu_set_selection = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_set_selection', ...
            'Text', 'Set selected measures', ...
            'MenuSelectedFcn', {@cb_set_selection} ...
            );
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
    function cb_set_selection(~, ~)
        pr.cb_set_measures()
    end
    
    if ~check_graphics(pr.table, 'uitable')
        pr.table = uitable( ...
            'Parent', pr.p, ...
            'Tag', 'table', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'ColumnSortable', true, ...
            'ContextMenu', pr.contextmenu, ...
            'ColumnName', {'', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
            'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
            'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'}, ...
            'ColumnEditable', [true false false false false], ...
            'CellEditCallback', {@cb_table_edit} ...
            );
    end
    function cb_table_edit(~, event) % (src, event)
        % only needs to update the selector
        
        i = event.Indices(1);

        if event.NewData == 1
            pr.selected = sort(unique([pr.selected(:); i]));
        else
            pr.selected = pr.selected(pr.selected ~= i);
        end
        
        pr.update()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the pushbutton.
    %
    % UPDATE(PR) updates the content and permissions of the pushbutton.
    %
    % See also draw, redraw, PlotElement.

    update@PanelProp(pr)
    el = pr.get('EL');
    prop = pr.get('PROP');
    g = el.get(prop);

    function set_table()
        g = el.get(prop);
        mlist_already_calculated = {};

        rowname = cell(length(pr.mlist), 1);
        data = cell(length(pr.mlist), 5);
        for mi = 1:1:length(pr.mlist)
            if any(cellfun(@(y) isequal(pr.mlist{mi}, y), mlist_already_calculated)) && ~isa(g.getMeasure(pr.mlist{mi}).getr('M'), 'NoValue')
                rowname{mi} = 'C';
            else
                rowname{mi} = '';
            end

            if any(pr.selected == mi)
                data{mi, 1} = true;
            else
                data{mi, 1} = false;
            end

            data{mi, 2} = pr.mlist{mi};

            if Measure.is_nodal(pr.mlist{mi})
                data{mi, 3} = 'NODAL';
            elseif Measure.is_global(pr.mlist{mi})
                data{mi, 3} = 'GLOBAL';
            else
                data{mi, 3} = 'BINODAL';
            end

            if Measure.is_superglobal(pr.mlist{mi})
                data{mi, 4} = 'SUPERGLOBAL';
            elseif Measure.is_unilayer(pr.mlist{mi})
                data{mi, 4} = 'UNILAYER';
            else
                data{mi, 4} = 'BILAYER';
            end

            data{mi, 5} = eval([pr.mlist{mi} '.getDescription()']);
        end

        set(pr.table, ...
            'RowName', rowname, ...
            'Data', data ...
            )

        % style SELECTED
        styles_row = find(pr.table.StyleConfigurations.Target == 'row');

        if ~isempty(styles_row)
            removeStyle(pr.table, styles_row)
        end
        if ~isempty(pr.selected)
            addStyle(pr.table, uistyle('FontWeight', 'bold'), 'row', pr.selected)
        end
    end

condition = el.get('INPUT_TYPE') == "graph_measures" && isa(el.getr('TEMPLATE'), 'NoValue');

if isa(el.getr('TEMPLATE'), 'NoValue')
    condition = el.get('INPUT_TYPE') == "graph_measures";
    if condition
        if isempty(pr.selected)
            pr.selected = find(ismember(pr.mlist, el.get('Measures')));
        end
        set(pr.table, 'Enable', 'on')
    else
        pr.selected = [];
        set(pr.table, 'Enable', 'off')
    end
else
    set(pr.table, 'Enable', 'off')
end

set_table();
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

    pr.redraw@PanelProp('Height', h + Dh, varargin{:})
    drawnow()

    set(pr.table, ...
        'Units', 'pixels', ...
        'Position', [s(.3) s(.3) w(pr.p, 'pixels')-s(.6) Dh-s(.6)] ...
        )
end
function cb_select_all(pr)
    el = pr.get('EL');
    prop = pr.get('PROP');
    g = el.get(prop);
    mlist = Graph.getCompatibleMeasureList(g);

    pr.selected = [1:1:length(mlist)];

    pr.update()
end
function cb_clear_selection(pr)
    pr.selected = [];

    pr.update()
end
function cb_invert_selection(pr)
    el = pr.get('EL');
    prop = pr.get('PROP');
    g = el.get(prop);
    mlist = Graph.getCompatibleMeasureList(g);

    selected_tmp = [1:1:length(mlist)];
    selected_tmp(pr.selected) = [];
    pr.selected = selected_tmp;

    pr.update()
end
function cb_hide_table(pr)
    set(pr.table, 'Visible', 'off');
    pr.redraw();
end
function cb_show_table(pr)
    set(pr.table, 'Visible', 'on');
    pr.redraw();
end
function cb_set_measures(pr)
    el = pr.get('EL');
    measure_short_list = pr.mlist(pr.selected);
    el.set('Measures', measure_short_list); 
    pr.update();
end