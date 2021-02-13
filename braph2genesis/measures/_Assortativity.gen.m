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

[i, j] = find(triu(A) ~= 0);  % nodes [i, j]
M = length(i);  % Number of edges

if isa(g, 'GraphBU')  % Binary undirected

    degree = Degree('G', g).get('M');

    k_i = degree(i);  % degree node i
    k_j = degree(j);  % degree node j
    
elseif isa(g, 'GraphWU')  % Weighted undirected
    
    strength = Strength('G', g).get('M');
    
    k_i = strength(i);  % strength node i
    k_j = strength(j);  % strength node j
end

% compute assortativity
assortativity = (sum(k_i .* k_j) / M - (sum(0.5 * (k_i + k_j)) / M)^2)...
    / (sum(0.5 * (k_i.^2 + k_j.^2)) / M - (sum(0.5 * (k_i + k_j)) / M)^2);
assortativity(isnan(assortativity)) = 0;  % Should return zeros, not NaN

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
