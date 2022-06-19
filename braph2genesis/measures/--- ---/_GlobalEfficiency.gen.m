%% ¡header!
GlobalEfficiency < Measure (m, global efficiency) is the graph global efficiency.

%%% ¡description!
The global efficiency is the average inverse shortest path length within each layer.
It is inversely related to the characteristic path length.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphBU
MultigraphBUD
MultigraphBUT
MultiplexWU
MultiplexBU
MultiplexBUD
MultiplexBUT

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
N = g.nodenumber();
L = g.layernumber();

distance = Distance('G', g).get('M');

global_efficiency = cell(L, 1);
for li = 1:1:L
    inverse_distance = distance{li}.^-1;  % inverse distance
    inverse_distance(1:N(li)+1:end) = 0;
    global_efficiency_layer = (sum(inverse_distance, 2) / (N(li)-1));
    global_efficiency(li) = {global_efficiency_layer};
end
value = global_efficiency;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

g = GraphBU('B', B);
global_efficiency = GlobalEfficiency('G', g).get('M');

assert(isequal(global_efficiency, known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiency is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];

B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B = {B11  B22};

known_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
                        };


g = MultiplexBU('B', B);
global_efficiency = GlobalEfficiency('G', g).get('M');

assert(isequal(global_efficiency, known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiency is not being calculated correctly for MultiplexBU.')