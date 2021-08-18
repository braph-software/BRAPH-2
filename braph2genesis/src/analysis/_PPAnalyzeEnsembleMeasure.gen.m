%% ¡header!
PPAnalyzeEnsembleMeasure < PlotProp (pl, plot property of analyze ensemble measure) is a plot of analyze ensemble measure.

%%% ¡description!
PPAnalyzeEnsembleMeasure plots a Analyze Ensemble Measure table.

%%% ¡seealso!
GUI, PlotElement, PlotProp, AnalyzeEnsemble, PPAnalyzeEnsembleGraph.

%% ¡properties!
pp
measure_tbl
selected
mlist
button_cb 
button_calc
button_del
already_calculated
graph_dict

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
    end

    pl.mlist = [];
    measures_guis = [];

    ui_button_table_update = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_calculate = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_selectall = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_clearselection = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_delete = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_see_measures = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');

    init_buttons()
    get_super_buttons()
        function init_buttons()
            set(ui_button_table_update, ...
                'Position', [0 0 0 0], ...
                'Visible', 'off', ...
                'Callback', {@cb_measures_update})

            set(ui_button_table_selectall, ...
                'Position', [.01 .11 .22 .07], ...
                'String', 'Select All', ...
                'TooltipString', 'Select all measures', ...
                'Callback', {@cb_table_selectall})

            set(ui_button_table_clearselection, ...
                'Position', [.01 .01 .22 .07], ...
                'String', 'Clear All', ...
                'TooltipString', 'Clear selection', ...
                'Callback', {@cb_table_clearselection})

            set(ui_button_table_calculate, ...
                'Position', [.26 .11 .22 .07], ...
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
            pl.selected = (1:1:length(pl.mlist))';
            pl.update(pl.selected, pl.already_calculated)
        end
        function cb_table_clearselection(~, ~)  % (src, event)
            pl.selected = [];
            pl.update(pl.selected, pl.already_calculated)
        end
        function cb_table_calculate(~, ~)
            pl.mlist = Graph.getCompatibleMeasureList(get_selected_graph());
            calculate_measure_list = pl.mlist(pl.selected);
            el = pl.get('EL');
            g_dict = el.memorize('G_DICT');

            % calculate
            f = waitbar(0, ['Calculating ' num2str(length(calculate_measure_list))  ' measures ensemble ...'], 'Name', BRAPH2.NAME);
            set_icon(f)

            for i = 1:length(pl.mlist)
                if ~ismember(pl.mlist(i), calculate_measure_list)
                    continue;
                end
                progress = (i / length(pl.selected)) * .8;
                extra = (i / length(pl.selected)) * 1.05 * .8;
                measure = pl.mlist{i};
                waitbar(progress, f, ['Measure: ' measure '  ...']);
                el.getMeasureEnsemble(measure);
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
        function cb_table_see_measures(~, ~)
            pl.mlist = Graph.getCompatibleMeasureList(get_selected_graph());
            plot_measure_list = pl.mlist(pl.selected);
            el = pl.get('El');
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
                        tmp_measure = el.getMeasureEnsemble(measure);
                        measures_guis{i} = GUI(tmp_measure, 'CloseRequest', false, 'Position', [x2+offset y2-offset w2 h2]); %#ok<AGROW>
                        k = k + 1;
                    end
                end
            end
        end
        function cb_table_delete(~, ~)
            el = pl.get('EL');
            delete_measure_list = pl.mlist(pl.selected);
            me_dict = el.get('ME_DICT');
            for i = 1:length(pl.mlist)
                if ~ismember(pl.mlist(i), delete_measure_list)
                    continue;
                end
                m_delete = pl.mlist{i};
                if me_dict.contains(m_delete)
                    index = me_dict.getIndex(m_delete);
                    me_dict.remove(index);
                end
                pl.already_calculated(i) = 'N';
            end
            pl.update(pl.selected,  pl.already_calculated)
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
        function graph = get_selected_graph()
            if isa(pl.graph_dict, 'NoValue')
                pl.graph_dict = el.getPropDefault('G_DICT');
            end
            graph = pl.graph_dict.getItem(1);
        end
        function cb_measures_update(~, ~)
            pl.update(pl.selected, pl.already_calculated);
        end

    set(pl.pp, 'DeleteFcn', {@close_f_settings})
        function close_f_settings(~,~)
            if ~isempty(measures_guis)
                for k = 1:length(measures_guis)
                    pe = measures_guis{k}; % plot element
                    m_gui_h = pe.return_outer_panel();
                    if isgraphics(ancestor(m_gui_h, 'Figure'))
                        close(ancestor(m_gui_h, 'Figure'))
                    end
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

    if el.getPropCategory(prop) == Category.RESULT && ~el.isLocked('ID')
        % do nothing
        set(pl.measure_tbl, 'Visible', 'off')
        button_management('off')
    else
        pl.graph_dict = el.get('G_DICT');      
        graph = get_selected_graph();
        
        set(pl.measure_tbl, ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .97 .7], ...
            'ColumnName', {'SEL', 'Measure', 'CAL', 'Shape', 'Scope', 'Notes'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', [true false false false false false]);

        % get compatible measures for specific graph
        
        pl.mlist = Graph.getCompatibleMeasureList(graph);
        if isempty(pl.already_calculated)
            pl.already_calculated =  repmat('N', [length(pl.mlist), 1]);
        end
        if isa(graph, 'Graph')
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
    function graph = get_selected_graph()
        if isa(pl.graph_dict, 'NoValue')
            pl.graph_dict = el.getPropDefault('G_DICT');
        end
        graph = pl.graph_dict.getItem(1);
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
    if el.getPropCategory(prop) == Category.RESULT && ~el.isLocked('ID')
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