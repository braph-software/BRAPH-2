%% ¡header!
GlobalEfficiencyAv < GlobalEfficiency (m, average global efficiency) is the graph average global efficiency.

%%% ¡description!
The average global efficiency is the average of the
global efficiency within each layer.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphBU
MultiplexWU
MultiplexGraphBU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();
global_efficiency = calculateValue@GlobalEfficiency(m, prop);
global_efficiency_av = cell(L, 1);
for li = 1:1:length(global_efficiency_av)
    global_efficiency_av(li) = {mean(global_efficiency{li})};
end

value = global_efficiency_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_global_efficiency = {mean([1/4 1/4 1/4 1/4 0])};

g = GraphBU('B', B);
global_efficiency_av = GlobalEfficiencyAv('G', g).get('M');

assert(isequal(global_efficiency_av, known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiency is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
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
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        };


g = MultiplexGraphBU('B', B);
global_efficiency_av = GlobalEfficiencyAv('G', g).get('M');

assert(isequal(global_efficiency_av, known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiency is not being calculated correctly for MultiplexGraphBU.')