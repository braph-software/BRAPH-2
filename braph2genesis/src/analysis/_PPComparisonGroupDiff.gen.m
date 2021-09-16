%% ¡header!
PPComparisonGroupDiff < PlotProp (pl, plot property of comparison group difference) is a plot of comparison group difference.

%%% ¡description!
PPComparisonGroupDiff plots a Comparison Group Difference.

%%% ¡seealso!
GUI, PlotElement, PlotProp, ComparisonGroup.

%% ¡properties!
pp
comparison_tbl
ui_sliding_panel
ui_slider

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
    value = el.getr(prop);
    comparison = el.get('C');
    graph = comparison.get('A1').get('G');
    node1_to_plot = 1;
    node2_to_plot = 1;
    node_labels = [];
    x_range = 1:10;
    m = el.get('MEASURE');
    node_labels_tmp = graph.get('BRAINATLAS').get('BR_DICT');
    node_labels = cellfun(@(x) x.get('ID') , node_labels_tmp.getItems(), 'UniformOutput', false);
    fdr_style = [0 1 0];
    fdr_q_value = 0.05; % default, might make it so the user chooses it.

    if el.getPropCategory(prop) == Category.RESULT && ~isCalculated()
        % remove previous tables/textbox
        if ~isempty(pl.comparison_tbl)
            if iscell(pl.comparison_tbl)
                cellfun(@(x) set(x, 'Visible', 'off'), pl.comparison_tbl, 'UniformOutput', false);
            else
                set(pl.comparison_tbl, 'Visible', 'off')
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
    elseif (isa(graph, 'MultiplexWU') && (~isa(graph, 'MultiplexBUD') && ~isa(graph, 'MultiplexBUT'))) ...
            || isa(graph, 'MultiplexWD') ...
            || isa(graph, 'MultiplexBU') ...
            || isa(graph, 'MultiplexBD')

        if Measure.is_global(m) % global
            node_labels = 'Global';
            for k = 1:size(value, 1)
                row_names{k} = ['Layer ' num2str(k)]; %#ok<AGROW>
            end
        elseif Measure.is_nodal(m) % nodal
            for k = 1:size(value, 1)
                row_names{k} = ['Layer ' num2str(k)]; %#ok<AGROW>
            end

        else  % binodal
            % do nothing
        end

        if Measure.is_binodal(m) % binodal with sliding panel
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
            delete(pl.comparison_tbl)
            pl.comparison_tbl = cell(size(value));
            for i = 1:1:size(pl.comparison_tbl, 1)
                for j = 1:1:size(pl.comparison_tbl, 2)
                    if isempty(pl.comparison_tbl{i, j}) || ~isgraphics(pl.comparison_tbl{i, j}, 'uitable')
                        pl.comparison_tbl{i, j} = uitable('Parent', pl.ui_sliding_panel);
                    end

                    p1s = el.get('P1');
                    [~, mask] = fdr(p1s{1}, fdr_q_value);

                    tmp_data = value(i, j);
                    tmp_data = num2cell([tmp_data{:}]);

                    for ll = 1:size(tmp_data, 1)
                        for mm = 1:size(tmp_data, 2)
                            if mask(ll, mm)

                                clr = dec2hex(round(fdr_style * 255), 2)';
                                clr = ['#'; clr(:)]';

                                tmp_data(ll, mm) = {strcat(...
                                    ['<html><body bgcolor="' clr '" text="#000000" width="100px">'], ...
                                    num2str(tmp_data{ll, mm}))};

                            end
                        end
                    end
                    set(pl.comparison_tbl{i, j}, ...
                        'Data', tmp_data, ...
                        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                        'CellEditCallback', {@cb_matrix_value, i, j} ...
                        )
                end
            end
        else
            % global and nodal with no sliding panel
            if isempty(pl.comparison_tbl) || ~isvalid(pl.comparison_tbl)
                pl.comparison_tbl = uitable('Parent', pl.pp);
            end
            value_double =  cell2mat(cellfun(@(x) x', value, 'UniformOutput', false));
            p1s = cell2mat(cellfun(@(x) x', el.get('P1'), 'UniformOutput', false));
            if Measure.is_nodal(m)
                [~, mask] = fdr(p1s, fdr_q_value);
            else
                [~, mask] = fdr(p1s', fdr_q_value);
                mask = mask';
            end

            % replace values to individual cells for html info
            tmp_double = num2cell(value_double);
            for i = 1:size(value_double, 1)
                for j = 1:size(value_double, 2)
                    if mask(i, j)
                        clr = dec2hex(round(fdr_style * 255), 2)';
                        clr = ['#'; clr(:)]';
                        tmp_double(i, j) = {strcat(...
                            ['<html><body bgcolor="' clr '" text="#000000" width="100px">'], ...
                            num2str(value_double(i, j)))}; %#ok<AGROW>
                    end
                end
            end

            set(pl.comparison_tbl, ...
                'Data', tmp_double, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'Units', 'normalized', ...
                'Position', [.01 .15 .98 .75], ...
                'ColumnName', node_labels, ...
                'RowName', row_names, ...
                'CellEditCallback', {@cb_matrix_value} ...
                )
        end

        ui_brain_view = uicontrol('Parent', pl.pp, ...
            'Style', 'pushbutton', ...
            'Units', 'characters', ...
            'Position', [50 .02 15 2]);

        init_brain_view_btn()

    elseif isa(graph, 'MultigraphBUD') || isa(graph, 'MultigraphBUT') ...
            || isa(graph, 'MultiplexBUD') || isa(graph, 'MultiplexBUT')

        if isa(graph, 'MultigraphBUD') || isa(graph, 'MultiplexBUD')
            x_range = graph.get('DENSITIES');
            x_name = 'Densities';
        else
            x_range = graph.get('THRESHOLDS');
            x_name = 'Thresholds';
        end

        if Measure.is_global(m) % global
            node_labels = 'Global';
            for k = 1:size(value, 1)
                row_names{k} = ['Layer ' num2str(k)]; %#ok<AGROW>
            end
        elseif Measure.is_nodal(m) % nodal
            for k = 1:size(value, 1)
                row_names{k} = ['Layer ' num2str(k)]; %#ok<AGROW>
            end

        else  % binodal
            % do nothing
        end

        if Measure.is_binodal(m) % binodal with sliding panel
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
            delete(pl.comparison_tbl)
            pl.comparison_tbl = cell(size(value));
            for i = 1:1:size(pl.comparison_tbl, 1)
                for j = 1:1:size(pl.comparison_tbl, 2)
                    if isempty(pl.comparison_tbl{i, j}) || ~isgraphics(pl.comparison_tbl{i, j}, 'uitable')
                        pl.comparison_tbl{i, j} = uitable('Parent', pl.ui_sliding_panel);
                    end

                    p1s = el.get('P1');
                    [~, mask] = fdr(p1s{1}, fdr_q_value);

                    tmp_data = value(i, j);
                    tmp_data = num2cell([tmp_data{:}]);

                    for ll = 1:size(tmp_data, 1)
                        for mm = 1:size(tmp_data, 2)
                            if mask(ll, mm)

                                clr = dec2hex(round(fdr_style * 255), 2)';
                                clr = ['#'; clr(:)]';

                                tmp_data(ll, mm) = {strcat(...
                                    ['<html><body bgcolor="' clr '" text="#000000" width="100px">'], ...
                                    num2str(tmp_data{ll, mm}))};

                            end
                        end
                    end
                    set(pl.comparison_tbl{i, j}, ...
                        'Data', tmp_data, ...
                        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                        'CellEditCallback', {@cb_matrix_value, i, j} ...
                        )
                end
            end
        else
            % global and nodal with no sliding panel
            if isempty(pl.comparison_tbl) || ~isvalid(pl.comparison_tbl)
                pl.comparison_tbl = uitable('Parent', pl.pp);
            end
            value_double =  cell2mat(cellfun(@(x) x', value, 'UniformOutput', false));
            p1s = cell2mat(cellfun(@(x) x', el.get('P1'), 'UniformOutput', false));
            if Measure.is_nodal(m)
                [~, mask] = fdr(p1s, fdr_q_value);
            else
                [~, mask] = fdr(p1s', fdr_q_value);
                mask = mask';
            end

            % replace values to individual cells for html info
            tmp_double = num2cell(value_double);
            for i = 1:size(value_double, 1)
                for j = 1:size(value_double, 2)
                    if mask(i, j)
                        clr = dec2hex(round(fdr_style * 255), 2)';
                        clr = ['#'; clr(:)]';
                        tmp_double(i, j) = {strcat(...
                            ['<html><body bgcolor="' clr '" text="#000000" width="100px">'], ...
                            num2str(value_double(i, j)))}; %#ok<AGROW>
                    end
                end
            end

            set(pl.comparison_tbl, ...
                'Data', tmp_double, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'Units', 'normalized', ...
                'Position', [.01 .15 .98 .75], ...
                'ColumnName', node_labels, ...
                'RowName', row_names, ...
                'CellEditCallback', {@cb_matrix_value} ...
                )
        end

        ui_node1_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu');
        ui_node2_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu');
        ui_measure_plot = uicontrol('Parent', pl.pp, 'Style', 'pushbutton');
        ui_brain_view = uicontrol('Parent', pl.pp, ...
            'Style', 'pushbutton', ...
            'Units', 'characters', ...
            'Position', [50 .02 15 2]);

        init_measure_plot_area()
        init_brain_view_btn()
    else % weighted
        % paint a normal cell tables
        value_cell = el.get(prop);
        if Measure.is_binodal(m)
            pl.comparison_tbl = cell(size(value_cell));
            for i = 1:1:size(pl.comparison_tbl, 1)
                for j = 1:1:size(pl.comparison_tbl, 2)
                    if isempty(pl.comparison_tbl{i, j}) || ~isgraphics(pl.comparison_tbl{i, j}, 'uitable')
                        pl.comparison_tbl{i, j} = uitable('Parent', pl.pp);
                    end
                    p1s = el.get('P1');
                    [~, mask] = fdr(p1s{1}, fdr_q_value);

                    tmp_data = value_cell(i, j);
                    tmp_data = num2cell([tmp_data{:}]);

                    for ll = 1:size(tmp_data, 1)
                        for mm = 1:size(tmp_data, 2)
                            if mask(ll, mm)

                                clr = dec2hex(round(fdr_style * 255), 2)';
                                clr = ['#'; clr(:)]';

                                tmp_data(ll, mm) = {strcat(...
                                    ['<html><body bgcolor="' clr '" text="#000000" width="100px">'], ...
                                    num2str(tmp_data{ll, mm}))};

                            end
                        end
                    end

                    set(pl.comparison_tbl{i, j}, ...
                        'Data', tmp_data, ...
                        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                        'CellEditCallback', {@cb_matrix_value, i, j} ...
                        )
                end
            end
        elseif  Measure.is_global(m)
            value_double = cell2mat(cellfun(@(x) x', value_cell, 'UniformOutput', false));
            p1s = cell2mat(cellfun(@(x) x', el.get('P1'), 'UniformOutput', false));

            delete(pl.comparison_tbl)
            pl.comparison_tbl = uicontrol( ...
                'Parent', pl.pp, ...
                'Style', 'text', ...
                'Units', 'normalized', ...
                'Position', [.01 .3 .5 .2], ...
                'BackgroundColor', [1 1 1], ...
                'String', num2str(value_double));

            [~, mask] = fdr(p1s, fdr_q_value);

            if mask(1, 1)
                set(pl.comparison_tbl, 'BackgroundColor', fdr_style);
            end
        else
            value_double = cellfun(@(x) x', value_cell, 'UniformOutput', false);
            value_double = num2cell([value_double{:}]);
            p1s = cell2mat(cellfun(@(x) x', el.get('P1'), 'UniformOutput', false));
            if isempty(pl.comparison_tbl) || ~isvalid(pl.comparison_tbl)
                pl.comparison_tbl = uitable('Parent', pl.pp);
            end
            set(pl.comparison_tbl, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'Units', 'normalized', ...
                'Position', [.01 .23 .98 .55], ...
                'ColumnName', node_labels, ...
                'CellEditCallback', {@cb_matrix_value} ...
                )

            [~, mask] = fdr(p1s, fdr_q_value);

            for i = 1:size(value_double, 1)
                for j = 1:size(value_double, 2)
                    if mask(i, j)

                        clr = dec2hex(round(fdr_style * 255), 2)';
                        clr = ['#'; clr(:)]';

                        value_double(i, j) = {strcat(...
                            ['<html><body bgcolor="' clr '" text="#000000" width="100px">'], ...
                            num2str(value_double{i, j}))};

                    end
                end
            end

            set(pl.comparison_tbl, 'Data', value_double);

        end
        ui_brain_view = uicontrol('Parent', pl.pp, ...
            'Style', 'pushbutton', ...
            'Units', 'characters', ...
            'Position', [50 .02 15 2]);
        init_brain_view_btn()
        x_name = 'Weighted';
    end

    % functions
        function init_measure_plot_area()
            set(ui_node1_popmenu, ...
                'Units', 'characters', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Position', [1 .02 15 2], ...
                'Callback', {@cb_node_1} ...
                );
            set(ui_node2_popmenu, ...
                'Units', 'characters', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Position', [17 .02 15 2], ...
                'Callback', {@cb_node_2} ...
                );

            set(ui_measure_plot, ...
                'String', 'Measure Plot', ...
                'Tooltip', 'Plot the Measure. Will plot depending on the node selection.', ...
                'Units', 'characters', ...
                'Position', [33 .02 15 2], ...
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
            x_label = graph.get('NODELABELS');
            y_name = m;
            title_plot = [y_name ' vs ' x_name];
            cil = el.memorize('CIL');
            ciu = el.memorize('CIU');


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

            pg = PlotGraph( ...
                'bkgcolor', [1 1 1], ...
                'setpos', [x2 y2 w2 h2], ...
                'setname', ['Plot of Measure - ' BRAPH2.STR]);
            [h_figure, h_axes] = pg.draw();

            if ~isempty(x_) && ~isempty(y_)

                handle_plot = plot(h_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1]);
                title(title_plot)
                xlabel(x_name)
                ylabel(y_name)
            else
            end

            hold(h_axes, 'on')
            xlabel(h_axes, x_label)
            ylabel(h_axes, measure_class)

            ui_confidence_interval_min_checkbox = uicontrol(f, 'Style', 'checkbox', 'Units', 'normalized');
            ui_confidence_interval_max_checkbox = uicontrol(f, 'Style', 'checkbox', 'Units', 'normalized');
            init_plot_panel()
            function init_plot_panel()
                set(ui_confidence_interval_min_checkbox, 'Position', [.02 .06 .25 .05]);
                set(ui_confidence_interval_min_checkbox, 'String', 'Show Confidence Interval Min');
                set(ui_confidence_interval_min_checkbox, 'Value', false);
                set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})

                set(ui_confidence_interval_max_checkbox, 'Position', [.02 .01 .25 .05]);
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
                'Toolbar', 'figure', ...
                'DockControls', 'off', ...
                'Color', [.94 .94 .94] ...
                );

            set_icon(f);

            ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
            delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))

            prop_tag = el.getPropTag(prop);

            pbv = PlotBrainView('SUBMENU', false, 'SETPOS', [.4 .50 .40 .30], ...
                'COMP', el, 'PROPTAG', prop_tag, 'Atlas', graph.get('BRAINATLAS'), 'Type', x_name);

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
    comparison = el.get('C');
    graph = comparison.get('A1').get('G');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pl.redraw@PlotProp('Height', 1.8, varargin{:})
    else
        value_cell = el.get(prop);
        if isempty(value_cell)
            pl.redraw@PlotProp('Height', 1.8, varargin{:})
        elseif ~isempty(pl.comparison_tbl)
            base = 10;
            if (isa(graph, 'GraphBU') || isa(graph, 'GraphBD') ...
                    || isa(graph, 'GraphWU') || isa(graph, 'GraphWD')) ...
                    && ~isa(graph, 'MultigraphBUD') && ~isa(graph, 'MultigraphBUT')

                if  Measure.is_binodal(el.get('Measure')) % binodal
                    pl.redraw@PlotProp('Height', 30, varargin{:})
                    for i = 1:1:size(value_cell, 1)
                        for j = 1:1:size(value_cell, 2)
                            set(pl.comparison_tbl{i, j}, ...
                                'Units', 'character', ...
                                'Position', ...
                                [ ...
                                (0.01 + (i - 1) * 0.98 / size(pl.comparison_tbl, 1)) * Plot.w(pl.pp) ...
                                (0.1 + (j - 1) * 0.98 / size(pl.comparison_tbl, 2)) * (Plot.h(pl.pp) - 1.8) ...
                                0.98 / size(pl.comparison_tbl, 1) * Plot.w(pl.pp) ...
                                0.98 / size(pl.comparison_tbl, 2) * (Plot.h(pl.pp) - 3.8) ...
                                ] ...
                                )
                        end
                    end
                elseif Measure.is_nodal(el.get('Measure')) % nodal
                    pl.redraw@PlotProp('Height', 10, varargin{:})
                else % global
                    pl.redraw@PlotProp('Height', 5, varargin{:})
                end
            else
                % density, threshold and multiplex
                if  Measure.is_binodal(el.get('Measure')) % binodal
                    % density and threshold
                    pl.redraw@PlotProp('Height', 30, varargin{:})
                    for i = 1:1:size(value_cell, 1)
                        for j = 1:1:size(value_cell, 2)
                            set(pl.comparison_tbl{i, j}, ...
                                'Units', 'character', ...
                                'Position', ...
                                [ ...
                                (0 + (i - 1) * 0.99) * Plot.w(pl.pp) ...
                                (0 + (j - 1) * 0.99 / size(pl.comparison_tbl, 2)) * (Plot.h(pl.pp) *.725) ...
                                0.98 * Plot.w(pl.pp) ...
                                1 / size(pl.comparison_tbl, 2) * (Plot.h(pl.pp) * .75) ...
                                ] ...
                                )
                        end
                    end
                    pl.slide()
                else
                    tmp_data = get(pl.comparison_tbl, 'Data');
                    tmp_h = size(tmp_data, 1); % 1.1 per row
                    f_h = (tmp_h * 1.1) + base;
                    if f_h < 20
                        pl.redraw@PlotProp('Height', f_h, varargin{:})
                        set(pl.comparison_tbl, 'Position', [.01 .2 .98 .6])
                    else
                        pl.redraw@PlotProp('Height', 15, varargin{:})
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

    y0_s = 3 + h(pl.pp)*.01;

    dw = 1;
    w_pp = cellfun(@(x) w(x), pl.comparison_tbl);
    w_p = sum(w_pp + dw) + dw;

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