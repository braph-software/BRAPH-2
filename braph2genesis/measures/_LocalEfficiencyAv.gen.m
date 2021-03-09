%% ¡header!
LocalEfficiencyAv < LocalEfficiency (m, average local efficiency) is the graph average local efficiency.

%%% ¡description!
The average local efficiency is the average of all the local efficiencies
within each layer.

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
MultiplexBU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average local efficiency.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
local_efficiency = calculateValue@LocalEfficiency(m, prop);

local_efficiency_av = cell(g.layernumber(), 1);
for li = 1:1:length(local_efficiency_av)
    local_efficiency_av(li) = {mean(local_efficiency{li})};
end

value = local_efficiency_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
A = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];

known_local_efficiency_av = {mean([5/6 1 5/6 1])};

g = GraphBU('B', A);
local_efficiency_av = LocalEfficiencyAv('G', g).get('M');

assert(isequal(local_efficiency_av, known_local_efficiency_av), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.BUG_ERR], ...
    'LocalEfficiencyAv is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
A = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];

known_local_efficiency_av = {mean([1/4 1/5 .1222 1/5])};

g = GraphWU('B', A);
local_efficiency_av = LocalEfficiencyAv('G', g).get('M');
assert(isequal(round(local_efficiency_av{1}, 3), round(known_local_efficiency_av{1}, 3)), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.BUG_ERR], ...
    'LocalEfficiencyAv is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
A11 = [
      0   .2  .2  .1
      .2  0   .3  0
      .2  .3  0   .3
      .1  0   .3  0
      ];

A22 = [
      0   .2  .2  .1
      .2  0   .3  0
      .2  .3  0   .3
      .1  0   .3  0
      ];
A = {A11 A22};

known_local_efficiency_av = {
                         mean([5/6 1 5/6 1])
                         mean([5/6 1 5/6 1])
                         };

g = MultiplexBU('B', A);
local_efficiency_av = LocalEfficiencyAv('G', g).get('M');

assert(isequal(local_efficiency_av, known_local_efficiency_av), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.BUG_ERR], ...
    'LocalEfficiencyAv is not being calculated correctly for MultiplexBU.')


%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
A11 = [
      0   .2  .2  .1
      .2  0   .3  0
      .2  .3  0   .3
      .1  0   .3  0
      ];

A22 = [
      0   .2  .2  .1
      .2  0   .3  0
      .2  .3  0   .3
      .1  0   .3  0
      ];
A = {A11 A22};

known_local_efficiency_av = {
                         round(mean([1/4 1/5 .1222 1/5]), 3)
                         round(mean([1/4 1/5 .1222 1/5]), 3)
                         };

g = MultiplexWU('B', A);
local_efficiency_av = LocalEfficiencyAv('G', g).get('M');
local_efficiency_av = cellfun(@(s) round(s, 3), local_efficiency_av, 'UniformOutput', false);

assert(isequal(local_efficiency_av, known_local_efficiency_av), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.BUG_ERR], ...
    'LocalEfficiencyAv is not being calculated correctly for MultiplexWU.')
