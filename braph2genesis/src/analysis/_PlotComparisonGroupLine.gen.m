%% ¡header!
PlotComparisonGroupLine < Plot (pr, plot graph) is a line plot of the comparison values.

%%% ¡description!
Plot is the line plot of the comparison values.
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
cp % measure

%% ¡props!

%%% ¡prop!
PLOTTITLE(metadata, string) to set plot line title

%%% ¡prop!
X(data, rvector) to set plot line graph x range

%%% ¡prop!
XLABEL(metadata, string) to set plot line x label

%%% ¡prop!
YLABEL(metadata, string) to set plot line y label

%%% ¡prop!
PLOTVALUE(data, cell) to set plot line atlas

%%% ¡prop!
MEASURE(data, string) to set plot line measure

%%% ¡prop!
COMPARISON(data, IDICT) to set the comparison dictionary

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

%%% ¡prop!
FILLCOLOR (metadata, rvector) to set plot patch face color
%%%% ¡default!
[0 0 0]


%%% ¡prop!
FILLALPHA (metadata, scalar) to set plot patch face color alpha
%%%% ¡check_prop!
check = value >= 0 && value <= 1;
%%%% ¡default!
0

%%% ¡prop!
CICOLOR (metadata, rvector) to set confidence interval plot line color
%%%% ¡default!
[0 0 0]

%%% ¡prop!
CILINESTYLE (metadata, string) to set confidence interval plot line style
%%%% ¡default!
'-'

%%% ¡prop!
CILINEWIDTH (metadata, scalar) to set confidence interval plot line width
%%%% ¡default!
0.5

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
    % see also settings, uipanel, isgraphics, PlotGraph.    
        
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
    cp_dict = pr.get('Comparison');
    pr.cp = cp_dict.getItem(1); % it has at least 1 measure
    measure_list = cellfun(@(x) x.get('MEASURE'), cp_dict.getItems(), 'UniformOutput', false);
    atlas = pr.cp.get('C').get('A1').get('G').get('BRAINATLAS');
    node_labels = cellfun(@(x) x.get('ID'), atlas.get('BR_DICT').getItems(), 'UniformOutput', false);

    h_p_min = [];
    h_fill_area = [];
    h_p_max = [];

    plot_properties_panel = uipanel(pr.h_settings, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Position', [0 0 1 1]);

    % measures panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    measure_panel = uipanel(plot_properties_panel, ...
        'Units', 'normalized', ...
        'BackgroundColor',  pr.h_settings.Color, ...
        'Position', [.01 .89 .98 .1] ...
        );

    measure_list_id = uicontrol(measure_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Measure', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .01 .1 .9]);

    measure_list_popup = uicontrol(measure_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.11 .1 .1 .8], ...
        'String', measure_list, ...
        'TooltipString', 'Plot Line Style', ...
        'Callback', {@cb_measure_selection} ...
        );

        function cb_measure_selection(~,~)
            val = measure_list_popup.Value;
            pr.cp = cp_dict.getItem(val);
            pr.set('YLABEL', pr.cp.get('MEASURE'));
            pr.set('CIL', pr.cp.get('CIL'));
            pr.set('CIU', pr.cp.get('CIU'));
            clear_axes()
            rules_node_popmenu_deactivation()
            update()
        end

    node_1_id = uicontrol(measure_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Brain Region 1', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.22 .01 .1 .9]);
    node_2_id = uicontrol(measure_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Brain Region 2', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.44 .01 .1 .9]);
    node1_popmenu  = uicontrol('Parent', measure_panel, 'Style', 'popupmenu', 'String', node_labels);
    node2_popmenu  = uicontrol('Parent', measure_panel, 'Style', 'popupmenu', 'String', node_labels);

        function update()
            if comp_plot_checkbox.Value
                pr.update_plot()
            else
                set(pr.h_plot, 'Visible', 'off');
            end
            if confidence_interval_min_checkbox.Value
                cb_show_confidence_interval_min()
            else
                set(h_p_min, 'Visible', 'off')
            end
            if confidence_interval_max_checkbox.Value
                cb_show_confidence_interval_max()
                else
                set(h_p_max, 'Visible', 'off')
            end
            if area_fill_checkbox.Value
                area_fill(h_p_min, h_p_max)
            else
                set(h_fill_area, 'Visible', 'off');
            end
        end
        function init_measure_plot_area()
            set(node1_popmenu, ...
                'Units', 'normalized', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Value', pr.get('NODE1'), ...
                'Position', [.33 .1 .1 .8], ...
                'Callback', {@cb_node_1} ...
                );
            set(node2_popmenu, ...
                'Units', 'normalized', ...
                'Tooltip', 'Select the Node to be Plotted.', ...
                'String', node_labels, ...
                'Value', pr.get('NODE2'), ...
                'Position', [.55 .1 .1 .8], ...
                'Callback', {@cb_node_2} ...
                );
            rules_node_popmenu_deactivation()
        end
        function rules_node_popmenu_deactivation()
            if Measure.is_global(pr.cp.get('MEASURE'))
                set(node1_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )
                set(node2_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )
                set(node_1_id, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )
                set(node_2_id, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )

            elseif Measure.is_nodal(pr.cp.get('MEASURE'))
                set(node1_popmenu, ...
                    'Visible', 'on', ...
                    'Enable', 'on' ...
                    )
                set(node2_popmenu, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )
                set(node_1_id, ...
                    'Visible', 'on', ...
                    'Enable', 'on' ...
                    )
                set(node_2_id, ...
                    'Visible', 'off', ...
                    'Enable', 'off' ...
                    )
                node_1_id.String = 'Brain Region';
            else
                set(node1_popmenu, ...
                    'Visible', 'on', ...
                    'Enable', 'on' ...
                    )
                set(node2_popmenu, ...
                    'Visible', 'on', ...
                    'Enable', 'on' ...
                    )
                set(node_1_id, ...
                    'Visible', 'on', ...
                    'Enable', 'on' ...
                    )
                set(node_2_id, ...
                    'Visible', 'on', ...
                    'Enable', 'on' ...
                    )
                node_1_id.String = 'Brain Region 1';
            end
        end
        function cb_node_1(source, ~)
            clear_axes()
            node1_to_plot = double(source.Value);
            pr.set('NODE1', node1_to_plot)
            update();
        end
        function cb_node_2(source, ~)
            clear_axes()
            node2_to_plot = double(source.Value);
            pr.set('NODE2', node2_to_plot)
            update();
        end
        function clear_axes()
            cla(pr.h_axes)
            pr.h_plot = [];
            h_p_min = [];
            h_fill_area = [];
            h_p_max = [];
        end

    % comp line style panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    comparison_plot_style_panel = uipanel(plot_properties_panel, ...
        'Units', 'normalized', ...
        'BackgroundColor',  pr.h_settings.Color, ...
        'Position', [.01 .01 .32 .88] ...
        );

    comp_plot_checkbox = uicontrol(comparison_plot_style_panel, ...
        'Style', 'checkbox', ...
        'Units', 'normalized', ...
        'Position', [.01 .84 .4 .1], ...
        'String', 'Comparison Plot', ...
        'Value', false, ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Callback', {@cb_show_comparison_plot});

        function cb_show_comparison_plot(~, ~)
            update();
            % enable/disable comp line panel
        end

    line_style_id = uicontrol(comparison_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Line Style', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .72 .32 .1]);

    ui_line_style = uicontrol(comparison_plot_style_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.34 .72 .64 .1], ...
        'String', line_style, ...
        'TooltipString', 'Plot Line Style', ...
        'Callback', {@cb_line_style});

        function cb_line_style(~, ~)  % (src, event)
            val = ui_line_style.Value;
            str = ui_line_style.String;
            pr.set('LINESTYLE', str{val})
            update()
        end

    line_color_id = uicontrol(comparison_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Line Color', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .6 .32 .1]);

    ui_line_color = uicontrol(comparison_plot_style_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.34 .6 .64 .1], ...
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

    line_width_id = uicontrol(comparison_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Line Width', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .48 .32 .1]);

    ui_line_width = uicontrol(comparison_plot_style_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.34 .48 .64 .1], ...
        'String', '5', ...
        'TooltipString', 'Plot Line Width', ...
        'Callback', {@cb_line_width});

        function cb_line_width(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pr.set('LINEWIDTH', value)
            update()
        end

    marker_style_id = uicontrol(comparison_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Marker Style', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .36 .32 .1]);

    ui_marker_style = uicontrol(comparison_plot_style_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.34 .36 .64 .1], ...
        'String', marker_style, ...
        'TooltipString', 'Plot Marker Style', ...
        'Callback', {@cb_marker_style});

        function cb_marker_style(~, ~)  % (src, event)
            val = ui_marker_style.Value;
            str = ui_marker_style.String;
            pr.set('MARKER', str{val})
            update()
        end

    marker_edge_id = uicontrol(comparison_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Marker Edge Color', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .24 .32 .1]);

    ui_marker_edge_color = uicontrol(comparison_plot_style_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.34 .24 .64 .1], ...
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

    marker_width_id = uicontrol(comparison_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Marker Width', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .12 .32 .1]);

    ui_marker_size = uicontrol(comparison_plot_style_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.34 .12 .64 .1], ...
        'String', '5', ...
        'TooltipString', 'Marker Line Width', ...
        'Callback', {@cb_marker_size});

        function cb_marker_size(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pr.set('MARKERSIZE', value)
            update()
        end

    marker_face_id = uicontrol(comparison_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Marker Face Color', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .01 .32 .1]);

    ui_marker_face_color = uicontrol(comparison_plot_style_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.34 .01 .64 .1], ...
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

    % cil ciu panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cil_ciu_plot_style_panel = uipanel(plot_properties_panel, ...
        'Units', 'normalized', ...
        'BackgroundColor',  pr.h_settings.Color, ...
        'Position', [.34 .01 .32 .88] ...
        );

    confidence_interval_min_checkbox = uicontrol(cil_ciu_plot_style_panel, ...
        'Style', 'checkbox', ...
        'Units', 'normalized', ...
        'Position', [.01 .84 .4 .1], ...
        'String', 'Confidence Interval Min', ...
        'Value', false, ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Callback', {@cb_show_confidence_interval_min});

        function cb_show_confidence_interval_min(src, ~)
            % enable/disable cil line panel

            % plot
            if confidence_interval_min_checkbox.Value
                cil = obtain_cil_ciu_value(pr.get('CIL'));
                x_ = pr.get('X');
                hold(pr.h_axes, 'on')
                if ~check_graphics(h_p_min, 'line')
                    h_p_min = plot(pr.h_axes, ...
                    x_, ...
                    cil, ...
                    'Marker', 'x', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.3 .4 .5], ...
                    'LineStyle', pr.get('CILINESTYLE'), ...
                    'LineWidth', pr.get('CILINEWIDTH'), ...
                    'Color', pr.get('CICOLOR'));
                else
                    set(h_p_min, ...
                        'LineStyle', pr.get('CILINESTYLE'), ...
                        'LineWidth', pr.get('CILINEWIDTH'), ...
                        'Color', pr.get('CICOLOR') )
                end		                
                h_p_min.Visible = true;
            else
                h_p_min.Visible = false;
            end
        end

    confidence_interval_max_checkbox = uicontrol(cil_ciu_plot_style_panel, ...
        'Units', 'normalized', ...
        'Style', 'checkbox', ...
        'Position', [.51 .84 .4 .1], ...
        'String', 'Confidence Interval Max', ...
        'Value', false, ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Callback', {@cb_show_confidence_interval_max});

        function cb_show_confidence_interval_max(src, ~)
            % enable/disable cil line panel

            % plot
            if confidence_interval_max_checkbox.Value
                hold(pr.h_axes, 'on')
                x_ = pr.get('X');
                ciu = obtain_cil_ciu_value(pr.get('CIU'));
                if ~check_graphics(h_p_max, 'line')
                    h_p_max = plot(pr.h_axes, ...
                        x_, ...
                        ciu, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', pr.get('CILINESTYLE'), ...
                        'LineWidth', pr.get('CILINEWIDTH'), ...
                        'Color', pr.get('CICOLOR'));
                else
                    set(h_p_max, ...
                        'LineStyle', pr.get('CILINESTYLE'), ...
                        'LineWidth', pr.get('CILINEWIDTH'), ...
                        'Color', pr.get('CICOLOR') )
                end
                h_p_max.Visible = true;
            else
                h_p_max.Visible = false;
            end
        end
        function limit = obtain_cil_ciu_value(array)
            node1_to_plot = pr.get('NODE1');
            node2_to_plot = pr.get('NODE2');

            if Measure.is_global(pr.cp.get('MEASURE')) % global
                is_inf_vector = cellfun(@(x) isinf(x), array);
                if any(is_inf_vector)
                    return;
                end
                limit = [array{:}];
            elseif Measure.is_nodal(pr.cp.get('MEASURE')) % nodal
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

    CI_style_id = uicontrol(cil_ciu_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'CI Line Style', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .72 .32 .1]);

    cil_ciu_style = uicontrol(cil_ciu_plot_style_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.34 .72 .64 .1], ...
        'String', line_style, ...
        'TooltipString', 'Plot CIL and CIU Style', ...
        'Callback', {@cb_minmax_line_style});

        function cb_minmax_line_style(src, ~)  % (src, event)
            val = src.Value;
            str = src.String;
            set(h_p_min, 'LineStyle', str{val})
            set(h_p_max, 'LineStyle', str{val})
            pr.set('CILINESTYLE', str{val})
        end

    CI_color_id = uicontrol(cil_ciu_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'CI Line Color', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .6 .32 .1]);

    cil_ciu_line_color = uicontrol(cil_ciu_plot_style_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.34 .6 .64 .1], ...
        'String', 'Line Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Plot CIL and CIU Color', ...
        'Callback', {@cb_minmax_color});

        function cb_minmax_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                set(h_p_min, 'COLOR', color)
                set(h_p_max, 'COLOR', color)
                pr.set('CICOLOR', value)
            end
        end

    CI_width_id = uicontrol(cil_ciu_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'CI Line Width', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .48 .32 .1]);

    cil_ciu_line_width = uicontrol(cil_ciu_plot_style_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.34 .48 .64 .1], ...
        'String', '5', ...
        'TooltipString', 'Plot Line Width', ...
        'Callback', {@cb_minmax_line_width});

        function cb_minmax_line_width(~, ~)  % (src, event)
            value = str2num(cil_ciu_line_width.String);
            set(h_p_min, 'LINEWIDTH', value)
            set(h_p_max, 'LINEWIDTH', value)
            pr.set('CILINEWIDTH', value)
        end

    % area fill %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fill_plot_style_panel = uipanel(plot_properties_panel, ...
        'Units', 'normalized', ...
        'BackgroundColor',  pr.h_settings.Color, ...
        'Position', [.67 .01 .32 .88] ...
        );

    area_fill_checkbox = uicontrol(fill_plot_style_panel, ...
        'Units', 'normalized', ...
        'Style', 'checkbox', ...
        'Position', [.01 .84 .4 .1], ...
        'String', 'Fill area', ...
        'Value', false, ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Callback', {@cb_fill_area});

        function cb_fill_area(~, ~)	
            update() 
            % disable enable
        end

    fill_alpha_id = uicontrol(fill_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Fill Area Alpha', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .72 .32 .1]);

    fill_area_alpha = uicontrol(fill_plot_style_panel, ...
        'Style', 'slider', ...
        'Units', 'normalized', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.34 .72 .64 .1], ...
        'String', 'Area Alpha', ...
        'Min', 0, 'Max', 1, 'Value', pr.get('FILLALPHA'), ...
        'TooltipString', 'Plot Area Color Transparency', ...
        'Callback', {@cb_fill_alpha});

        function cb_fill_alpha(~, ~)  % (src, event)
            pr.set('FILLALPHA', get(fill_area_alpha, 'Value'))
            update()
        end

    fill_alpha_id = uicontrol(fill_plot_style_panel, ...
        'Style', 'text', ...
        'HorizontalAlignment', 'left', ...
        'Units', 'normalized', ...
        'String', 'Fill Area Color', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .6 .32 .1]);

    fill_area_color = uicontrol(fill_plot_style_panel, ...
        'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.34 .6 .64 .1], ...
        'String', 'Area Color', ...
        'TooltipString', 'Plot Area Color', ...
        'Callback', {@cb_fill_color});

        function cb_fill_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pr.set('FILLCOLOR', color)
                update()
            end
        end
        function area_fill(X, Y)
            x_data = get(X, 'XData');
            y1_data = get(X, 'YData');
            y2_data = get(Y, 'YData');
            if area_fill_checkbox.Value
                h_fill_area = [];
                h_fill_area = fill(pr.h_axes, [x_data, fliplr(x_data)], [y1_data, fliplr(y2_data)], pr.get('FILLCOLOR'), 'FaceAlpha', pr.get('FILLALPHA'));
            end
        end

    init_measure_plot_area()
    cb_measure_selection()

    if nargin > 0
        f_settings = pr.h_settings;
    end
end
function update_plot(pr)
    % UPDATEPLOT chooses the correct data to be ploted
    %
    % UPDATEPLOT chooses the correct data to be ploted and calls the plotline
    %   function.
    %
    % See also settings, plotline.
    
    comparison = pr.cp;
    plot_value = comparison.get('DIFF');
    if Measure.is_global(pr.cp.get('MEASURE')) % global
        is_inf_vector = cellfun(@(x) isinf(x), plot_value);
        if any(is_inf_vector)
            return;
        end
        y_ = [plot_value{:}];
    elseif Measure.is_nodal(pr.cp.get('MEASURE')) % nodal
        for l = 1:length(plot_value)
            tmp = plot_value{l};
            tmp_y = tmp(pr.get('NODE1'));
            if isinf(tmp_y)
                return;
            end
            y_(l) = tmp_y; %#ok<AGROW>
        end
    else  % binodal
        for l = 1:length(plot_value)
            tmp = plot_value{l};
            tmp_y = tmp(pr.get('NODE1'), pr.get('NODE2'));
            if isinf(tmp_y)
                return;
            end
            y_(l) = tmp_y; %#ok<AGROW>
        end
    end
    pr.plotline(pr.get('X'), y_)
end
function plotline(pr, x, y)
    % PLOTLINE plots the comparison in the given axis.
    %
    % PLOTLINE(PR, X, Y) plots the comparison in the given axis with the
    %   specified plot properties. 
    %
    % See also draw, settings.
    if ~check_graphics(pr.h_plot, 'line')
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
    else
        set(pr.h_plot, ...
            'XDATA', x, ...
            'YDATA', y, ...
            'Visible', 'on', ...
            'Marker', pr.get('MARKER'), ...
            'MarkerSize', pr.get('MARKERSIZE'), ...
            'MarkerEdgeColor', pr.get('MARKEREDGECOLOR'), ...
            'MarkerFaceColor', pr.get('MARKERFACECOLOR'), ...
            'LineStyle', pr.get('LINESTYLE'), ...
            'LineWidth', pr.get('LINEWIDTH'), ...
            'Color', pr.get('COLOR') ...
            );
    end
    uistack(pr.h_plot,'top')
    title(pr.h_axes, pr.get('PLOTTITLE'))
    xlabel(pr.h_axes, pr.get('XLABEL'))
    ylabel(pr.h_axes, pr.get('YLABEL'))
end