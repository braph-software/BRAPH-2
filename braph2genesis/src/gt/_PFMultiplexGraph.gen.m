%% ¡header!
PFMultiplexGraph < PFGraph (pf, panel figure multiplex) is a plot of a multiplex.

%%% ¡description!
% % % PFMultiplexGraph manages the plot of the multiplex layer graph. 
% % % This class provides the common methods needed to manage the plot of 
% % % the graph. 

%%% ¡seealso!
PanelFig, Graph, MultiplexWU

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

h_plot

%% ¡props!

%%% ¡prop!
LAYER (figure, string) is the id of the selected layer.
%%%% ¡default!
1
%%%% ¡gui!
g = pf.get('G');
pr = PP_LayerID('EL', pf, 'PROP', PFMultiGraph.DT, ...
    'G', g, ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PFGraph(pf, varargin{:});
    % axes
    pf.h_axes = pf.get('ST_AXIS').h();

    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function h = plotAdjacency(pf)
    
    % select correct matrix, A is a [n n] where n is the number of layers,
    % the diagonal is where the info is kept
    l = str2double(pf.get('LAYER'));
    multiplex = pf.get('G').get('A');    
    correct_graph = multiplex{l, l};
    % plot
    if pf.get('ST_ADJACENCY').get('BINARY')
        h = pf.plotb(correct_graph);
    elseif pf.get('ST_ADJACENCY').get('HIST')
        h = pf.hist(correct_graph);
    else
        h = pf.plotw(correct_graph);
    end
end