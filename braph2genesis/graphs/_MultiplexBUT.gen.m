%% ¡header!
MultiplexBUT < MultiplexWU (g, binary undirected multiplex with fixed thresholds) is a binary undirected multiplex with fixed thresholds.

%%% ¡description!
In a binary undirected multiplex with fixed thresholds (BUT), 
all the layers consist of binary undirected (BU) multiplex graphs 
derived from the same weighted supra-connectivity matrices 
binarized at different thresholds.

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
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡gui_!
% % % pr = PlotPropSmartVector('EL', g, 'PROP', MultiplexBUT.THRESHOLDS, 'MAX', 1, 'MIN', 0, varargin{:});

%%% ¡prop!
NODELABELS (metadata, STRING) is the node labels.

%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the graph template to set the graph and measure parameters.
%%%% ¡settings!
'MultiplexBUT'

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
        for j = (i - 1) * L + 1:1:i * L
            A{j, j} = dediagonalize(binarize(A_WU{layer, layer}, 'threshold', threshold));
            layer = layer + 1;
        end
    end
end

value = A;
%%%% ¡gui!
bas = g.get('BAS');
if ~isempty(bas)
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
else
    rowname = '{}';
end

if isempty(g.get('LAYERLABELS'))
    xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
    ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
else
    layerlabels = str2cell(g.get('LAYERLABELS'));
    xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
    ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
end

pr = PanelPropCell('EL', g, 'PROP', GraphWU.A, ...
    'TAB_H', 40, ...
    'XYSLIDERLOCK', true, ... 
    'XSLIDER', false, 'YSLIDER', true, ...
    'XSLIDERLABELS', xlayerlabels, 'YSLIDERLABELS', ylayerlabels, ...
    'XSLIDERHEIGHT', 3, 'YSLIDERWIDTH', 5, ...
    'ROWNAME', rowname, ...
    'COLUMNNAME', rowname, ...
    varargin{:});

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
    ls = ones(1, length(thresholds)) * l / length(thresholds);
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