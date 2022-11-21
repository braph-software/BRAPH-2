%% ¡header!
GraphP < Graph (g, preview weighted undirected graph) is a preview weighted undirected graph.

%% ¡description!
In a graph with weighted values in the diagonal

%% ¡graph!
graph = Graph.GRAPH;

%% ¡connectivity!
connectivity = Graph.WEIGHTED;

%% ¡directionality!
directionality = Graph.UNDIRECTED;

%% ¡selfconnectivity!
selfconnectivity = Graph.NONSELFCONNECTED;

%% ¡negativity!
negativity = Graph.NONNEGATIVE;

% ¡props!

%% ¡prop!
B (data, smatrix) is the input graph adjacency matrix.
%%% ¡gui!
bas = g.get('BAS');
if ~isempty(bas)
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
else
    rowname = '{}';
end

pr = PanelPropMatrix('EL', g, 'PROP', GraphP.B, ...
    'ROWNAME', rowname, ...
    'COLUMNNAME', rowname, ...
    varargin{:});


% ¡props_update!

%% ¡prop!
TEMPLATE (parameter, item) is the graph template to set the graph and measure parameters.
%%% ¡settings!
'GraphP'

%% ¡prop!
A (result, cell) is the symmetric non-negative adjacency matrix of the weighted undirected graph.
%%% ¡calculate!
B = g.get('B');

varargin = {}; %% TODO add props to manage the relevant properties of symmetrize, dediagonalize, semipositivize, standardize
B = symmetrize(B, varargin{:}); %% enforces symmetry of adjacency matrix
B = diag(B, varargin{:}); %% preserve only diagonal values 
B = semipositivize(B, varargin{:}); %% removes negative weights
B = standardize(B, varargin{:}); %% ensures all weights are between 0 and 1

A = {B};
value = A;
%%% ¡gui!
bas = g.get('BAS');
if ~isempty(bas)
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
else
    rowname = '{}';
end

pr = PanelPropCell('EL', g, 'PROP', GraphP.A, ...
    'TAB_H', 40, ...
    'XSLIDER', false, 'YSLIDER', false, ...
    'ROWNAME', rowname, ...
    'COLUMNNAME', rowname, ...
    varargin{:});

    RANDOMIZE returns a randomized graph and the correlation coefficients
    
    RANDOM_G = RANDOMIZE(G) returns the randomized graph
    RANDOM_G obtained with a randomized correlation
    matrix via the static function randomize_A.
    
    RANDOM_G = RANDOMIZE(G, 'AttemptPerEdge', VALUE, 'NumberOfWeights', VALUE)
    returns the randomized graph RANDOM_G obtained with a randomized correlation
    matrix via the static function randomize_A, it passes the
    attempts per edge and the number of weights specified by the user.
    
    See also randomize_A

    get rules
    number_of_weights = g.get('NUMBEROFWEIGHTS');
    attempts_per_edge = g.get('ATTEMPTSPEREDGE');

    correction for multigraphs
    if Graph.is_multigraph(g)
        tmp_b = g.get('B');
        tmp_g = GraphWU('B', tmp_b);
        tmp_A = cell2mat(tmp_g.get('A'));
        random_B = GraphWU.randomize_A(tmp_A, attempts_per_edge, number_of_weights);
        if isa(g, 'MultigraphBUD')
            random_g = MultigraphBUD('B', random_B, 'Densities', g.get('Densities'));
        else
            random_g = MultigraphBUT('B', random_B, 'Thresholds', g.get('Thresholds'));
        end
    else
        A = cell2mat(g.get('A'));
        random_A = GraphWU.randomize_A(A, attempts_per_edge, number_of_weights);
        random_g = GraphWU('B', random_A);
    end
end
