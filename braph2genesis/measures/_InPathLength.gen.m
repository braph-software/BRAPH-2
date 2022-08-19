%% ¡header!
InPathLength < Measure (m, in-path length) is the graph in-path length.

%%% ¡description!
The in-path length is the average shortest in-path length of one
node to all other nodes within a layer.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphWD
MultiplexBD
MultiplexWD

%% ¡props!
%%% ¡prop! 
rule (parameter, OPTION) 
%%%% ¡settings!
{'subgraphs' 'harmonic' 'default'}
%%%% ¡default!
'default'

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the in-path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.nodenumber();
L = g.layernumber();

in_path_length = cell(L, 1);                    
path_length_rule = m.get('rule');

distance = Distance('G', g).get('M');

parfor li = 1:1:L
    in_path_length_layer = zeros(N(1), 1);
    distance_layer = distance{li};

    switch lower(path_length_rule)
        case {'subgraphs'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                in_path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));
            end
            in_path_length_layer(isnan(in_path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
        case {'harmonic'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                in_path_length_layer(u) = harmmean(Du(Du~=0));
            end
        otherwise  % 'default'
            for u = 1:1:N
                Du = distance_layer(:, u);
                in_path_length_layer(u) = mean(Du(Du~=0));
            end
    end
    in_path_length(li) = {in_path_length_layer};
end
value = in_path_length;


%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
A = [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];

known_in_path_length = {[Inf Inf Inf Inf Inf]'};

g = GraphBD('B', A);
in_path_length = InPathLength('G', g).get('M');

assert(isequal(in_path_length, known_in_path_length), ...
    [BRAPH2.STR ':InPathLength:' BRAPH2.BUG_ERR], ...
    'InPathLength is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
A11 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];

A22 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];
A = {A11  A22};

known_in_path_length = {
                    [Inf Inf Inf Inf Inf]'
                    [Inf Inf Inf Inf Inf]'
                    };

g = MultiplexBD('B', A);
in_path_length = InPathLength('G', g).get('M');

assert(isequal(in_path_length, known_in_path_length), ...
    [BRAPH2.STR ':InPathLength:' BRAPH2.BUG_ERR], ...
    'InPathLength is not being calculated correctly for MultiplexBD.')