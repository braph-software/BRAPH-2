%% ¡header!
MultigraphWUD < GraphWU (g, weighted undirected multigraph with fixed densities) is a weighted undirected multigraph with fixed densities.

%%% ¡description!
In a weighted undirected multigraph with fixed densities, 
all the layers consist of weighted undirected (WU) graphs 
derived from the same weighted connectivity matrix 
binarized at different densities.
There are no connections between layers.

%%% ¡graph!
graph = Graph.MULTIGRAPH;

%%% ¡connectivity!
connectivity = Graph.WEIGHTED * ones(layernumber);

%%% ¡directionality!
directionality = Graph.UNDIRECTED * ones(layernumber);

%%% ¡selfconnectivity!
selfconnectivity = Graph.NONSELFCONNECTED * ones(layernumber);

%%% ¡negativity!
negativity = Graph.NONNEGATIVE * ones(layernumber);

%% ¡props!

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡gui!
pr = PlotPropSmartVector('EL', g, 'PROP', MultigraphWUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});

%% ¡props_update!

%%% ¡prop!
A (result, cell) is the cell array with the symmetric weighted adjacency matrices of the weighted undirected multigraph.
%%%% ¡calculate!
A_WU = calculateValue@GraphWU(g, prop);

densities = g.get('DENSITIES');
A = cell(length(densities));

for i = 1:1:length(densities)
    density = densities(i);
    A{i, i} = fractionate(cell2mat(A_WU), 'density', density);
end

value = A;

%% ¡methods!
function [l, ls] = layernumber(g)
    %LAYERNUMBER returns the number of layers in the graph.
    %
    % L = LAYERNUMBER(G) returns the number of layers in graph G. L is a scalar.
    %
    % [~, LS] = LAYERNUMBER(G) returns the number of layers in the partitions
    %  of graph G. LS is a vector of integers.
    %
    % See also nodenumber.

    l = length(g.get('A'));
    ls = ones(1, l);
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
B = [
     0 .1 .2 .3 .4
    .1  0 .5 .6 .7
    .2 .5  0 .8 .9
    .3 .6 .8  0  1
    .4 .7 .9  1  0
    ];
g = MultigraphWUD('B', B, 'DENSITIES', [0 16 100]);

A = g.get('A');

assert( ...
    sum(sum(A{1, 1})) == 0 && ...
    sum(sum(A{2, 2})) == 3.8 && ...
    sum(sum(A{3, 3})) == 11, ...
    [BRAPH2.STR ':MultigraphWUD:' BRAPH2.BUG_ERR], ...
    'MultigraphWUD is not constructing well.')