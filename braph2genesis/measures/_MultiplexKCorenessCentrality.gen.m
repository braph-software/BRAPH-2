%% ¡header!
MultiplexKCorenessCentrality < Measure (m, multiplex k-coreness centrality) is the graph multiplex k-coreness centrality.

%%% ¡description!
The multiplex k-coreness centrality of a node is k if the node belongs to the k-core
but not to the (k+1)-core.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexWU
MultiplexWD
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex k-coreness centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    N = g.nodenumber();
    A = g.get('A'); % 2D-cell array (for multigraph, multiplex, etc.) 
    
    multiplex_k_coreness_centrality = cell(length(ls), 1);
    directionality_layer =  g.getDirectionalityType(l);
    for i = 1:1:length(ls)
        A_sum = zeros(N(1), N(1));
        for j = 1:1:length(l)
            A_sum = A_sum + A{j, j};
        end
        multiplex_coreness = zeros(1, N(1));
        for k = 1:N(1)
            m_k_core = m.calculate_multiplexkcore(A_sum, k, directionality_layer);
            ss = sum(m_k_core) > 0;
            multiplex_coreness(ss) = k;
        end
        multiplex_k_coreness_centrality(li) = {multiplex_coreness'};
    end
    value = multiplex_k_coreness_centrality;
end

%% ¡methods!
function m_k_core = calculate_multiplexkcore(m, A, k, directionality_layer)
% CALCULATE MKCORE calculates the multiplex k-core value of a supra-adjacency matrix
%
% MKCORE = CALCULATEMULTIPLEXKCORE(M, A, k, directionality_layer) returns
% the value of the multiplex k-core of a supra-adjacency matrix

iter = 0;
subAii = binarize(A);
while 1
    % get degrees of matrix
    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
        ovdeg = sum(subAii, 1)';  % degree undirected graphs
    else
        ovdeg = (sum(subAii, 1)' + sum(subAii, 2));  % degree directed
    end
    
    % find nodes with degree < k
    low_k_nodes = find((ovdeg < k) & (ovdeg > 0));
    
    % if none found -> stop
    if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
    
    % peel away found nodes
    iter = iter + 1;
    subAii(low_k_nodes, :) = 0;
    subAii(:, low_k_nodes) = 0;
end
m_k_core = subAii;  % add k-core of layer li
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
A11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

A22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
A = {A11 A22};

known_multiplexk_coreness_centrality = {
                        [4 4 4 3]'
                        [4 4 4 4]'
                        };

g = MultiplexBD('B', A);
multiplex_k_coreness_centrality = MultiplexKCorenessCentrality('G', g).get('M');

assert(isequal(multiplex_k_coreness_centrality, known_multiplexk_coreness_centrality), ...
    [BRAPH2.STR ':MultiplexKCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'MultiplexKCorenessCentrality is not being calculated correctly for MultiplexBD.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {A11 A22};
             
known_multiplexk_coreness_centrality = {
                        [2 2 2 1]'
                        [2 2 2 2]'
                        };        

g = MultiplexWU('B', A);
multiplex_k_coreness_centrality = MultiplexKCorenessCentrality('G', g).get('M');

assert(isequal(multiplex_k_coreness_centrality, known_multiplexk_coreness_centrality), ...
    [BRAPH2.STR ':MultiplexKCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'MultiplexKCorenessCentrality is not being calculated correctly for MultiplexWU.')