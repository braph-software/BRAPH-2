%% ¡header!
PPCompareGroup_CPDict_ST_WU < PlotProp (pr, plot property graph) is a plot of a comparison dictionary.

%%% ¡description!
PPCompareGroup_CPDict_WU plots the comparison dictionary property associated with a graph.
It also provides the buttons to navigate the graphical interface of the measures.

CALLBACK -  These are callback functions:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, PlotProp, CompareGroup, ComparisonGroup.

%% ¡properties!
p
measure_tbl % measure table
measure_btn % calculate measures button
measure_plot_btn
mlist % list of measures compatible with the graph
selected % list of selected measures
already_calculated % list of measures already calculated
f_m % array of measure class figures
graph % graph of the comparison

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

    % graph button   
    
    pr.mlist = [];
    
    pr.measure_tbl = uitable( ...
        'Parent', pr.p, ...
        'CellEditCallback', {@cb_measure_edit}, ...
        'ColumnName', {'SEL', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
        'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
        'Visible', 'off', ...
        'ColumnEditable', [true false false false false] ...
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
        'Visible', 'off', ...
        'Callback', {@cb_measure_btn} ...
        );
    
    pr.measure_plot_btn = uicontrol(...
        'Parent', pr.p, ...
        'Style', 'pushbutton', ...
        'Tag', 'measure_plot_button', ...
        'Units', 'normalized', ...
        'String', 'Show Comparisons', ...
        'TooltipString', 'Show Selected Measures Comparison', ...
        'Position', [.51 .02 .48 .09], ...
        'Visible', 'off', ...
        'Callback', {@cb_measure_plot_btn} ...
        );
        
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
        set(pr.measure_tbl, 'Visible', 'off')
        set(pr.measure_btn, 'Visible', 'off')
        set(pr.measure_plot_btn, 'Visible', 'off')

    else
        cp_dict = el.get(prop);
        pr.graph = el.get('A1').get('G');
        
         % visible gui
        set(pr.measure_tbl, 'Visible', 'on')
        set(pr.measure_btn, 'Visible', 'on')
        set(pr.measure_plot_btn, 'Visible', 'on')

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
                    row_names{i} = '';
                end
            end
            set(pr.measure_tbl, 'RowName', row_names)
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
        if  ~isempty(pr.measure_tbl) && isgraphics(pr.measure_tbl, 'uitable')
            set(pr.measure_tbl, ...
                'Units', 'normalized', ...
                'Position', [.01 .13 .98 (Dh/(h+Dh)-.27)] ...
                )
        end
        pr.redraw@PlotProp('Height', (h + Dh)*1.5, varargin{:})
    else
        if  ~isempty(pr.measure_tbl) && isgraphics(pr.measure_tbl, 'uitable')
            set(pr.measure_tbl, ...
                'Units', 'normalized', ...
                'Position', [.01 .13 .98 (Dh/(h+Dh)-.32)], ...
                'Visible', 'off' ...
                )
        end
        pr.redraw@PlotProp(varargin{:})
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

    f_count = 1;
    for i = 1:length(pr.mlist)
        if ~ismember(pr.mlist(i), measure_short_list)
            continue;
        end
        measure_name = pr.mlist{i};
        plot_permission = true;
        tmp_gui = [];
        for j = 1:cp_dict.length()
            cp = cp_dict.getItem(j);
            if isequal(measure_name, cp.get('measure'))
                x = (f_gr_x + f_gr_w) / screen_w + mod(i - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                y = f_gr_y / screen_h;
                w = f_gr_w / screen_w;
                h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((i - .5) / N)) / N / screen_h;
                   
                for k = 1:length(pr.f_m)
                    tmp_f = pr.f_m{k};
                    if isgraphics(tmp_f)
                        tmp_gui = get(tmp_f, 'UserData');
                        if isequal(tmp_gui.get('pe').get('el').get('id'), cp.get('ID'))
                            plot_permission = false;
                            if isequal(get(tmp_f, 'Visible'), 'on')
                                % hide
                                set(tmp_f, 'Visible', 'off')
                            else
                                % show
                                figure(tmp_f);
                                set(tmp_f, ...
                                    'Visible', 'on', ...
                                    'WindowState', 'normal' ...
                                    );
                            end
                        end
                    end                    
                end
                if plot_permission
                    pr.f_m{f_count} = GUI('pe', cp, 'POSITION', [x y w h], 'CLOSEREQ', false).draw();
                    f_count = f_count + 1;
                end
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
            waitbar(.1 + .20 * i / length(pr.selected), wb, ['Calculating comparison ' measure ]);
        end
        el.getComparison(measure).memorize('DIFF');
        el.getComparison(measure).memorize('P1');
        el.getComparison(measure).memorize('P2');
        el.getComparison(measure).memorize('CIL');
        el.getComparison(measure).memorize('CIU');
        pr.already_calculated{i} = 1;
    end

    % close progress bar
    if pr.get('WAITBAR')
        close(wb)
    end
    pr.update();
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
            if isequal(pp_c.Enable, 'off')
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
    
end
