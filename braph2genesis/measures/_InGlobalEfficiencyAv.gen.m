%% ¡header!
InGlobalEfficiencyAv < InGlobalEfficiency (m, average in-global efficiency) is the graph average in-global efficiency.

%%% ¡description!
The average in-global efficiency is the average of the in-global efficiency
within each layer.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
GraphBD
MultiplexWD
MultiplexBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the in-global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

in_global_efficiency = calculateValue@InGlobalEfficiency(m, prop);

in_global_efficiency_av = cell(L, 1);
for li = 1:1:L
    in_global_efficiency_av(li) = {mean(in_global_efficiency{li})};
end
value = in_global_efficiency_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_in_global_efficiency_av = {mean([1/4 1/4 1/4 1/4 0])};

g = GraphBD('B', B);
in_global_efficiency = InGlobalEfficiencyAv('G', g).get('M');

assert(isequal(in_global_efficiency, known_in_global_efficiency_av), ...
    [BRAPH2.STR ':InGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiency is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
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

known_in_global_efficiency_av = {
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        };


g = MultiplexBD('B', B);
in_global_efficiency = InGlobalEfficiencyAv('G', g).get('M');

assert(isequal(in_global_efficiency, known_in_global_efficiency_av), ...
    [BRAPH2.STR ':InGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiency is not being calculated correctly for MultiplexBU.')