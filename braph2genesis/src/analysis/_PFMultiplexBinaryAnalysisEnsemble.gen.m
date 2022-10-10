%% ¡header!
PFMultiplexBinaryAnalysisEnsemble < PFMultiAnalysisEnsemble (pf, panel figure multiplex) is a plot of a multiplex.

%%% ¡description!
% % % PFMultiplexGraph manages the plot of the multiplex layer graph. 
% % % This class provides the common methods needed to manage the plot of 
% % % the graph. 

%%% ¡seealso!
PanelFig, AnalysisEnsemble, MultiplexBUD, MultiplexBUT

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

h_plot

%% ¡props!

%%% ¡prop!
LAYER (figure, string) is the id of the selected layer.
%%%% ¡default!
'1'
%%%% ¡gui!
g = pf.get('A').get('G_DICT');
pr = PP_LayerEnsembleID('EL', pf, 'PROP', PFMultiplexBinaryAnalysisEnsemble.LAYER, ...
    'G', g, ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PFMultiAnalysisEnsemble(pf, varargin{:});
    % axes
    pf.h_axes = pf.get('ST_AXIS').h();

    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function h = plotAdjacency(pf)
    
    % select correct matrix, A is a [m m] where m is the number of layers * the number of densities,
    % the diagonal is where the info is kept   
    g_id = pf.get('G');
    L = length(graph.get('B')); % total layers
    D = length(graph.get(14)); % total densities or thresholds
    % choosen values
    l = str2double(pf.get('LAYER'));
    d = str2double(pf.get('DT'));

    % get correct matrix
    correct = (L*d) - (L-l);   

    if isequal(g_id, 'Mean Graph')
        g_dict = pf.get('A').get('G_DICT');
        adjacency_matrix = 0;
        for i = 1:g_dict.length()
            g_temp = g_dict.getItem(i);
            multigraph = g_temp.get('A');
            correct_graph = multigraph{correct, correct};
            adjacency_matrix = adjacency_matrix + correct_graph;
        end
        correct_graph = adjacency_matrix ./ g_dict.length();
    elseif isnan(str2double(pf.get('G')))
        g_id = pf.get('G');
        graph = pf.get('A').get('G_DICT').getItem(g_id);
        multigraph = graph.get('A');
        correct_graph = multigraph{correct, correct};
    else
        graph = pf.get('A').get('G_DICT').getItem(g_id);
        multigraph = graph.get('A');
        correct_graph = multigraph{correct, correct};
    end
    
    % plot
    if pf.get('ST_ADJACENCY').get('BINARY')
        h = pf.plotb(correct_graph);
    elseif pf.get('ST_ADJACENCY').get('HIST')
        h = pf.hist(correct_graph);
    else
        h = pf.plotw(correct_graph);
    end
end