% test LocalEfficiency

%% Test 1: GraphBU
A = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];

known_local_efficiency = {[5/6 1 5/6 1]'};

g = GraphBU(A);
local_efficiency = LocalEfficiency(g);

assert(isequal(local_efficiency.getValue(), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.BUG_ERR], ...
    'LocalEfficiency is not being calculated correctly for GraphBU.')

%% Test 2: GraphWU
A = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];

known_local_efficiency = {[1/4 1/5 .1222 1/5]'};

g = GraphWU(A);
local_efficiency = LocalEfficiency(g);
local_efficiency = local_efficiency.getValue();
assert(isequal(round(local_efficiency{1}, 4), known_local_efficiency{1}), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.BUG_ERR], ...
    'LocalEfficiency is not being calculated correctly for GraphWU.')
