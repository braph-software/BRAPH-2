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
A = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0 
    ];

known_in_path_length = {Inf};

g = GraphBD('B', A);
in_path_length_av = InPathLengthAv('G', g).get('M');

assert(isequal(in_path_length_av, known_in_path_length), ...
    [BRAPH2.STR ':InPathLength:' BRAPH2.BUG_ERR], ...
    'InPathLength is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
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

known_in_path_length = {
                    Inf
                    Inf
                    };

g = MultiplexBD('B', A);
in_path_length_av = InPathLengthAv('G', g).get('M');

assert(isequal(in_path_length_av, known_in_path_length), ...
    [BRAPH2.STR ':InPathLength:' BRAPH2.BUG_ERR], ...
    'InPathLength is not being calculated correctly for MultiplexBD.')