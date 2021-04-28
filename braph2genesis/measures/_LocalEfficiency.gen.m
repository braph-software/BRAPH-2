%% ¡header!
LocalEfficiency < Measure (m, local efficiency) is the graph local efficiency.

%%% ¡description!
The local efficiency is the average inverse shortest path length with 
local nodes within each layer.

%%% ¡shape!
shape = Measure.NODAL;

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
M (result, cell) is the local efficiency.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.nodenumber();
L = g.layernumber();

local_efficiency = cell(L, 1);
for li = 1:1:L    
    Aii = A{li, li};    
    local_efficiency_layer = zeros(N(li), 1);
    for i = 1:1:N(li)
        nodes = find(Aii(i, :)  | Aii(:, i).');  % neighbours of u
        if numel(nodes) > 1
            sub_graph = g.subgraph(g, nodes);
            global_efficiency = GlobalEfficiency('G', sub_graph).get('M');
            local_efficiency_layer(i) = mean(global_efficiency{li});
        end
    end
    local_efficiency(li) = {local_efficiency_layer};
end

value = local_efficiency;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

known_local_efficiency = {[5/6 1 5/6 1]'};

g = GraphBU('B', B);
local_efficiency = LocalEfficiency('G', g).get('M');

assert(isequal(local_efficiency, known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.BUG_ERR], ...
    'LocalEfficiency is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];

known_local_efficiency = {[1/4 1/5 .1222 1/5]'};

g = GraphWU('B', B);
local_efficiency = LocalEfficiency('G', g).get('M');
assert(isequal(round(local_efficiency{1}, 4), known_local_efficiency{1}), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.BUG_ERR], ...
    'LocalEfficiency is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
B11 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];

B22 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];
B = {B11 B22};

known_local_efficiency = {
                         [5/6 1 5/6 1]'
                         [5/6 1 5/6 1]'
                         };

g = MultiplexBU('B', B);
local_efficiency = LocalEfficiency('G', g).get('M');

assert(isequal(local_efficiency, known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.BUG_ERR], ...
    'LocalEfficiency is not being calculated correctly for MultiplexBU.')


%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
B11 = [
      0   .2  .2  .1
      .2  0   .3  0
      .2  .3  0   .3
      .1  0   .3  0
      ];

B22 = [
      0   .2  .2  .1
      .2  0   .3  0
      .2  .3  0   .3
      .1  0   .3  0
      ];
B = {B11 B22};

known_local_efficiency = {
                         [1/4 1/5 .1222 1/5]'
                         [1/4 1/5 .1222 1/5]'
                         };

g = MultiplexWU('B', B);
local_efficiency = LocalEfficiency('G', g).get('M');
local_efficiency = cellfun(@(s) round(s, 4), local_efficiency, 'UniformOutput', false);

assert(isequal(local_efficiency, known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.BUG_ERR], ...
    'LocalEfficiency is not being calculated correctly for MultiplexWU.')