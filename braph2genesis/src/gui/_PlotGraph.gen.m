%% ¡header!
PlotGraph < Plot (pr, plot graph) is a plot of a graph of a function.

%%% ¡description!
Plot is the plot of a graph of a function.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pr.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
h_plot % plot handle
pp
h_settings_line % settings panel handle
h_settings_adj % settings panel for adjacency matrix

%% ¡props!

%%% ¡prop!
SUBMENU (metadata, logical) to set a submenu
%%%% ¡default!
false

%%% ¡prop!
GRAPH (data, item) is the graph which is been ploted
%%%% ¡default!
Graph()

%% ¡methods!
function [h_figure, h_axes, subpanel] = draw(pr, varargin)
    %DRAW draws the graphical panel.
    %
    % DRAW(PL) draws the graphical panel.
    %
    % H = DRAW(PL) returns a handle to the graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % see also settings, uipanel, isgraphics.    
        
    pr.pp = draw@Plot(pr, varargin{:});

    pr.h_figure = get(pr.pp, 'Parent');
    
    if pr.get('SUBMENU')
        subpanel = uipanel(pr.h_figure, ...
            'BackGroundColor', 'w', ...
            'Units', 'normalized', ...
            'Position', [.0 .15 1 .85] ...
            );
        
        pr.h_axes = axes(subpanel);
        set(pr.h_figure, 'Color', 'w')
        set(pr.pp, 'BackGroundColor', 'w');
        
    else
        pr.h_axes = axes(pr.pp);
    end
        
    if nargout > 0
        h_figure = pr.h_figure;
    end
    if nargout > 1
        h_axes = pr.h_axes;
    end
end
function f_settings = settings(pr, varargin)
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
    
    f = settings@Plot(pr, varargin{:});
    set_icon(f);
    graph = pr.get('GRAPH');
    
    set(f, 'Toolbar', 'figure')
    pg_toolbar = findall(f, 'Tag', 'FigureToolBar');
    delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
    delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
    delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
    delete(findall(ui_toolbar, 'Tag', 'Standard.OpenInspector'))
    delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
    delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
    delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
    delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
    delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
    delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
    
    pg_toolbar_line = uipushtool(pg_toolbar, ...
        'Separator', 'off', ...
        'TooltipString', 'Line Plot Panel', ...
        'CData', imread('line_plot.png'), ...
        'ClickedCallback', {@cb_toolbar_line});
    
    function cb_toolbar_line(~,~)
        set(pr.h_settings_line, 'Visible', 'on', 'Enable', 'on')
        set(pr.h_settings_adj, 'Visible', 'off', 'Enable', 'off')
        pr.line_plot_settings();
    end
    
    pg_toolbar_adj = uipushtool(pg_toolbar, ...
        'Separator', 'off', ...
        'TooltipString', 'Adjacency Plot Panel', ...
        'CData', imread('adj_plot.png'), ...
        'ClickedCallback', {@cb_toolbar_adjacency});
    
    function cb_toolbar_adjacency(~,~)
        set(pr.h_settings_line, 'Visible', 'off', 'Enable', 'off')
        set(pr.h_settings_adj, 'Visible', 'on', 'Enable', 'on')
        pr.line_plot_adjacency();
    end
    
    % create dynamic panel, create two panels
    pr.h_settings_line = uipanel(f, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Position', [0 0 1 1]);
    
    pr.h_settings_adj = uipanel(f, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Position', [0 0 1 1]);
    
    initial_rules()
    function initial_rules()
        if isa(graph, 'GraphWU')
            cb_toolbar_adjacency()
        else
            cb_toolbar_line()
        end
    end

    if nargin > 0 
        f_settings = h_settings;
    end
end
function f_line_plot = line_plot_settings(pr, varargin)
    % panel
    line_style = {'-', '--', ':', ':.', 'none'};
    marker_style = {'o', '+', '*', '.', 'x', ...
        '_', '|', 'square', 'diamond', '^', ...
        '>', '<', 'pentagram', 'hexagram', 'none'};

    ui_plot_properties_panel = uicontrol(pr.h_settings, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Position', [0 0 1 1]);

    % line properties
    ui_line_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.05 .75 .4 .20], ...
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
        'Position', [.05 .55 .4 .18], ...
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
        'Position', [.05 .35 .4 .18], ...
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
        'Position', [.55 .75 .4 .18], ...
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
        'Position', [.55 .55 .4 .18], ...
        'String', '5', ...
        'TooltipString', 'Plot Line Width', ...
        'Callback', {@cb_marker_size});

        function cb_marker_size(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pr.set('MARKERSIZE', value)
            update()
        end
    ui_marker_edge_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.55 .35 .4 .20], ...
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
        'Position', [.55 .35 .4 .20], ...
        'String', 'Marker Face Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Marker Edge Color', ...
        'Callback', {@cb_marker_face_color});

        function cb_marker_face_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pr.set('MARKERFACECOLOR', color)
                update()
            end
        end

        function update()
            plot_object = pr.h_axes.Children;
            if isgraphics(plot_object)
                set(plot_object, ...
                    'COLOR', pr.get('COLOR'), ...
                    'LINESTYLE', pr.get('LINESTYLE'), ...
                    'LINESWIDTH', pr.get('LINEWIDTH'), ...
                    'MARKER', pr.get('MARKER'), ...
                    'MARKERSIZE', pr.get('MARKERSIZE'), ...
                    'MARKEREDGECOLOR', pr.get('MARKEREDGECOLOR'), ...
                    'MARKERFACECOLOR', pr .get('MARKERFACECOLOR'));
            end
        end
    
    if nargin > 0 
        f_line_plot = pr.h_settings;
    end
end
function f_adj_plot = adj_plot_settings(pr, varargin)
    % panel
    ui_parent = pr.h_figure;
    ui_parent_axes = pr.h_axes;
    matrix_plot = pr.h_plot;

    ui_matrix_weighted_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
    set(ui_matrix_weighted_checkbox, 'Position', [.02 .82 .3 .07], ...
        'String', 'weighted correlation matrix', ...
        'Value', true, ...
        'TooltipString', 'Select weighted matrix', ...
        'FontWeight', 'bold', ...
        'Callback', {@cb_matrix_weighted_checkbox})

    % density
    ui_matrix_density_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
    set(ui_matrix_density_checkbox, 'Position', [.02 .70 .3 .07], ...
        'String', 'binary correlation matrix (set density)', ...
        'Value', false,...
        'TooltipString', 'Select binary correlation matrix with a set density', ...
        'Callback', {@cb_matrix_density_checkbox})

    ui_matrix_density_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
    set(ui_matrix_density_edit, 'Position', [.02 .6 .3 .07], ...
        'String', '50.00', ...
        'TooltipString', 'Set density.', ...
        'FontWeight', 'bold', ...
        'Enable', 'off', ...
        'Callback', {@cb_matrix_density_edit});

    ui_matrix_density_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
    set(ui_matrix_density_slider, 'Position', [.33 .6 .3 .07], ...
        'Min', 0, 'Max', 100, 'Value', 50, ...
        'TooltipString', 'Set density.', ...
        'Enable', 'off', ...
        'Callback', {@cb_matrix_density_slider})

    % threshold
    ui_matrix_threshold_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
    set(ui_matrix_threshold_checkbox, 'Position', [.02 .5 .3 .07],...
        'String', 'binary correlation matrix (set threshold)', ...
        'Value', false, ...
        'TooltipString', 'Select binary correlation matrix with a set threshold', ...
        'Callback', {@cb_matrix_threshold_checkbox})

    ui_matrix_threshold_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
    set(ui_matrix_threshold_edit, 'Position', [.02 .4 .3 .07], ...
        'String', '0.50', ...
        'TooltipString', 'Set threshold.', ...
        'FontWeight', 'bold' ,...
        'Enable', 'off', ...
        'Callback', {@cb_matrix_threshold_edit});

    ui_matrix_threshold_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
    set(ui_matrix_threshold_slider, 'Position', [.33 .4 .3 .07], ...
        'Min', -1, 'Max', 1, 'Value', .50, ...
        'TooltipString', 'Set threshold.', ...
        'Enable', 'off', ...
        'Callback', {@cb_matrix_threshold_slider})

    % histogram
    ui_matrix_histogram_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
    set(ui_matrix_histogram_checkbox, 'Position', [.02 .3 .1 .07],...
        'String', 'histogram', ...
        'Value', false, ...
        'TooltipString', 'Select histogram of correlation coefficients', ...
        'Callback', {@cb_matrix_histogram_checkbox})

        function cb_matrix_weighted_checkbox(~, ~)
            set(ui_matrix_weighted_checkbox, 'Value', true)
            set(ui_matrix_weighted_checkbox, 'FontWeight', 'bold')

            set(ui_matrix_histogram_checkbox, 'Value', false)
            set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')

            set(ui_matrix_density_checkbox, 'Value', false)
            set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
            set(ui_matrix_density_edit, 'Enable', 'off')
            set(ui_matrix_density_slider, 'Enable', 'off')

            set(ui_matrix_threshold_checkbox, 'Value', false)
            set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
            set(ui_matrix_threshold_edit, 'Enable', 'off')
            set(ui_matrix_threshold_slider, 'Enable', 'off')

            update_matrix()
        end
        function cb_matrix_density_checkbox(~, ~)
            set(ui_matrix_weighted_checkbox, 'Value', false)
            set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')

            set(ui_matrix_histogram_checkbox, 'Value', false)
            set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')

            set(ui_matrix_density_checkbox, 'Value', true)
            set(ui_matrix_density_checkbox, 'FontWeight', 'bold')
            set(ui_matrix_density_edit, 'Enable', 'on')
            set(ui_matrix_density_slider, 'Enable', 'on')

            set(ui_matrix_threshold_checkbox, 'Value', false)
            set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
            set(ui_matrix_threshold_edit, 'Enable', 'off')
            set(ui_matrix_threshold_slider, 'Enable', 'off')

            update_matrix()
        end
        function cb_matrix_threshold_checkbox(~, ~)
            set(ui_matrix_weighted_checkbox, 'Value', false)
            set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')

            set(ui_matrix_histogram_checkbox, 'Value', false)
            set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')

            set(ui_matrix_density_checkbox, 'Value', false)
            set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
            set(ui_matrix_density_edit, 'Enable', 'off')
            set(ui_matrix_density_slider, 'Enable', 'off')

            set(ui_matrix_threshold_checkbox, 'Value', true)
            set(ui_matrix_threshold_checkbox, 'FontWeight', 'bold')
            set(ui_matrix_threshold_edit, 'Enable', 'on')
            set(ui_matrix_threshold_slider, 'Enable', 'on')

            update_matrix()
        end
        function cb_matrix_histogram_checkbox(~, ~)
            set(ui_matrix_weighted_checkbox, 'Value', false)
            set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')

            set(ui_matrix_histogram_checkbox, 'Value', true)
            set(ui_matrix_histogram_checkbox, 'FontWeight', 'bold')

            set(ui_matrix_density_checkbox, 'Value', false)
            set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
            set(ui_matrix_density_edit, 'Enable', 'off')
            set(ui_matrix_density_slider, 'Enable', 'off')

            set(ui_matrix_threshold_checkbox, 'Value', false)
            set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
            set(ui_matrix_threshold_edit, 'Enable', 'off')
            set(ui_matrix_threshold_slider, 'Enable', 'off')

            update_matrix()
        end
        function cb_matrix_density_edit(~, ~)
            update_matrix();
        end
        function cb_matrix_density_slider(src, ~)
            set(ui_matrix_density_edit, 'String', get(src, 'Value'))
            update_matrix();
        end
        function cb_matrix_threshold_edit(~, ~)
            update_matrix();
        end
        function cb_matrix_threshold_slider(src, ~)
            set(ui_matrix_threshold_edit, 'String', get(src, 'Value'))
            update_matrix();
        end
        function update_matrix()
            % get A and layer
            A = pr.get('GRAPH').get('A');
            layer_to_plot = pr.get('Layer');
            % i need to ask graph to return the plot 'Graph.PlotType'
            if  get(ui_matrix_histogram_checkbox, 'Value') % histogram
                if size(A, 2) > 1
                    pr.h_plot = pr.hist(A{layer_to_plot, layer_to_plot});
                else
                    pr.h_plot = pr.hist(A{layer_to_plot});
                end
            elseif get(ui_matrix_threshold_checkbox, 'Value')  % threshold
                if size(A, 2) > 1
                    pr.h_plot = pr.plotb(A{layer_to_plot, layer_to_plot}, ...
                        'threshold', ...
                        str2double(get(ui_matrix_threshold_edit, 'String')));
                else
                    pr.h_plot = pr.plotb(A{layer_to_plot}, ...
                        'threshold', ...
                        str2double(get(ui_matrix_threshold_edit, 'String')));
                end
            elseif get(ui_matrix_density_checkbox, 'Value')  % density
                if size(A, 2) > 1
                    pr.h_plot = pr.plotb(A{layer_to_plot, layer_to_plot}, ...
                        'density', ...
                        str2double(get(ui_matrix_density_edit, 'String')));
                else
                    pr.h_plot = pr.plotb(A{layer_to_plot}, ...
                        'density', ...
                        str2double(get(ui_matrix_density_edit, 'String')));
                end
            else  % weighted correlation
                if size(A, 2) > 1
                    pr.h_plot = pr.plotw(A{layer_to_plot, layer_to_plot});
                else
                    pr.h_plot = pr.plotw(A{layer_to_plot});
                end
            end
        end

    update_matrix()

    if nargout > 0
        graph_panel = matrix_plot;
    end
end
function h = plotw(pr, A, varargin)
    % PLOTW plots a weighted matrix
    %
    % H = PLOTW(A) plots the weighted matrix A and returns the handle to
    %   the plot H.
    %
    % H = PLOTW(A,'PropertyName',PropertyValue) sets the property of the
    %   matrix plot PropertyName to PropertyValue.
    %   All standard plot properties of surf can be used.
    %   Additional admissive properties are:
    %       xlabels   -   1:1:number of matrix elements (default)
    %       ylabels   -   1:1:number of matrix elements (default)
    %
    % See also Graph, plotb, surf.

    N = length(A);

    % x labels
    xlabels = (1:1:N);
    for n = 1:2:length(varargin)
        if strcmpi(varargin{n}, 'xlabels')
            xlabels = varargin{n + 1};
        end
    end
    if ~iscell(xlabels)
        xlabels = {xlabels};
    end

    % y labels
    ylabels = (1:1:N);
    for n = 1:2:length(varargin)
        if strcmpi(varargin{n}, 'ylabels')
            ylabels = varargin{n + 1};
        end
    end
    if ~iscell(ylabels)
        ylabels = {ylabels};
    end

    ht = surf('Parent', pr.h_axes, ...
        (0:1:N), ...
        (0:1:N), ...
        [A, zeros(size(A, 1), 1); zeros(1, size(A, 1) + 1)]);
    view(pr.h_axes, 2)
    colorbar(pr.h_axes)
    shading(pr.h_axes, 'flat')
    axis(pr.h_axes, 'equal', 'square', 'tight')
    grid(pr.h_axes, 'off')
    box(pr.h_axes, 'on')
    set(pr.h_axes, ...
        'XAxisLocation', 'top', ...
        'XTick', (1:1:N) - .5, ...
        'XTickLabel', {}, ...
        'YAxisLocation', 'left', ...
        'YDir', 'Reverse', ...
        'YTick', (1:1:N) - .5, ...
        'YTickLabel', ylabels)

    if ~verLessThan('matlab', '8.4.0')
        set(pr.h_axes, ...
            'XTickLabelRotation', 90, ...
            'XTickLabel', xlabels)
    else
        t = text('Parent', pr.h_axes, (1:1:N) - .5, zeros(1, N), xlabels);
        set(t, ...
            'HorizontalAlignment', 'left', ...
            'VerticalAlignment', 'middle', ...
            'Rotation', 90);
    end

    colormap(pr.h_axes, 'jet')

    % output if needed
    if nargout > 0
        h = ht;
    end
end
function h = plotb(pr, A, varargin)
    % PLOTB plots a binary matrix
    %
    % H = PLOTB(A) plots the binarized version of weighted matrix A and
    %   returns the handle to the plot H.
    %   The matrix A can be binarized by fixing the threshold
    %   (default, threshold = 0.5).
    %
    % H = PLOTB(A, 'PropertyName', PropertyValue) sets the property of the
    %   matrix plot PropertyName to PropertyValue.
    %   All standard plot properties of surf can be used.
    %   Additional admissive properties are:
    %       threshold   -   0.5 (default)
    %       xlabels     -   1:1:number of matrix elements (default)
    %       ylabels     -   1:1:number of matrix elements (default)
    %
    % See also Graph, binarize, plotw, surf.

    N = length(A);

    % threshold
    threshold = get_from_varargin(0, 'threshold', varargin{:});

    % density
    density = get_from_varargin([], 'density', varargin{:});

    % x labels
    xlabels = (1:1:N);
    for n = 1:2:length(varargin)
        if strcmpi(varargin{n}, 'xlabels')
            xlabels = varargin{n + 1};
        end
    end
    if ~iscell(xlabels)
        xlabels = {xlabels};
    end

    % y labels
    ylabels = (1:1:N);
    for n = 1:2:length(varargin)
        if strcmpi(varargin{n}, 'ylabels')
            ylabels = varargin{n + 1};
        end
    end
    if ~iscell(ylabels)
        ylabels = {ylabels};
    end

    B = binarize(A, 'threshold', threshold, 'density', density);

    ht = surf('Parent', pr.h_axes, ...
        (0:1:N), ...
        (0:1:N), ...
        [B, zeros(size(B, 1), 1); zeros(1, size(B, 1) + 1)]);
    view(pr.h_axes, 2)
    shading(pr.h_axes, 'flat')
    axis(pr.h_axes, 'equal', 'square', 'tight')
    grid(pr.h_axes, 'off')
    colorbar(pr.h_axes)
    box(pr.h_axes, 'on')
    set(pr.h_axes, ...
        'XAxisLocation', 'top',  ...
        'XTick', (1:1:N) - .5, ...
        'XTickLabel', {},  ...
        'YAxisLocation', 'left',  ...
        'YDir', 'Reverse',  ...
        'YTick', (1:1:N) - .5, ...
        'YTickLabel', ylabels)

    if ~verLessThan('matlab',  '8.4.0')
        set(pr.h_axes, ...
            'XTickLabelRotation',90, ...
            'XTickLabel', xlabels)
    else
        t = text('Parent', pr.h_axes, (1:1:N) - .5, zeros(1,N), xlabels);
        set(t, ...
            'HorizontalAlignment', 'left',  ...
            'VerticalAlignment', 'middle',  ...
            'Rotation',90);
    end

    colormap(pr.h_axes, 'bone')

    % output if needed
    if nargout > 0
        h = ht;
    end
end
function h = hist(pr, A, varargin)
    % HIST plots the histogram and density of a matrix
    %
    % H = HIST(A) plots the histogram of a matrix A and the associated density and
    %   returns the handle to the plot H.
    %
    % H = HIST(A,'PropertyName',PropertyValue) sets the property of the histogram
    %   plot PropertyName to PropertyValue.
    %   All standard plot properties of surf can be used.
    %   Additional admissive properties are:
    %       bins       -   -1:.001:1 (default)
    %       diagonal   -   'exclude' (default) | 'include'
    %
    % See also Graph, histogram.

    [count, bins, density] = histogram(A, varargin{:});

    bins = [bins(1) bins bins(end)];
    count = [0 count 0];
    density = [100 density 0];

    hold(pr.h_axes, 'on')
    ht1 = fill(pr.h_axes, bins, count, 'k');
    ht2 = plot(bins, density, 'b', 'linewidth', 2, 'Parent', pr.h_axes);
    hold(pr.h_axes, 'off')
    xlabel(pr.h_axes, 'coefficient values / threshold')
    ylabel(pr.h_axes, 'coefficient counts / density')

    grid(pr.h_axes, 'off')
    box(pr.h_axes, 'on')
    colorbar(pr.h_axes, 'off')
    axis(pr.h_axes, 'square', 'tight')
    set(pr.h_axes, ...
        'XAxisLocation', 'bottom',  ...
        'XTickLabelMode', 'auto',  ...
        'XTickMode', 'auto',  ...
        'YTickLabelMode', 'auto',  ...
        'YAxisLocation', 'left',  ...
        'YDir', 'Normal',  ...
        'YTickMode', 'auto',  ...
        'YTickLabelMode', 'auto')

    % output if needed
    if nargout > 0
        h = [ht1 ht2];
    end
end