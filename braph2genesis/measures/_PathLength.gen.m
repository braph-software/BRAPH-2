%% ¡header!
PathLength < Measure (m, path length) is the graph path length.

%%% ¡description!
The path length is the average shortest path lengths of one node to all
other nodes within a layer.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBU
GraphWU
MultiplexGraphBU
MultiplexGraphWU

%% ¡props!
%%% ¡prop! 
rule (metadata, OPTION) 
%%%% ¡settings!
{'subgraphs' 'harmonic' 'default'}
%%%% ¡default!
'default'

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell array with adjacency matrix 
N = g.nodenumber();
L = g.layernumber();

path_length = cell(L, 1);                    
path_length_rule = m.get('rule');

distance = Distance('G', g).get('M');

for li = 1:1:L
    path_length_layer = zeros(N(1), 1);
    distance_layer = distance{li};

    switch lower(path_length_rule)
        case {'subgraphs'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));
            end
            path_length_layer(isnan(path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
        case {'harmonic'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = harmmean(Du(Du~=0));
            end
        otherwise  % 'default'
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = mean(Du(Du~=0));
            end
    end
    path_length(li) = {path_length_layer};
end
value = path_length;


%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

known_path_length = {[2 4/3 4/3 2]'};

g = GraphBU('B', B);
path_length = PathLength('G', g).get('M');

assert(isequal(path_length, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.BUG_ERR], ...
    'PathLength is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBU
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
B = { A11  A22};

known_path_length = {
                    [2 4/3 4/3 2]'
                    [2 4/3 4/3 2]'
                    };

g = MultiplexGraphBU('B', B);
path_length = PathLength('G', g).get('M');

assert(isequal(path_length, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.BUG_ERR], ...
    'PathLength is not being calculated correctly for MultiplexGraphBU.')