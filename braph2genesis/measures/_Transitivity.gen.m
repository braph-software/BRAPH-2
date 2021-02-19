%% ¡header!
Transitivity < Triangles (m, transitivity) is the graph transitivity.

%%% ¡description!
The transitivity of a graph is the fraction of triangles to the number 
of (unordered) triplets within a layer.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphWD
GraphBU
GraphBD
MultiplexGraphWU
MultiplexGraphWD
MultiplexGraphBU
MultiplexGraphBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the transitivity.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell array with adjacency matrix 

L = g.layernumber();

triangles = calculateValue@Triangles(m, prop);

transitivity = cell(L, 1);
directionality_type =  g.getDirectionalityType(g.layernumber());
for li = 1:1:L      
    Aii = A{li, li};
    if directionality_type == Graph.UNDIRECTED  % undirected graphs
        
        degree = Degree('G', g).get('M');
        
        transitivity_layer = 2 * sum(triangles{li}) ./ sum((degree{li} .* (degree{li} - 1)));
        
    else  % directed graphs
        
        in_degree = InDegree('G', g).get('M');
        
        out_degree = OutDegree('G', g).get('M');
        
        transitivity_layer = sum(triangles{li}) ./ sum(((out_degree{li} + in_degree{li}) .* (out_degree{li} + in_degree{li} - 1) - 2 * diag(Aii^2)));
    end
    transitivity_layer(isnan(transitivity_layer)) = 0;  % Should return zeros, not NaN
    transitivity(li) = {transitivity_layer};
end
value = transitivity;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_transitivity = {3/4};

g = GraphBU('B', B);
transitivity = Transitivity('G', g);

assert(isequal(transitivity.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBU
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {A11  A22};

known_transitivity = {3/4; 3/4};      

g = MultiplexGraphBU('B', A);
transitivity = Transitivity('G', g).get('M');

assert(isequal(transitivity, known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for MultiplexGraphBU.')