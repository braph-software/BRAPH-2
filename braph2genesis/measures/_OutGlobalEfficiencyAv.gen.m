%% ¡header!
OutGlobalEfficiencyAv < OutGlobalEfficiency (m, average out-global efficiency) is the graph average out-global efficiency.

%%% ¡description!
The average out-global efficiency is the average of the out-global efficiency
without each layer.

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
MultiplexGraphBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the out-global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

out_global_efficiency = calculateValue@OutGlobalEfficiency(m, prop);

out_global_efficiency_av = cell(L, 1);
for li = 1:1:L
    out_global_efficiency_av(li) = {mean(out_global_efficiency{li})};
end
value = out_global_efficiency_av;

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

known_out_global_efficiency = {mean([1/4 1/4 1/4 1/4 0])};

g = GraphBD('B', B);
out_global_efficiency = OutGlobalEfficiencyAv('G', g).get('M');

assert(isequal(out_global_efficiency, known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiency is not beoutg calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
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

known_out_global_efficiency = {
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        };


g = MultiplexGraphBD('B', B);
out_global_efficiency = OutGlobalEfficiencyAv('G', g).get('M');

assert(isequal(out_global_efficiency, known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiency is not beoutg calculated correctly for MultiplexGraphBU.')