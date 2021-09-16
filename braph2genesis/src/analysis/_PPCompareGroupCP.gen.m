%% ¡header!
PPCompareGroupCP < PlotProp (pl, plot property of comparison group cp dict) is a plot of comparison group cp dict.

%%% ¡description!
PPCompareGroupCP plots a Compairson Group cp dictionary.

%%% ¡seealso!
GUI, PlotElement, PlotProp, ComparisonGroup.

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

    pl.pp = draw@PlotProp(pl, varargin{:});
    
    if isempty(pl.comparison_tbl) || ~isgraphics(pl.comparison_tbl, 'uitable')        
        pl.comparison_tbl = uitable();
        set( pl.comparison_tbl, ...
            'Parent', pl.pp)
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

    if el.getPropCategory(prop) == Category.RESULT && ~isCalculated()
        % do nothing
        set(pl.comparison_tbl, 'Visible', 'off')
        
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
        a1 = el.get('A1');
        graph = a1.get('G'); % get first analysis graph class
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
        
        set(pl.comparison_tbl, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .9 .7], ...
            'Visible', 'on', ...
            'ColumnName', {'SEL', 'Measure', 'CAL', 'Shape', 'Scope', 'Notes'}, ...
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
            set(pl.comparison_tbl, 'Data', data)
            set(pl.comparison_tbl, 'ColumnWidth', {parent_position_pixels(3)*.06, 'auto', parent_position_pixels(3)*.06, 'auto', 'auto', parent_position_pixels(3)})
        end

        ui_button_table_calculate = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_table_selectall = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_table_clearselection = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_delete = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        ui_button_see_comparisons = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
        
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
                'Visible', 'on', ...
                'Position', [.01 .01 .22 .07], ...
                'String', 'Clear', ...
                'TooltipString', 'Clear selection', ...
                'Callback', {@cb_table_clearselection})
            
            set(ui_button_table_calculate, ...
                'Position', [.26 .11 .22 .07], ...
                'Visible', 'on', ...
                'String', 'Calculate Comparisons', ...
                'TooltipString', 'Calculate Comparison of Selected Comparisons', ...
                'Callback', {@cb_table_calculate})
            
            set(ui_button_delete, ...
                'Position', [.26 .01 .22 .07], ...
                'Visible', 'on', ...
                'String', 'Delete Measures', ...
                'TooltipString', 'Delete Selected Measures', ...
                'Callback', {@cb_table_delete})
            
            set(ui_button_see_comparisons, ...
                'Position', [.51 .11 .22 .07], ...
                'Visible', 'on', ...
                'String', 'See Comparisons', ...
                'TooltipString', 'See the GUI of the Selected Comparisons', ...
                'Callback', {@cb_see_comparisons} ...
                )
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

            % calculate
            f = waitbar(0, ['Calculating ' num2str(length(calculate_measure_list))  ' comparisons ...'], 'Name', BRAPH2.NAME);
            set_icon(f)
            for i = 1:length(calculate_measure_list)
                progress = (i / length(calculate_measure_list)) * .8;
                extra = (i / length(calculate_measure_list)) * 1.05 * .8;
                measure = calculate_measure_list{i};
                waitbar(progress, f, ['Calculating comparison: ' measure ' ...']);              
                tmp_comp = el.getComparison(measure)                

                tmp_comp.memorize('DIFF');
                tmp_comp.memorize('P1')
                tmp_comp.memorize('P2');
                tmp_comp.memorize('CIL');
                tmp_comp.memorize('CIU');

                result_comparison{i, 1} = tmp_comp; %#ok<*AGROW>

                waitbar(extra, f, ['Measure: ' measure ' Calculated! ...']);
            end
            
            % close progress bar
            if exist('f', 'var')
                waitbar(1, f, 'Finishing')
                pause(.5)
                close(f)
            end
            pl.update(pl.selected)
        end
        function cb_table_delete(~, ~)
            mlist = Graph.getCompatibleMeasureList(graph);
            delete_measure_list = mlist(pl.selected);
            c_dict = el.get(prop).get('CP_DICT');
            for i = 1:c_dict.length()
                c_c = c_dict.getItem(i);
                m_c = c_c.get('Measure');               
                if contains(m_c, delete_measure_list)                   
                    c_dict.remove(i);
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
            obj = get_handle_objs('figure', 'Compare');
        end
        function objs = getGUIComparisons()
            objs = get_handle_objs('figure', [], 'ComparisonGroup');
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
        function cb_see_comparisons(~, ~)
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
                        tmp_comparison = el.getComparison(measure);
                        GUI(tmp_comparison, 'CLOSEREQUEST', false, 'POSITION',  [x2+offset y2-offset w2 h2]);
                        k = k + 1;
                    end
                end
            end

            comparison_guis = getGUIComparisons();
            pl.update(pl.selected)
        end
        function is_calculated = isAlreadyCalculated(m)
            is_calculated = 'N';
            c_dict = el.get('CP_DICT');
            comparisons = c_dict.getItems();
            for i = 1:length(comparisons)
                c = comparisons{i};
                if isequal(c.get('measure'), m) && ~isa(c.getr('DIFF'), 'NoValue')
                    is_calculated = 'C';
                end
            end
        end

    set(pl.pp, 'DeleteFcn', {@close_f_settings})

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