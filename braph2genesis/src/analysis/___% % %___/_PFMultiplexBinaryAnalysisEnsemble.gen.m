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

    g_id = str2double(pf.get('G'));
    if isnan(g_id)
        g_id = pf.get('G');
    end
    [l, ls] = pf.get('A').get('G_DICT').getItem(1).layernumber();
    total_l = ls(1); % total multi-layers
    % choosen values
    l = str2double(pf.get('LAYER'));
    d = str2double(pf.get('DT'));
    % get correct index matrix
    index = total_l * (d - 1) + l;
    
    if isequal(g_id, 'Mean Graph')
        g_dict = pf.get('A').get('G_DICT');
        adjacency_matrix = 0;
        for i = 1:g_dict.length()
            g_temp = g_dict.getItem(i);
            multigraph = g_temp.get('A');
            correct_graph = multigraph{index, index};
            adjacency_matrix = adjacency_matrix + correct_graph;
        end
        correct_graph = adjacency_matrix ./ g_dict.length();
    elseif isnan(str2double(pf.get('G')))
        g_id = pf.get('G');
        graph = pf.get('A').get('G_DICT').getItem(g_id);
        multigraph = graph.get('A');
        correct_graph = multigraph{index, index};
    else
        graph = pf.get('A').get('G_DICT').getItem(g_id);
        multigraph = graph.get('A');
        correct_graph = multigraph{index, index};
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