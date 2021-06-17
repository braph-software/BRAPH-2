%% ¡header!
PPMeasureEnsembleM < PlotProp (pl, plot property of measure ensemble) is a plot of measure ensemble.

%%% ¡description!
PPMeasureEnsembleM plots a Measure Ensemble measures table.

%%% ¡seealso!
GUI, PlotElement, PlotProp, MeasureEnsemble.

%% ¡properties!
pp
measure_tbl

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
function update(pl)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, redraw, refresh.

    update@PlotProp(pl)

    el = pl.get('EL');
    prop = pl.get('PROP');
    graph_dict = el.get('A').get('G_DICT');
    graph = graph_dict.getItem(1);
    value = el.getr(prop);
    node1_to_plot = 1;
    node2_to_plot = 1;
    node_labels = [];
    x_range = 1:10;
    m = el.get('MEASURE');
    
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        % do nothing
    elseif isa(graph, 'MultigraphBUD') || isa(graph, 'MultigraphBUT')
        node_labels_tmp = graph.get('NODELABELS');
        node_labels = split(node_labels_tmp, ',');
        if isa(graph, 'MultigraphBUD')
            x_range = graph.get('DENSITIES');
        else
            x_range = graph.get('THRESHOLDS');
        end
        if isempty(node_labels)
            node_labels = cell(1, size(value, 1));
            for k = 1:length(node_labels)
                node_labels{k} = ['node_' num2str(k)];
            end
        end
        value_cell = el.get(prop);
        if isempty(pl.measure_tbl)
            pl.measure_tbl = cell(size(value_cell));
        end
        for i = 1:1:size(pl.measure_tbl, 1)
            for j = 1:1:size(pl.measure_tbl, 2)
                if isempty(pl.measure_tbl{i, j}) || ~isgraphics(pl.measure_tbl{i, j}, 'uitable')
                    pl.measure_tbl{i, j} = uitable('Parent', pl.pp);
                end
                set(pl.measure_tbl{i, j}, ...
                    'Data', value_cell{i, j}, ...
                    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)] ...
                    )
            end
        end
        
        ui_node1_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu');
        ui_node2_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu');
        ui_measure_plot = uicontrol('Parent', pl.pp, 'Style', 'pushbutton');
        init_measure_plot_area()
        
    else
        % paint a normal cell tables
        value_cell = el.get(prop);
        if isempty(pl.measure_tbl)
            pl.measure_tbl = cell(size(value_cell));
        end
        for i = 1:1:size(pl.measure_tbl, 1)
            for j = 1:1:size(pl.measure_tbl, 2)
                if isempty(pl.measure_tbl{i, j}) || ~isgraphics(pl.measure_tbl{i, j}, 'uitable')
                    pl.measure_tbl{i, j} = uitable('Parent', pl.pp);
                end
                set(pl.measure_tbl{i, j}, ...
                    'Data', value_cell{i, j}, ...
                    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                    'CellEditCallback', {@cb_matrix_value, i, j} ...
                    )
            end
        end
    end
    
    function init_measure_plot_area()
        set(ui_node1_popmenu, ...            
            'Units', 'normalized', ...
            'Tooltip', 'Select the Node to be Plotted.', ...
            'String', node_labels, ...
            'Position', [.01 .02 .3 .08], ...
            'Callback', {@cb_node_1} ...
            );
        set(ui_node2_popmenu, ...            
            'Units', 'normalized', ...
            'Tooltip', 'Select the Node to be Plotted.', ...
            'String', node_labels, ...
            'Position', [.32 .02 .3 .08], ...
            'Callback', {@cb_node_2} ...
            );
        
        set(ui_measure_plot, ... 
            'String', 'Measure Plot', ...
            'Tooltip', 'Plot the Measure. Will plot depending on the node selection.', ...
            'Units', 'normalized', ...
            'Position', [.63 .02 .3 .08], ...
            'Callback', {@cb_plot_m} ...
            );
        
        rules_node_popmenu_deactivation()
    end
    function rules_node_popmenu_deactivation()
        if Measure.is_global(m)
            set(ui_node1_popmenu, ...
                'Visible', 'off', ...
                'Enable', 'off' ...
                )
            set(ui_node2_popmenu, ...
                'Visible', 'off', ...
                'Enable', 'off' ...
                )
        elseif Measure.is_nodal(m)
            set(ui_node1_popmenu, ...
                'Visible', 'on', ...
                'Enable', 'on' ...
                )
            set(ui_node2_popmenu, ...
                'Visible', 'off', ...
                'Enable', 'off' ...
                )
        else
            set(ui_node1_popmenu, ...
                'Visible', 'on', ...
                'Enable', 'on' ...
                )
            set(ui_node2_popmenu, ...
                'Visible', 'on', ...
                'Enable', 'on' ...
                )
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
        
        if Measure.is_global(m) % global
            is_inf_vector = cellfun(@(x) isinf(x), plot_value);
            if any(is_inf_vector)
                return;
            end
            y_ = [plot_value{:}];
        elseif Measure.is_nodal(m) % nodal
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
        
        plot_figure = figure( ...
            'Visible', 'on', ...
            'NumberTitle', 'off', ...
            'Name', ['Plot of Measure Ensemble - ' BRAPH2.STR], ...
            'Units', 'normalized', ...
            'Position', [x2 y2 w2 h2], ...
            'MenuBar', 'none', ...
            'Toolbar', 'figure', ...
            'Color', 'w' ...
            );
        h_axes = axes(plot_figure);
        set_icon(plot_figure);
        ui_toolbar = findall(plot_figure, 'Tag', 'FigureToolBar');
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
    end
    function [pixels, normalized] = get_figure_position()
        fig_h = getGUIFigureObj();
        set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
        pixels = getpixelposition(fig_h);
        normalized = get(fig_h, 'Position');
        set(fig_h, 'Units', 'characters'); % go back
    end
    function obj = getGUIFigureObj()
        obj = get_handle_objs('figure', 'AnalyzeEnsemble');
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
        
        for i = 1:1:size(value_cell, 1)
            for j = 1:1:size(value_cell, 2)
                set(pl.measure_tbl{i, j}, ...
                    'Units', 'character', ...
                    'Position', ...
                    [ ...
                    (0.01 + (i - 1) * 0.98 / size(pl.measure_tbl, 1)) * Plot.w(pl.pp) ...
                    (0.2 + (j - 1) * 0.8 / size(pl.measure_tbl, 2)) * (Plot.h(pl.pp) - 1.8) ...
                    0.98 / size(pl.measure_tbl, 1) * Plot.w(pl.pp) ...
                    0.8 / size(pl.measure_tbl, 2) * (Plot.h(pl.pp) - 1.8) ...
                    ] ...
                    )
            end
        end
    end
end