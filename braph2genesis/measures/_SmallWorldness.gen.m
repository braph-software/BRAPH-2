%% ¡header!
SmallWorldness < PathLengthAv (m, small-worldness) is the graph small-worldness.

%%% ¡description!
The small-worldness coefficient is the fraction of the clustering coefficient 
and average path length of each layer and the clustering coefficient and
average path length of 100 random graphs.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBU
GraphWU
MultiplexBU
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the small worldness
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
if isempty(g.get('A'))
    value = {};
    return;
end
L = g.layernumber();

clustering_av = ClusteringAv('G', g).get('M');
path_length_av = PathLengthAv('G', g).get('M');

M = 100;  % number of random graphs
clustering_av_random = cell(1, M);
path_length_av_random = cell(1, M);
for r = 1:1:M
    g_random = g.randomize();

    clustering_av_random(r) = {ClusteringAv('G', g_random).get('M')};
    path_length_av_random(r) = {calculateValue@PathLengthAv(m, prop)}; 
    
end
path_length_av_random = cellfun(@(x) cell2mat(x), path_length_av_random, 'UniformOutput', false);
clustering_av_random = cellfun(@(x) cell2mat(x), clustering_av_random, 'UniformOutput', false);
path_length_av_random = cell2mat(path_length_av_random);
clustering_av_random = cell2mat(clustering_av_random);
path_length_av_random = mean(path_length_av_random, 2);
clustering_av_random = mean(clustering_av_random, 2);

small_worldness = cell(L, 1);
for li = 1:1:L
    small_worldness_layer = (clustering_av{li}/clustering_av_random(li)) / (path_length_av{li}/ path_length_av_random(li));
    small_worldness(li) = {small_worldness_layer};
end

value = small_worldness;


%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
A = rand(20);

known_smallworldness = {1};

g = GraphBU('B', A);
smallworldness = SmallWorldness('G', g).get('M');

assert(isequal(smallworldness, known_smallworldness), ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.BUG_ERR], ...
    'SmallWorldness is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
A11 = rand(20);

A22 = rand(20);
A = {A11 A22};

known_smallworldness = {
                       1
                       1
                       };

g = MultiplexWU('B', A);
smallworldness = SmallWorldness('G', g).get('M');
smallworldness = cellfun(@(s) round(s, 1), smallworldness, 'UniformOutput', false);

assert(isequal(smallworldness, known_smallworldness), ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.BUG_ERR], ...
    'SmallWorldness is not being calculated correctly for MultiplexWU.')

%%% ¡test!
%%%% ¡name!
GraphBU subgraphs
%%%% ¡code!
A = rand(20);

known_smallworldness = {1};

g = GraphBU('B', A);
smallworldness = SmallWorldness('G', g, 'rule', 'subgraphs').get('M');

assert(isequal(smallworldness, known_smallworldness), ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.BUG_ERR], ...
    'SmallWorldness is not being calculated correctly for GraphBU.')
