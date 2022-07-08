%% ¡header!
MultiplexBUD < MultiplexWU (g, binary undirected multiplex with fixed densities) is a binary undirected multiplex with fixed densities.

%%% ¡description!
In a binary undirected multiplex with fixed densities (BUD), 
all the layers consist of binary undirected (BU) multiplex graphs 
derived from the same weighted supra-connectivity matrices 
binarized at different densities.

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
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡gui_!
% % % pr = PlotPropSmartVector('EL', g, 'PROP', MultiplexBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});

%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the graph template to set the graph and measure parameters.
%%%% ¡settings!
'MultiplexBUD'

%%% ¡prop!
A (result, cell) is the cell array containing the multiplex binary adjacency matrices of the binary undirected multiplex. 
%%%% ¡calculate!
A_WU = calculateValue@MultiplexWU(g, prop);

densities = g.get('DENSITIES');
L = length(A_WU); % number of layers of MultiplexWU
A = cell(length(densities) * L); % the new g.layernumber() will be equal to = L*length(densities)

if L > 0 && ~isempty(cell2mat(A_WU))
    A(:, :) = {eye(length(A_WU{1, 1}))};
    for i = 1:1:length(densities)
        density = densities(i);
        layer = 1;
        for j = (i - 1) * L + 1:1:i * L
            A{j, j} = dediagonalize(binarize(A_WU{layer, layer}, 'density', density));
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
    densities = g.get('DENSITIES');
    ls = ones(1, length(densities)) * l / length(densities);
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
A = [
     0 .1 .2 .3 .4
    .1  0 .5 .6 .7
    .2 .5  0 .8 .9
    .3 .6 .8  0  1
    .4 .7 .9  1  0
    ];
B = {A, A};

g = MultiplexBUD('B', B, 'DENSITIES', [0 55 100]);

A = g.get('A');

assert( ...
    sum(sum(A{1, 1})) == 0 && ...
    sum(sum(A{2, 2})) == 0 && ...
    sum(sum(A{3, 3})) == 10 && ...
    sum(sum(A{4, 4})) == 10 && ...
    sum(sum(A{5, 5})) == 20 && ...
    sum(sum(A{6, 6})) == 20, ...
    [BRAPH2.STR ':MultiplexBUD:' BRAPH2.BUG_ERR], ...
    'MultiplexBUD is not constructing well.')
