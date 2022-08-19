%% ¡header!
PFMultiAnalysisEnsemble < PFAnalysisEnsemble (pf, panel figure multigraph ensemble) is a plot of a multigraph ensemble.

%%% ¡description!
% % % PFGraph manages the plot of the single layer graph. 
% % % This class provides the common methods needed to manage the plot of 
% % % the graph. 

%%% ¡seealso!
PanelFig, AnalysisEnsemble, MultigraphBUT, MultigraphBUT

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

h_plot

%% ¡props_update!
%%% ¡prop!
ST_ADJACENCY (figure, item) determines the colormap settings.
%%%% ¡settings!
'SettingsGraph'
%%%% ¡default!
SettingsGraph('WEIGHTED', true, 'BINARY', false, 'BINARY_VALUE', 50, 'HIST', false, 'COLORBAR', true)
%%%% ¡postprocessing!
if check_graphics(pf.h_plot, 'surface')
        
    if pf.get('ST_ADJACENCY').get('COLORBAR')
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
pr = SettingsGraphPP('EL', pf, 'PROP', PFMultiAnalysisEnsemble.ST_ADJACENCY, varargin{:});

%% ¡props!

%%% ¡prop!
DT (figure, string) is the id of the selected density or layer.
%%%% ¡default!
'1'
%%%% ¡gui!
g = pf.get('A').get('G_DICT');
pr = PP_DTIDEnsemble('EL', pf, 'PROP', PFMultiAnalysisEnsemble.DT, ...
    'G', g, ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PFAnalysisEnsemble(pf, varargin{:});
    % axes
    pf.h_axes = pf.get('ST_AXIS').h();

    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function h = plotAdjacency(pf)

    % get subject graph
    g_id = str2double(pf.get('G'));
    if isnan(g_id)
        g_id = pf.get('G');
    end
    graph = pf.get('A').get('G_DICT').getItem(g_id);
    multigraph = graph.get('A');
    
    % select correct matrix from the multigraph
    index = str2double(pf.get('DT'));
    correct_graph = multigraph{index, index};
    
    % plot
    if pf.get('ST_ADJACENCY').get('BINARY')
        h = pf.plotb(correct_graph);
    elseif pf.get('ST_ADJACENCY').get('HIST')
        h = pf.hist(correct_graph);
    else
        h = pf.plotw(correct_graph);
    end
end