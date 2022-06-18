%% ¡header!
PPAnalyzeGroup_G < PanelProp (pr, panel property graph) is a plot of a graph property.

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
selected

contextmenu
%
menu_graph_plot
menu_graph_element
%
menu_select_all
menu_clear_selection
menu_invert_selection
%
menu_measure_calculate
menu_measure_open_plots
menu_measure_hide_plots
menu_measure_open_elements
menu_measure_hide_elements

f_graph_plot
f_graph_element

f_measure_plots
f_measure_elements

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

    if ~check_graphics(pr.contextmenu, 'uicontextmenu')
        pr.contextmenu = uicontextmenu( ...
            'Parent', ancestor(pr.p, 'figure'), ...
            'Tag', 'contextmenu' ...
            );
        pr.menu_graph_plot = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_graph_plot', ...
            'Text', 'Plot Graph', ...
            'MenuSelectedFcn', {@cb_graph_plot} ...
            );
        pr.menu_graph_element = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_graph_element', ...
            'Text', 'Extract Data Graph', ...
            'MenuSelectedFcn', {@cb_graph_element} ...
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
        pr.menu_measure_calculate = uimenu( ...
            'Separator', 'on', ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_measure_calculate', ...
            'Text', 'Calculate Selected Measures', ...
            'MenuSelectedFcn', {@cb_measure_calculate} ...
            );
        pr.menu_measure_plots = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_graph_plots', ...
            'Text', 'Plot Selected Measures', ...
            'MenuSelectedFcn', {@cb_measure_plots} ...
            );
        pr.menu_measure_elements = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_measure_elements', ...
            'Text', 'Extract Data Selected Measures', ...
            'MenuSelectedFcn', {@cb_measure_elements} ...
            );
    end
    function cb_graph_plot(~, ~) 
        pr.cb_graph_plot()
    end
    function cb_graph_element(~, ~) 
        pr.cb_graph_element()
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
    function cb_measure_calculate(~, ~) 
        pr.cb_measure_calculate()
    end
    function cb_menu_measure_plots(~, ~) 
        pr.cb_menu_measure_plots()
    end
    function cb_menu_measure_elements(~, ~) 
        pr.cb_menu_measure_elements()
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
    
    function set_table()
        g = el.get(prop);
        mlist = Graph.getCompatibleMeasureList(g);
        mlist_already_calculated = cellfun(@(x) x.get('ID'), g.get('M_DICT').getItems(), 'UniformOutput', false);
        
        rowname = cell(length(mlist), 1);
        data = cell(length(mlist), 5);
        for mi = 1:1:length(mlist)
            if any(cellfun(@(y) isequal(mlist{mi}, y), mlist_already_calculated))
                rowname{mi} = 'C';
            else
                rowname{mi} = '';
            end                
            
            if any(pr.selected == mi)
                data{mi, 1} = true;
            else
                data{mi, 1} = false;
            end

            data{mi, 2} = mlist{mi};

            if Measure.is_nodal(mlist{mi})
                data{mi, 3} = 'NODAL';
            elseif Measure.is_global(mlist{mi})
                data{mi, 3} = 'GLOBAL';
            else
                data{mi, 3} = 'BINODAL';
            end

            if Measure.is_superglobal(mlist{mi})
                data{mi, 4} = 'SUPERGLOBAL';
            elseif Measure.is_unilayer(mlist{mi})
                data{mi, 4} = 'UNILAYER';
            else
                data{mi, 4} = 'BILAYER';
            end

            data{mi, 5} = eval([mlist{mi} '.getDescription()']);
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

    value = el.getr(prop);
    if isa(value, 'NoValue')
        % don't plot anything for a result not yet calculated
        set(pr.table, 'Visible', 'off')
    else
        set_table()
        set(pr.table, 'Visible', 'on')
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
    if isa(value, 'NoValue') % && el.getPropCategory(prop) == Category.RESULT 
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
function cb_graph_plot(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    if ~check_graphics(pr.f_graph_plot, 'figure')
        f = ancestor(pr.p, 'figure');
        gui = GUIFig( ...
            'PF', el.memorize(prop).memorize('PFG'), ... % ensure that the property is stored
            'WAITBAR', Callback('EL', pr, 'TAG', 'WAITBAR'), ...
            'POSITION', [ ...
                x0(f, 'normalized')+w(f, 'normalized') ...
                y0(f, 'normalized') ...
                w(0,'normalized')-x0(f, 'normalized')-w(f, 'normalized') ...
                h(f, 'normalized') ...
                ], ...
            'CLOSEREQ', false ...
            );
        pr.f_graph_plot = gui.draw();
    else
        gui = get(pr.f_graph_plot, 'UserData');
        if get(pr.f_graph_plot, 'Visible')
            gui.cb_hide()
        else
            gui.cb_bring_to_front()
        end
    end

    pr.update()
end
function cb_graph_element(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');

    if ~check_graphics(pr.f_graph_element, 'figure')
        f = ancestor(pr.p, 'figure');
        gui = GUIElement( ...
            'PE', el.memorize(prop), ... % ensure that the property is stored
            'WAITBAR', Callback('EL', pr, 'TAG', 'WAITBAR'), ...
            'POSITION', [ ...
                x0(f, 'normalized')+w(f, 'normalized') ...
                y0(f, 'normalized') ...
                w(f, 'normalized') ...
                h(f, 'normalized') ...
                ], ...
            'CLOSEREQ', false ...
            );
        pr.f_graph_element = gui.draw();
    else
        gui = get(pr.f_graph_element, 'UserData');
        if get(pr.f_graph_element, 'Visible')
            gui.cb_hide()
        else
            gui.cb_bring_to_front()
        end
    end
        
    pr.update()
    
% % %     % updates and redraws the parent PanelElement as well as all siblings PanelProp's
% % %     pe = get(get(pr.p, 'Parent'), 'UserData');
% % %     pe.update()
% % %     pe.redraw()
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
function cb_measure_calculate(pr) 

    el = pr.get('EL');
    prop = pr.get('PROP');
    g = el.memorize(prop);
    mlist = Graph.getCompatibleMeasureList(g);
    
    wb = braph2waitbar(el.get('WAITBAR'), 0, ['Calculating ' num2str(length(pr.selected))  ' measures ...']);

    for i = 1:1:length(mlist)
        if ismember(i, pr.selected)
            measure = mlist{i};
            
            braph2waitbar(wb, .1 + .9 * i / length(pr.selected), ['Calculating measure ' int2str(i) ' (' measure ') of ' int2str(length(pr.selected)) ' ...'])

            if isa(g.getMeasure(measure).getr('M'), 'NoValue')
                g.getMeasure(measure).memorize('M');
            end
        end
    end
    
    braph2waitbar(wb, 'close')

	pr.update();
end
function cb_menu_measure_plots(pr) 

end
function cb_menu_measure_elements(pr) 

end
function cb_bring_to_front(pr)

    cb_bring_to_front@Panel(pr);
    
    % bring to front graph plot figure
    if check_graphics(pr.f_graph_plot, 'figure')
        figure(pr.f_graph_plot)
        set(pr.f_graph_plot, ...
            'Visible', 'on', ...
            'WindowState', 'normal' ...
            )        
    end
    
    % bring to front graph element figure
    if check_graphics(pr.f_graph_element, 'figure')
        figure(pr.f_graph_element)
        set(pr.f_graph_element, ...
            'Visible', 'on', ...
            'WindowState', 'normal' ...
            )        
    end
end
function cb_hide(pr)
    
    cb_hide@Panel(pr);
    
    % hide callback graph plot figure
    if check_graphics(pr.f_graph_plot, 'figure')
        set(pr.f_graph_plot, 'Visible', 'off')
    end
    
    % hide callback graph element figure
    if check_graphics(pr.f_graph_element, 'figure')
        set(pr.f_graph_element, 'Visible', 'off')
    end
end
function cb_close(pr)
    
    cb_close@Panel(pr);

    % close callback graph plot figure
    if check_graphics(pr.f_graph_plot, 'figure')
        close(pr.f_graph_plot)
    end
    
    % close callback graph element figure
    if check_graphics(pr.f_graph_element, 'figure')
        close(pr.f_graph_element)
    end
end
% % % function cb_graph_value(pr)
% % %     %CB_GRAPH_VALUE executes callback for the pushbutton.
% % %     %
% % %     % CB_GRAPH_VALUE(PR) executes callback for the pushbutton.
% % %     %  It opens Graph GUI.
% % %     %
% % %     % See also cb_measure_value.
% % % 
% % %     el = pr.get('EL');
% % %     prop = pr.get('PROP');
% % % 
% % %     pr.update()
% % % 
% % %     % determine figure position
% % %     f_gr = ancestor(pr.p, 'Figure'); % GUI Group
% % %     f_gr_x = Plot.x0(f_gr, 'pixels');
% % %     f_gr_y = Plot.y0(f_gr, 'pixels');
% % %     f_gr_w = Plot.w(f_gr, 'pixels');
% % %     f_gr_h = Plot.h(f_gr, 'pixels');
% % % 
% % %     screen_x = Plot.x0(0, 'pixels');
% % %     screen_y = Plot.y0(0, 'pixels');
% % %     screen_w = Plot.w(0, 'pixels');
% % %     screen_h = Plot.h(0, 'pixels');
% % % 
% % %     N = ceil(sqrt(1));
% % % 
% % %     x = (f_gr_x + f_gr_w) / screen_w + mod(1 - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
% % %     y = f_gr_y / screen_h;
% % %     w = f_gr_w / screen_w;
% % %     h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((1 - .5) / N)) / N / screen_h;
% % % 
% % % 
% % %     % TODO: check this part of the code once GUI is finalized
% % %     value = el.getr(prop);
% % %     if ~check_graphics(pr.f_g, 'figure')
% % %         if isa(value, 'NoValue')
% % %             pr.f_g = GUI( ...
% % %                 'PE', el.getPropDefault(prop), ...
% % %                 'POSITION', [x y w h], ...
% % %                 'CLOSEREQ', false).draw();
% % %         else
% % %             pr.f_g = GUI( ...
% % %                 'PE', el.get(prop), ...
% % %                 'POSITION', [x y w h], ...
% % %                 'CLOSEREQ', false).draw();
% % %         end
% % %     elseif isequal(get(pr.f_g, 'Visible'), 'on')
% % %         gui = get(pr.f_g, 'UserData');
% % %         gui.cb_hide()
% % %     else
% % %         gui = get(pr.f_g, 'UserData');
% % %         gui.cb_bring_to_front()
% % %     end
% % % end
% % % function cb_measure_gui(pr)
% % %     %CB_MEASURE_GUI executes callback for the pushbutton.
% % %     %
% % %     % CB_MEASURE_GUI(PR) executes callback for the pushbutton.
% % %     %  It opens Measure GUI.
% % %     %
% % %     % See also cb_graph_value.
% % % 
% % %     el = pr.get('EL');
% % %     prop = pr.get('PROP');
% % %     graph = el.memorize(prop);
% % %     pr.mlist = Graph.getCompatibleMeasureList(graph);
% % % 
% % %     measure_short_list = pr.mlist(pr.selected);
% % % 
% % %     % determine figure position
% % %     f_gr = ancestor(pr.p, 'Figure'); % GUI Group
% % %     f_gr_x = Plot.x0(f_gr, 'pixels');
% % %     f_gr_y = Plot.y0(f_gr, 'pixels');
% % %     f_gr_w = Plot.w(f_gr, 'pixels');
% % %     f_gr_h = Plot.h(f_gr, 'pixels');
% % % 
% % %     screen_x = Plot.x0(0, 'pixels');
% % %     screen_y = Plot.y0(0, 'pixels');
% % %     screen_w = Plot.w(0, 'pixels');
% % %     screen_h = Plot.h(0, 'pixels');
% % % 
% % %     N = ceil(sqrt(length(pr.mlist))); % number of row and columns of figures
% % %     f_count = 1;
% % % 
% % %     for i = 1:length(pr.mlist)
% % %         if ~ismember(pr.mlist(i), measure_short_list)
% % %             continue;
% % %         end
% % % 
% % %         measure = pr.mlist{i};
% % % 
% % %         x = (f_gr_x + f_gr_w) / screen_w + mod(i - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
% % %         y = f_gr_y / screen_h;
% % %         w = f_gr_w / screen_w;
% % %         h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((i - .5) / N)) / N / screen_h;
% % % 
% % %         result_measure = graph.getMeasure(measure);
% % %         plot_permission = true;
% % %         tmp_gui = [];
% % %         for j = 1:length(pr.f_m)
% % %             tmp_f = pr.f_m{j};
% % %             if check_graphics(tmp_f, 'figure')
% % %                 tmp_gui = get(tmp_f, 'UserData');
% % %                 if isequal(tmp_gui.get('pe').get('el').get('id'), result_measure.get('ID'))
% % %                     plot_permission = false;
% % %                     if isequal(get(tmp_f, 'Visible'), 'on')
% % %                         % hide
% % %                         set(tmp_f, 'Visible', 'off')
% % %                     else
% % %                         % show
% % %                         figure(tmp_f)
% % %                         set(tmp_f, ...
% % %                             'Visible', 'on', ...
% % %                             'WindowState', 'normal' ...
% % %                             )
% % %                     end
% % %                 end
% % %             end            
% % %         end
% % %         if plot_permission
% % %             pr.f_m{f_count} = GUI('pe', result_measure, 'POSITION', [x y w h], 'CLOSEREQ', false).draw();
% % %             f_count = f_count + 1;
% % %         end
% % %     end
% % % end
% % % function cb_graph_ui_figure(pr)
% % %     % CB_GRAPH_UI_FIGURE draws a new figure to manage a plot graph.
% % %     %
% % %     % CB_GRAPH_UI_FIGURE(PR) draws a new figure to manage a plot graph and
% % %     % sets the figure to F_PG property of PPGRAPH
% % %     %
% % %     % see also cb_graph_value, cb_measure_value.
% % % 
% % %     f_pg = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
% % %     f_ba_x = Plot.x0(f_pg, 'pixels');
% % %     f_ba_y = Plot.y0(f_pg, 'pixels');
% % %     f_ba_w = Plot.w(f_pg, 'pixels');
% % %     f_ba_h = Plot.h(f_pg, 'pixels');
% % % 
% % %     screen_x = Plot.x0(0, 'pixels');
% % %     screen_y = Plot.y0(0, 'pixels');
% % %     screen_w = Plot.w(0, 'pixels');
% % %     screen_h = Plot.h(0, 'pixels');
% % % 
% % %     x = f_ba_x + f_ba_w;
% % %     h = f_ba_h / 1.5;
% % %     y = f_ba_y + f_ba_h - h;
% % %     w = screen_w - x;
% % % 
% % %     if isempty(pr.f_pg) || ~check_graphics(pr.f_pg, 'figure')
% % %         pr.f_pg = figure( ...
% % %         'NumberTitle', 'off', ...
% % %         'Units', 'normalized', ...
% % %         'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
% % %         'CloseRequestFcn', {@cb_f_pg_close} ...
% % %         );
% % %         set_braph2icon(pr.f_pg)
% % %         menu_about = BRAPH2.add_menu_about(pr.f_pg);
% % %         set(pr.f_pg, 'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')])
% % % 
% % %         el = pr.get('EL');
% % %         prop = pr.get('PROP');
% % %         g = el.get(prop);
% % %         group = el.get('GR').get('ID');
% % % 
% % %         if isa(el, 'AnalyzeGroup_ST_BUD')
% % %             x_range = el.get('DENSITIES');
% % %             x_title = 'DENSITIES';
% % %         elseif isa(el, 'AnalyzeGroup_ST_BUT')
% % %             x_range = el.get('THRESHOLDS');
% % %             x_title = 'THRESHOLDS';
% % %         end
% % % 
% % %         pg = PlotAnalysisLine( ...
% % %             'Graph', g, ...
% % %             'X', x_range, ...
% % %             'PLOTTITLE', ['Analysis of group ' group], ...
% % %             'XLABEL', x_title ...
% % %             );
% % % 
% % %         pg.draw('Parent', pr.f_pg)
% % %         set(pr.f_pg, 'UserData', pg);
% % % 
% % %         f_settings = pg.settings();
% % %         set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
% % %         f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
% % %         f_settings.OuterPosition(2) = f_ba_y/screen_h;
% % %     elseif isequal(get(pr.f_pg, 'Visible'), 'on')
% % %         gui = get(pr.f_pg, 'UserData');
% % %         gui.cb_hide()
% % %     else
% % %         gui = get(pr.f_pg, 'UserData');
% % %         gui.cb_bring_to_front()
% % %     end
% % % 
% % %         function cb_f_pg_close(~, ~)
% % %             delete(pr.f_pg);
% % %             pr.update()
% % %         end
% % % 
% % %     pr.update()
% % % end
% % % function cb_graph_adj_figure(pr)
% % %     f_pg = ancestor(pr.p, 'Figure'); 
% % %     f_ba_x = Plot.x0(f_pg, 'pixels');
% % %     f_ba_y = Plot.y0(f_pg, 'pixels');
% % %     f_ba_w = Plot.w(f_pg, 'pixels');
% % %     f_ba_h = Plot.h(f_pg, 'pixels');
% % % 
% % %     screen_x = Plot.x0(0, 'pixels');
% % %     screen_y = Plot.y0(0, 'pixels');
% % %     screen_w = Plot.w(0, 'pixels');
% % %     screen_h = Plot.h(0, 'pixels');
% % % 
% % %     x = f_ba_x + f_ba_w;
% % %     h = f_ba_h / 1.5;
% % %     y = f_ba_y + f_ba_h - h;
% % %     w = screen_w - x;
% % % 
% % %     if isempty(pr.f_adj) || ~check_graphics(pr.f_adj, 'figure')
% % %         pr.f_adj = figure( ...
% % %             'NumberTitle', 'off', ...
% % %             'Units', 'normalized', ...
% % %             'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
% % %             'CloseRequestFcn', {@cb_f_adj_close} ...
% % %             );
% % %         set_braph2icon(pr.f_adj)
% % %         menu_about = BRAPH2.add_menu_about(pr.f_adj);
% % %         set(pr.f_adj, 'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')])
% % %         el = pr.get('EL');
% % %         prop = pr.get('PROP');
% % %         g = el.get(prop);
% % %         g_dict = IndexedDictionary( ...
% % %             'it_class', g.getClass() ...
% % %             );
% % %         g_dict.add(g);
% % %         pg = PlotAdjacencyMatrix('G_DICT', g_dict);
% % %         pg.draw('Parent', pr.f_adj)
% % %         set(pr.f_adj, 'UserData', pg);
% % % 
% % %         f_settings = pg.settings();
% % %         set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
% % %         f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
% % %         f_settings.OuterPosition(2) = f_ba_y/screen_h;
% % %     elseif isequal(get(pr.f_adj, 'Visible'), 'on')
% % %         gui = get(pr.f_adj, 'UserData');
% % %         gui.cb_hide()
% % %     else
% % %         gui = get(pr.f_adj, 'UserData');
% % %         gui.cb_bring_to_front()
% % %     end
% % % 
% % %         function cb_f_adj_close(~, ~)
% % %             delete(pr.f_adj);
% % %             pr.update()
% % %         end
% % % 
% % %     pr.update()
% % % end
% % % function list =  is_measure_calculated(pr)
% % %     % IS_MEASURE_CALCULATED checks if a measure has been calculated for the graph.
% % %     % 
% % %     % LIST = IS_MEASURE_CALCULATED(PR) returns an array with the check for
% % %     %  previously calculated measures. C if a measures has been calculated
% % %     %  and NC for nor calculated measures.
% % %     %
% % %     % See also get_button_condition.
% % %     
% % %     el = pr.get('EL');
% % %     prop = pr.get('PROP');
% % %     graph = el.memorize(prop);
% % %     measure_dict = graph.get('M_DICT');
% % %     measure_list = pr.mlist;
% % %     calculated_list = cell(size(measure_list, 2), 1);
% % %     if measure_dict.length() > 0
% % %         for i = 1:length(measure_list)
% % %             measure = measure_list{i};
% % %             if any(cellfun(@(x) isequal(measure, x.get('ID')), measure_dict.getItems()))
% % %                 calculated_list{i} = 1;
% % %             else
% % %                 calculated_list{i} = 0;
% % %             end
% % %         end
% % %     else
% % %         [calculated_list{:}] = deal(0);
% % %     end
% % %     list = calculated_list;
% % % end
% % % function state = get_button_condition(pr)
% % %     % GET_BUTTON_CONDITION returns the calculate button state.
% % %     %
% % %     % STATE = GET_BUTTON_CONDITION(PR) returns the calculate button state.
% % %     %
% % %     % see also is_measure_calculated.
% % % 
% % %     plot_prop_children = get(pr.p, 'Children');
% % %     state = 0; % calculated
% % %     for i = 1:length(plot_prop_children)
% % %         pp_c = plot_prop_children(i);
% % %         if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
% % %             if isequal(pp_c.Enable, 'off')
% % %                 state = 1;  % not calculated
% % %             end
% % %         end
% % %     end
% % % end
% % % function cb_bring_to_front(pr)
% % %     %CB_BRING_TO_FRONT brings to front the figure and its settings figure.
% % %     %
% % %     % CB_BRING_TO_FRONT(PR) brings to front the figure and its
% % %     %  settings figure.
% % %     %
% % %     % See also cb_hide, cb_close.
% % % 
% % %     % brings to front settings panel
% % %     pr.cb_bring_to_front@PlotProp();
% % %     
% % %     % bring to front graph class
% % %     if check_graphics(pr.f_g, 'figure')
% % %         gui = get(pr.f_g, 'UserData');
% % %         pe = gui.get('PE');
% % %         pe.cb_bring_to_front()
% % %     end
% % %     
% % %     % bring to front measure class guis
% % %     for i = 1:length(pr.f_m)
% % %         f_m = pr.f_m{i};
% % %         if check_graphics(f_m, 'figure')
% % %             gui = get(f_m, 'UserData');
% % %             pe = gui.get('PE');
% % %             pe.cb_bring_to_front()
% % %         end
% % %     end
% % %     
% % %     % bring to front plot graph
% % %     if check_graphics(pr.f_pg, 'figure')
% % %         gui = get(pr.f_pg, 'UserData');
% % %         gui.cb_bring_to_front()
% % %     end  
% % %     
% % %     % bring to front plot graph
% % %     if check_graphics(pr.f_adj, 'figure')
% % %         gui = get(pr.f_adj, 'UserData');
% % %         gui.cb_bring_to_front()
% % %     end 
% % % end
% % % function cb_hide(pr)
% % %     %CB_HIDE hides the figure and its settings figure.
% % %     %
% % %     % CB_HIDE(PR) hides the figure and its settings figure.
% % %     %
% % %     % See also cb_bring_to_front, cb_close.
% % % 
% % %     % hides settings panel
% % %     pr.cb_hide@PlotProp();
% % %     
% % %     % bring to front graph class
% % %     if check_graphics(pr.f_g, 'figure')
% % %         gui = get(pr.f_g, 'UserData');
% % %         pe = gui.get('PE');
% % %         pe.cb_hide()
% % %     end    
% % %     
% % %     % bring to front measure class guis
% % %     for i = 1:length(pr.f_m)
% % %         f_m = pr.f_m{i};
% % %         if check_graphics(f_m, 'figure')
% % %             gui = get(f_m, 'UserData');
% % %             pe = gui.get('PE');
% % %             pe.cb_hide()
% % %         end
% % %     end
% % %     
% % %     % bring to front plot graph
% % %     if check_graphics(pr.f_pg, 'figure')
% % %         gui = get(pr.f_pg, 'UserData');
% % %         gui.cb_hide();
% % %     end 
% % %     if check_graphics(pr.f_adj, 'figure')
% % %         gui = get(pr.f_adj, 'UserData');
% % %         gui.cb_hide();
% % %     end 
% % % end
% % % function cb_close(pr)
% % %     %CB_CLOSE closes the figure.
% % %     %
% % %     % CB_CLOSE(PR) closes the figure and its children figures.
% % %     %
% % %     % See also cb_bring_to_front, cd_hide.
% % % 
% % %     % closes measure class guis
% % %     for i = 1:length(pr.f_m)
% % %         f_m = pr.f_m{i};
% % %         if check_graphics(f_m, 'figure')
% % %             delete(f_m)
% % %         end
% % %     end
% % %     
% % %     % close plot graph figure
% % %     if ~isempty(pr.f_pg) && check_graphics(pr.f_pg, 'figure')
% % %         delete(pr.f_pg);
% % %     end
% % %     
% % %     % close adj graph figure
% % %     if ~isempty(pr.f_adj) && check_graphics(pr.f_adj, 'figure')
% % %         delete(pr.f_adj);
% % %     end    
% % %     
% % %     % close graph class
% % %     if check_graphics(pr.f_g, 'figure')
% % %         gui = get(pr.f_g, 'UserData');
% % %         pe = gui.get('PE');
% % %         pe.cb_close()
% % %     end
% % % end
