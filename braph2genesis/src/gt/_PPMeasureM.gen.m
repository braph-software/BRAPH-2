%% ¡header!
PPMeasureM < PlotProp (pl, plot property of measure M) is a plot of measure M.

%%% ¡description!
PPMeasureM plots a Measure result table and plot.

%%% ¡seealso!
GUI, PlotElement, PlotProp, MultigraphBUD, MultigraphBUT.

%% ¡properties!
pp
table_value_cell
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
    
    get_super_buttons()
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
    value = el.getr(prop);
    node1_to_plot = 1;
    node2_to_plot = 1;
    graph = el.get('G');
    node_labels = [];
    x_range = 1:10;
    y_label = el.getClass();
    node_labels_tmp = graph.get('BRAINATLAS').get('BR_DICT');
    node_labels = cellfun(@(x) x.get('ID') , node_labels_tmp.getItems(), 'UniformOutput', false);
    f = [];
    brain_view_gui = [];

    if el.getPropCategory(prop) == Category.RESULT && isequal(pl.button_calc.Enable, 'on')
        % remove previous tables/textbox
        if ~isempty(pl.table_value_cell)
            if iscell(pl.table_value_cell)
                cellfun(@(x) set(x, 'Visible', 'off'), pl.table_value_cell, 'UniformOutput', false);
            else
                set(pl.table_value_cell, 'Visible', 'off')
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
        % constants
        value_cell = el.get(prop);
        x_label = 'Layer';

        % labels
        if Measure.is_global(el) % global
            node_labels = 'Global';
            for k = 1:size(value_cell, 1)
                row_names{k} = [x_label ': ' num2str(k)]; %#ok<AGROW>
            end
        elseif Measure.is_nodal(el) % nodal
            for k = 1:size(value_cell, 1)
                row_names{k} = [x_label ': ' num2str(k)]; %#ok<AGROW>
            end
        else  % binodal
            % do nothing
        end

        % plot rules edit/tables
        if Measure.is_binodal(el)
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

            delete(pl.table_value_cell)
            pl.table_value_cell = cell(size(value_cell));
            for i = 1:1:size(pl.table_value_cell, 1)
                for j = 1:1:size(pl.table_value_cell, 2)
                    if isempty(pl.table_value_cell{i, j}) || ~isgraphics(pl.table_value_cell{i, j}, 'uitable')
                        pl.table_value_cell{i, j} = uitable('Parent', pl.ui_sliding_panel, 'Visible', 'on');
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

    elseif isa(graph, 'MultigraphBUD') || isa(graph, 'MultigraphBUT') ...
            || isa(graph, 'MultiplexBUD') || isa(graph, 'MultiplexBUT')
        % constants
        if isa(graph, 'MultigraphBUD') || isa(graph, 'MultiplexBUD')
            x_range = graph.get('DENSITIES');
            x_label = 'Densities';
        else
            x_range = graph.get('THRESHOLDS');
            x_label = 'Thresholds';
        end
        plot_title = [y_label ' vs ' x_label];
        value_cell = el.get(prop);

        % labels
        if Measure.is_global(el) % global
            node_labels = 'Global';
            for k = 1:size(value_cell, 1)
                row_names{k} = [x_label ': ' num2str(k)]; %#ok<AGROW>
            end
        elseif Measure.is_nodal(el) % nodal
            for k = 1:size(value_cell, 1)
                row_names{k} = [x_label ':' num2str(k)]; %#ok<AGROW>
            end
        else  % binodal
            % do nothing
        end

        % plot rules edit/tables
        if Measure.is_binodal(el)
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

            delete(pl.table_value_cell)
            pl.table_value_cell = cell(size(value_cell));
            for i = 1:1:size(pl.table_value_cell, 1)
                for j = 1:1:size(pl.table_value_cell, 2)
                    if isempty(pl.table_value_cell{i, j}) || ~isgraphics(pl.table_value_cell{i, j}, 'uitable')
                        pl.table_value_cell{i, j} = uitable('Parent', pl.ui_sliding_panel, 'Visible', 'on');
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
                'Position', [.01 .1 .98 .8], ...
                'ColumnName', node_labels, ...
                'Visible', 'on', ...
                'RowName', row_names, ...
                'CellEditCallback', {@cb_matrix_value} ...
                )
        end

        ui_node1_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu', 'String', node_labels);
        ui_node2_popmenu  = uicontrol('Parent', pl.pp, 'Style', 'popupmenu', 'String', node_labels);
        ui_measure_plot = uicontrol('Parent', pl.pp, 'Style', 'pushbutton');
        ui_brain_view = uicontrol('Parent', pl.pp, ...
            'Style', 'pushbutton', ...
            'Units', 'normalized', ...
            'Position', [.74 .01 .25 .08]);

        init_measure_plot_area()
        init_brain_view_btn()

    else % weighted
        % paint a normal cell tables
        value_cell = el.get(prop);

        if Measure.is_binodal(el) % binodal
            pl.table_value_cell = cell(size(value_cell));
            for i = 1:1:size(pl.table_value_cell, 1)
                for j = 1:1:size(pl.table_value_cell, 2)
                    if isempty(pl.table_value_cell{i, j}) || ~isgraphics(pl.table_value_cell{i, j}, 'uitable')
                        pl.table_value_cell{i, j} = uitable('Parent', pl.pp, 'Visible', 'on');
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
                'Visible', 'on', ...
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
            if Measure.is_global(el)
                set(ui_node1_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )
                set(ui_node2_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )

            elseif Measure.is_nodal(el)
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
            x_ = x_range;

            [~, normalized] = get_figure_position();
            x2 = normalized(1) + normalized(3);
            h2 = normalized(4) / 1.61;
            y2 = normalized(2) + normalized(4) - h2;
            w2 = normalized(3) * 1.61;

            f = figure( ...
                'Visible', 'off', ...
                'NumberTitle', 'off', ...
                'Name', ['PlotGraph - ' BRAPH2.STR], ...
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

            pg = PlotGraphLine( ...
                'bkgcolor', [1 1 1], ...
                'setname', ['Plot of Measure - ' BRAPH2.STR], ...
                'ATLAS', graph.get('BRAINATLAS'),...
                'X', x_,...
                'PLOTVALUE', plot_value, ...
                'MEASURE', el.getClass(), ...
                'PLOTTITLE', plot_title, ...
                'XLABEL', x_label, ...
                'YLABEL', y_label ...
                );
            
            h_plot_line = pg.draw('Parent', f);
            pg.set('SETPOS', [x2 normalized(2) w2 h2*1.61-h2-.065]); % height has to be correcter for the toolbar and menu
            pg.settings();

            set(f, 'Visible', 'on')
           
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

            brain_view_gui = figure( ...
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

            set_icon(brain_view_gui);

            ui_toolbar = findall(brain_view_gui, 'Tag', 'FigureToolBar');
            delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))

            pbv = PlotBrainView('SUBMENU', false, 'SETPOS', [.4 .50 .40 .30], ...
                'ME', el, 'Atlas', graph.get('BRAINATLAS'), 'Type', x_label);

            el_panel = uipanel( ...
                'Parent', brain_view_gui, ...
                'BorderType', 'none' ...
                );

            pbv.draw('Parent', el_panel);
            pbv.settings('SETPOS', [x2 normalized(2) w2 h2*1.61-h2-.065]);

            set(brain_view_gui, 'Visible', 'on')
        end
        function cb_slide(~, ~)
            pl.slide()
        end
    
        set(pl.pp, ...
            'DeleteFcn', {@close_f_settings})

        function close_f_settings(~,~)
            if ~isempty(f)               
                if isgraphics(ancestor(f, 'Figure'))
                    close(ancestor(f, 'Figure'))
                end                
            end
            if ~isempty(brain_view_gui)               
                if isgraphics(ancestor(brain_view_gui, 'Figure'))
                    close(ancestor(brain_view_gui, 'Figure'))
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
        graph = el.get('G');

        if isempty(value_cell) % empty results
            pl.redraw@PlotProp('Height', 1.8, varargin{:})
        elseif ~isempty(pl.table_value_cell) % with values
            base = 12;
            if (isa(graph, 'GraphBU') || isa(graph, 'GraphBD') ...
                    || isa(graph, 'GraphWU') || isa(graph, 'GraphWD')) ...
                    && ~isa(graph, 'MultigraphBUD') && ~isa(graph, 'MultigraphBUT')
                
                if Measure.is_binodal(el) % binodal
                    pl.redraw@PlotProp('Height', 30, varargin{:})
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
                elseif Measure.is_global(el) % global
                    pl.redraw@PlotProp('Height', 5, varargin{:})
                else % nodal
                    pl.redraw@PlotProp('Height', 10, varargin{:})
                end
            else
                % density and threshold and multiplex weighted
                if Measure.is_binodal(el) % binodal
                    pl.redraw@PlotProp('Height', 30, varargin{:})
                    for i = 1:1:size(value_cell, 1)
                        for j = 1:1:size(value_cell, 2)
                            set(pl.table_value_cell{i, j}, ...
                                'Units', 'character', ...
                                'Position', ...
                                [ ...
                                (0 + (i - 1) * 0.99) * Plot.w(pl.pp) ...
                                (0 + (j - 1) * 0.99 / size(pl.table_value_cell, 2)) * (Plot.h(pl.pp) *.725) ...
                                0.98 * Plot.w(pl.pp) ...
                                1 / size(pl.table_value_cell, 2) * (Plot.h(pl.pp) * .75) ...
                                ] ...
                                )
                        end
                    end
                    pl.slide()
                elseif Measure.is_global(el) % global
                    tmp_data = get(pl.table_value_cell, 'Data');
                    tmp_h = size(tmp_data, 1); % 1.1 per row
                    f_h = (tmp_h * 1.1) + base;
                    if f_h < 15
                        pl.redraw@PlotProp('Height', f_h, varargin{:})
                        set(pl.table_value_cell, 'Position', [.01 .2 .98 .6])
                    else
                        pl.redraw@PlotProp('Height', 15, varargin{:})
                    end
                else % nodal
                    tmp_data = get(pl.table_value_cell, 'Data');
                    tmp_h = size(tmp_data, 1); % 1.1 per row
                    f_h = (tmp_h * 1.1) + base + 2;
                    if f_h < 20
                        pl.redraw@PlotProp('Height', f_h, varargin{:})
                        set(pl.table_value_cell, 'Position', [.01 .2 .98 .6])
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

    y0_s = y0(f) + h(pl.pp)*.01;

    dw = 1;
    n = length(pl.table_value_cell);
    w_pp = cellfun(@(x) w(x), pl.table_value_cell);
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