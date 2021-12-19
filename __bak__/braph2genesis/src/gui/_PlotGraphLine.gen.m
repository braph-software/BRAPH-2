%% ¡header!
PlotGraphLine < PlotGraph (pl, plot graph line) is a plot of a function .

%%% ¡description!
PlotGraphLine is the plot of a function whose plot is a line plot.
It is a graphical figure with properties for the plot.
To generate the plot, call pl.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure, PlotGraph.

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
h_plot_line % handle of the plot line
pp % handle for the outer panel
subpanel % handle for inner subpanel

%% ¡props!

%%% ¡prop!
PLOTTITLE(metadata, string) to set plot line title

%%% ¡prop!
XLABEL(metadata, string) to set plot line x label

%%% ¡prop!
YLABEL(metadata, string) to set plot line y label

%%% ¡prop!
ATLAS(data, item) to set plot line atlas

%%% ¡prop!
GRAPH(data, item) to set plot line graph

%%% ¡prop!
X(data, rvector) to set plot line graph x range

%%% ¡prop!
PLOTVALUE(data, cell) to set plot line atlas

%%% ¡prop!
MEASURE(data, string) to set plot line measure

%%% ¡prop!
CIL (metadata, CELL) to set plot line cil

%%% ¡prop!
CIU (metadata, CELL) to set plot line ciu

%%% ¡prop!
NODE1 (metadata, scalar) to set plot line node 1
%%%% ¡default!
1

%%% ¡prop!
NODE2 (metadata, scalar) to set plot line node 2
%%%% ¡default!
2

%%% ¡prop!
COLOR (metadata, rvector) to set plot line color
%%%% ¡default!
[0 0 0]

%%% ¡prop!
LINESTYLE (metadata, string) to set plot line style
%%%% ¡default!
'-'

%%% ¡prop!
LINEWIDTH (metadata, scalar) to set plot line width
%%%% ¡default!
0.5

%%% ¡prop!
MARKER (metadata, string) to set plot marker style
%%%% ¡default!
'none'

%%% ¡prop!
MARKERSIZE (metadata, scalar) to set plot marker size
%%%% ¡default!
6

%%% ¡prop!
MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color
%%%% ¡default!
[0 0 0]

%%% ¡prop!
MARKERFACECOLOR (metadata, rvector) to set plot marker face color
%%%% ¡default!
[0 0 0]

%% ¡methods!
function h_plot_line = draw(pl, varargin)
    %DRAW draws the plot line.
    %
    % DRAW(PL) draws the plot line.
    %
    % H = DRAW(PL) returns a handle to the plot line.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the plot line
    %  with custom property-value couples.
    %  All standard plot properties of plot line can be used.
    %
    % see also settings, uipanel, isgraphics, PlotGraph.    
        
    [pl.h_figure, pl.h_axes] = draw@PlotGraph(pl, varargin{:});
    
    % variable init
    plot_value = pl.get('PLOTVALUE');
    m = pl.get('MEASURE');        
    x_ = pl.get('X');
    atlas = pl.get('ATLAS');        
    y_ = [];
    node_labels_tmp = pl.get('ATLAS').get('BR_DICT');
    node_labels = cellfun(@(x) x.get('ID') , node_labels_tmp.getItems(), 'UniformOutput', false); 
    
    function obtain_value()
        node1_to_plot = pl.get('NODE1');
        node2_to_plot = pl.get('NODE2');
        
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
    end
    function plotline()
        obtain_value()
        pl.h_plot_line = plot( ...
            pl.h_axes, ...
            x_, ...
            y_, ...
            'Marker', pl.get('MARKER'), ...
            'MarkerSize', pl.get('MARKERSIZE'), ...
            'MarkerEdgeColor', pl.get('MARKEREDGECOLOR'), ...
            'MarkerFaceColor', pl.get('MARKERFACECOLOR'), ...
            'LineStyle', pl.get('LINESTYLE'), ...
            'LineWidth', pl.get('LINEWIDTH'), ...
            'Color', pl.get('COLOR') ...
            );
        
        title(pl.get('PLOTTITLE'))
        xlabel(pl.get('XLABEL'))
        ylabel(pl.get('YLABEL'))
    end

    plotline()
    
    if nargout > 0
        h_plot_line = pl.h_plot_line;
    end
end
function  f_settings = settings(pl, varargin)
    %SETTINGS opens the property editor GUI.
    %
    % SETTINGS(PL) allows the user to specify the properties of the plot
    %  by opening a GUI property editor.
    %
    % F = SETTINGS(PL) returns a handle to the property editor GUI.
    %
    % SETTINGS(PL, 'Property', VALUE, ...) sets the properties of the
    %  property editor GUI with custom property-value couples.
    %  All standard plot properties of figure can be used.
    %
    % See also draw, figure, isgraphics.

    f = settings@Plot(pl, varargin{:});
    set_icon(f);

    % panel
    line_style = {'-', '--', ':', ':.', 'none'};
    marker_style = {'o', '+', '*', '.', 'x', ...
        '_', '|', 'square', 'diamond', '^', ...
        '>', '<', 'pentagram', 'hexagram', 'none'};
    m = pl.get('MEASURE');
    node_labels_tmp = pl.get('ATLAS').get('BR_DICT');
    node_labels = cellfun(@(x) x.get('ID') , node_labels_tmp.getItems(), 'UniformOutput', false);

    ui_plot_properties_panel = uipanel(f, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Position', [0 0 1 1]);

    % line properties
    ui_line_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.05 .75 .4 .16], ...
        'String', 'Line Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Plot Line Color', ...
        'Callback', {@cb_line_color});

        function cb_line_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pl.set('COLOR', color)
                update()
            end
        end

    ui_line_style = uicontrol(ui_plot_properties_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.05 .51 .4 .2], ...
        'String', line_style, ...
        'TooltipString', 'Plot Line Style', ...
        'Callback', {@cb_line_style});

        function cb_line_style(~, ~)  % (src, event)
            val = ui_line_style.Value;
            str = ui_line_style.String;
            pl.set('LINESTYLE', str{val})
            update()
        end

    ui_line_width = uicontrol(ui_plot_properties_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.05 .35 .4 .16], ...
        'String', '5', ...
        'TooltipString', 'Plot Line Width', ...
        'Callback', {@cb_line_width});

        function cb_line_width(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pl.set('LINEWIDTH', value)
            update()
        end

    % markers
    ui_marker_style = uicontrol(ui_plot_properties_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.55 .71 .4 .2], ...
        'String', marker_style, ...
        'TooltipString', 'Plot Marker Style', ...
        'Callback', {@cb_marker_style});

        function cb_marker_style(~, ~)  % (src, event)
            val = ui_marker_style.Value;
            str = ui_marker_style.String;
            pl.set('MARKER', str{val})
            update()
        end

    ui_marker_size = uicontrol(ui_plot_properties_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.55 .55 .4 .16], ...
        'String', '5', ...
        'TooltipString', 'Plot Line Width', ...
        'Callback', {@cb_marker_size});

        function cb_marker_size(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pl.set('MARKERSIZE', value)
            update()
        end
    ui_marker_edge_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.55 .35 .4 .16], ...
        'String', 'Marker Edge Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Marker Edge Color', ...
        'Callback', {@cb_marker_edge_color});

        function cb_marker_edge_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pl.set('MARKEREDGECOLOR', color)
                update()
            end
        end
    ui_marker_face_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.55 .35 .4 .16], ...
        'String', 'Marker Face Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Marker Edge Color', ...
        'Callback', {@cb_marker_face_color});

        function cb_marker_face_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pl.set('MARKERFACECOLOR', color)
                update()
            end
        end

    ui_node1_popmenu  = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'popupmenu', 'String', node_labels);
    ui_node2_popmenu  = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'popupmenu', 'String', node_labels);

        function update()
            pl.draw();
        end
        function init_measure_plot_area()
            set(ui_node1_popmenu, ...
                'Units', 'normalized', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Value', pl.get('NODE1'), ...
                'Position', [.05 .12 .4 .16], ...
                'Callback', {@cb_node_1} ...
                );
            set(ui_node2_popmenu, ...
                'Units', 'normalized', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Value', pl.get('NODE2'), ...
                'Position', [.55 .12 .4 .16], ...
                'Callback', {@cb_node_2} ...
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
            pl.set('NODE1', node1_to_plot)
            update();
        end
        function cb_node_2(source, ~)
            node2_to_plot = double(source.Value);
            pl.set('NODE2', node2_to_plot)
            update();
        end

    if ~isempty(pl.get('CIL')) && ~isempty(pl.get('CIU'))
        ui_confidence_interval_min_checkbox = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'checkbox', 'Units', 'normalized');
        ui_confidence_interval_max_checkbox = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'checkbox', 'Units', 'normalized');
        h_p_min = [];
        h_p_max = [];
        init_cil_panel()
    end
        function init_cil_panel()
            set(ui_confidence_interval_min_checkbox, 'Position', [.05 .01 .4 .14]);
            set(ui_confidence_interval_min_checkbox, 'String', 'Show Confidence Interval Min');
            set(ui_confidence_interval_min_checkbox, 'Value', false);
            set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})

            set(ui_confidence_interval_max_checkbox, 'Position', [.55 .01 .4 .14]);
            set(ui_confidence_interval_max_checkbox, 'String', 'Show Confidence Interval Max');
            set(ui_confidence_interval_max_checkbox, 'Value', false);
            set(ui_confidence_interval_max_checkbox, 'Callback', {@cb_show_confidence_interval_max})
        end
        function cb_show_confidence_interval_min(src, ~)
            if src.Value == true
                cil = obtain_cil_ciu_value(pl.get('CIL'));
                x_ = pl.get('X');
                hold(pl.h_axes, 'on')
                h_p_min = plot(pl.h_axes, ...
                    x_, ...
                    cil, ...
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
                hold(pl.h_axes, 'on')
                x_ = pl.get('X');
                ciu = obtain_cil_ciu_value(pl.get('CIU'));
                h_p_max = plot(pl.h_axes, ...
                    x_, ...
                    ciu, ...
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
        function limit = obtain_cil_ciu_value(array)
            node1_to_plot = pl.get('NODE1');
            node2_to_plot = pl.get('NODE2');

            if Measure.is_global(m) % global
                is_inf_vector = cellfun(@(x) isinf(x), array);
                if any(is_inf_vector)
                    return;
                end
                limit = [array{:}];
            elseif Measure.is_nodal(m) % nodal
                for l = 1:length(array)
                    tmp = array{l};
                    tmp_y = tmp(node1_to_plot);
                    if isinf(tmp_y)
                        return;
                    end
                    limit(l) = tmp_y; %#ok<AGROW>
                end
            else  % binodal
                for l = 1:length(array)
                    tmp = array{l};
                    tmp_y = tmp(node1_to_plot, node2_to_plot);
                    if isinf(tmp_y)
                        return;
                    end
                    limit(l) = tmp_y; %#ok<AGROW>
                end
            end
        end

    init_measure_plot_area()

    if nargin > 0
        f_settings = f;
    end
end