%% ¡header!
PPAnalyzeGroupMP_G < PlotProp (pr, plot property graph mp) is a plot of a multiplex graph property.

%%% ¡description!
PPAnalyzeGroupMP_G plots the measure table associated with a multiplex graph of the analysis.
It also provides the buttons to navigate the graphical interface of both
the measures and the graph.

CALLBACKS - These are callback functions:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, PlotProp, AnalyzeGroup

%% ¡properties!
p
measure_tbl
measure_btn
graph_btn
plot_graph_btn
plot_type_adj
line_plot_tglbtn % line plot toggle button
measure_plot_btn
mlist
selected
already_calculated
graph % internal graph type
f_m % array of measure class figures
f_pg % figure for plot graph
f_adj % figure for plot adj
f_g % figure for class graph

%% ¡methods!
function h_panel = draw(pr, varargin)
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

    pr.p = draw@PlotProp(pr, varargin{:});
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    if ~check_graphics(pr.graph_btn, 'pushbutton') && ...
            (isempty(pr.measure_tbl) || ~isgraphics(pr.measure_tbl, 'uitable'))
        % graph button
        pr.graph_btn = uicontrol( ...
            'Style', 'pushbutton', ...
            'Tag', 'pushbutton_value', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'String', 'Graph Data', ...
            'TooltipString', 'Open a GUI for the graph data.', ...
            'Position', [.79 .76 .2 .15], ...
            'Visible', 'off', ...
            'Callback', {@cb_graph_btn} ...
            );
        
        pr.plot_type_adj = uicontrol(...
            'Style', 'pushbutton', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'CData', imresize(imread('icon_plot_adj.png'), [40 40]), ...
            'TooltipString', 'Open a plot for the adjacency matrix.', ...
            'Position', [.01 .76 .2 .15], ...
            'Visible', 'off', ...
            'Callback', {@cb_plot_type_adj} ...
            );
        
        pr.line_plot_tglbtn = uicontrol(...
            'Style', 'pushbutton', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'CData', imresize(imread('icon_plot_lines.png'), [40 40]), ...
            'TooltipString', 'Open a line plot for the measure.', ...
            'Position', [.23 .76 .2 .15], ...
            'Visible', 'off', ...
            'Callback', {@cb_plot_type_line} ...
            );
        pr.mlist = [];
        
        pr.measure_tbl = uitable( ...
            'Parent', pr.p, ...
            'Visible', 'on', ...
            'ColumnName', {'SEL', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
            'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', [true false false false false], ...
            'Visible', 'off', ...
            'CellEditCallback', {@cb_measure_edit} ...
            );
        
        % measure button
        pr.measure_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'measure_button', ...
            'Units', 'normalized', ...
            'String', 'Calculate Measures', ...
            'TooltipString', 'Calculate Selected Measures', ...
            'Position', [.01 .02 .48 .09], ...
            'Visible', 'off', ...
            'Callback', {@cb_measure_btn} ...
            );
        
        pr.measure_plot_btn = uicontrol(...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'measure_plot_button', ...
            'Units', 'normalized', ...
            'String', 'Show Measures', ...
            'TooltipString', 'Show Selected Measures', ...
            'Position', [.51 .02 .48 .09], ...
            'Visible', 'off', ...
            'Callback', {@cb_measure_plot_btn} ...
            );
    end
        
        function cb_graph_btn(~, ~) % (src, event)
        pr.cb_graph_value()
        end
        function cb_plot_type_adj(~, ~)
        pr.cb_graph_adj_figure();
        end
        function cb_plot_type_line(~, ~)
        pr.cb_graph_ui_figure();
        end
        function cb_measure_edit(~, event)
        i = event.Indices(1);
        col = event.Indices(2);
        newdata = event.NewData;
        switch col
            case 1
                if newdata == 1
                    pr.selected = sort(unique([pr.selected(:); i]));
                else
                    pr.selected = pr.selected(pr.selected ~= i);
                end
                
            otherwise
                % dont do anything
        end
        pr.update()
        end
        function cb_measure_btn(~, ~)
        pr.cb_measure_calc()
        end
        function cb_measure_plot_btn(~, ~)
        pr.cb_measure_gui();
    end
        

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the pushbutton.
    %
    % UPDATE(PR) updates the content and permissions of the pushbutton.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PlotProp(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
    button_state = pr.get_button_condition();

    if ~button_state
        % visible gui
        set(pr.line_plot_tglbtn, 'Visible', 'off')
        set(pr.graph_btn, 'Visible', 'off')
        set(pr.plot_type_adj, 'Visible', 'off')
        set(pr.measure_tbl, 'Visible', 'off')
        set(pr.measure_btn, 'Visible', 'off')
        set(pr.measure_plot_btn, 'Visible', 'off')
        pr.graph = [];
        pr.already_calculated = [];

    else
        graph = el.get(prop);
        pr.graph = graph;
        
        % visible gui
        set(pr.graph_btn, 'Visible', 'on')
        set(pr.plot_type_adj, 'Visible', 'on')
        set(pr.measure_tbl, 'Visible', 'on')
        set(pr.measure_btn, 'Visible', 'on')
        set(pr.measure_plot_btn, 'Visible', 'on')

        if  ~isa(graph, 'NoValue') && isa(graph, 'Graph')
            if isempty(pr.mlist)
                pr.mlist = Graph.getCompatibleMeasureList(graph);
            end
            pr.already_calculated = pr.is_measure_calculated();
            data = cell(length(pr.mlist), 5);
            for mi = 1:1:length(pr.mlist)
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
            set(pr.measure_tbl, 'Data', data)
            set(pr.measure_tbl, 'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'})

            row_names = cell(length(pr.already_calculated), 1);
            for i = 1:length(pr.already_calculated)
                if pr.already_calculated{i}
                    row_names{i} = 'C';
                else
                    row_names{i} = '';
                end
            end
            set(pr.measure_tbl, 'RowName', row_names)
        end

        if ~check_graphics(pr.f_pg, 'figure')
            set(pr.plot_type_adj, 'Enable', 'on');
            set(pr.line_plot_tglbtn, 'Enable', 'on');
        end        
    end

    function plot_type_rules()
        if ~isempty(pr.graph) && ~contains(el.getClass(), 'WU') && ~isempty(pr.already_calculated) && any([pr.already_calculated{:}])
            set(pr.line_plot_tglbtn, ...
                    'Enable', 'on', ...
                    'Visible', 'on');
        else
            set(pr.line_plot_tglbtn, ...
                    'Enable', 'off', ...
                    'Visible', 'off');
        end
    end
   
    plot_type_rules()
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

    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
    [Dh, varargin] = get_and_remove_from_varargin(15, 'DHeight', varargin);

    if pr.get_button_condition()
        if ~isempty(pr.measure_tbl) && isgraphics(pr.measure_tbl, 'uitable')
            set(pr.measure_tbl, ...
                'Units', 'normalized', ...
                'Position', [.01 .13 .98 (Dh/(h+Dh)-.27)] ...
                )
        end
        
        pr.redraw@PlotProp('Height', (h + Dh)*1.5, varargin{:})
    else
        if ~isempty(pr.measure_tbl) && isgraphics(pr.measure_tbl, 'uitable')
            set(pr.measure_tbl, ...
                'Units', 'normalized', ...
                'Position', [.01 .13 .98 (Dh/(h+Dh)-.32)], ...
                'Visible', 'off' ...
                )
        end
        pr.redraw@PlotProp(varargin{:})
    end   
end
function cb_graph_value(pr)
    %CB_GRAPH_VALUE executes callback for the pushbutton.
    %
    % CB_GRAPH_VALUE(PR) executes callback for the pushbutton.
    %  It opens Graph GUI.
    %
    % See also cb_measure_value.

    el = pr.get('EL');
    prop = pr.get('PROP');

    pr.update()

    % determine figure position
    f_gr = ancestor(pr.p, 'Figure'); % GUI Group
    f_gr_x = Plot.x0(f_gr, 'pixels');
    f_gr_y = Plot.y0(f_gr, 'pixels');
    f_gr_w = Plot.w(f_gr, 'pixels');
    f_gr_h = Plot.h(f_gr, 'pixels');

    screen_x = Plot.x0(0, 'pixels');
    screen_y = Plot.y0(0, 'pixels');
    screen_w = Plot.w(0, 'pixels');
    screen_h = Plot.h(0, 'pixels');

    N = ceil(sqrt(1));

    x = (f_gr_x + f_gr_w) / screen_w + mod(1 - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
    y = f_gr_y / screen_h;
    w = f_gr_w / screen_w;
    h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((1 - .5) / N)) / N / screen_h;


    % TODO: check this part of the code once GUI is finalized
    value = el.getr(prop);
    if ~check_graphics(pr.f_g, 'figure')
        if isa(value, 'NoValue')
            pr.f_g = GUI( ...
                'PE', el.getPropDefault(prop), ...
                'POSITION', [x y w h], ...
                'CLOSEREQ', false).draw();
        else
            pr.f_g = GUI( ...
                'PE', el.get(prop), ...
                'POSITION', [x y w h], ...
                'CLOSEREQ', false).draw();
        end
    elseif  isequal(get(pr.f_g, 'Visible'), 'on')
        gui = get(pr.f_g, 'UserData');
        gui.cb_hide()
    else
        gui = get(pr.f_g, 'UserData');
        gui.cb_bring_to_front()
    end
    
end
function cb_measure_gui(pr)
    %CB_MEASURE_GUI executes callback for the pushbutton.
    %
    % CB_MEASURE_GUI(PR) executes callback for the pushbutton.
    %  It opens Measure GUI.
    %
    % See also cb_graph_value.

    el = pr.get('EL');
    prop = pr.get('PROP');
    graph = el.memorize(prop);
    pr.mlist = Graph.getCompatibleMeasureList(graph);

    measure_short_list = pr.mlist(pr.selected);

    % determine figure position
    f_gr = ancestor(pr.p, 'Figure'); % GUI Group
    f_gr_x = Plot.x0(f_gr, 'pixels');
    f_gr_y = Plot.y0(f_gr, 'pixels');
    f_gr_w = Plot.w(f_gr, 'pixels');
    f_gr_h = Plot.h(f_gr, 'pixels');

    screen_x = Plot.x0(0, 'pixels');
    screen_y = Plot.y0(0, 'pixels');
    screen_w = Plot.w(0, 'pixels');
    screen_h = Plot.h(0, 'pixels');

    N = ceil(sqrt(length(pr.mlist))); % number of row and columns of figures
    f_count = 1;

    for i = 1:length(pr.mlist)
        if ~ismember(pr.mlist(i), measure_short_list)
            continue;
        end

        measure = pr.mlist{i};

        x = (f_gr_x + f_gr_w) / screen_w + mod(i - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
        y = f_gr_y / screen_h;
        w = f_gr_w / screen_w;
        h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((i - .5) / N)) / N / screen_h;

        result_measure = graph.getMeasure(measure);
        plot_permission = true;
        tmp_gui = [];
        for j = 1:length(pr.f_m)
            tmp_f = pr.f_m{j};
            if check_graphics(tmp_f,'figure')
                tmp_gui = get(tmp_f, 'UserData');
                if isequal(tmp_gui.get('pe').get('el').get('id'), result_measure.get('ID'))
                    plot_permission = false;
                    if isequal(get(tmp_f, 'Visible'), 'on')
                        % hide
                        set(tmp_f, 'Visible', 'off')
                    else
                        % show
                        figure(tmp_f)
                        set(tmp_f, ...
                            'Visible', 'on', ...
                            'WindowState', 'normal' ...
                            )
                    end
                end
            end            
        end
        if plot_permission
            pr.f_m{f_count} = GUI('pe', result_measure, 'POSITION', [x y w h], 'CLOSEREQ', false).draw();
            f_count = f_count + 1;
        end
    end
end
function cb_measure_calc(pr)
    el = pr.get('EL');
    prop = pr.get('PROP');
    graph = el.memorize(prop);
    pr.mlist = Graph.getCompatibleMeasureList(graph);

    measure_short_list = pr.mlist(pr.selected);

    % calculate
	wb = braph2waitbar(pr.get('WAITBAR'), 0, ['Calculating ' num2str(length(pr.selected))  ' measures ...']);

    for i = 1:length(pr.mlist)
        if ~ismember(pr.mlist(i), measure_short_list)
            continue;
        end

        measure = pr.mlist{i};

        braph2waitbar(wb, .1 + .20 * i / length(pr.selected), ['Calculating measure ' measure ])
        
        result_measure = graph.getMeasure(measure);
        result_measure.memorize('M');
        pr.already_calculated{i} = 1;
    end

    % close progress bar
    braph2waitbar(wb, 'close')

    pr.update();
end
function cb_graph_ui_figure(pr)
    % CB_GRAPH_UI_FIGURE draws a new figure to manage a plot graph.
    %
    % CB_GRAPH_UI_FIGURE(PR) draws a new figure to manage a plot graph and
    % sets the figure to F_PG property of PPGRAPH
    %
    % see also cb_graph_value, cb_measure_value.

    f_pg = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
    f_ba_x = Plot.x0(f_pg, 'pixels');
    f_ba_y = Plot.y0(f_pg, 'pixels');
    f_ba_w = Plot.w(f_pg, 'pixels');
    f_ba_h = Plot.h(f_pg, 'pixels');

    screen_x = Plot.x0(0, 'pixels');
    screen_y = Plot.y0(0, 'pixels');
    screen_w = Plot.w(0, 'pixels');
    screen_h = Plot.h(0, 'pixels');

    x = f_ba_x + f_ba_w;
    h = f_ba_h / 1.5;
    y = f_ba_y + f_ba_h - h;
    w = screen_w - x;
    
    if isempty(pr.f_pg) || ~check_graphics(pr.f_pg, 'figure')
        pr.f_pg = figure( ...
            'NumberTitle', 'off', ...
            'Units', 'normalized', ...
            'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
            'CloseRequestFcn', {@cb_f_pg_close} ...
            );
        set_braph2icon(pr.f_pg)
        menu_about = BRAPH2.add_menu_about(pr.f_pg);
        set(pr.f_pg, 'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')])

        el = pr.get('EL');
        prop = pr.get('PROP');        
        group = el.get('GR').get('ID');

        if isa(el, 'AnalyzeGroup_ST_MP_BUD')
            x_range = el.get('DENSITIES');
            x_title = 'DENSITIES';
        elseif isa(el, 'AnalyzeGroup_ST_MP_BUT')
            x_range = el.get('THRESHOLDS');
            x_title = 'THRESHOLDS';
        end
        
         pg = PlotAnalysisMPLine( ... 
                'Graph', pr.graph, ...
                'X', x_range, ...
                'PLOTTITLE', ['Analysis of group ' group], ...
                'XLABEL', x_title ...
                );
            
            pg.draw('Parent', pr.f_pg)
            set(pr.f_pg, 'UserData', pg);
            
            f_settings = pg.settings();
            set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
            f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
            f_settings.OuterPosition(2) = f_ba_y/screen_h;     
    elseif isequal(get(pr.f_pg, 'Visible'), 'on')
        gui = get(pr.f_pg, 'UserData');
        gui.cb_hide()
    else
        gui = get(pr.f_pg, 'UserData');
        gui.cb_bring_to_front()
    end

        function cb_f_pg_close(~, ~)
            delete(pr.f_pg);
            pr.update()
        end

    pr.update()
end
function cb_graph_adj_figure(pr)
    f_pg = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
    f_ba_x = Plot.x0(f_pg, 'pixels');
    f_ba_y = Plot.y0(f_pg, 'pixels');
    f_ba_w = Plot.w(f_pg, 'pixels');
    f_ba_h = Plot.h(f_pg, 'pixels');

    screen_x = Plot.x0(0, 'pixels');
    screen_y = Plot.y0(0, 'pixels');
    screen_w = Plot.w(0, 'pixels');
    screen_h = Plot.h(0, 'pixels');

    x = f_ba_x + f_ba_w;
    h = f_ba_h / 1.5;
    y = f_ba_y + f_ba_h - h;
    w = screen_w - x;

    if isempty(pr.f_adj) || ~check_graphics(pr.f_adj, 'figure')
        pr.f_adj = figure( ...
            'NumberTitle', 'off', ...
            'Units', 'normalized', ...
            'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
            'CloseRequestFcn', {@cb_f_adj_close} ...
            );
        set_braph2icon(pr.f_adj)
        menu_about = BRAPH2.add_menu_about(pr.f_adj);
        set(pr.f_adj, 'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')])
        el = pr.get('EL');
        prop = pr.get('PROP');
        g = el.get(prop);
        
        g_dict = IndexedDictionary( ...
            'it_class', g.getClass() ...
            );
        g_dict.add(g);
        pg = PlotAdjacencyMatrix('G_DICT', g_dict);
        
        pg.draw('Parent', pr.f_adj)
        set(pr.f_adj, 'UserData', pg);

        f_settings = pg.settings();
        set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
        f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
        f_settings.OuterPosition(2) = f_ba_y/screen_h;
    elseif isequal(get(pr.f_adj, 'Visible'), 'on')
        gui = get(pr.f_adj, 'UserData');
        gui.cb_hide()
    else
        gui = get(pr.f_adj, 'UserData');
        gui.cb_bring_to_front()
    end

        function cb_f_adj_close(~, ~)
            delete(pr.f_adj);
            pr.update()
        end

    pr.update()
end
function list =  is_measure_calculated(pr)
    % IS_MEASURE_CALCULATED checks if a measure has been calculated for the graph.
    % 
    % LIST = IS_MEASURE_CALCULATED(PR) returns an array with the check for
    %  previously calculated measures. C if a measures has been calculated
    %  and NC for nor calculated measures.
    %
    % See also get_button_condition.
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    graph = el.memorize(prop);
    measure_dict = graph.get('M_DICT');
    measure_list = pr.mlist;
    calculated_list = cell(size(measure_list, 2), 1);
    if measure_dict.length() > 0
        for i = 1:length(measure_list)
            measure = measure_list{i};
            if any(cellfun(@(x) isequal(measure, x.get('ID')), measure_dict.getItems()))
                calculated_list{i} = 1;
            else
                calculated_list{i} = 0;
            end
        end
    else
        [calculated_list{:}] = deal(0);
    end
    list = calculated_list;
end
function state = get_button_condition(pr)
    % GET_BUTTON_CONDITION returns the calculate button state.
    %
    % STATE = GET_BUTTON_CONDITION(PR) returns the calculate button state.
    %
    % see also is_measure_calculated.

    plot_prop_children = get(pr.p, 'Children');
    state = 0; % calculated
    for i = 1:length(plot_prop_children)
        pp_c = plot_prop_children(i);
        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
            if isequal(pp_c.Enable, 'off')
                state = 1;  % not calculated
            end
        end
    end
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to front the figure and its settings figure.
    %
    % CB_BRING_TO_FRONT(PR) brings to front the figure and its
    %  settings figure.
    %
    % See also cb_hide, cb_close.

    % brings to front settings panel
    pr.cb_bring_to_front@PlotProp();
    
    % bring to front graph class
    if check_graphics(pr.f_g, 'figure')
        gui = get(pr.f_g, 'UserData');
        pe = gui.get('PE');
        pe.cb_bring_to_front()
    end
    
    % bring to front measure class guis
    for i = 1:length(pr.f_m)
        f_m = pr.f_m{i};
        if check_graphics(f_m, 'figure')
            gui = get(f_m, 'UserData');
            pe = gui.get('PE');
            pe.cb_bring_to_front()
        end
    end
    
    % bring to front plot graph
    if check_graphics(pr.f_pg, 'figure')
        gui = get(pr.f_pg, 'UserData');
        gui.cb_bring_to_front()
    end  
    if check_graphics(pr.f_adj, 'figure')
        gui = get(pr.f_adj, 'UserData');
        gui.cb_bring_to_front()
    end
end
function cb_hide(pr)
    %CB_HIDE hides the figure and its settings figure.
    %
    % CB_HIDE(PR) hides the figure and its settings figure.
    %
    % See also cb_bring_to_front, cb_close.

    % hides settings panel
    pr.cb_hide@PlotProp();
    
    % bring to front graph class
    if check_graphics(pr.f_g, 'figure')
        gui = get(pr.f_g, 'UserData');
        pe = gui.get('PE');
        pe.cb_hide()
    end
    
    % bring to front measure class guis
    for i = 1:length(pr.f_m)
        f_m = pr.f_m{i};
        if check_graphics(f_m, 'figure')
            gui = get(f_m, 'UserData');
            pe = gui.get('PE');
            pe.cb_hide()
        end
    end
    
    % bring to front plot graph
    if check_graphics(pr.f_pg, 'figure')
        gui = get(pr.f_pg, 'UserData');
        gui.cb_hide();
    end 
    if check_graphics(pr.f_adj, 'figure')
        gui = get(pr.f_adj, 'UserData');
        gui.cb_hide();
    end 
end
function cb_close(pr)
    %CB_CLOSE closes the figure.
    %
    % CB_CLOSE(PR) closes the figure and its children figures.
    %
    % See also cb_bring_to_front, cd_hide.

    % closes measure class guis
    for i = 1:length(pr.f_m)
        f_m = pr.f_m{i};
        if check_graphics(f_m, 'figure')
            close(f_m)
        end
    end
    
    % close plot graph figure
    if ~isempty(pr.f_pg) && check_graphics(pr.f_pg, 'figure')
        delete(pr.f_pg);
    end
    
    
    % close adj graph figure
    if ~isempty(pr.f_adj) && check_graphics(pr.f_adj, 'figure')
        delete(pr.f_adj);
    end 
    
    % close graph class
    if check_graphics(pr.f_g, 'figure')
        gui = get(pr.f_g, 'UserData');
        pe = gui.get('PE');
        pe.cb_close()
    end
end
