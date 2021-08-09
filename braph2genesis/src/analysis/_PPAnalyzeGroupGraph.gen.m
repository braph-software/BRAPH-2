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
mlist
graph
button_cb 
button_calc
button_del 
already_calculated

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
        pl.measure_tbl = uitable('Parent', pl.pp, ...
            'CellEditCallback', {@cb_measure_selection});
        pl.text = uicontrol( ...
            'Parent', pl.pp, ...
            'Style', 'Text', ...
            'String', '' ...
            );
    end

    graph_gui = [];
    h_measures = [];
    pl.already_calculated = [];

    ui_button_table_calculate = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_delete = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_see_graph = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_selectall = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_clearselection = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_see_measures = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    init_buttons()
    get_super_buttons()

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
        function get_super_buttons()
            [pl.button_cb, pl.button_calc, pl.button_del] = pl.get_buttons();
        end
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
            pl.update(pl.selected, pl.already_calculated)
        end
        function cb_table_selectall(~, ~)  % (src, event)
            pl.mlist = Graph.getCompatibleMeasureList(pl.graph);
            pl.selected = (1:1:length(pl.mlist))';
            pl.update(pl.selected, pl.already_calculated)
        end
        function cb_table_clearselection(~, ~)  % (src, event)
            pl.selected = [];
            pl.update(pl.selected, pl.already_calculated)
        end
        function cb_table_calculate(~, ~)
            pl.mlist = Graph.getCompatibleMeasureList(pl.graph);
            g = el.memorize('G');

            % calculate
            f = waitbar(0, ['Calculating ' num2str(length(pl.selected))  ' measures ...'], 'Name', BRAPH2.NAME);
            set_icon(f)
            for i = 1:length(pl.mlist)
                if ~ismember(pl.mlist(i), pl.selected)
                    continue;
                end
                progress = (i / length(pl.selected)) * .8;
                extra = (i / length(pl.selected)) * 1.05 * .8;
                measure = pl.mlist{i};
                waitbar(progress, f, ['Calculating measure: ' measure ' ...']);
                result_measure{i} = g.getMeasure(measure).memorize('M'); %#ok<AGROW>
                waitbar(extra, f, ['Measure: ' measure ' Calculated! ...']);
                pl.already_calculated(i) = 'C';
            end

            % close progress bar
            if exist('f', 'var')
                waitbar(1, f, 'Finishing')
                pause(.5)
                close(f)
            end
            pl.update(pl.selected,  pl.already_calculated);
        end
        function cb_table_delete(~, ~)
            pl.mlist = Graph.getCompatibleMeasureList(pl.graph);
            delete_measure_list = pl.mlist(pl.selected);
            g_dict = el.get(prop).get('M_DICT');
            for i = 1:length(delete_measure_list)
                m_delete = delete_measure_list{i};
                if g_dict.contains(m_delete)
                    index = g_dict.getIndex(m_delete);
                    g_dict.remove(index);
                end
            end
            pl.update(pl.selected,  pl.already_calculated)
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
            graph_gui = GUI(graph, 'CloseRequest', false, 'Position', [x2 y2 w2 h2]);
        end
        function cb_table_see_measures(~, ~)
            pl.mlist = Graph.getCompatibleMeasureList(pl.graph);
            plot_measure_list = pl.mlist(pl.selected);
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
                        g = el.memorize('G');
                        tmp_measure = g.getMeasure(measure);
                        h_measures{i} = GUI(tmp_measure, 'CloseRequest', false, 'Position', [x2+offset y2-offset w2 h2]); %#ok<AGROW>
                        k = k + 1;
                    end
                end
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
            obj = ancestor(pl.pp, 'Figure');
        end

    % close function to pl.pp
    set(pl.pp, ...
        'DeleteFcn', {@close_f_settings})

    function close_f_settings(~,~)
        if ~isempty(h_measures)
            for k = 1:length(h_measures)
                pe = h_measures{k};
                m_gui_h = pe.return_outer_panel();
                if isgraphics(ancestor(m_gui_h, 'Figure'))
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

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl, selected, calculated)
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
        pl.already_calculated = calculated;
    end

    pl.mlist = [];

    if el.getPropCategory(prop) == Category.RESULT && isequal(pl.button_calc.Enable, 'on')
        set(pl.measure_tbl, 'Visible', 'off')
        set(pl.text, 'Visible', 'off')
        button_management('off')
    else
        pl.graph = el.get(prop);
        if isa(pl.graph, 'NoValue')
            pl.graph = el.getPropDefault(prop);
        end

        set(pl.text, ...
            'Units', 'normalized', ...
            'Position', [.3 .9 .3 .06], ...
            'Visible', 'on', ...
            'BackgroundColor', [.62 .545 .439], ...
            'String', pl.graph.getClass());

        set(pl.measure_tbl, ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .9 .7], ...
            'Visible', 'on', ...
            'ColumnName', {'SEL', 'Measure', 'CAL' 'Shape', 'Scope', 'Notes'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', [true false false false false false] ...
            )

        % get compatible measures for specific graph
        pl.mlist = Graph.getCompatibleMeasureList(pl.graph);
        if isempty(pl.already_calculated)
            pl.already_calculated =  repmat('N', [length(pl.mlist), 1]);
        end
        if isa(pl.graph, 'Graph')
            [parent_position_pixels, ~] = get_figure_position();
            data = cell(length(pl.mlist), 6);
            for mi = 1:1:length(pl.mlist)
                if any(pl.selected == mi)
                    data{mi, 1} = true;
                else
                    data{mi, 1} = false;
                end
                data{mi, 2} = pl.mlist{mi};
                data{mi, 3} = pl.already_calculated(mi);
                if Measure.is_nodal(pl.mlist{mi})
                    data{mi, 4} = 'NODAL';
                elseif Measure.is_global(pl.mlist{mi})
                    data{mi, 4} = 'GLOBAL';
                else
                    data{mi, 4} = 'BINODAL';
                end

                if Measure.is_superglobal(pl.mlist{mi})
                    data{mi, 5} = 'SUPERGLOBAL';
                elseif Measure.is_unilayer(pl.mlist{mi})
                    data{mi, 5} = 'UNILAYER';
                else
                    data{mi, 5} = 'BILAYER';
                end

                data{mi, 6} = eval([pl.mlist{mi} '.getDescription()']);
            end
            set(pl.measure_tbl, 'Data', data)
            set(pl.measure_tbl, 'ColumnWidth', {parent_position_pixels(3)*.06, 'auto', parent_position_pixels(3)*.06, 'auto', 'auto', parent_position_pixels(3)})
        end

        button_management('on')
    end
        function [pixels, normalized] = get_figure_position()
            fig_h = getGUIFigureObj();
            set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
            pixels = getpixelposition(fig_h);
            normalized = get(fig_h, 'Position');
            set(fig_h, 'Units', 'characters'); % go back
        end
        function obj = getGUIFigureObj()
            obj = ancestor(pl.pp, 'Figure');
        end
        function button_management(value)
            % delete brainview buttons
            childs = get(pl.pp, 'Child');
            for n = 1:length(childs)
                child = childs(n);
                if ~isgraphics(child, 'uitable') && ...
                        isequal(child.Style, 'pushbutton') && ...
                        ~(isequal(child.String, 'C') ||  isequal(child.String, 'D') || isequal(child.String, 'G'))
                    set(child, 'Visible', value)
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
