%% ¡header!
PPCompareEnsembleCP < PlotProp (pl, plot property of comparison ensemble cp dict) is a plot of comparison ensemble cp dict.

%%% ¡description!
PPCompareEnsembleCP plots a Compairson Ensemble cp dictionary.

%%% ¡seealso!
GUI, PlotElement, PlotProp, CompareEnsemble, ComparisonEnsemble.

%% ¡properties!
pp
comparison_tbl
selected

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the idict for group ensemble property graphical panel.
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
    pl.selected = [];
    a1 = el.get('A1');
    graph = a1.get('G_DICT').getItem(1); % get first analysis graph class
    if isa(graph, 'NoValue')        
        graph_class =  el.get('A1').getPropSettings('G');
        graph = eval([graph_class '()']);
    end
    comparison_guis = [];
    case_ = 0;
    mlist = [];
    
    if isa(a1.get(a1.getPropNumber()), 'double')
        % I assume both analyses have the same inputs of t and d
        x_range = a1.get(a1.getPropNumber());  % bud, but
        x_label = a1.getPropTag(a1.getPropNumber());
    else
        case_ = 1; % weighted
    end

    pl.pp = draw@PlotProp(pl, varargin{:});
    set(pl.pp, 'DeleteFcn', {@close_f_settings}, ...
        varargin{:})
    
    function close_f_settings(~,~)
        if ~isempty(comparison_guis)
            for k = 1:length(comparison_guis)                
                c_gui_h = comparison_guis{k};
                if isgraphics(c_gui_h)
                    close(c_gui_h)
                end
            end
        end        
    end

    if isempty(pl.comparison_tbl) || ~isgraphics(pl.comparison_tbl, 'uitable')
        
        pl.comparison_tbl = uitable();
        set( pl.comparison_tbl, ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .9 .7], ...
            'ColumnName', {'', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'char', 'char'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', [true false false false false], ...
            'CellEditCallback', {@cb_measure_selection} ...
            )            
        
        % get compatible measures for specific graph
        mlist = Graph.getCompatibleMeasureList(graph);
        if ~isa(graph, 'Graph')
            [~, normalized] = get_figure_position();
            data = cell(length(mlist), 5);
            for mi = 1:1:length(mlist)
                if any(pl.selected == mi)
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
            set(pl.comparison_tbl, 'Data', data)
            set(pl.comparison_tbl, 'ColumnWidth', ['auto' 'auto' 'auto' 'auto' normalized(3)*.9*.3])
        end
    end
    
    ui_button_table_calculate = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_selectall = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_clearselection = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');    
    
    init_buttons()
        function init_buttons()            
            set(ui_button_table_calculate, ...
                'Position', [.02 .01 .3 .07], ...
                'String', 'Calculate Measures', ...
                'TooltipString', 'Calculate Selected Measures', ...
                'Callback', {@cb_table_calculate})           
            
            
            set(ui_button_table_selectall, ...
                'Position', [.34 .01 .3 .07], ...
                'String', 'Select All', ...
                'TooltipString', 'Select all measures', ...
                'Callback', {@cb_table_selectall})

            set(ui_button_table_clearselection, ...
                'Position', [.66 .01 .3 .07], ...
                'String', 'Clear All', ...
                'TooltipString', 'Clear selection', ...
                'Callback', {@cb_table_clearselection})
        end

    % callbacks
        function cb_measure_selection(~, event)
            i = event.Indices(1);
            col = event.Indices(2);
            newdata = event.NewData;
            switch col
                case 1
                    if newdata == 1
                        pl.selected = sort(unique([pl.selected(:); i]));
                    else
                        pl.selected = pl.selected(pl.selected~=i);
                    end
                otherwise
            end
            pl.update()            
        end
        function cb_table_selectall(~, ~)  % (src, event)            
            pl.selected = (1:1:length(mlist))';
            pl.update()
        end
        function cb_table_clearselection(~, ~)  % (src, event)            
            pl.selected = [];
            pl.update()
        end
        function cb_table_calculate(~, ~)
            mlist = Graph.getCompatibleMeasureList(graph);
            calculate_measure_list = mlist(pl.selected);            
            
            % calculate
            f = waitbar(0, ['Calculating ' num2str(length(calculate_measure_list))  ' measures ...'], 'Name', BRAPH2.NAME);
            set_icon(f)
            for i = 1:length(calculate_measure_list)
                progress = (1 / (length(calculate_measure_list) * .9)) * i;   
                extra = (1 / (length(calculate_measure_list) * .9)) * 1.5;
                measure = calculate_measure_list{i};
                waitbar(progress, f, ['Calculating comparison: ' measure ' ...']);               
                
                result_comparison{i, 1} = el.getComparison(measure).memorize('DIFF'); %#ok<*AGROW>
                result_comparison{i, 2} = el.getComparison(measure).memorize('P1');
                result_comparison{i, 3} = el.getComparison(measure).memorize('P2');
                result_comparison{i, 4} = el.getComparison(measure).memorize('CIL');
                result_comparison{i, 5} = el.getComparison(measure).memorize('CIU');
                waitbar(extra, f, ['Measure: ' measure ' Calculated! ...']);
            end
            
            [~, normalized] = get_figure_position();
            % create window for results            
            % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
            x2 = normalized(1) + normalized(3);
            h2 = normalized(4);
            y2 = normalized(2);
            w2 = normalized(3);            
            
            waitbar(.95, f, 'Plotting the Comparisons GUI ...')            
            for i = 1:length(calculate_measure_list)                
                offset = 0.02 * i;
                if offset > .45
                    offset = 0;
                end
                measure_class = calculate_measure_list{i};
                comparison = result_comparison(i, :);
                
                if case_
                    comparison_guis{i} = GUIComparisonWeightedPlot(comparison, measure_class, [x2+offset y2-offset w2*1.61 h2]);
                else
                    comparison_guis{i} = GUIComparisonPlot(comparison, measure_class, [x2+offset y2-offset w2*1.61 h2]);
                end
            end

            % close progress bar
            if exist('f', 'var')
                waitbar(1, f, 'Finishing')
                pause(.5)
                close(f)
            end       
        end
        function [pixels, normalized] = get_figure_position()
            fig_h = getGUIFigureObj();
            set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
            pixels = getpixelposition(fig_h);
            normalized = get(fig_h, 'Position');
            set(fig_h, 'Units', 'characters'); % go back
        end
        function obj = getGUIFigureObj()
            obj = get_handle_objs('figure', 'Compare');
        end       
        function h = GUIComparisonPlot(comparison, measure_class, position)
            f_title = ['Plot of Comparison: ' measure_class];
            nodes1_selection = 1;
            nodes2_selection = 1;
            nodes_list = [];

            f =  figure( ...
                'Visible', 'on', ...
                'NumberTitle', 'off', ...
                'Name', f_title, ...
                'Units', 'normalized', ...
                'Position', position, ...
                'MenuBar', 'none', ...
                'Toolbar', 'figure', ...
                'Color', 'w' ...
                );


            set_icon(f)
            
            diff = comparison{1, 1};
            p1 = comparison{1, 2};
            p2 = comparison{1, 3};
            cil = comparison{1, 4};
            ciu = comparison{1, 5};

            % ui objects declaration
            plot_panel = uipanel(f, 'Units', 'normalized');
            nodes1_popmenu = uicontrol(f, 'Units', 'normalized');
            nodes2_popmenu = uicontrol(f, 'Units', 'normalized');

            % flow
            update_nodes_list()
            init_gui_buttons()
            h_axes = axes(plot_panel);
            gui_toolbar()
            update_plot()

            % functions
            function init_gui_buttons()
                set(plot_panel, ...
                    'Position', [.02 .1 .98 .88] ...
                    )

                set(nodes1_popmenu, ...
                    'Position', [.3 .01 .3 .07], ...
                    'Style', 'popupmenu', ...
                    'String', nodes_list, ...
                    'Callback', {@cb_nodes1} ...
                    )

                set(nodes2_popmenu, ...
                    'Position', [.62 .01 .3 .07], ...
                    'Style', 'popupmenu', ...
                    'String', nodes_list, ...
                    'Callback', {@cb_nodes2} ...
                    )
                rules_node_popmenu_deactivation()
            end
            function gui_toolbar()
                ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
                delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
                delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
                delete(findall(ui_toolbar, 'Tag', 'Standard.SaveFigure'))
                delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
                delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
                delete(findall(ui_toolbar, 'Tag', 'Standard.OpenInspector'))
                delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
                delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
                delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
                delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
                delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
                delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
            end
            function cb_nodes1(~, ~)
                nodes1_selection = get(nodes1_popmenu, 'Value');
                update_plot();
            end
            function cb_nodes2(~, ~)
                nodes2_selection = get(nodes2_popmenu, 'Value');
                update_plot();
            end
            function rules_node_popmenu_deactivation()
                if Measure.is_global(measure_class)
                    set(nodes1_popmenu, ...
                        'Visible', 'off' ...
                        )
                    set(nodes2_popmenu, ...
                        'Visible', 'off' ...
                        )
                elseif Measure.is_nodal(measure_class)
                    set(nodes1_popmenu, ...
                        'Visible', 'on' ...
                        )
                    set(nodes2_popmenu, ...
                        'Visible', 'off' ...
                        )
                else
                    set(nodes1_popmenu, ...
                        'Visible', 'on' ...
                        )
                    set(nodes2_popmenu, ...
                        'Visible', 'on' ...
                        )
                end
            end
            function update_nodes_list()
                node_dict = a1.get('GR').get('SUB_DICT').getItem(1).get('BA').get('BR_DICT');
                nodes_list = cellfun(@(x) x.get('ID') , node_dict.getItems(), 'UniformOutput', false);
            end
            function update_plot()
                plot_value = diff;
                if Measure.is_global(measure_class) % global
                    is_inf_vector = cellfun(@(x) isinf(x), plot_value);
                    if any(is_inf_vector)
                        return;
                    end
                    y_ = [plot_value{:}];
                elseif Measure.is_nodal(measure_class) % nodal
                    for l = 1:length(plot_value)
                        tmp = plot_value{l};
                        tmp_y = tmp(nodes1_selection);
                        if isinf(tmp_y)
                            return;
                        end
                        y_(l) = tmp_y; %#ok<AGROW>
                    end
                else  % binodal
                    for l = 1:length(plot_value)
                        tmp = plot_value{l};
                        tmp_y = tmp(nodes1_selection, nodes2_selection);
                        if isinf(tmp_y)
                            return;
                        end
                        y_(l) = tmp_y; %#ok<AGROW>
                    end
                end

                x_ = x_range;
                
                if ~isempty(x_) && ~isempty(y_)                    
                    
                    p = plot(h_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'o', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.9 .4 .1], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 0 1]);
                else
                end
                
                hold(h_axes, 'on')
                xlabel(h_axes, x_label)
                ylabel(h_axes, measure_class)
                
                ui_confidence_interval_min_checkbox = uicontrol(f, 'Style', 'checkbox', 'Units', 'normalized');
                ui_confidence_interval_max_checkbox = uicontrol(f, 'Style', 'checkbox', 'Units', 'normalized');
                init_plot_panel()
                function init_plot_panel()
                    set(ui_confidence_interval_min_checkbox, 'Position', [.02 .08 .25 .05]);
                    set(ui_confidence_interval_min_checkbox, 'String', 'Show Confidence Interval Min');
                    set(ui_confidence_interval_min_checkbox, 'Value', false);
                    set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})
                    
                    set(ui_confidence_interval_max_checkbox, 'Position', [.02 .02 .25 .05]);
                    set(ui_confidence_interval_max_checkbox, 'String', 'Show Confidence Interval Max');
                    set(ui_confidence_interval_max_checkbox, 'Value', false);
                    set(ui_confidence_interval_max_checkbox, 'Callback', {@cb_show_confidence_interval_max})
                end
                
                h_p_min = [];
                h_p_max = [];
                function cb_show_confidence_interval_min(src, ~)
                    if src.Value == true
                        
                        y_ = cil;
                        x_ = x_range;
                        h_p_min = plot(h_axes, ...
                            x_, ...
                            y_, ...
                            'Marker', 'x', ...
                            'MarkerSize', 10, ...
                            'MarkerEdgeColor', [0 0 1], ...
                            'MarkerFaceColor', [.3 .4 .5], ...
                            'LineStyle', '-', ...
                            'LineWidth', 1, ...
                            'Color', [0 1 1]);
                        h_p_min.Visible = true;
                    else
                        h_p_min.Visible = false;
                    end
                end
                function cb_show_confidence_interval_max(src, ~)
                    if src.Value == true
                        
                        y_ = ciu; 
                        x_ = x_range;
                        h_p_max = plot(h_axes, ...
                            x_, ...
                            y_, ...
                            'Marker', 'x', ...
                            'MarkerSize', 10, ...
                            'MarkerEdgeColor', [0 0 1], ...
                            'MarkerFaceColor', [.3 .4 .5], ...
                            'LineStyle', '-', ...
                            'LineWidth', 1, ...
                            'Color', [0 1 1]);
                        h_p_max.Visible = true;
                    else
                        h_p_max.Visible = false;
                    end
                end
            end

            if nargout > 0
                h = f;
            end
        end
        function h = GUIComparisonWeightedPlot(comparison, measure_class, position)
            f_title = ['Plot of Comparison: ' measure_class];

            f =  figure( ...
                'Visible', 'on', ...
                'NumberTitle', 'off', ...
                'Name', f_title, ...
                'Units', 'normalized', ...
                'Position', position, ...
                'MenuBar', 'none', ...
                'Toolbar', 'figure', ...
                'Color', 'w' ...
                );

            set_icon(f)

            diff = comparison{1, 1};
            p1 = comparison{1, 2};
            p2 = comparison{1, 3};
            cil = comparison{1, 4};
            ciu = comparison{1, 5};
            
            uitable(f, ...
                'Units', 'normalized', ...
                'Position', [.02 .82 .98 .18], ...
                'Data', diff{:} ...
                );
            
            uitable(f, ...
                'Units', 'normalized', ...
                'Position', [.02 .62 .98 .18], ...
                'Data', p1{:} ...
                );
            
            uitable(f, ...
                'Units', 'normalized', ...
                'Position', [.02 .42 .98 .18], ...
                'Data', p2{:} ...
                );
            
            uitable(f, ...
                'Units', 'normalized', ...
                'Position', [.02 .22 .98 .18], ...
                'Data', cil{:} ...
                );
            
            uitable(f, ...
                'Units', 'normalized', ...
                'Position', [.02 .02 .98 .18], ...
                'Data', ciu{:} ...
                );

            if nargout > 0
                h = f;
            end
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
    a1 = el.get('A1');
    graph = a1.get('G_DICT').getItem(1);

    function [pixels, normalized] = get_figure_position()
        fig_h = getGUIFigureObj();
        set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
        pixels = getpixelposition(fig_h);
        normalized = get(fig_h, 'Position');
        set(fig_h, 'Units', 'characters'); % go back
    end
    function obj = getGUIFigureObj()
        obj = get_handle_objs('figure', 'CompareEnsemble');
    end

    if el.getPropCategory(prop) == Category.RESULT && isa(graph, 'NoValue')
        %
    else
        % construct a data holder
        if isa(graph, 'Graph')  
            [parent_position_pixels, ~] = get_figure_position();
            mlist = Graph.getCompatibleMeasureList(graph);
            data = cell(length(mlist), 5);
            for mi = 1:1:length(mlist)
                if any(pl.selected == mi)
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

            set(pl.comparison_tbl, ...
                'Data', data, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)] ...
                )
            set(pl.comparison_tbl, 'ColumnWidth', {'auto', 'auto', 'auto', 'auto', parent_position_pixels(3)})
        end

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

    pl.redraw@PlotProp('Height', 30, varargin{:});
end
function selected = getSelected(pl)
    selected = pl.selected;
end