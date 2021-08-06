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
text

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

    if isempty(pl.measure_tbl) || ~isgraphics(pl.measure_tbl, 'uitable')

        pl.measure_tbl = uitable('Parent', pl.pp);
        pl.text = uicontrol( ...
            'Parent', pl.pp, ...
            'Style', 'Text', ...
            'String', '' ...
            );
    end

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl, selected)
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

    measures_guis = [];
    graph_gui = [];
    mlist = [];

    if el.getPropCategory(prop) == Category.RESULT && ~isCalculated()

        set(pl.measure_tbl, 'Visible', 'off')

        set(pl.text, 'Visible', 'off')

        % delete brainview buttons
        childs = get(pl.pp, 'Child');
        for n = 1:length(childs)
            child = childs(n);
            if ~isgraphics(child, 'uitable') && ...
                    isequal(child.Style, 'pushbutton') && ...
                    ~(isequal(child.String, 'C') ||  isequal(child.String, 'D') || isequal(child.String, 'G'))
                set(child, 'Visible', 'off')
            end
        end
    else
        graph = el.get(prop);
        if isa(graph, 'NoValue')
            graph = el.getPropDefault(prop);
        end

        set(pl.text, ...
            'Units', 'normalized', ...
            'Position', [.3 .9 .3 .06], ...
            'Visible', 'on', ...
            'BackgroundColor', [.62 .545 .439], ...
            'String', graph.getClass());

        set( pl.measure_tbl, ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .9 .7], ...
            'Visible', 'on', ...
            'ColumnName', {'SEL', 'Measure', 'CAL' 'Shape', 'Scope', 'Notes'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', [true false false false false false], ...
            'CellEditCallback', {@cb_measure_selection} ...
            )

        % get compatible measures for specific graph
        mlist = Graph.getCompatibleMeasureList(graph);
        if isa(graph, 'Graph')
            [parent_position_pixels, normalized] = get_figure_position();
            data = cell(length(mlist), 6);
            for mi = 1:1:length(mlist)
                if any(pl.selected == mi)
                    data{mi, 1} = true;
                else
                    data{mi, 1} = false;
                end                
                data{mi, 2} = mlist{mi};
                data{mi, 3} = isAlreadyCalculated(mlist{mi});
                if Measure.is_nodal(mlist{mi})
                    data{mi, 4} = 'NODAL';
                elseif Measure.is_global(mlist{mi})
                    data{mi, 4} = 'GLOBAL';
                else
                    data{mi, 4} = 'BINODAL';
                end

                if Measure.is_superglobal(mlist{mi})
                    data{mi, 5} = 'SUPERGLOBAL';
                elseif Measure.is_unilayer(mlist{mi})
                    data{mi, 5} = 'UNILAYER';
                else
                    data{mi, 5} = 'BILAYER';
                end

                data{mi, 6} = eval([mlist{mi} '.getDescription()']);
            end
            set(pl.measure_tbl, 'Data', data)
            set(pl.measure_tbl, 'ColumnWidth', {parent_position_pixels(3)*.06, 'auto', parent_position_pixels(3)*.06, 'auto', 'auto', parent_position_pixels(3)})
        end

        ui_button_table_calculate = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_delete = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_table_see_graph = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_table_selectall = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_table_clearselection = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_see_measures = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');

        init_buttons()
    end

        function init_buttons()
            set(ui_button_table_selectall, ...
                'Position', [.01 .11 .22 .07], ...
                'Visible', 'on', ...
                'String', 'Select All', ...
                'TooltipString', 'Select all measures', ...
                'Callback', {@cb_table_selectall})

            set(ui_button_table_clearselection, ...
                'Position', [.01 .01 .22 .07], ...
                'Visible', 'on', ...
                'String', 'Clear', ...
                'TooltipString', 'Clear selection', ...
                'Callback', {@cb_table_clearselection})
            
            set(ui_button_table_calculate, ...
                'Position', [.26 .11 .22 .07], ...
                'Visible', 'on', ...
                'String', 'Calculate Measures', ...
                'TooltipString', 'Calculate Selected Measures', ...
                'Callback', {@cb_table_calculate})

            set(ui_button_delete, ...
                'Position', [.26 .01 .22 .07], ...
                'Visible', 'on', ...
                'String', 'Delete Measures', ...
                'TooltipString', 'Delete Selected Measures', ...
                'Callback', {@cb_table_delete})
            
            set(ui_button_see_measures, ...
                'Position', [.51 .11 .22 .07], ...
                'Visible', 'on', ...
                'String', 'See Measures', ...
                'TooltipString', 'See the GUI of the Selected Measures', ...
                'Callback', {@cb_table_see_measures} ...
                )

            set(ui_button_table_see_graph, ...
                'Position', [.51 .01 .22 .07], ...
                'Visible', 'on', ...
                'String', 'See Graph', ...
                'TooltipString', 'Create a GUI Graph', ...
                'Callback', {@cb_table_graph})
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
                
                otherwise
            end
            pl.update(pl.selected)
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
            g = el.memorize('G');

            % calculate
            f = waitbar(0, ['Calculating ' num2str(length(calculate_measure_list))  ' measures ...'], 'Name', BRAPH2.NAME);
            set_icon(f)
            for i = 1:length(calculate_measure_list)
                progress = (i / length(calculate_measure_list)) * .8;
                extra = (i / length(calculate_measure_list)) * 1.05 * .8;
                measure = calculate_measure_list{i};
                waitbar(progress, f, ['Calculating measure: ' measure ' ...']);
                result_measure{i} = g.getMeasure(measure).memorize('M'); %#ok<AGROW>
                waitbar(extra, f, ['Measure: ' measure ' Calculated! ...']);
            end
            
            % close progress bar
            if exist('f', 'var')
                waitbar(1, f, 'Finishing')
                pause(.5)
                close(f)
            end
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
        function bool = isCalculated()
            childs = get(pl.pp, 'Child');
            bool = false;
            for n = 1:length(childs)
                child = childs(n);
                if ~isgraphics(child, 'uitable') && isequal(child.Style, 'pushbutton') && isequal(child.String, 'C')
                    if isequal('off', child.Enable)
                        bool = true;
                    end
                end
            end
        end
        function is_calculated = isAlreadyCalculated(m)
            is_calculated = 'N';
            m_dict = el.get('G').get('M_DICT');
            if m_dict.contains(m)
                m_obj = m_dict.get(m);
                if ~isa(m_obj.getr('M'), 'NoValue')
                    is_calculated = 'C';
                end
            end
        end
        function cb_table_see_measures(~, ~)
            mlist = Graph.getCompatibleMeasureList(graph);
            plot_measure_list = mlist(pl.selected);
            if ~isempty(plot_measure_list)
                [~, normalized] = get_figure_position();
                % create window for results
                % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
                x2 = normalized(1) + normalized(3);
                h2 = normalized(4);
                y2 = normalized(2);
                w2 = normalized(3);
                k = 1;
                for i = 1:length(plot_measure_list)
                    if plot_measure_list{i}
                        offset = 0.02 * k;
                        if offset > .45
                            offset = 0;
                        end
                        measure = plot_measure_list{i};
                        GUI(measure, 'CloseRequest', false, 'Position', [x2+offset y2-offset w2 h2])
                        k = k + 1;
                    end
                end
            end
            
            measures_guis = getGUIMeasures();
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
