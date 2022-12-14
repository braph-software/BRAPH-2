%% ¡header!
MultiplexWU < Graph (g, multiplex weighted undirected graph) is a multiplex weighted undirected graph.

%%% ¡description!
In a multiplex weighted undirected (WU) graph, 
the edges are associated with a real number between 0 and 1 
indicating the strength of the connection, and they are undirected.
The connectivity matrix is symmetric.

%%% ¡graph!
graph = Graph.MULTIPLEX;

%%% ¡connectivity!
connectivity = Graph.WEIGHTED * ones(layernumber);

%%% ¡directionality!
directionality = Graph.UNDIRECTED * ones(layernumber);

%%% ¡selfconnectivity!
selfconnectivity = Graph.SELFCONNECTED * ones(layernumber);
selfconnectivity(1:layernumber+1:end) = Graph.NONSELFCONNECTED;

%%% ¡negativity!
negativity = Graph.NONNEGATIVE * ones(layernumber);

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
%%%% ¡default!
{[] []};

%%% ¡prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡default!
5

%%% ¡prop!
NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
%%%% ¡default!
10

%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the graph template to set the graph and measure parameters.
%%%% ¡settings!
'MultiplexWU'

%%% ¡prop!
A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted undirected graph.
%%%% ¡calculate!
B = g.get('B');
L = length(B); %% number of layers
A = cell(L, L);

varargin = {}; %% TODO add props to manage the relevant properties of dediagonalize, semipositivize, binarize
for i = 1:1:L
    M = symmetrize(B{i}, varargin{:}); %% enforces symmetry of adjacency matrix
    M = dediagonalize(M, varargin{:}); %% removes self-connections by removing diagonal from adjacency matrix
    M = semipositivize(M, varargin{:}); %% removes negative weights
    M = standardize(M, varargin{:}); %% enforces binary adjacency matrix
    A(i, i) = {M};
    if ~isempty(A{1, 1})
        for j = i+1:1:L
            A(i, j) = {eye(length(A{1, 1}))};
            A(j, i) = {eye(length(A{1, 1}))};
        end
    end
end

value = A;
%%%% ¡gui!
bas = g.get('BAS');
if ~isempty(bas)
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
else
    rowname = '{}';
end

if isempty(g.get('LAYERLABELS'))
    xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
    ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
else
    layerlabels = str2cell(g.get('LAYERLABELS'));
    xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
    ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
end

pr = PanelPropCell('EL', g, 'PROP', MultiplexWU.A, ...
    'TAB_H', 40, ...
    'XYSLIDERLOCK', true, ... 
    'XSLIDER', false, 'YSLIDER', true, ...
    'XSLIDERLABELS', xlayerlabels, 'YSLIDERLABELS', ylayerlabels, ...
    'XSLIDERHEIGHT', 3, 'YSLIDERWIDTH', 7, ...
    'ROWNAME', rowname, ...
    'COLUMNNAME', rowname, ...
    varargin{:});

%% ¡methods!
function random_g = randomize(g)
    % RANDOMIZE returns a randomized graph
    %
    % RANDOMIZED_G = RANDOMIZE(G) returns the randomized
    % graph RANDOM_G obtained with a randomized correlation
    % matrix via the static function randomize_A while preserving
    % degree distributions. The randomization it is done layer by
    % layer and then integrated in the 2-D supra-adjacency matrix
    % cell array.
    %
    % RANDOMIZED_G = RANDOMIZE(G, 'AttemptsPerEdge', VALUE)
    % returns the randomized graph RANDOM_G obtained with a
    % randomized correlation matrix via the static function
    % randomize_A while preserving  degree distributions.
    % The multiplex is randomized layer by layer where randomized
    % adjacency matrix of each layer are then integrated in the
    % 2-D supra-adjacency matrix cell array.
    %
    % See also GraphBD

    % get rules
    number_of_weights = g.get('NUMBEROFWEIGHTS');
    attempts_per_edge = g.get('ATTEMPTSPEREDGE');

    if nargin<2
        attempts_per_edge = 5;
    end

            % get A
            A = g.get('A');
            [l, ls] = g.layernumber();
              
            % special case for multiplexBUD and multiplexBUT
            if Graph.is_binary(g)
                tmp_b = g.get('B');
                tmp_g = MultiplexWU('B', tmp_b);
                tmp_A = tmp_g.get('A');
                random_multi_A = cell(1, ls(1));
                for li = 1:1:ls(1)
                    Aii = tmp_A{li, li};
                    random_A = GraphWU.randomize_A(Aii, attempts_per_edge, number_of_weights);
                    random_multi_A(li) = {random_A};
                end
                if isa(g, 'MultiplexBUD')
                    random_g = MultiplexBUD('B', random_multi_A, 'Densities', g.get('Densities'));
                else
                    random_g = MultiplexBUT('B', random_multi_A, 'Thresholds', g.get('Thresholds'));
                end
                
            else % multiplexWU
                random_multi_A = cell(1, l);
                for li = 1:1:l
                    Aii = A{li, li};
                    random_A = GraphWU.randomize_A(Aii, attempts_per_edge, number_of_weights);
                    random_multi_A(li) = {random_A};
                end
                random_g = MultiplexWU('B', random_multi_A);
            end
end


%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
A = rand(randi(10));
B = {A, A};
g = MultiplexWU('B', B);

A1 = symmetrize(standardize(semipositivize(dediagonalize(A))));
A = {A1, eye(length(A)); eye(length(A)), A1};

assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultiplexWU:' BRAPH2.BUG_ERR], ...
    'MultiplexWU is not constructing well.')