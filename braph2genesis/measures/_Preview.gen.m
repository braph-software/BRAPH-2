%% ¡header!
Preview < Measure (m, degree) is the graph preview comparison.

%%% ¡description!
The Preview measure is used to calculate comparisons on raw group data.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphP

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
value = A;