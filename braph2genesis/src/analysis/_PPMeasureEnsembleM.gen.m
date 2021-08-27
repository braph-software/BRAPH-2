%% ¡header!
PPMeasureEnsembleM < PlotProp (pl, plot property of measure ensemble) is a plot of measure ensemble.

%%% ¡description!
PPMeasureEnsembleM plots a Measure Ensemble measures table.

%%% ¡seealso!
GUI, PlotElement, PlotProp, MeasureEnsemble.

%% ¡properties!
pp
measure_tbl
ui_sliding_panel
ui_slider
table_tag
button_cb 
button_calc
button_del 

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

    get_super_buttons();

        function get_super_buttons()
            [pl.button_cb, pl.button_calc, pl.button_del] = pl.get_buttons();
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
    graph_dict = el.get('A').get('G_DICT');
    graph = graph_dict.getItem(1);
    value = el.getr(prop);
    node1_to_plot = 1;
    node2_to_plot = 1;
    node_labels = [];
    x_range = 1:10;
    m = el.get('MEASURE');

    if el.getPropCategory(prop) == Category.RESULT && isequal(pl.button_calc.Enable, 'on')
        % remove previous tables/textbox
        if ~isempty(pl.measure_tbl)
            if iscell(pl.measure_tbl)
                cellfun(@(x) set(x, 'Visible', 'off'), pl.measure_tbl, 'UniformOutput', false);
            else
                set(pl.measure_tbl, 'Visible', 'off')
            end
        end
        % delete brainview buttons
        childs = get(pl.pp, 'Child');
        for n = 1:length(childs)
            child = childs(n);
            if ~isgraphics(child, 'uitable') && isequal(child.String, 'Brain View')
                set(child, 'Visible', 'off')
            end
        end
    elseif isa(graph, 'MultiplexWU') || isa(graph, 'MultiplexWD') ...
            || isa(graph, 'MultiplexBU') || isa(graph, 'MultiplexBD')
        
        
        node_dict = graph.get('BRAINATLAS').get('BR_DICT');
        node_labels = cellfun(@(x) x.get('ID') , node_dict.getItems(), 'UniformOutput', false);
        value_cell = el.get(prop);
        x_label = 'Layer';
        
        % labels
        if Measure.is_global(m) % global
            node_labels = 'Global';
            for k = 1:size(value_cell, 1)
                row_names{k} = [x_label ': ' num2str(k)]; %#ok<AGROW>
            end
        elseif Measure.is_nodal(m) % nodal
            for k = 1:size(value_cell, 1)
                row_names{k} = [x_label ': ' num2str(k)]; %#ok<AGROW>
            end
        else  % binodal
            % do nothing
        end
        
        % plot rules edit/tables
        if Measure.is_binodal(m)
            % create new panel with slider
            pl.ui_sliding_panel = uipanel( ...
                'Parent', pl.pp, ...
                'Units', 'characters', ...
                'BackgroundColor', [.62 .545 .439]);
            pl.ui_slider = uicontrol( ...
                'Parent', pl.pp, ...
                'Style', 'slider', ...
                'Units', 'characters', ...
                'Value', 1, ...
                'Callback', {@cb_slide} ...
                );

            pl.table_tag = uicontrol('Parent', pl.pp, ...
                'Style', 'text', ...
                'Units', 'normalized', ...
                'Position', [.01 .09 .3 .05], ...
                'BackgroundColor', [.62 .545 .439], ...
                'HorizontalAlignment', 'left', ...
                'String', '');

            delete(pl.measure_tbl)
            pl.measure_tbl = cell(size(value_cell));
            for i = 1:1:size(pl.measure_tbl, 1)
                for j = 1:1:size(pl.measure_tbl, 2)
                    if isempty(pl.measure_tbl{i, j}) || ~isgraphics(pl.measure_tbl{i, j}, 'uitable')
                        pl.measure_tbl{i, j} = uitable('Parent', pl.ui_sliding_panel, 'Visible', 'on');
                    end
                    set(pl.measure_tbl{i, j}, ...
                        'Data', value_cell{i, j}, ...
                        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                        'CellEditCallback', {@cb_matrix_value, i, j} ...
                        )
                end
            end
        else
            if isempty(pl.measure_tbl) || ~isvalid(pl.measure_tbl)
                pl.measure_tbl = uitable('Parent', pl.pp);
            end
            value_double =  cell2mat(cellfun(@(x) x', value_cell, 'UniformOutput', false));
            set(pl.measure_tbl, ...
                'Data', value_double, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'Units', 'normalized', ...
                'Position', [.01 .1 .98 .8], ...
                'ColumnName', node_labels, ...
                'Visible', 'on', ...
                'RowName', row_names, ...
                'CellEditCallback', {@cb_matrix_value} ...
                )
        end
       
        ui_brain_view = uicontrol('Parent', pl.pp, ...
            'Style', 'pushbutton', ...
            'Units', 'normalized', ...
            'Position', [.74 .01 .25 .08]);        
        init_brain_view_btn()
        
    elseif isa(graph, 'MultigraphBUD') || isa(graph, 'MultigraphBUT')
        y_label = el.get('MEASURE');
        node_dict = graph.get('BRAINATLAS').get('BR_DICT');
        node_labels = cellfun(@(x) x.get('ID') , node_dict.getItems(), 'UniformOutput', false);
        if isa(graph, 'MultigraphBUD')
            x_range = graph.get('DENSITIES');
            x_label = 'Densities';
        else
            x_range = graph.get('THRESHOLDS');
            x_label = 'Thresholds';
        end
        
        plot_title = [y_label ' vs ' x_label];
        value_cell = el.get(prop);
        
        % labels
        if Measure.is_global(m) % global
            node_labels = 'Global';
            for k = 1:size(value_cell, 1)
                row_names{k} = [x_label ': ' num2str(k)]; %#ok<AGROW>
            end
        elseif Measure.is_nodal(m) % nodal
            for k = 1:size(value_cell, 1)
                row_names{k} = [x_label ':' num2str(k)]; %#ok<AGROW>
            end
        else  % binodal
            % do nothing
        end
        
        % plot rules edit/tables
        if Measure.is_binodal(m)
            % create new panel with slider
            pl.ui_sliding_panel = uipanel( ...
                'Parent', pl.pp, ...
                'Units', 'characters', ...
                'BackgroundColor', [.62 .545 .439]);
            pl.ui_slider = uicontrol( ...
                'Parent', pl.pp, ...
                'Style', 'slider', ...
                'Units', 'characters', ...
                'Value', 1, ...
                'Callback', {@cb_slide} ...
                );

            pl.table_tag = uicontrol('Parent', pl.pp, ...
                'Style', 'text', ...
                'Units', 'normalized', ...
                'Position', [.01 .09 .3 .05], ...
                'BackgroundColor', [.62 .545 .439], ...
                'HorizontalAlignment', 'left', ...
                'String', '');

            delete(pl.measure_tbl)
            pl.measure_tbl = cell(size(value_cell));
            for i = 1:1:size(pl.measure_tbl, 1)
                for j = 1:1:size(pl.measure_tbl, 2)
                    if isempty(pl.measure_tbl{i, j}) || ~isgraphics(pl.measure_tbl{i, j}, 'uitable')
                        pl.measure_tbl{i, j} = uitable('Parent', pl.ui_sliding_panel, 'Visible', 'on');
                    end
                    set(pl.measure_tbl{i, j}, ...
                        'Data', value_cell{i, j}, ...
                        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                        'CellEditCallback', {@cb_matrix_value, i, j} ...
                        )
                end
            end
        else
            if isempty(pl.measure_tbl) || ~isvalid(pl.measure_tbl)
                pl.measure_tbl = uitable('Parent', pl.pp);
            end
            value_double =  cell2mat(cellfun(@(x) x', value_cell, 'UniformOutput', false));
            set(pl.measure_tbl, ...
                'Data', value_double, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'Units', 'normalized', ...
                'Position', [.01 .1 .98 .8], ...
                'ColumnName', node_labels, ...
                'Visible', 'on', ...
                'RowName', row_names, ...
                'CellEditCallback', {@cb_matrix_value} ...
                )
        end

        ui_node1_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu');
        ui_node2_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu');
        ui_measure_plot = uicontrol('Parent', pl.pp, 'Style', 'pushbutton');
        ui_brain_view = uicontrol('Parent', pl.pp, ...
            'Style', 'pushbutton', ...
            'Units', 'normalized', ...
            'Position', [.74 .01 .25 .08]);

        init_measure_plot_area()
        init_brain_view_btn()
    else
        % paint a normal cell tables
        value_cell = el.get(prop);
        if Measure.is_binodal(m) % binodal
            pl.measure_tbl = cell(size(value_cell));
            for i = 1:1:size(pl.measure_tbl, 1)
                for j = 1:1:size(pl.measure_tbl, 2)
                    if isempty(pl.measure_tbl{i, j}) || ~isgraphics(pl.measure_tbl{i, j}, 'uitable')
                        pl.measure_tbl{i, j} = uitable('Parent', pl.pp, 'Visible', 'on');
                    end
                    set(pl.measure_tbl{i, j}, ...
                        'Data', value_cell{i, j}, ...
                        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                        'CellEditCallback', {@cb_matrix_value, i, j} ...
                        )
                end
            end
        elseif Measure.is_global(m)
            node_labels = 'Global';
            value_double = cell2mat(cellfun(@(x) x', value_cell, 'UniformOutput', false));
            delete(pl.measure_tbl)
            pl.measure_tbl = uicontrol( ...
                'Parent', pl.pp, ...
                'Style', 'text', ...
                'Units', 'normalized', ...
                'Visible', 'on', ...
                'Position', [.01 .3 .5 .2], ...
                'BackgroundColor', [1 1 1], ...
                'String', num2str(value_double) ...
                );
        else % nodal
            if isempty(pl.measure_tbl) || ~isvalid(pl.measure_tbl)
                pl.measure_tbl = uitable('Parent', pl.pp);
            end
            value_double = cell2mat(cellfun(@(x) x', value_cell, 'UniformOutput', false));
            set(pl.measure_tbl, ...
                'Data', value_double, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'Units', 'normalized', ...
                'Visible', 'on', ...
                'Position', [.01 .25 .98 .55], ...
                'ColumnName', node_labels, ...
                'CellEditCallback', {@cb_matrix_value} ...
                )
        end
        ui_brain_view = uicontrol('Parent', pl.pp, ...
            'Style', 'pushbutton', ...
            'Units', 'normalized', ...
            'Position', [.74 .01 .25 .2]);
        init_brain_view_btn()
        x_label = 'Weighted';
    end

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
                'Position', [.49 .01 .25 .08], ...
                'Callback', {@cb_plot_m} ...
                );

            rules_node_popmenu_deactivation()
        end
        function init_brain_view_btn()
            set(ui_brain_view, ...
                'String', 'Brain View', ...
                'Tooltip', 'Plot the Measure Brain View. Will plot depending on the node selection.', ...
                'Callback', {@cb_brain_view} ...
                );
            
            rules_brain_view()
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
        function rules_brain_view()
            if Measure.is_global(m)
                set(ui_brain_view, ...
                    'Visible', 'off', ...
                    'Enable', 'off');

            elseif Measure.is_nodal(m)
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
            obj = ancestor(pl.pp, 'Figure');
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
        function cb_slide(~, ~)
            pl.slide()
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
    if el.getPropCategory(prop) == Category.RESULT && isequal(pl.button_calc.Enable, 'on')
        pl.redraw@PlotProp('Height', 1.8, varargin{:})
    else
        value_cell = el.get(prop);

        if isempty(value_cell) % empty results
            pl.redraw@PlotProp('Height', 1.8, varargin{:})
        elseif ~isempty(pl.measure_tbl) % with values
            graph_dict = el.get('A').get('G_DICT');
            graph = graph_dict.getItem(1);
            base = 12;
            m = el.get('MEASURE');
            if isa(graph, 'GraphBU') || isa(graph, 'GraphBD') ...
                    || isa(graph, 'GraphWU') || isa(graph, 'GraphWD')
                
                if Measure.is_binodal(m) % binodal
                    pl.redraw@PlotProp('Height', 30, varargin{:})
                    for i = 1:1:size(value_cell, 1)
                        for j = 1:1:size(value_cell, 2)
                            set(pl.measure_tbl{i, j}, ...
                                'Units', 'character', ...
                                'Position', ...
                                [ ...
                                (0.01 + (i - 1) * 0.98 / size(pl.measure_tbl, 1)) * Plot.w(pl.pp) ...
                                (0.1 + (j - 1) * 0.98 / size(pl.measure_tbl, 2)) * (Plot.h(pl.pp) - 1.8) ...
                                0.98 / size(pl.measure_tbl, 1) * Plot.w(pl.pp) ...
                                0.98 / size(pl.measure_tbl, 2) * (Plot.h(pl.pp) - 3.5) ...
                                ] ...
                                )
                        end
                    end
                elseif Measure.is_global(m) % global
                    pl.redraw@PlotProp('Height', 5, varargin{:})
                else % nodal
                    pl.redraw@PlotProp('Height', 10, varargin{:})
                end
            else
                % density and threshold and multiplex weighted
                if Measure.is_binodal(m) % binodal
                    pl.redraw@PlotProp('Height', 30, varargin{:})
                    for i = 1:1:size(value_cell, 1)
                        for j = 1:1:size(value_cell, 2)
                            set(pl.measure_tbl{i, j}, ...
                                'Units', 'character', ...
                                'Position', ...
                                [ ...
                                (0 + (i - 1) * 0.99) * Plot.w(pl.pp) ...
                                (0 + (j - 1) * 0.99 / size(pl.measure_tbl, 2)) * (Plot.h(pl.pp) *.725) ...
                                0.98 * Plot.w(pl.pp) ...
                                1 / size(pl.measure_tbl, 2) * (Plot.h(pl.pp) * .75) ...
                                ] ...
                                )
                        end
                    end
                    pl.slide()
                elseif Measure.is_global(m) % global
                    tmp_data = get(pl.measure_tbl, 'Data');
                    tmp_h = size(tmp_data, 1); % 1.1 per row
                    f_h = (tmp_h * 1.1) + base;
                    if f_h < 15
                        pl.redraw@PlotProp('Height', f_h, varargin{:})
                        set(pl.measure_tbl, 'Position', [.01 .2 .98 .6])
                    else
                        pl.redraw@PlotProp('Height', 15, varargin{:})
                    end
                else % nodal
                    tmp_data = get(pl.measure_tbl, 'Data');
                    tmp_h = size(tmp_data, 1); % 1.1 per row
                    f_h = (tmp_h * 1.1) + base + 2;
                    if f_h < 20
                        pl.redraw@PlotProp('Height', f_h, varargin{:})
                        set(pl.measure_tbl, 'Position', [.01 .2 .98 .6])
                    else
                        pl.redraw@PlotProp('Height', 20, varargin{:})
                    end
                end
            end
        end
    end
end
function slide(pl)
    %SLIDE slides the panel horizontally.
    %
    % SLIDE(PL) slides the panel horizontally, without redrawing the prop panels.
    %
    % See also draw, update, redraw.

    f = pl.pp;
    p = pl.ui_sliding_panel;
    s = pl.ui_slider;

    units = get(f, 'Units');
    set(f, 'Units', 'character')

    y0_s = y0(f) + h(pl.pp)*.01+3.4;

    dw = 1;
    n = length(pl.measure_tbl);
    w_pp = cellfun(@(x) w(x), pl.measure_tbl);
    w_p = sum(w_pp + dw) + dw;
    single_w = w_p / n;

    if w_p > w(f)
        offset = get(s, 'Value');
        set(p, 'Position', [w(p)-w(f)-offset y0_s+1 w_p h(f)*.76])

        set(s, ...
            'Position', [0 y0_s w(f) 1], ...
            'Visible', 'on', ...
            'Min', w(p) - w(f), ...
            'Max', w_p, ...
            'Value', max(get(s, 'Value'), w(p) - w(f)) ...
            );
        current_table = abs((w(p)-w(f)-offset)) / single_w;
        set(pl.table_tag, 'String', ['Table : ' num2str(round(current_table) + 1)])
        
    else
        set(p, 'Position', [0.1 h(f)*.2 w(f)*.98 h(f)-h(f)*.15])

        set(s, 'Visible', 'off')
    end

    set(f, 'Units', units)

    % auxiliary functions
        function r = x0(h)
            r = get(h, 'Position');
            r = r(1);
        end
        function r = y0(h)
            r = get(h, 'Position');
            r = r(2);
        end
        function r = w(h)
            r = get(h, 'Position');
            r = r(3);
        end
        function r = h(h)
            r = get(h, 'Position');
            r = r(4);
        end
end