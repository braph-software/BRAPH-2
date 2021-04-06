%% ¡header!
MultiplexBUT < MultiplexWU (g, binary undirected multiplex with fixed thresholds) is a binary undirected multiplex with fixed thresholds.

%%% ¡description!
In a binary undirected multiplex with fixed thresholds (BUT), 
all the layers consist of binary undirected (BU) multiplex graphs 
derived from the same weighted supra-connectivity matrices 
binarized at different thresholds.

%%% ¡ensemble!
false

%%% ¡graph!
graph = Graph.MULTIPLEX;

%%% ¡connectivity!
connectivity = Graph.BINARY * ones(layernumber);

%%% ¡directionality!
directionality = Graph.UNDIRECTED * ones(layernumber);

%%% ¡selfconnectivity!
selfconnectivity = Graph.SELFCONNECTED * ones(layernumber);
selfconnectivity(1:layernumber+1:end) = Graph.NONSELFCONNECTED;                

%%% ¡negativity!
negativity = Graph.NONNEGATIVE * ones(layernumber);

%% ¡props!

%%% ¡prop!
THRESHOLDS (data, rvector) is the vector of thresholds.

%% ¡props_update!

%%% ¡prop!
A (result, cell) is the cell array containing the multiplex binary adjacency matrices of the binary undirected multiplex. 
%%%% ¡calculate!
A_WU = calculateValue@MultiplexWU(g, prop);

thresholds = g.get('THRESHOLDS');
L = length(A_WU); % number of layers
A = cell(length(thresholds)*L);

if L > 0
    A(:, :) = {eye(length(A_WU{1, 1}))};
    for i = 1:1:length(thresholds)
        threshold = thresholds(i);
        layer = 1;
        for j = (i*2) - 1:1: (i*2) + L - 2     
            A{j, j} = binarize(A_WU{layer, layer}, 'threshold', threshold);
            layer = layer + 1;
        end
    end
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
    thresholds = g.get('THRESHOLDS');
    ls = ones(1, length(thresholds))*l/length(thresholds);
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
A = [
     0 .1 .2 .3 .4 
    .1 0 .1 .2 .3
    .2 .1 0 .1 .2
    .3 .2 .1 0 .1
    .4 .3 .2 .1 0
    ];
B = {A, A};

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 .1 .2 .3 .4]);

A = g.get('A');

assert(isequal( ...
    A{1, 1}, ...
    [
    0 1 1 1 1
    1 0 1 1 1
    1 1 0 1 1
    1 1 1 0 1
    1 1 1 1 0
    ]) ...
    && ...
    isequal( ...
    A{2, 2}, ...
    [
    0 1 1 1 1
    1 0 1 1 1
    1 1 0 1 1
    1 1 1 0 1
    1 1 1 1 0
    ]) ...
    && ...
    isequal( ...
    A{3, 3}, ...
    [
    0 0 1 1 1
    0 0 0 1 1
    1 0 0 0 1
    1 1 0 0 0
    1 1 1 0 0
    ]) ...
    && ...
    isequal( ...
    A{4, 4}, ...
    [
    0 0 1 1 1
    0 0 0 1 1
    1 0 0 0 1
    1 1 0 0 0
    1 1 1 0 0
    ]) ...
    && ...
    isequal( ...
    A{5, 5}, ...
    [
    0 0 0 1 1
    0 0 0 0 1
    0 0 0 0 0
    1 0 0 0 0
    1 1 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{6, 6}, ...
    [
    0 0 0 1 1
    0 0 0 0 1
    0 0 0 0 0
    1 0 0 0 0
    1 1 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{7, 7}, ...
    [
    0 0 0 0 1
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    1 0 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{8, 8}, ...
    [
    0 0 0 0 1
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    1 0 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{9, 9}, ...
    [
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{10, 10}, ...
    [
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    ]), ...
    [BRAPH2.STR ':MultiplexBUT:' BRAPH2.BUG_ERR], ...
    'MultiplexBUT is not constructing well.')