%% ¡header!
PathLength < Measure (m, path length) is the graph path length.

%%% ¡description!
The path length is the average shortest path length of one node to all 
other nodes within a layer.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBU
MultigraphBUD
MultigraphBUT
GraphWU
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexWU

%% ¡props!
%%% ¡prop! 
rule (parameter, OPTION) is the path length algorithm
%%%% ¡settings!
{'subgraphs' 'harmonic' 'mean'}
%%%% ¡default!
'harmonic'

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.nodenumber();
L = g.layernumber();

path_length = cell(L, 1);                    
path_length_rule = m.get('rule');

distance = Distance('G', g).get('M');

parfor li = 1:1:L
    path_length_layer = zeros(N(1), 1);
    distance_layer = distance{li};

    switch lower(path_length_rule)
        case {'subgraphs'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));
            end
        case {'mean'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = mean(Du(Du~=0));
            end
        otherwise  % 'harmonic' 'default'
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = harmmean(Du(Du~=0));
            end
    end 
    path_length(li) = {path_length_layer}; % node Inf corresponds to isolated nodes
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
MultigraphBUT
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

thresholds = [0 1];

known_path_length = { ...
    [2   4/3  4/3  2]'
    [Inf Inf  Inf  Inf]'
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

path_length = PathLength('G', g).get('M');

assert(isequal(path_length, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.BUG_ERR], ...
    'PathLength is not being calculated correctly for MultigraphBUT.')

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
B = { A11  A22};

known_path_length = {
                    [2 4/3 4/3 2]'
                    [2 4/3 4/3 2]'
                    };

g = MultiplexBU('B', B);
path_length = PathLength('G', g).get('M');

assert(isequal(path_length, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.BUG_ERR], ...
    'PathLength is not being calculated correctly for MultiplexBU.')
