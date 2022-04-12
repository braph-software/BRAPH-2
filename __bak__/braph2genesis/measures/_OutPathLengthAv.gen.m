%% ¡header!
OutPathLengthAv < OutPathLength (m, average out-path length) is the graph average out-path length.

%%% ¡description!
The average out-path length of a graph is the average of the sum of the
out-path lengths within each layer. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphWD
MultiplexBD
MultiplexWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average out-path length.
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
B = [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];
known_out_path_length_av = {Inf};

g = GraphBD('B', B);
out_path_length_av = OutPathLengthAv('G', g).get('M');

assert(isequal(out_path_length_av, known_out_path_length_av), ...
    [BRAPH2.STR ':OutPathLength:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAv is not beoutg calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];

B22 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
       ];
B = {B11 B22};

known_out_path_length_av = {
                    Inf
                    Inf
                    };

g = MultiplexBD('B', B);
out_path_length_av = OutPathLengthAv('G', g).get('M');

assert(isequal(out_path_length_av, known_out_path_length_av), ...
    [BRAPH2.STR ':OutPathLength:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAv is not beoutg calculated correctly for MultiplexBD.')
