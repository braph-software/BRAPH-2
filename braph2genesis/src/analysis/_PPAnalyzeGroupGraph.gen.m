%% ¡header!
PPAnalyzeGroupGraph < PlotProp (pl, plot property of analyze group graph) is a plot of analyze group graph.

%%% ¡description!
PPAnalyzeGroupGraph plots a Analyze Group graph table.

%%% ¡seealso!
GUI, PlotElement, PlotProp, AnalyzeGroup, AnalyzeGroup_ST_WU, AnalyzeGroup_ST_BUT, AnalyzeGroup_ST_BUD

%% ¡properties!
pp
measure_tbl
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

    pl.pp = draw@PlotProp(pl, varargin{:});

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
    end
function update(pl, selected, calculate, plot_selected)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, redraw, refresh.

    update@PlotProp(pl)

    el = pl.get('EL');
    prop = pl.get('PROP');
    if nargin > 1
        pl.selected = selected;
    else
        pl.selected = [];
    end
     if nargin > 2
        to_calc = calculate;
    else
        to_calc = [];
    end
    if nargin > 3
        to_plot = plot_selected;
    else
        to_plot = [];
    end

    measures_guis = [];
    graph_gui = [];
    mlist = [];

    if el.getPropCategory(prop) == Category.RESULT && ~el.isLocked('ID')
        % do nothing
    else
        graph = el.get(prop);
        if isa(graph, 'NoValue')
            graph = el.getPropDefault(prop);
        end
        if isempty(pl.measure_tbl) || ~isgraphics(pl.measure_tbl, 'uitable')
            uicontrol( ...
                'Parent', pl.pp, ...
                'Units', 'normalized', ...
                'Position', [.3 .8 .3 .1], ...
                'Style', 'Text', ...
                'String', graph.getClass() ...
                )

            pl.measure_tbl = uitable();
            set( pl.measure_tbl, ...
                'Parent', pl.pp, ...
                'Units', 'normalized', ...
                'Position', [.02 .2 .9 .7], ...
                'ColumnName', {'SEL', 'CAL', 'GUI', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
                'ColumnFormat', {'logical', 'logical', 'logical', 'char', 'char', 'char', 'char'}, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'ColumnEditable', [true true true false false false false], ...
                'CellEditCallback', {@cb_measure_selection} ...
                )
        end

        % get compatible measures for specific graph
        mlist = Graph.getCompatibleMeasureList(graph);
        if isa(graph, 'Graph')
            [parent_position_pixels, normalized] = get_figure_position();
            data = cell(length(mlist), 7);
            for mi = 1:1:length(mlist)
                if any(pl.selected == mi)
                    data{mi, 1} = true;
                else
                    data{mi, 1} = false;
                end
                if any(to_calc == mi)
                    data{mi, 2} = true;
                else
                    data{mi, 2} = false;
                end
                if any(to_plot == mi)
                    data{mi, 3} = true;
                else
                    data{mi, 3} = false;
                end
                data{mi, 4} = mlist{mi};
                if Measure.is_nodal(mlist{mi})
                    data{mi, 5} = 'NODAL';
                elseif Measure.is_global(mlist{mi})
                    data{mi, 5} = 'GLOBAL';
                else
                    data{mi, 5} = 'BINODAL';
                end

                if Measure.is_superglobal(mlist{mi})
                    data{mi, 6} = 'SUPERGLOBAL';
                elseif Measure.is_unilayer(mlist{mi})
                    data{mi, 6} = 'UNILAYER';
                else
                    data{mi, 6} = 'BILAYER';
                end

                data{mi, 7} = eval([mlist{mi} '.getDescription()']);
            end
            set(pl.measure_tbl, 'Data', data)
            set(pl.measure_tbl, 'ColumnWidth', {parent_position_pixels(3)*.06, parent_position_pixels(3)*.06, parent_position_pixels(3)*.06, 'auto', 'auto', 'auto', parent_position_pixels(3)})
        end

        ui_button_table_calculate = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_delete = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_table_see_graph = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_table_selectall = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_table_clearselection = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');

        init_buttons()
    end

        function init_buttons()
            set(ui_button_table_calculate, ...
                'Position', [.02 .11 .22 .07], ...
                'String', 'Calculate Measures', ...
                'TooltipString', 'Calculate Selected Measures', ...
                'Callback', {@cb_table_calculate})

            set(ui_button_delete, ...
                'Position', [.02 .01 .22 .07], ...
                'String', 'Delete Measures', ...
                'TooltipString', 'Delete Selected Measures', ...
                'Callback', {@cb_table_delete})

            set(ui_button_table_see_graph, ...
                'Position', [.26 .01 .22 .07], ...
                'String', 'See Graph', ...
                'TooltipString', 'Create a GUI Graph', ...
                'Callback', {@cb_table_graph})

            set(ui_button_table_selectall, ...
                'Position', [.52 .01 .22 .07], ...
                'String', 'Select All', ...
                'TooltipString', 'Select all measures', ...
                'Callback', {@cb_table_selectall})

            set(ui_button_table_clearselection, ...
                'Position', [.76 .01 .22 .07], ...
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
                        pl.selected = pl.selected(pl.selected ~= i);
                    end
                case 2
                    if newdata == 1
                        to_calc = sort(unique([to_calc(:); i]));
                        pl.selected = sort(unique([pl.selected(:); i]));
                    else
                        to_calc = to_calc(to_calc ~= i);
                    end
                case 3
                    if newdata == 1
                        to_plot = sort(unique([to_plot(:); i]));
                        pl.selected = sort(unique([pl.selected(:); i]));
                    else
                        to_plot = to_plot(to_plot ~= i);
                    end
                otherwise
            end
            pl.update(pl.selected, to_calc, to_plot)
        end
        function cb_table_selectall(~, ~)  % (src, event)
            mlist = Graph.getCompatibleMeasureList(graph);
            pl.selected = (1:1:length(mlist))';
            pl.update(pl.selected)
        end
        function cb_table_clearselection(~, ~)  % (src, event)
            pl.selected = [];
            pl.update(pl.selected)
        end
        function cb_table_calculate(~, ~)
            mlist = Graph.getCompatibleMeasureList(graph);
            calculate_measure_list = mlist(pl.selected);
            measure_list_to_plot = mlist(to_plot);
            measure_list_to_calculate = mlist(to_calc);
            g = el.memorize('G');

            % calculate
            f = waitbar(0, ['Calculating ' num2str(length(calculate_measure_list))  ' measures ...'], 'Name', BRAPH2.NAME);
            set_icon(f)
            for i = 1:length(calculate_measure_list)
                progress = (i / length(calculate_measure_list)) * .8;
                extra = (i / length(calculate_measure_list)) * 1.05 * .8;
                measure = calculate_measure_list{i};
                waitbar(progress, f, ['Calculating measure: ' measure ' ...']);
                g_measure = g.getMeasure(measure); %#ok<AGROW>

                if contains(measure, measure_list_to_plot)
                    plot_measure{i} = true; %#ok<AGROW>
                else
                    plot_measure{i} = false; %#ok<AGROW>
                end
                
                % precalculate
                if contains(measure, measure_list_to_calculate)
                    g_measure.get('M');                    
                end
                
                result_measure{i} = g_measure;
                waitbar(extra, f, ['Measure: ' measure ' Calculated! ...']);
            end

            if ~isempty(to_plot)
                [~, normalized] = get_figure_position();
                % create window for results
                % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
                x2 = normalized(1) + normalized(3);
                h2 = normalized(4);
                y2 = normalized(2);
                w2 = normalized(3);
                waitbar(.95, f, 'Plotting the Measures GUI ...')
                k = 1;
                for i = 1:length(result_measure)
                    if plot_measure{i}
                        offset = 0.02 * k;
                        if offset > .45
                            offset = 0;
                        end
                        measure = result_measure{i};
                        GUI(measure, 'CloseRequest', false, 'Position', [x2+offset y2-offset w2 h2])
                        k = k + 1;
                    end
                end
            end

            % close progress bar
            if exist('f', 'var')
                waitbar(1, f, 'Finishing')
                pause(.5)
                close(f)
            end
            measures_guis = getGUIMeasures();
        end
        function cb_table_delete(~, ~)
            mlist = Graph.getCompatibleMeasureList(graph);
            delete_measure_list = mlist(pl.selected);
            g_dict = el.get(prop).get('M_DICT');
            for i = 1:length(delete_measure_list)
                m_delete = delete_measure_list{i};
                if g_dict.contains(m_delete)
                    index = g_dict.getIndex(m_delete);
                    g_dict.remove(index);
                end
            end
        end
        function cb_table_graph(~, ~)
            [parent_position_pixels, normalized] = get_figure_position();
            w = parent_position_pixels(3);
            h = parent_position_pixels(4);

            screen_size = get(0,'screensize');

            if w >= screen_size(3) / 2
                x2 = normalized(1) / 2;
                w2 = normalized(3) / 2 - .01;
            elseif h == screen_size(4)
                y2 = normalized(2);
                h2 = normalized(4) / 2;
            else % golden ratio
                % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
                x2 = normalized(1) + normalized(3);
                h2 = normalized(4);
                y2 = normalized(2);
                w2 = normalized(3);
            end
            GUI(graph, 'CloseRequest', false, 'Position', [x2 y2 w2 h2]);
            graph_gui = getGUIGraph();
        end
        function [pixels, normalized] = get_figure_position()
            fig_h = getGUIFigureObj();
            set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
            pixels = getpixelposition(fig_h);
            normalized = get(fig_h, 'Position');
            set(fig_h, 'Units', 'characters'); % go back
        end
        function obj = getGUIFigureObj()
            obj = get_handle_objs('figure', 'AnalyzeGroup');
        end
        function objs = getGUIMeasures()
            [~, objs] = get_handle_objs('figure', [], 'Measure');
        end
        function obj = getGUIGraph()
            [~, figHandles] = get_handle_objs('figure', [], 'Graph');
            obj = figHandles{1};
        end

    % close function to pl.pp
    set(pl.pp, ...
        'DeleteFcn', {@close_f_settings})

        function close_f_settings(~,~)
            if ~isempty(measures_guis)
                for k = 1:length(measures_guis)
                    m_gui_h = measures_guis{k};
                    if isgraphics(m_gui_h)
                        close(m_gui_h)
                    end
                end
            end
            if ~isempty(graph_gui)
                if isgraphics(graph_gui)
                    close(graph_gui)
                end
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

    el = pl.get('EL');
    prop = pl.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pl.redraw@PlotProp('Height', 1.8, varargin{:})
    else
        value_cell = el.get(prop);

        if isempty(value_cell)
            pl.redraw@PlotProp('Height', 1.8, varargin{:})
        else
            pl.redraw@PlotProp('Height', 30, varargin{:})
        end

    end
end
function selected = getSelected(pl)
selected = pl.selected;
end