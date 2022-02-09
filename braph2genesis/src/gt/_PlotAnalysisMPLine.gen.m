%% ¡header!
PlotAnalysisMPLine < Plot (pr, plot graph mp) is a line plot of the mp measure values.

%%% ¡description!
PlotAnalysisMPLine is the line plot of the mp measure values.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pr.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
h_plot % plot handle
pp
h_settings
m % measure

%% ¡props!

%%% ¡prop!
PLOTTITLE(metadata, string) to set plot line title.

%%% ¡prop!
GRAPH(data, item) to set plot line title.

%%% ¡prop!
X(data, rvector) to set plot line graph x range.

%%% ¡prop!
XLABEL(metadata, string) to set plot line x label.

%%% ¡prop!
YLABEL(metadata, string) to set plot line y label.

%%% ¡prop!
PLOTVALUE(data, cell) to set plot line atlas.

%%% ¡prop!
MEASURE(data, string) to set plot line measure.

%%% ¡prop!
LAYER (metadata, scalar) to set plot line layer.
%%%% ¡default!
1

%%% ¡prop!
NODE1 (metadata, scalar) to set plot line node 1.
%%%% ¡default!
1

%%% ¡prop!
NODE2 (metadata, scalar) to set plot line node 2.
%%%% ¡default!
2

%%% ¡prop!
COLOR (metadata, rvector) to set plot line color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
LINESTYLE (metadata, string) to set plot line style.
%%%% ¡default!
'-'

%%% ¡prop!
LINEWIDTH (metadata, scalar) to set plot line width.
%%%% ¡default!
0.5

%%% ¡prop!
MARKER (metadata, string) to set plot marker style.
%%%% ¡default!
'none'

%%% ¡prop!
MARKERSIZE (metadata, scalar) to set plot marker size.
%%%% ¡default!
6

%%% ¡prop!
MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
MARKERFACECOLOR (metadata, rvector) to set plot marker face color.
%%%% ¡default!
[0 0 0]

%% ¡methods!
function h_figure = draw(pr, varargin)
    %DRAW draws the plot line.
    %
    % DRAW(PR) draws the plot line.
    %
    % H = DRAW(PR) returns a handle to the plot line.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the plot line
    %  with custom property-value couples.
    %  All standard plot properties of plot line can be used.
    %
    % see also settings, uipanel, isgraphics, Plot.    
        
    
    pr.pp = draw@Plot(pr, varargin{:});
    pr.h_figure = get(pr.pp, 'Parent');
    subpanel = uipanel(pr.h_figure, ...
        'BackGroundColor', 'w', ...
        'Units', 'normalized', ...
        'Position', [.0 .0 1 1] ...
        );
    
    pr.h_axes = axes(subpanel);
        
    if nargout > 0
        h_figure = pr.h_figure;
    end
end
function f_settings = settings(pr, varargin)
    %SETTINGS opens the property editor GUI.
    %
    % SETTINGS(PR) allows the user to specify the properties of the plot
    %  by opening a GUI property editor.
    %
    % F = SETTINGS(PR) returns a handle to the property editor GUI.
    %
    % SETTINGS(PR, 'Property', VALUE, ...) sets the properties of the
    %  property editor GUI with custom property-value couples.
    %  All standard plot properties of figure can be used.
    %
    % See also draw, figure, isgraphics.

    pr.h_settings = settings@Plot(pr, varargin{:});
    set_braph2_icon(pr.h_settings);

    % constants
    line_style = {'-', '--', ':', ':.', 'none'}; % TODO: move to BRAPH2
    marker_style = {'o', '+', '*', '.', 'x', ...
        '_', '|', 'square', 'diamond', '^', ...
        '>', '<', 'pentagram', 'hexagram', 'none'}; % TODO: move to BRAPH2
    graph = pr.get('GRAPH');
    measure_dict = graph.get('M_DICT');
    pr.m = measure_dict.getItem(1); % it has at least 1 measure
    measure_list = measure_dict.getKeys();
    atlas = graph.get('BRAINATLAS');
    node_labels = cellfun(@(x) x.get('ID') , atlas.get('BR_DICT').getItems(), 'UniformOutput', false);

    ui_plot_properties_panel = uipanel(pr.h_settings, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Position', [0 0 1 1]);

    % line properties
    measure_list_popup = uicontrol(ui_plot_properties_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.05 .8 .4 .16], ...
        'String', measure_list, ...
        'TooltipString', 'Plot Line Style', ...
        'Callback', {@cb_measure_selection} ...
        );

        function cb_measure_selection(~,~)
            val = measure_list_popup.Value;
            str = measure_list_popup.String;
            pr.m = measure_dict.getItem(val);
            pr.set('YLABEL', pr.m.get('ID'))
            rules_node_popmenu_deactivation()
            pr.update_plot()
        end

    ui_line_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.05 .49 .4 .16], ...
        'String', 'Line Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Plot Line Color', ...
        'Callback', {@cb_line_color});

        function cb_line_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pr.set('COLOR', color)
                update()
            end
        end

    ui_line_style = uicontrol(ui_plot_properties_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.05 .65 .4 .16], ...
        'String', line_style, ...
        'TooltipString', 'Plot Line Style', ...
        'Callback', {@cb_line_style});

        function cb_line_style(~, ~)  % (src, event)
            val = ui_line_style.Value;
            str = ui_line_style.String;
            pr.set('LINESTYLE', str{val})
            update()
        end

    ui_line_width = uicontrol(ui_plot_properties_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.05 .29 .4 .16], ...
        'String', '5', ...
        'TooltipString', 'Plot Line Width', ...
        'Callback', {@cb_line_width});

        function cb_line_width(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pr.set('LINEWIDTH', value)
            update()
        end

    % markers
    ui_marker_style = uicontrol(ui_plot_properties_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.55 .65 .4 .16], ...
        'String', marker_style, ...
        'TooltipString', 'Plot Marker Style', ...
        'Callback', {@cb_marker_style});

        function cb_marker_style(~, ~)  % (src, event)
            val = ui_marker_style.Value;
            str = ui_marker_style.String;
            pr.set('MARKER', str{val})
            update()
        end

    ui_marker_size = uicontrol(ui_plot_properties_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.55 .09 .4 .16], ...
        'String', '5', ...
        'TooltipString', 'Marker Line Width', ...
        'Callback', {@cb_marker_size});

        function cb_marker_size(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pr.set('MARKERSIZE', value)
            update()
        end
    ui_marker_edge_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.55 .49 .4 .16], ...
        'String', 'Marker Edge Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Marker Edge Color', ...
        'Callback', {@cb_marker_edge_color});

        function cb_marker_edge_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pr.set('MARKEREDGECOLOR', color)
                update()
            end
        end
    ui_marker_face_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.55 .29 .4 .16], ...
        'String', 'Marker Face Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Marker Face Color', ...
        'Callback', {@cb_marker_face_color});

        function cb_marker_face_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pr.set('MARKERFACECOLOR', color)
                update()
            end
        end

    ui_node1_popmenu  = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'popupmenu', 'String', node_labels);
    ui_node2_popmenu  = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'popupmenu', 'String', node_labels);

        function update()
            pr.update_plot();
        end
        function init_measure_plot_area()
            set(ui_node1_popmenu, ...
                'Units', 'normalized', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Value', pr.get('NODE1'), ...
                'Position', [.55 .8 .1 .16], ...
                'Callback', {@cb_node_1} ...
                );
            set(ui_node2_popmenu, ...
                'Units', 'normalized', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Value', pr.get('NODE2'), ...
                'Position', [.66 .8 .1 .16], ...
                'Callback', {@cb_node_2} ...
                );
            rules_node_popmenu_deactivation()
        end
        function rules_node_popmenu_deactivation()
            if Measure.is_global(pr.m)
                set(ui_node1_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )
                set(ui_node2_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )

            elseif Measure.is_nodal(pr.m)
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
            pr.set('NODE1', node1_to_plot)
            update();
        end
        function cb_node_2(source, ~)
            node2_to_plot = double(source.Value);
            pr.set('NODE2', node2_to_plot)
            update();
        end

    layer_number = size(pr.m.get('G').get('B'), 2);
    layer_popup = uicontrol('Parent', ui_plot_properties_panel,...
        'Style', 'popupmenu',...
        'Units', 'normalized', ...
        'String', arrayfun(@(x) [num2str(x)], [1:layer_number], 'UniformOutput', false));
    init_layer_section()
        function init_layer_section()
            set(layer_popup, 'Position', [.77 .81 .1 .16], ...
                'Value', pr.get('LAYER'), ...
                'Callback', {@layer_popup_selector});

        end
        function layer_popup_selector(src, ~)
            layer_to_plot = double(src.Value);
            pr.set('LAYER', layer_to_plot)
            update();
        end

    init_measure_plot_area()

    if nargin > 0
        f_settings = pr.h_settings;
    end
end
function update_plot(pr)
    measure = pr.m;
    plot_value = measure.get('M');
    layer_number = size(pr.m.get('G').get('B'), 2);
    choosen_layer = pr.get('LAYER');

    if Measure.is_global(pr.m) % global
        is_inf_vector = cellfun(@(x) isinf(x), plot_value);
        if any(is_inf_vector)
            return;
        end
        y_ = [plot_value{choosen_layer:layer_number:end}];
    elseif Measure.is_nodal(pr.m) % nodal
        tmp_index = 1;
        for l = choosen_layer:layer_number:length(plot_value)
            tmp = plot_value{l};
            tmp_y = tmp(pr.get('NODE1'));
            if isinf(tmp_y)
                return;
            end
            y_(tmp_index) = tmp_y; %#ok<AGROW>
            tmp_index = tmp_index + 1;
        end
    else  % binodal
        tmp_index = 1;
        for l = choosen_layer:layer_number:length(plot_value)
            tmp = plot_value{l};
            tmp_y = tmp(pr.get('NODE1'), pr.get('NODE2'));
            if isinf(tmp_y)
                return;
            end
            y_(tmp_index) = tmp_y; %#ok<AGROW>
            tmp_index = tmp_index + 1;
        end
    end
    pr.plotline(pr.get('X'), y_)
end
function plotline(pr, x, y)
    pr.h_plot = plot( ...
        pr.h_axes, ...
        x, ...
        y, ...
        'Marker', pr.get('MARKER'), ...
        'MarkerSize', pr.get('MARKERSIZE'), ...
        'MarkerEdgeColor', pr.get('MARKEREDGECOLOR'), ...
        'MarkerFaceColor', pr.get('MARKERFACECOLOR'), ...
        'LineStyle', pr.get('LINESTYLE'), ...
        'LineWidth', pr.get('LINEWIDTH'), ...
        'Color', pr.get('COLOR') ...
        );

    title(pr.h_axes, pr.get('PLOTTITLE'))
    xlabel(pr.h_axes, pr.get('XLABEL'))
    ylabel(pr.h_axes, pr.get('YLABEL'))
end