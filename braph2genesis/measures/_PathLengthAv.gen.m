%% ¡header!
PathLengthAv < PathLength (m, average path length) is the graph average path length.

%%% ¡description!
The average path length of a graph is the average of the sum of 
the path lengths within each layer.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphBU
MultigraphBUD
MultigraphBUT
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class

path_length = calculateValue@PathLength(m, prop);
path_length_av = cell(g.layernumber(), 1);
path_length_rule = m.get('rule');
parfor li = 1:1:length(path_length_av)
    switch lower(path_length_rule)
        case {'subgraphs'}
            player = path_length{li};
            path_length_av(li) = {mean(player(player~=Inf))};
        case {'mean'}
            path_length_av(li) = {mean(path_length{li})};
        otherwise  % 'harmonic' 'default'
            path_length_av(li) = {harmmean(path_length{li})};
    end
end
value = path_length_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
A = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

known_path_length_av = {harmmean([18/11 18/15 18/15 18/11])};

g = GraphBU('B', A);
path_length_av = PathLengthAv('G', g).get('M');

assert(isequal(path_length_av, known_path_length_av), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.BUG_ERR], ...
    'PathLengthAv is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
A11 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];
A22 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];
A = {A11  A22};

known_path_length_av = {
                       harmmean([18/11 18/15 18/15 18/11])
                       harmmean([18/11 18/15 18/15 18/11])
                       };

g = MultiplexBU('B', A);
path_length_av = PathLengthAv('G', g).get('M');

assert(isequal(path_length_av, known_path_length_av), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.BUG_ERR], ...
    'PathLengthAv is not being calculated correctly for MultiplexBU.')
    