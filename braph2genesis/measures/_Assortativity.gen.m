%% ¡header!
Assortativity < Measure (m, assortativity) is the graph assortativity.

%%% ¡description!
The assortativity coefficient of a graph is the correlation coefficient 
between the degrees/strengths of all nodes on two opposite ends of an edge within a layer.
The corresponding coefficient for directed and weighted networks is calculated
by using the weighted and directed variants of degree/strength.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphBU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the assortativity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();

assortativity = cell(L, 1);
connectivity_type =  g.getConnectivityType(g.layernumber());
for li = 1:1:L
    Aii = A{li, li};
    [i, j] = find(triu(Aii) ~= 0);  % nodes [i, j]
    M = length(i);  % Number of edges
    k_i = zeros(M, L);
    k_j = zeros(length(j), L);
    
    if connectivity_layer == Graph.BINARY 
        
        degree = Degree('G', g).get('M');        
        d = degree{li};
        
    elseif connectivity_layer == Graph.WEIGHTED 
        
        strength = Strength('G', g).get('M');        
        d = strength{li};
    end
    k_i(:, li) = d(i);  % degree/strength node i
    k_j(:, li) = d(j);  % degree/strength node j
    % compute assortativity
    assortativity_layer = (sum(k_i(:, li) .* k_j(:, li)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2)...
        / (sum(0.5 * (k_i(:, li).^2 + k_j(:, li).^2)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2);
    assortativity_layer(isnan(assortativity_layer)) = 0;  % Should return zeros, not NaN
    assortativity(li) = {assortativity_layer};
end

value = assortativity;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B_BU = [
    1 1 0 0 1;
    1 1 1 1 0;
    0 1 1 1 0;
    0 1 1 1 1;
    1 0 0 1 0];
assortativity_BU = (37/6-(15/6)^2)/(39/6-(15/6)^2);

g = GraphBU('B', B_BU);

assortativity_1 = Assortativity('G', g);
assortativity_2 = assortativity_BU;
assert(isequal(assortativity_1.get('M'), assortativity_BU), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.BUG_ERR], ...
    'Assortativity is not being calculated correctly for GraphBU')

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B_WU = [
    1 2 0 0 1;
    2 1 3 2 0;
    0 3 1 1 0;
    0 2 1 1 2;
    1 0 0 2 1];

assortativity_WU_compress = (14.222222/6-(9.333333/6)^2)/(16.111111/6-(9.333333/6)^2);

g = GraphWU('B', B_WU);

assortativity_1 = Assortativity('G', g);
assert(isequal(assortativity_1.get('M'), assortativity_WU_compress), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.BUG_ERR], ...
    'Assortativity is not being calculated correctly for GraphBU')
