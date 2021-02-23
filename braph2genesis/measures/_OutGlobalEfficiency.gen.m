%% ¡header!
OutGlobalEfficiency < Measure (m, out-global efficiency) is the graph out-global efficiency.

%%% ¡description!
The out-global efficiency is the average outverse shortest out-path length without each layer. 
It is outversely related to the characteristic out-path length.

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
M (result, cell) is the out-global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
N = g.nodenumber();
L = g.layernumber();

distance = Distance('G', g).get('M');

out_global_efficiency = cell(L, 1);
for li = 1:1:L
    outverse_distance = distance{li}.^-1;  % outverse distance
    outverse_distance(1:N(li)+1:end) = 0;
    global_efficiency_layer = (sum(outverse_distance, 2) / (N(li)-1));
    out_global_efficiency(li) = {global_efficiency_layer};
end
value = out_global_efficiency;

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

known_out_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

g = GraphBD('B', B);
out_global_efficiency = OutGlobalEfficiency('G', g).get('M');

assert(isequal(out_global_efficiency, known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiency is not beoutg calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
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
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
                        };


g = MultiplexGraphBD('B', B);
out_global_efficiency = OutGlobalEfficiency('G', g).get('M');

assert(isequal(out_global_efficiency, known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiency is not beoutg calculated correctly for MultiplexGraphBD.')