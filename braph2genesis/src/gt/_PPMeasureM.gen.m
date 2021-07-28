%% ¡header!
PPMeasureM < PlotProp (pl, plot property of measure M) is a plot of measure M.

%%% ¡description!
PPMeasureM plots a Measure result table and plot.

%%% ¡seealso!
GUI, PlotElement, PlotProp, MultigraphBUD, MultigraphBUT.

%% ¡properties!
pp
table_value_cell

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

    if isempty(pl.table_value_cell)
        pl.table_value_cell = uitable('Parent', pl.pp);
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
    value = el.getr(prop);
    node1_to_plot = 1;
    node2_to_plot = 1;
    graph = el.get('G');
    node_labels = [];
    x_range = 1:10;
    y_label = el.getClass();
    node_labels_tmp = graph.get('BRAINATLAS').get('BR_DICT');
    node_labels = cellfun(@(x) x.get('ID') , node_labels_tmp.getItems(), 'UniformOutput', false);
    
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        % remove previous tables/textbox
        if ~isempty(pl.table_value_cell)
            delete(pl.table_value_cell)
        end
        % delete brainview buttons
        childs = get(pl.pp, 'Child');
        for n = 1:length(childs)
            child = childs(n);
            if isequal(child.String, 'Brain View')
                delete(child)
            end
        end

    elseif isa(graph, 'MultigraphBUD') || isa(graph, 'MultigraphBUT')
        if isa(graph, 'MultigraphBUD')
            x_range = graph.get('DENSITIES');
            x_label = 'Densities';
        else
            x_range = graph.get('THRESHOLDS');
            x_label = 'Thresholds';
        end

        plot_title = [y_label ' vs ' x_label];
        value_cell = el.get(prop);

        if Measure.is_global(el) % global
            node_labels = 'Global';
            for k = 1:size(value_cell, 1)
                row_names{k} = ['Layer ' num2str(k)]; %#ok<AGROW>
            end
        elseif Measure.is_nodal(el) % nodal

            for k = 1:size(value_cell, 1)
                row_names{k} = ['Layer ' num2str(k)]; %#ok<AGROW>
            end

        else  % binodal
            % do nothing
        end

        if Measure.is_binodal(el)
            delete(pl.table_value_cell)
            pl.table_value_cell = cell(size(value_cell));
            for i = 1:1:size(pl.table_value_cell, 1)
                for j = 1:1:size(pl.table_value_cell, 2)
                    if isempty(pl.table_value_cell{i, j}) || ~isgraphics(pl.table_value_cell{i, j}, 'uitable')
                        pl.table_value_cell{i, j} = uitable('Parent', pl.pp);
                    end
                    set(pl.table_value_cell{i, j}, ...
                        'Data', value_cell{i, j}, ...
                        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                        'CellEditCallback', {@cb_matrix_value, i, j} ...
                        )
                end
            end
        else
            if isempty(pl.table_value_cell) || ~isvalid(pl.table_value_cell)
                pl.table_value_cell = uitable('Parent', pl.pp);
            end
            value_double =  cell2mat(cellfun(@(x) x', value_cell, 'UniformOutput', false));
            set(pl.table_value_cell, ...
                'Data', value_double, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'Units', 'normalized', ...
                'Position', [.01 .15 .98 .8], ...
                'ColumnName', node_labels, ...
                'RowName', row_names, ...
                'CellEditCallback', {@cb_matrix_value} ...
                )
        end

        ui_node1_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu');
        ui_node2_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu');
        ui_measure_plot = uicontrol('Parent', pl.pp, 'Style', 'pushbutton');
        ui_brain_view = uicontrol('Parent', pl.pp, 'Style', 'pushbutton');
        init_measure_plot_area()
        init_brain_view_btn()

    else % weighted
        % paint a normal cell tables
        value_cell = el.get(prop);

        if Measure.is_binodal(el) % binodal
            delete(pl.table_value_cell)
            pl.table_value_cell = cell(size(value_cell));
            for i = 1:1:size(pl.table_value_cell, 1)
                for j = 1:1:size(pl.table_value_cell, 2)
                    if isempty(pl.table_value_cell{i, j}) || ~isgraphics(pl.table_value_cell{i, j}, 'uitable')
                        pl.table_value_cell{i, j} = uitable('Parent', pl.pp);
                    end
                    set(pl.table_value_cell{i, j}, ...
                        'Data', value_cell{i, j}, ...
                        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                        'CellEditCallback', {@cb_matrix_value, i, j} ...
                        )
                end
            end
        elseif Measure.is_global(el)
            node_labels = 'Global';
            value_double = cell2mat(cellfun(@(x) x', value_cell, 'UniformOutput', false));
            delete(pl.table_value_cell)
            pl.table_value_cell = uicontrol( ...
                'Parent', pl.pp, ...
                'Style', 'text', ...
                'Units', 'normalized', ...
                'Position', [.01 .3 .5 .2], ...
                'BackgroundColor', [1 1 1], ...
                'String', num2str(value_double) ...
                );
        else % nodal
            if isempty(pl.table_value_cell) || ~isvalid(pl.table_value_cell)
                pl.table_value_cell = uitable('Parent', pl.pp);
            end
            value_double = cell2mat(cellfun(@(x) x', value_cell, 'UniformOutput', false));
            set(pl.table_value_cell, ...
                'Data', value_double, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'Units', 'normalized', ...
                'Position', [.01 .25 .98 .55], ...
                'ColumnName', node_labels, ...
                'CellEditCallback', {@cb_matrix_value} ...
                )
        end

        ui_brain_view = uicontrol('Parent', pl.pp, 'Style', 'pushbutton');
        init_brain_view_btn()
        rules_brain_view()
        x_label = 'Weighted';
    end

    % functions
        function init_measure_plot_area()
            set(ui_node1_popmenu, ...
                'Units', 'normalized', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Position', [.01 .01 .2 .08], ...
                'Callback', {@cb_node_1} ...
                );
            set(ui_node2_popmenu, ...
                'Units', 'normalized', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Position', [.21 .01 .2 .08], ...
                'Callback', {@cb_node_2} ...
                );

            set(ui_measure_plot, ...
                'String', 'Measure Plot', ...
                'Tooltip', 'Plot the Measure. Will plot depending on the node selection.', ...
                'Units', 'normalized', ...
                'Position', [.74 .01 .25 .08], ...
                'Callback', {@cb_plot_m} ...
                );

            rules_node_popmenu_deactivation()
        end
        function init_brain_view_btn()
            set(ui_brain_view, ...
                'String', 'Brain View', ...
                'Tooltip', 'Plot the Measure Brain View. Will plot depending on the node selection.', ...
                'Units', 'normalized', ...
                'Position', [.49 .01 .25 .2], ...
                'Callback', {@cb_brain_view} ...
                );
        end
        function rules_node_popmenu_deactivation()
            if Measure.is_global(el)
                set(ui_node1_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )
                set(ui_node2_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )

                set(ui_brain_view, ...
                    'Visible', 'off', ...
                    'Enable', 'off');

            elseif Measure.is_nodal(el)
                set(ui_node1_popmenu, ...
                    'Visible', 'on', ...
                    'Enable', 'on' ...
                    )
                set(ui_node2_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )

                set(ui_brain_view, ...
                    'Visible', 'on', ...
                    'Enable', 'on');
            else
                set(ui_node1_popmenu, ...
                    'Visible', 'on', ...
                    'Enable', 'on' ...
                    )
                set(ui_node2_popmenu, ...
                    'Visible', 'on', ...
                    'Enable', 'on' ...
                    )

                set(ui_brain_view, ...
                    'Visible', 'off', ...
                    'Enable', 'off');
            end
        end
        function rules_brain_view()
            if Measure.is_global(el)
                set(ui_brain_view, ...
                    'Visible', 'off', ...
                    'Enable', 'off');

            elseif Measure.is_nodal(el)
                set(ui_brain_view, ...
                    'Visible', 'on', ...
                    'Enable', 'on');
            else
                set(ui_brain_view, ...
                    'Visible', 'off', ...
                    'Enable', 'off');
            end
        end
        function cb_node_1(source, ~)
            node1_to_plot = double(source.Value);
        end
        function cb_node_2(source, ~)
            node2_to_plot = double(source.Value);
        end
        function cb_plot_m(~, ~)
            plot_value = value;

            if Measure.is_global(el) % global
                is_inf_vector = cellfun(@(x) isinf(x), plot_value);
                if any(is_inf_vector)
                    return;
                end
                y_ = [plot_value{:}];
            elseif Measure.is_nodal(el) % nodal
                for l = 1:length(plot_value)
                    tmp = plot_value{l};
                    tmp_y = tmp(node1_to_plot);
                    if isinf(tmp_y)
                        return;
                    end
                    y_(l) = tmp_y; %#ok<AGROW>
                end
            else  % binodal
                for l = 1:length(plot_value)
                    tmp = plot_value{l};
                    tmp_y = tmp(node1_to_plot, node2_to_plot);
                    if isinf(tmp_y)
                        return;
                    end
                    y_(l) = tmp_y; %#ok<AGROW>
                end
            end

            x_ = x_range;

            [~, normalized] = get_figure_position();
            x2 = normalized(1) + normalized(3);
            h2 = normalized(4);
            y2 = normalized(2);
            w2 = normalized(3) * 1.61;

            f = figure( ...
                'Visible', 'off', ...
                'NumberTitle', 'off', ...
                'Name', ['PlotGraph - ' BRAPH2.STR], ...
                'Units', 'normalized', ...
                'Position', [x2 y2 w2 h2], ...
                'Units', 'character', ...
                'MenuBar', 'none', ...
                'DockControls', 'off', ...
                'Color', [.94 .94 .94] ...
                );

            set_icon(f);

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

            pg = PlotGraph( ...
                'bkgcolor', [1 1 1], ...
                'setname', ['Plot of Measure - ' BRAPH2.STR]);
            [h_figure, h_axes] = pg.draw('Parent', f);

            set(f, 'Visible', 'on')

            handle_plot = plot( ...
                h_axes, ...
                x_, ...
                y_, ...
                'Marker', 'o', ...
                'MarkerSize', 10, ...
                'MarkerEdgeColor', [0 0 1], ...
                'MarkerFaceColor', [.9 .4 .1], ...
                'LineStyle', '-', ...
                'LineWidth', 1, ...
                'Color', [0 0 1] ...
                );
            title(plot_title)
            xlabel(x_label)
            ylabel(y_label)
        end
        function [pixels, normalized] = get_figure_position()
            fig_h = getGUIFigureObj();
            set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
            pixels = getpixelposition(fig_h);
            normalized = get(fig_h, 'Position');
            set(fig_h, 'Units', 'characters'); % go back
        end
        function obj = getGUIFigureObj()
            figHandles = findobj('Type', 'figure');
            for i = 1:1:length(figHandles)
                fig_h = figHandles(i);
                if contains(fig_h.Name, el.getClass())
                    obj = fig_h;
                end
            end
        end
        function cb_brain_view(~, ~)
            [~, normalized] = get_figure_position();
            x2 = normalized(1) + normalized(3);
            h2 = normalized(4) / 1.61;
            y2 = normalized(2) + normalized(4) - h2;
            w2 = normalized(3) * 1.61;

            f = figure( ...
                'Visible', 'off', ...
                'NumberTitle', 'off', ...
                'Name', ['PlotBrainView - ' BRAPH2.STR], ...
                'Units', 'normalized', ...
                'Position', [x2 y2 w2 h2], ...
                'Units', 'character', ...
                'MenuBar', 'none', ...
                'DockControls', 'off', ...
                'Color', [.94 .94 .94] ...
                );

            set_icon(f);

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

            pbv = PlotBrainView('SUBMENU', false, 'SETPOS', [.4 .50 .40 .30], ...
                'ME', el, 'Atlas', graph.get('BRAINATLAS'), 'Type', x_label);

            el_panel = uipanel( ...
                'Parent', f, ...
                'BorderType', 'none' ...
                );

            pbv.draw('Parent', el_panel);
            pbv.settings('SETPOS', [x2 normalized(2) w2 h2*1.61-h2-.065]);

            set(f, 'Visible', 'on')
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
        graph = el.get('G');

        if isempty(value_cell)
            pl.redraw@PlotProp('Height', 1.8, varargin{:})
        elseif isa(graph, 'MultigraphBUD') || isa(graph, 'MultigraphBUT')
            pl.redraw@PlotProp('Height', 30, varargin{:})
        elseif Measure.is_binodal(el)
            pl.redraw@PlotProp('Height', 30, varargin{:})
        elseif Measure.is_global(el)
            pl.redraw@PlotProp('Height', 5, varargin{:})
        else
            pl.redraw@PlotProp('Height', 10, varargin{:})
        end
    end

    if Measure.is_binodal(el) && exist('value_cell') %#ok<EXIST>
        for i = 1:1:size(value_cell, 1)
            for j = 1:1:size(value_cell, 2)
                set(pl.table_value_cell{i, j}, ...
                    'Units', 'character', ...
                    'Position', ...
                    [ ...
                    (0.01 + (i - 1) * 0.98 / size(pl.table_value_cell, 1)) * Plot.w(pl.pp) ...
                    (0.1 + (j - 1) * 0.98 / size(pl.table_value_cell, 2)) * (Plot.h(pl.pp) - 1.8) ...
                    0.98 / size(pl.table_value_cell, 1) * Plot.w(pl.pp) ...
                    0.98 / size(pl.table_value_cell, 2) * (Plot.h(pl.pp) - 3.5) ...
                    ] ...
                    )
            end
        end
    end
end