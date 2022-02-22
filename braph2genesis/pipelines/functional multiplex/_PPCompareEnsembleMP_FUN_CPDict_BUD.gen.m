%% ¡header!
PPCompareEnsembleMP_FUN_CPDict_BUD < PlotProp (pr, plot property graph mp) is a plot of a binary undirect using densities multilayer comparison ensemble dictionary.

%%% ¡description!
PPCompareEnsembleMP_FUN_CPDict_BUD plots the binary undirect using densities multilayer comparison ensemble
dictionary property associated with a graph.
It also provides the buttons to navigate the graphical interface of the multilayer measure ensemble.

CALLBACK - These are callback functions:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, PlotProp, CompareEnsemble, ComparisonEnsemble.

%% ¡properties!
p
measure_tbl % measure table
measure_btn % calculate measures button
line_plot_tgl_btn % line plot toggle button
adj_plot_tgl_btn % adjacency toggle button
mlist % list of measures compatible with the graph
selected % list of selected measures
already_calculated % list of measures already calculated
f_m % array of measure class figures
f_pc % figure for plot graph
f_adj
graph % graph of the comparison

%% ¡props_update!

%%% ¡prop!
ENABLE (metadata, option) switches between off and inactive fields.
%%%% ¡default!
'on'

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

    % declare constants
    el = pr.get('EL');
    a1 = el.get('A1');
    pr.graph = a1.get('G_DICT').getItem(1);

    pr.p = draw@PlotProp(pr, varargin{:});

    % graph button
    pr.adj_plot_tgl_btn = uicontrol(...
        'Style', 'pushbutton', ...
        'Parent', pr.p, ...
        'Units', 'normalized', ...
        'CData', imresize(imread('icon_plot_adj.png'), [40 40]), ...
        'TooltipString', 'Plot to adjacency matrix plot.', ...
        'Position', [.01 .71 .2 .2], ...
        'Callback', {@cb_plot_type_adj} ...
        );
    
    pr.line_plot_tgl_btn = uicontrol(...
        'Style', 'pushbutton', ...
        'Parent', pr.p, ...
        'Units', 'normalized', ...
        'CData', imresize(imread('icon_plot_lines.png'), [40 40]), ...
        'TooltipString', 'Plot to line plot.', ...
        'Position', [.23 .71 .2 .2], ...
        'Callback', {@cb_plot_type_line} ...
        );
        
    function cb_plot_type_adj(~, ~)
        pr.cb_graph_adj_figure();
    end
    function cb_plot_type_line(~, ~)
        pr.cb_graph_ui_figure();
    end    

    if isempty(pr.measure_tbl) || ~isgraphics(pr.measure_tbl, 'uitable')
        pr.mlist = [];

        pr.measure_tbl = uitable( ...
            'Parent', pr.p, ...
            'CellEditCallback', {@cb_measure_edit} ...
            );

        % measure button
        pr.measure_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'measure_button', ...
            'Units', 'normalized', ...
            'String', 'Calculate Comparisons', ...
            'TooltipString', 'Calculate Selected Measure Comparison', ...
            'Position', [.01 .02 .48 .09], ...
            'Callback', {@cb_measure_btn} ...
            );
        
        measure_plot_btn = uicontrol(...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'measure_plot_button', ...
            'Units', 'normalized', ...
            'String', 'Show Comparisons', ...
            'TooltipString', 'Show Selected Measures Comparison', ...
            'Position', [.51 .02 .48 .09], ...
            'Callback', {@cb_measure_plot_btn} ...
            );
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
    set(...
        pr.measure_tbl, ...
        'Visible', 'on', ...
        'ColumnName', {'SEL', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
        'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
        'ColumnEditable', [true false false false false] ...
        );

    if button_state

    else

        if  ~isa(pr.graph, 'NoValue') && isa(pr.graph, 'Graph')
            if isempty(pr.mlist)
                pr.mlist = Graph.getCompatibleMeasureList(pr.graph);
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
                    row_names{i} = 'NC';
                end
            end
            set(pr.measure_tbl, 'RowName', row_names)
        end

        if ~check_graphics(pr.f_pc, 'figure')
            set(pr.adj_plot_tgl_btn, 'Enable', 'on');
            set(pr.line_plot_tgl_btn, 'Enable', 'on');
        end

    end

        function plot_type_rules()
            if ~isempty(pr.graph) && isa(el.get('A1'), 'AnalyzeEnsemble_FUN_MP_BUD') && ~isempty(pr.already_calculated) && any([pr.already_calculated{:}])
                set(pr.line_plot_tgl_btn, 'Enable', 'on');
            else
                set(pr.line_plot_tgl_btn, 'Enable', 'off');
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

    set(pr.measure_tbl, ...
        'Units', 'normalized', ...
        'Position', [.01 .13 .98 (Dh/(h+Dh)-.32)] ...
        )

    pr.redraw@PlotProp('Height', h + Dh, varargin{:})
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
    cp_dict = el.get(prop);    
    pr.mlist = Graph.getCompatibleMeasureList(pr.graph);
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

    for i = 1:length(pr.mlist)
        if ~ismember(pr.mlist(i), measure_short_list)
            continue;
        end
        measure_name = pr.mlist{i};
        for j = 1:cp_dict.length()
            cp = cp_dict.getItem(j);
            if isequal(measure_name, cp.get('measure'))
                x = (f_gr_x + f_gr_w) / screen_w + mod(i - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                y = f_gr_y / screen_h;
                w = f_gr_w / screen_w;
                h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((i - .5) / N)) / N / screen_h;
                               
                pr.f_m{i} = GUI('pe', cp, 'POSITION', [x y w h], 'CLOSEREQ', false).draw();   
                break; % go to next measure
            end            
        end        
    end
end
function cb_measure_calc(pr)
    el = pr.get('EL');   
    pr.mlist = Graph.getCompatibleMeasureList(pr.graph);
    measure_short_list = pr.mlist(pr.selected);

    % calculate
    if pr.get('WAITBAR')
        wb = waitbar(0, ['Calculating ' num2str(length(pr.selected))  ' comparisons ...'], 'Name', BRAPH2.NAME);
        set_braph2_icon(wb)
    end

    for i = 1:length(pr.mlist)
        if ~ismember(pr.mlist(i), measure_short_list)
            continue;
        end

        measure = pr.mlist{i};
        if pr.get('WAITBAR')
            waitbar(.1 + .70 * i / length(pr.selected), wb, ['Calculating measure ' measure ]);
        end
        el.getComparison(measure).memorize('DIFF');
        el.getComparison(measure).get('P1');
        el.getComparison(measure).get('P2');
        el.getComparison(measure).get('CIL');
        el.getComparison(measure).get('CIU');
        pr.already_calculated{i} = 1;
    end

    % close progress bar
    if pr.get('WAITBAR')
        close(wb)
    end
    pr.update();
end
function cb_graph_ui_figure(pr)
    % CB_GRAPH_UI_FIGURE draws a new figure to manage a plot graph.
    %
    % CB_GRAPH_UI_FIGURE(PR) draws a new figure to manage a plot graph and
    % sets the figure to F_PG property of PPGRAPH
    %
    % see also cb_graph_value, cb_measure_value.

    f_pc = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
    f_ba_x = Plot.x0(f_pc, 'pixels');
    f_ba_y = Plot.y0(f_pc, 'pixels');
    f_ba_w = Plot.w(f_pc, 'pixels');
    f_ba_h = Plot.h(f_pc, 'pixels');

    screen_x = Plot.x0(0, 'pixels');
    screen_y = Plot.y0(0, 'pixels');
    screen_w = Plot.w(0, 'pixels');
    screen_h = Plot.h(0, 'pixels');

    x = f_ba_x + f_ba_w;
    h = f_ba_h / 1.5;
    y = f_ba_y + f_ba_h - h;
    w = screen_w - x;

   if isempty(pr.f_pc) || ~check_graphics(pr.f_pc, 'figure')
        pr.f_pc = figure( ...
            'NumberTitle', 'off', ...
            'Units', 'normalized', ...
            'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
            'CloseRequestFcn', {@cb_f_pg_close} ...
            );
        set_braph2_icon(pr.f_pc)
        menu_about = BRAPH2.add_menu_about(pr.f_pc);
        
        el = pr.get('EL');
        prop = pr.get('PROP');
        
        x_range = el.get('A1').get('DENSITIES');
        x_title = 'DENSITIES';
        
        plot_title = ['Comparison between ' el.get('A1').get('GR').get('ID') ' and ' el.get('A2').get('GR').get('ID')];
        pg = PlotComparisonEnsembleMPLine( ...
            'Comparison', el.get('CP_DICT'), ...
            'X', x_range, ...
            'PLOTTITLE', plot_title, ...
            'XLABEL', x_title ...
            );
        pg.draw('Parent', pr.f_pc)
        set(pr.f_pc, 'UserData', pg);
        
        f_settings = pg.settings();
        set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
        f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
        f_settings.OuterPosition(2) = f_ba_y/screen_h;
   else
       gui = get(pr.f_pc, 'UserData');
       gui.cb_bring_to_front()
   end

        function cb_f_pg_close(~, ~)
            delete(pr.f_pc);
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
        set_braph2_icon(pr.f_adj)
        menu_about = BRAPH2.add_menu_about(pr.f_adj);
        el = pr.get('EL');
        a1 = el.get('A1');
        g_dict_tmp = a1.get('G_DICT');
        pg = PlotAdjacencyMatrix('G_DICT', g_dict_tmp);
        pg.draw('Parent', pr.f_adj)
        set(pr.f_adj, 'UserData', pg);

        f_settings = pg.settings();
        set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
        f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
        f_settings.OuterPosition(2) = f_ba_y/screen_h;
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
    cp_dict = el.get(prop);
    measure_list = pr.mlist;
    calculated_list = cell(cp_dict.length(), 1);
    if cp_dict.length() > 0
        for i = 1:length(measure_list)
            measure = measure_list{i};
            if any(cellfun(@(x) isequal(x.get('MEASURE'), measure), cp_dict.getItems()))
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
    state = 0;
    for i = 1:length(plot_prop_children)
        pp_c = plot_prop_children(i);
        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
            if isequal(pp_c, 'on')
                state = 1;            
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
    if check_graphics(pr.f_pc, 'figure')
        gui = get(pr.f_pc, 'UserData');
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
    if check_graphics(pr.f_pc, 'figure')
        gui = get(pr.f_pc, 'UserData');
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
    if ~isempty(pr.f_pc) && check_graphics(pr.f_pc, 'figure')
        delete(pr.f_pc);
    end
    if ~isempty(pr.f_adj) && check_graphics(pr.f_adj, 'figure')
        delete(pr.f_adj);
    end    
end
