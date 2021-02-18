%% ¡header!
InGlobalEfficiency < Measure (m, in-global efficiency) is the graph in-global efficiency.

%%% ¡description!
The in-global efficiency is the average inverse shortest in-path length within each layer. 
It is inversely related to the characteristic in-path length.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
GraphBD
MultiplexGraphWD
MultiplexGraphBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the in-global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
N = g.nodenumber();
L = g.layernumber();

distance = Distance('G', g).get('M');

in_global_efficiency = cell(L, 1);
for li = 1:1:L
    inverse_distance = distance{li}.^-1;  % inverse distance
    inverse_distance(1:N(li)+1:end) = 0;
    global_efficiency_layer = (sum(inverse_distance, 2) / (N(li)-1));
    in_global_efficiency(li) = {global_efficiency_layer};
end
value = in_global_efficiency;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_in_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

g = GraphBD('B', B);
in_global_efficiency = InGlobalEfficiency('G', g).get('M');

assert(isequal(in_global_efficiency, known_in_global_efficiency), ...
    [BRAPH2.STR ':InGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiency is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWD
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

known_in_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
                        };


g = MultiplexGraphBD('B', B);
in_global_efficiency = InGlobalEfficiency('G', g).get('M');

assert(isequal(in_global_efficiency, known_in_global_efficiency), ...
    [BRAPH2.STR ':InGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiency is not being calculated correctly for MultiplexGraphBU.')