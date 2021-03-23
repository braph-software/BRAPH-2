%% ¡header!
InPathLengthAv < InPathLength (m, average in-path length) is the graph average in-path length.

%%% ¡description!
The average in-path length of a graph is 
the average of the sum of the in-path lengths within each layer. 

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
M (result, cell) is the average in-path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class

in_path_length = calculateValue@InPathLength(m, prop);
in_path_length_av = cell(g.layernumber(), 1);
for li = 1:1:length(in_path_length_av)
    in_path_length_av(li) = {mean(in_path_length{li})};
end
value = in_path_length_av;

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

known_in_path_length_av = {Inf};

g = GraphBD('B', B);
in_path_length_av = InPathLengthAv('G', g).get('M');

assert(isequal(in_path_length_av, known_in_path_length_av), ...
    [BRAPH2.STR ':InPathLength:' BRAPH2.BUG_ERR], ...
    'InPathLength is not being calculated correctly for GraphBD.')

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

known_in_path_length_av = {
                    Inf
                    Inf
                    };

g = MultiplexBD('B', B);
in_path_length_av = InPathLengthAv('G', g).get('M');

assert(isequal(in_path_length_av, known_in_path_length_av), ...
    [BRAPH2.STR ':InPathLength:' BRAPH2.BUG_ERR], ...
    'InPathLength is not being calculated correctly for MultiplexBD.')
