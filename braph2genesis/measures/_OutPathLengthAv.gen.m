%% ¡header!
OutPathLengthAv < OutPathLength (m, average out-path length) is the graph average out-path length.

%%% ¡description!
The average out-path length is the average shortest out-path lengths of one
node to all other nodes without a layer.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphWD
MultiplexGraphBD
MultiplexGraphWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class

out_path_length = calculateValue@OutPathLength(m, prop);
out_path_length_av = cell(g.layernumber(), 1);
for li = 1:1:length(out_path_length_av)
    out_path_length_av(li) = {mean(out_path_length{li})};
end
value = out_path_length_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
A = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0 
    ];

known_out_path_length = {Inf};

g = GraphBD('B', A);
out_path_length = OutPathLengthAv('G', g).get('M');

assert(isequal(out_path_length, known_out_path_length), ...
    [BRAPH2.STR ':OutPathLength:' BRAPH2.BUG_ERR], ...
    'OutPathLength is not beoutg calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
%%%% ¡code!
A11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0 
      ];

A22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0 
      ];
A = {A11  A22};

known_out_path_length = {
                    Inf
                    Inf
                    };

g = MultiplexGraphBD('B', A);
out_path_length = OutPathLengthAv('G', g).get('M');

assert(isequal(out_path_length, known_out_path_length), ...
    [BRAPH2.STR ':OutPathLength:' BRAPH2.BUG_ERR], ...
    'OutPathLength is not beoutg calculated correctly for MultiplexGraphBD.')