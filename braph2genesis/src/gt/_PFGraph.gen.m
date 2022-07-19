%% ¡header!
PFGraph < PanelFig (pf, panel figure graph) is a plot of a graph.

%%% ¡description!
% % % PFGraph manages the plot of the single layer graph. 
% % % This class provides the common methods needed to manage the plot of 
% % % the graph. 

%%% ¡seealso!
PanelFig, Graph

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

toolbar
tool_grid
tool_axis
tool_weighted
tool_binary
tool_hist
tool_colorbar

h_plot

%% ¡props!

%%% ¡prop!
G (metadata, item) is the graph.
%%%% ¡settings!
'Graph'

%%% ¡prop!
ST_AXIS (figure, item) determines the axis settings.
%%%% ¡settings!
'SettingsAxis'
%%%% ¡default!
SettingsAxis('GRID', false, 'EQUAL', false)
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('ST_AXIS', varargin)) && check_graphics(pf.h_axes, 'axes')
    % update state of toggle tool
    set(pf.tool_grid, 'State', pf.get('ST_AXIS').get('GRID'))

    % update state of toggle tool
    set(pf.tool_axis, 'State', pf.get('ST_AXIS').get('AXIS'))
end
%%%% ¡gui!
pr = SettingsAxisPP('EL', pf, 'PROP', PFGraph.ST_AXIS, varargin{:});

%%% ¡prop!
STYLE (figure, option) is the x-coordinate.
%%%% ¡settings!
{'parula', 'turbo', 'hsv', 'hot', 'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', 'cooper', 'pink', 'jet', 'lines', 'prism', 'flag', 'white'}
%%%% ¡default!
'jet'
%%%% ¡postprocessing!
if pf.prop_set('STYLE', varargin) && ~braph2_testing
    pf.draw()
end

%%% ¡prop!
ST_COLORMAP (figure, item) determines the colormap settings.
%%%% ¡settings!
'SettingsGraph'
%%%% ¡default!
SettingsGraph('WEIGHTED', true, 'BINARY', false, 'HIST', false, 'COLORBAR', true)
%%%% ¡postprocessing!
if check_graphics(pf.h_plot, 'surface')
        
    % update state of toggle tool
    set(pf.tool_weighted, 'State', pf.get('ST_COLORMAP').get('WEIGHTED'))

    % update state of toggle tool
    set(pf.tool_binary, 'State', pf.get('ST_COLORMAP').get('BINARY'))
    
    % update state of toggle tool
    set(pf.tool_hist, 'State', pf.get('ST_COLORMAP').get('HIST'))
    
    % update state of toggle tool
    set(pf.tool_colorbar, 'State', pf.get('ST_COLORMAP').get('COLORBAR'))
    
    if pf.get('ST_COLORMAP').get('COLORBAR')
        colorbar('Parent', pf.p, ...
            'Direction', 'normal', ...
            'Location', 'eastoutside', ...
            'AxisLocation', 'out' ...            
            )
    else
        colorbar('Parent', pf.p, ...
            'off')
    end
end
%%%% ¡gui!
pr = SettingsGraphPP('EL', pf, 'PROP', PFGraph.ST_COLORMAP, varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PanelFig(pf, varargin{:});
    
    % axes
    if ~check_graphics(pf.h_axes, 'axes')
        pf.h_axes = uiaxes( ...
            'Parent', pf.p, ...
            'Tag', 'h_axes', ...
            'Units', 'normalized', ...
            'OuterPosition', [0 0 1 1] ...
            );
        pf.h_axes.Toolbar.Visible = 'off';
        pf.h_axes.Interactions = [];
    end
    
    pf.memorize('ST_AXIS').h(pf.h_axes).set('PANEL', pf, 'UITAG', 'h_axes')
    listener(pf.get('ST_AXIS'), 'PropSet', @cb_st_axis);
    function cb_st_axis(~, ~) % (src, event)
        set(pf.tool_axis, 'State', pf.get('ST_AXIS').get('AXIS'))
        set(pf.tool_grid, 'State', pf.get('ST_AXIS').get('GRID'))
    end
    
    % Toolbar
    if ~check_graphics(pf.toolbar, 'uitoolbar')
        pf.toolbar = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'ToolBar');
    end
    
    if check_graphics(pf.toolbar, 'uitoolbar') && ~check_graphics(pf.tool_axis, 'uitoggletool') % implies that also the other tools are not defined
        
        uipushtool(pf.toolbar, 'Separator', 'on', 'Visible', 'off')

        % Axis
        pf.tool_axis = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_axis', ...
            'State', pf.get('ST_AXIS').get('AXIS'), ...
            'Tooltip', 'Show axis', ...
            'CData', imread('icon_axis.png'), ...
            'OnCallback', {@cb_axis, true}, ...
            'OffCallback', {@cb_axis, false});
        
        % Grid
        pf.tool_grid = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_grid', ...
            'State', pf.get('ST_AXIS').get('GRID'), ...
            'Tooltip', 'Show grid', ...
            'CData', imread('icon_grid.png'), ...
            'OnCallback', {@cb_grid, true}, ...
            'OffCallback', {@cb_grid, false});
    end
    function cb_axis(~, ~, axis) % (src, event)
        pf.get('ST_AXIS').set('AXIS', axis);
    end
    function cb_grid(~, ~, grid) % (src, event)
        pf.get('ST_AXIS').set('GRID', grid);
    end


    % colormap listener
    pf.memorize('ST_COLORMAP').h(pf.h_axes).set('PANEL', pf, 'UITAG', 'h_axes')
    listener(pf.get('ST_COLORMAP'), 'PropSet', @cb_st_colormap);
    function cb_st_colormap(~, ~) % (src, event)
        set(pf.tool_weighted, 'State', pf.get('ST_COLORMAP').get('WEIGHTED'))
        set(pf.tool_binary, 'State', pf.get('ST_COLORMAP').get('BINARY'))
        set(pf.tool_hist, 'State', pf.get('ST_COLORMAP').get('HIST'))
        set(pf.tool_colorbar, 'State', pf.get('ST_COLORMAP').get('COLORBAR'))        
    end

    if check_graphics(pf.toolbar, 'uitoolbar') && ~check_graphics(pf.tool_weighted, 'uitoggletool')
        % WEIGHTED
        pf.tool_weighted = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_weighted', ...
            'State', pf.get('ST_COLORMAP').get('WEIGHTED'), ...
            'Tooltip', 'Show weighted plot', ...
            'CData', imread('icon_weighted.png'), ...
            'OnCallback', {@cb_weighted, true}, ...
            'OffCallback', {@cb_weighted, false});
        
        % BINARY
        pf.tool_binary = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_binary', ...
            'State', pf.get('ST_COLORMAP').get('BINARY'), ...
            'Tooltip', 'Show binary plot', ...
            'CData', imread('icon_binary.png'), ...
            'OnCallback', {@cb_binary, true}, ...
            'OffCallback', {@cb_binary, false});
        
        % BINARY
        pf.tool_hist = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_hist', ...
            'State', pf.get('ST_COLORMAP').get('HIST'), ...
            'Tooltip', 'Show histogram plot', ...
            'CData', imread('icon_hist.png'), ...
            'OnCallback', {@cb_hist, true}, ...
            'OffCallback', {@cb_hist, false});
        
        % COLORBAR
        pf.tool_colorbar = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_colorbar', ...
            'State', pf.get('ST_COLORMAP').get('COLORBAR'), ...
            'Tooltip', 'Show colorbar', ...
            'CData', imread('icon_colorbar.png'), ...
            'OnCallback', {@cb_bar, true}, ...
            'OffCallback', {@cb_bar, false});
    end
    
    function cb_weighted(~, ~, statement) % (src, event)
        pf.get('ST_COLORMAP').set('WEIGHTED', statement);
        % reverse buttons
        if statement
            set(pf.tool_binary, 'State', false)
            set(pf.tool_hist, 'State', false)
            pf.draw()
        end
    end
    function cb_binary(~, ~, statement) % (src, event)
        pf.get('ST_COLORMAP').set('BINARY', statement);
        % reverse buttons
        if statement
            set(pf.tool_weighted, 'State', false)
            set(pf.tool_hist, 'State', false)
            pf.draw()
        end
    end
    function cb_hist(~, ~, statement) % (src, event)
        pf.get('ST_COLORMAP').set('HIST', statement);
        if statement
            set(pf.tool_weighted, 'State', false)
            set(pf.tool_binary, 'State', false)
            pf.draw()
        end
    end
    function cb_bar(~, ~, statement) % (src, event)
        pf.get('ST_COLORMAP').set('COLORBAR', statement);
        if statement
            pf.draw()
        end
    end
    
    % plot
    if pf.get('ST_COLORMAP').get('BINARY')
        pf.h_plot = pf.plotb(pf.get('G').get('A'));
    elseif pf.get('ST_COLORMAP').get('HIST')
        pf.h_plot = pf.hist(pf.get('G').get('A'));
    else
        pf.h_plot = pf.plotw(pf.get('G').get('A'));
    end

    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function str = tostring(pf, varargin)
    %TOSTRING string with information about the graph.
    %
    % STR = TOSTRING(PF) returns a string with information about the graph.
    %
    % STR = TOSTRING(PF, N) trims the string to the first N characters.
    %
    % STR = TOSTRING(PF, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also disp, tree.

    str = ['Plot ' pf.get('G').get('ID')];
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end
function h = plotw(pf, A, varargin)
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
    
    if iscell(A)
        A = cell2mat(A);
    end

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
    
    cla(pf.h_axes)

    ht = surf('Parent', pf.h_axes, ...
        (0:1:N), ...
        (0:1:N), ...
        [A, zeros(size(A, 1), 1); zeros(1, size(A, 1) + 1)]);
    view(pf.h_axes, 2)
    colorbar(pf.h_axes)
    shading(pf.h_axes, 'flat')
    axis(pf.h_axes, 'equal', 'square', 'tight')
    grid(pf.h_axes, 'off')
    box(pf.h_axes, 'on')
    set(pf.h_axes, ...
        'XAxisLocation', 'top', ...
        'XTick', (1:1:N) - .5, ...
        'XTickLabel', {}, ...
        'YAxisLocation', 'left', ...
        'YDir', 'Reverse', ...
        'YTick', (1:1:N) - .5, ...
        'YTickLabel', ylabels)

    if ~verLessThan('matlab', '8.4.0')
        set(pf.h_axes, ...
            'XTickLabelRotation', 90, ...
            'XTickLabel', xlabels)
    else
        t = text('Parent', pf.h_axes, (1:1:N) - .5, zeros(1, N), xlabels);
        set(t, ...
            'HorizontalAlignment', 'left', ...
            'VerticalAlignment', 'middle', ...
            'Rotation', 90);
    end

    colormap(pf.h_axes, pf.get('Style'))

    % output if needed
    if nargout > 0
        h = ht;
    end
end
function h = plotb(pf, A, varargin)
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

    if iscell(A)
        A = cell2mat(A);
    end
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
    
    cla(pf.h_axes)

    ht = surf('Parent', pf.h_axes, ...
        (0:1:N), ...
        (0:1:N), ...
        [B, zeros(size(B, 1), 1); zeros(1, size(B, 1) + 1)]);
    view(pf.h_axes, 2)
    shading(pf.h_axes, 'flat')
    axis(pf.h_axes, 'equal', 'square', 'tight')
    grid(pf.h_axes, 'off')
    colorbar(pf.h_axes)
    box(pf.h_axes, 'on')
    set(pf.h_axes, ...
        'XAxisLocation', 'top',  ...
        'XTick', (1:1:N) - .5, ...
        'XTickLabel', {},  ...
        'YAxisLocation', 'left',  ...
        'YDir', 'Reverse',  ...
        'YTick', (1:1:N) - .5, ...
        'YTickLabel', ylabels)

    if ~verLessThan('matlab',  '8.4.0')
        set(pf.h_axes, ...
            'XTickLabelRotation',90, ...
            'XTickLabel', xlabels)
    else
        t = text('Parent', pf.h_axes, (1:1:N) - .5, zeros(1,N), xlabels);
        set(t, ...
            'HorizontalAlignment', 'left',  ...
            'VerticalAlignment', 'middle',  ...
            'Rotation',90);
    end

    colormap(pf.h_axes, 'bone')

    % output if needed
    if nargout > 0
        h = ht;
    end
end
function h = hist(pf, A, varargin)
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
    
    if iscell(A)
        A = cell2mat(A);
    end

    [count, bins, density] = histogram(A, varargin{:});

    bins = [bins(1) bins bins(end)];
    count = [0 count 0];
    density = [100 density 0];

    hold(pf.h_axes, 'on')
    cla(pf.h_axes)
    ht1 = fill(pf.h_axes, bins, count, 'k');
    ht2 = plot(bins, density, 'b', 'linewidth', 2, 'Parent', pf.h_axes);
    hold(pf.h_axes, 'off')
    xlabel(pf.h_axes, 'coefficient values / threshold')
    ylabel(pf.h_axes, 'coefficient counts / density')

    grid(pf.h_axes, 'off')
    box(pf.h_axes, 'on')
    colorbar(pf.h_axes, 'off')
    axis(pf.h_axes, 'square', 'tight')
    set(pf.h_axes, ...
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
