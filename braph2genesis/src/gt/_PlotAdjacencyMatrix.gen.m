%% ¡header!
PlotAdjacencyMatrix < Plot (pr, plot graph) is a plot of the adjacency matrix of the graph.

%%% ¡description!
Plot is the plot of adjacency matrix of the graph.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pr.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
h_plot
pp
h_settings

%% ¡props!

%%% ¡prop!
SUBMENU (metadata, logical) to set a submenu
%%%% ¡default!
false

%%% ¡prop!
G_DICT (data, idict) is the dictionary that contains the graphs been ploted
%%%% ¡settings!
'Graph'

%%% ¡prop!
LAYER (metadata, scalar) is the layer to be ploted
%%%% ¡default!
1

%%% ¡prop!
SUBJECT (metadata, scalar) is the subject to be ploted
%%%% ¡default!
1

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
    
    % overwrite close req
    set(pr.pp, 'DeleteFcn', {@cb_close_fs})
    
    function cb_close_fs(~, ~)
        if ~isempty(pr.h_settings) && check_graphics(pr.h_settings, 'figure')
            close(pr.h_settings)
        end
    end
    
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
    pr.h_settings = f;
    
    set(f, 'Toolbar', 'none')
    
    % panel
    ui_parent = pr.h_settings;
    ui_parent_axes = pr.h_axes;
    matrix_plot = pr.h_plot;
    
    g_dict = pr.get('G_DICT');
    g_check = g_dict.length();
    tmp_g = g_dict.getItem(1);
    if iscell(tmp_g.get('B'))
        layer_check = size(tmp_g.get('B'), 2);
    else
        layer_check = 1;
    end
    
    % new part layers and subjects
    mod = 0;
    if g_check > 1
        mod = mod + .1; % substract from height to all uicontrols
        
        subject_selector_id = uicontrol(ui_parent, ...
            'Style', 'text', ...
            'Units', 'normalized', ...
            'String', 'Subject Selection', ...
            'BackgroundColor', pr.h_settings.Color, ...
            'Position', [.02 .82 .3 .07]);
        
        subject_list = cellfun(@(x) ['Subject: ' num2str(x)], num2cell([1:g_check]), 'UniformOutput', false);
        subject_select_popup = uicontrol('Parent', ui_parent, ...
            'Style', 'popupmenu', ...
            'Units', 'normalized', ...            
            'Position', [.33 .82 .3 .07], ...
            'String', subject_list, ...
            'TooltipString', 'Select a subject.', ...
            'Callback', {@cb_subject_index} ...
            );
    end
    
    function cb_subject_index(~, ~)
        val = subject_select_popup.Value;
        str = subject_select_popup.String;
        pr.set('subject', val); 
        update_matrix();
    end

    if layer_check > 1 
        layer_selector_id = uicontrol(ui_parent, ...
            'Style', 'text', ...
            'Units', 'normalized', ...
            'String', 'Layer Selection', ...
            'BackgroundColor', pr.h_settings.Color, ...
            'Position', [.02 .82-mod .3 .07]);
        
        layer_list = cellfun(@(x) ['Layer: ' num2str(x)], num2cell([1:layer_check]), 'UniformOutput', false);
        layer_select_popup = uicontrol('Parent', ui_parent, ...
            'Style', 'popupmenu', ...
            'Units', 'normalized', ...            
            'Position', [.33 .82-mod .3 .07], ...
            'String', layer_list, ...
            'TooltipString', 'Select a layer.', ...
            'Callback', {@cb_layer_index} ...
            );
        
        mod = mod + .1;
    end
    
    function cb_layer_index(~, ~)
        val = layer_select_popup.Value;
        str = layer_select_popup.String;
        pr.set('layer', val);
        update_matrix();
    end
    
    ui_matrix_weighted_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
    set(ui_matrix_weighted_checkbox, 'Position', [.02 .82-mod .3 .07], ...
        'String', 'weighted correlation matrix', ...
        'Value', true, ...
        'TooltipString', 'Select weighted matrix', ...
        'FontWeight', 'bold', ...
        'Callback', {@cb_matrix_weighted_checkbox})
    
    % density
    ui_matrix_density_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
    set(ui_matrix_density_checkbox, 'Position', [.02 .7-mod .3 .07], ...
        'String', 'binary correlation matrix (set density)', ...
        'Value', false,...
        'TooltipString', 'Select binary correlation matrix with a set density', ...
        'Callback', {@cb_matrix_density_checkbox})
    
    ui_matrix_density_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
    set(ui_matrix_density_edit, 'Position', [.02 .6-mod .3 .07], ...
        'String', '50.00', ...
        'TooltipString', 'Set density.', ...
        'FontWeight', 'bold', ...
        'Enable', 'off', ...
        'Callback', {@cb_matrix_density_edit});
    
    ui_matrix_density_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
    set(ui_matrix_density_slider, 'Position', [.33 .6-mod .3 .07], ...
        'Min', 0, 'Max', 100, 'Value', 50, ...
        'TooltipString', 'Set density.', ...
        'Enable', 'off', ...
        'Callback', {@cb_matrix_density_slider})
    
    % threshold
    ui_matrix_threshold_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
    set(ui_matrix_threshold_checkbox, 'Position', [.02 .5-mod .3 .07],...
        'String', 'binary correlation matrix (set threshold)', ...
        'Value', false, ...
        'TooltipString', 'Select binary correlation matrix with a set threshold', ...
        'Callback', {@cb_matrix_threshold_checkbox})
    
    ui_matrix_threshold_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
    set(ui_matrix_threshold_edit, 'Position', [.02 .4-mod .3 .07], ...
        'String', '0.50', ...
        'TooltipString', 'Set threshold.', ...
        'FontWeight', 'bold' ,...
        'Enable', 'off', ...
        'Callback', {@cb_matrix_threshold_edit});
    
    ui_matrix_threshold_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
    set(ui_matrix_threshold_slider, 'Position', [.33 .4-mod .3 .07], ...
        'Min', -1, 'Max', 1, 'Value', .50, ...
        'TooltipString', 'Set threshold.', ...
        'Enable', 'off', ...
        'Callback', {@cb_matrix_threshold_slider})
    
    % histogram
    ui_matrix_histogram_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
    set(ui_matrix_histogram_checkbox, 'Position', [.02 .33-mod .1 .07],...
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
        g_dict_item = pr.get('G_DICT').getItem(pr.get('Subject'));
        A = g_dict_item.get('B');
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
            if iscell(A) && size(A, 2) > 1
                pr.h_plot = pr.plotw(A{layer_to_plot, layer_to_plot});
            elseif iscell(A)
                pr.h_plot = pr.plotw(A{layer_to_plot});
            else
                pr.h_plot = pr.plotw(A);
            end
        end
    end

update_matrix()

if nargout > 0
    f_settings = pr.h_settings;
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