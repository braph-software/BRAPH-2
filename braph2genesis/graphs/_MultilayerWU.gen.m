%% ¡header!
MultilayerWU < Graph (g, multilayer weighted undirected graph) is a multilayer weighted undirected graph.

%%% ¡description!
In a multilayer weighted undirected (WU) graph, layers have different number 
 of nodes with within-layer weighted undirected edges, associated with a real 
 number between 0 and 1 and indicating the strength of the connection.
The connectivity matrices are symmetric.
There are connections between layers connecting the corresponding nodes.

%% ¡props_update!

%%% ¡prop!

NAME (constant, string) is the name of the multilayer weighted undirected graph.
%%%% ¡default!
'MultilayerWU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multilayer weighted undirected graph.
%%%% ¡default!
'In a multilayer weighted undirected (WU) graph, layers have different number of nodes with within-layer weighted undirected edges, associated with a real number between 0 and 1 and indicating the strength of the connection. The connectivity matrices are symmetric. There are connections between layers connecting the corresponding nodes.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multilayer weighted undirected graph.
%%% ¡_prop!
% % % TEMPLATE (parameter, item) is the graph template to set the graph and measure parameters.
% % % %%%% ¡_settings!
% % % 'MultilayerWU'

%%% ¡prop!
ID (data, string) is a few-letter code for the multilayer weighted undirected graph.
%%%% ¡default!
'MultilayerWU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multilayer weighted undirected graph.
%%%% ¡default!
'MultilayerWU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multilayer weighted undirected graph.
%%%% ¡default!
'MultilayerWU notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTILAYER__.
%%%% ¡default!
Graph.MULTILAYER

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.WEIGHTED * ones(layernumber);

%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.UNDIRECTED * ones(layernumber);

%%% ¡prop!
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.SELFCONNECTED * ones(layernumber);
value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;                

%%% ¡prop!
NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.NONNEGATIVE * ones(layernumber);

%%% ¡prop!
A (result, cell) is the cell containing the multilayer weighted adjacency matrices of the multilayer weighted undirected graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>
L = length(B); %#ok<PROPLC> % number of layers
for i = 1:1:L
    M = symmetrize(B{i,i}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
    M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
    B(i, i) = {M};
end
A = B;
value = A;

%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerWU.A, ...
    'TABLE_HEIGHT', s(40), ...
    'XYSLIDERLOCK', true, ... 
    'XSLIDERSHOW', false, ...
    'YSLIDERSHOW', true, ...
    'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
    'YSLIDERWIDTH', s(5), ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
%%%% ¡calculate!
value = ones(1, g.get('LAYERNUMBER'));

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
    alayerlabels = cellfun(@num2str, num2cell([1:1:g.get('LAYERNUMBER')]), 'uniformoutput', false);
end
value = alayerlabels;

%%% ¡prop!
COMPATIBLE_MEASURES (constant, stringlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultilayerWU')

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.
%%%% ¡default!
{[] []; [] []}
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerWU.B, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
    'XSLIDERHEIGHT', s(3.5), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.
%%%% ¡settings!
{'max', 'sum', 'average', 'min'}

%%% ¡prop!
SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
%%%% ¡settings!
{'zero', 'absolute'}

%%% ¡prop!
STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.
%%%% ¡settings!
{'threshold' 'range'}

%% ¡tests!

%%% ¡excluded_props!
[MultilayerWU.PFGA MultilayerWU.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi(10));
B2 = rand(randi(10));
B3 = rand(randi(10));
B12 = rand(size(B1,1),size(B2,2));
B13 = rand(size(B1,1),size(B3,2));
B23 = rand(size(B2,1),size(B3,2));
B = {
    B1                           B12                            B13
    B12'                         B2                             B23
    B13'                         B23'                           B3
    };
g = MultilayerWU('B', B);
g.get('A_CHECK')
A1 = symmetrize(standardize(semipositivize(dediagonalize(B1))));
A2 = symmetrize(standardize(semipositivize(dediagonalize(B2))));
A3 = symmetrize(standardize(semipositivize(dediagonalize(B3))));
B{1,1} = A1;
B{2,2} = A2;
B{3,3} = A3;
A = B
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
    'MultilayerWU is not constructing well.')

% %%% ¡test!
% %%%% ¡name!
% Symmetrize, Semipositivize and Standardize Rules
% %%%% ¡probability!
% .01
% %%%% ¡code!
% B1 = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)
% B2 = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)
% B3 = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)
% B = {
%     B1                           rand(size(B1,1),size(B2,2))  rand(size(B1,1),size(B3,2))
%     rand(size(B1,1),size(B2,2))' B2                           rand(size(B2,1),size(B3,2))
%     rand(size(B1,1),size(B3,2))' rand(size(B2,1),size(B3,2))' B3
%     };
% 
% g0 = MultilayerWU('B', B); % 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'threshold'
% 
% A1 = B1;
% A2 = B3;
% A3 = B3;
% A0 = B;
% 
% A1(A1 < 0) = 0;
% A1(A1 > 1) = 1;
% A1 = dediagonalize(A1);
% 
% A2(A2 < 0) = 0;
% A2(A2 > 1) = 1;
% A2 = dediagonalize(A2);
% 
% A3(A3 < 0) = 0;
% A3(A3 > 1) = 1;
% A3 = dediagonalize(A3);
% 
% A0{1,1} = A1;
% A0{2,2} = A2;
% A0{3,3} = A3;
% 
% assert(isequal(g0.get('A'), A0), ...
%     [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%     'MultilayerWU is not constructing well.')
% 
% g_zero = MultilayerWU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero'); % 'STANDARDIZE_RULE', 'threshold'
% 
% A1 = B1;
% A2 = B3;
% A3 = B3;
% A_zero = B;
% 
% A1(A1 < 0) = 0;
% A1(A1 > 1) = 1;
% A1 = dediagonalize(A1);
% 
% A2(A2 < 0) = 0;
% A2(A2 > 1) = 1;
% A2 = dediagonalize(A2);
% 
% A3(A3 < 0) = 0;
% A3(A3 > 1) = 1;
% A3 = dediagonalize(A3);
% 
% A_zero{1,1} = A1;
% A_zero{2,2} = A2;
% A_zero{3,3} = A3;
% 
% assert(isequal(g0.get('A'), A_zero), ...
%     [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%     'MultilayerWU is not constructing well.')
% 
% g_absolute = MultilayerWU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute'); % 'STANDARDIZE_RULE', 'threshold'
% 
% A1 = B1;
% A2 = B3;
% A3 = B3;
% A_absolute = B;
% 
% A1 = abs(A1);
% A1(A1 < 0) = 0;
% A1(A1 > 1) = 1;
% A1 = dediagonalize(A1);
% 
% A2 = abs(A2);
% A2(A2 < 0) = 0;
% A2(A2 > 1) = 1;
% A2 = dediagonalize(A2);
% 
% A3 = abs(A3);
% A3(A3 < 0) = 0;
% A3(A3 > 1) = 1;
% A3 = dediagonalize(A3);
% 
% A_absolute{1,1} = A1;
% A_absolute{2,2} = A2;
% A_absolute{3,3} = A3;
% 
% assert(isequal(g_absolute.get('A'), A_absolute), ...
%     [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%     'MultilayerWU is not constructing well.')
% 
% 
% g_theresold = MultilayerWU('B', B, 'STANDARDIZE_RULE', 'threshold'); % 'SEMIPOSITIVIZE_RULE', 'zero'
% 
% A1 = B1;
% A2 = B3;
% A3 = B3;
% A_theresold = B;
% 
% A1(A1 < 0) = 0;
% A1(A1 > 1) = 1;
% A1 = dediagonalize(A1);
% 
% A2(A2 < 0) = 0;
% A2(A2 > 1) = 1;
% A2 = dediagonalize(A2);
% 
% A3(A3 < 0) = 0;
% A3(A3 > 1) = 1;
% A3 = dediagonalize(A3);
% 
% A_theresold{1,1} = A1;
% A_theresold{2,2} = A2;
% A_theresold{3,3} = A3;
% 
% assert(isequal(g_theresold.get('A'), A_theresold), ...
%     [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%     'MultilayerWU is not constructing well.')
% 
% g_zero_theresold = MultilayerWU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'threshold');
% 
% A1 = B1;
% A2 = B3;
% A3 = B3;
% A_zero_theresold = B;
% 
% A1(A1 < 0) = 0;
% A1(A1 > 1) = 1;
% A1 = dediagonalize(A1);
% 
% A2(A2 < 0) = 0;
% A2(A2 > 1) = 1;
% A2 = dediagonalize(A2);
% 
% A3(A3 < 0) = 0;
% A3(A3 > 1) = 1;
% A3 = dediagonalize(A3);
% 
% A_zero_theresold{1,1} = A1;
% A_zero_theresold{2,2} = A2;
% A_zero_theresold{3,3} = A3;
% 
% assert(isequal(g_theresold.get('A'), A_zero_theresold), ...
%     [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%     'MultilayerWU is not constructing well.')
% 
% g_absolute_theresold = MultilayerWU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'STANDARDIZE_RULE', 'threshold');
% 
% A1 = B1;
% A2 = B3;
% A3 = B3;
% A_absolute_theresold = B;
% 
% A1 = abs(A1);
% A1(A1 < 0) = 0;
% A1(A1 > 1) = 1;
% A1 = dediagonalize(A1);
% 
% A2 = abs(A2);
% A2(A2 < 0) = 0;
% A2(A2 > 1) = 1;
% A2 = dediagonalize(A2);
% 
% A3 = abs(A3);
% A3(A3 < 0) = 0;
% A3(A3 > 1) = 1;
% A3 = dediagonalize(A3);
% 
% A_absolute_theresold{1,1} = A1;
% A_absolute_theresold{2,2} = A2;
% A_absolute_theresold{3,3} = A3;
% 
% assert(isequal(g_absolute_theresold.get('A'), A_absolute_theresold), ...
%     [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%     'MultilayerWU is not constructing well.')
% 
% g_range = MultilayerWU('B', B, 'STANDARDIZE_RULE', 'range'); % 'SEMIPOSITIVIZE_RULE', 'zero'
% A1 = B1;
% A2 = B3;
% A3 = B3;
% A_range = B;
% 
% A1 = dediagonalize(A1);
% A1(A1 < 0) = 0;
% A1 = A1 / max(max(A1));
% 
% A2 = dediagonalize(A2);
% A2(A2 < 0) = 0;
% A2 = A2 / max(max(A2));
% 
% A3 = dediagonalize(A3);
% A3(A3 < 0) = 0;
% A3 = A3 / max(max(A3));
% 
% A_range{1,1} = A1;
% A_range{2,2} = A2;
% A_range{3,3} = A3;
% 
% assert(isequal(g_absolute_theresold.get('A'), A_range), ...
%     [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%     'MultilayerWU is not constructing well.')
% 
% g_zero_range = MultilayerWU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'range');
% A1 = B1;
% A2 = B3;
% A3 = B3;
% A_zero_range = B;
% 
% A1 = dediagonalize(A1);
% A1(A1 < 0) = 0;
% A1 = A1 / max(max(A1));
% 
% A2 = dediagonalize(A2);
% A2(A2 < 0) = 0;
% A2 = A2 / max(max(A2));
% 
% A3 = dediagonalize(A3);
% A3(A3 < 0) = 0;
% A3 = A3 / max(max(A3));
% 
% A_zero_range{1,1} = A1;
% A_zero_range{2,2} = A2;
% A_zero_range{3,3} = A3;
% 
% assert(isequal(g_absolute_theresold.get('A'), A_zero_range), ...
%     [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%     'MultilayerWU is not constructing well.')
% 
% g_absolute_range = MultilayerWU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'STANDARDIZE_RULE', 'range');
% A1 = B1;
% A2 = B3;
% A3 = B3;
% A_absolute_range = B;
% 
% A1 = abs(A1);
% A1 = standardize(dediagonalize(A1), 'StandardizeRule', 'range');
% A2 = abs(A2);
% A2 = standardize(dediagonalize(A2), 'StandardizeRule', 'range');
% A3 = abs(A3);
% A3 = standardize(dediagonalize(A3), 'StandardizeRule', 'range');
% 
% A_absolute_range{1,1} = A1;
% A_absolute_range{2,2} = A2,
% A_absolute_range{3,3} = A3;
% 
% assert(isequal(g_absolute_range.get('A'), A_absolute_range), ...
%     [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%     'MultilayerWU is not constructing well.')

%% ¡_props!

%%% ¡_prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡_default!
5

%%% ¡_prop!
NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
%%%% ¡_default!
10

%% ¡_methods!
function random_g = randomize(g)
    % RANDOMIZE returns a randomized graph
    %
    % RANDOMIZED_G = RANDOMIZE(G) returns the randomized
    % graph RANDOM_G obtained with a randomized correlation
    % matrix via the static function randomize_A while preserving
    % degree distributions. The randomization it is done layer by
    % layer and then integrated in the 2-D supra-adjacency matrix
    % cell array.
    %
    % RANDOMIZED_G = RANDOMIZE(G, 'AttemptsPerEdge', VALUE)
    % returns the randomized graph RANDOM_G obtained with a
    % randomized correlation matrix via the static function
    % randomize_A while preserving  degree distributions.
    % The multilayer is randomized layer by layer where randomized
    % adjacency matrix of each layer are then integrated in the
    % 2-D supra-adjacency matrix cell array.
    %
    % See also GraphBD

    % get rules
    number_of_weights = g.get('NUMBEROFWEIGHTS');
    attempts_per_edge = g.get('ATTEMPTSPEREDGE');

    if nargin<2
        attempts_per_edge = 5;
    end

            % get A
            A = g.get('A');
            [l, ls] = g.layernumber();
              
            % special case for multiplexBUD and multiplexBUT
            if Graph.is_binary(g)
                tmp_b = g.get('B');
                tmp_g = MultilayerWU('B', tmp_b);
                tmp_A = tmp_g.get('A');
                random_multi_A = cell(1, ls(1));
                for li = 1:1:ls(1)
                    Aii = tmp_A{li, li};
                    random_A = GraphWU.randomize_A(Aii, attempts_per_edge, number_of_weights);
                    random_multi_A(li) = {random_A};
                end
                if isa(g, 'MultiplexBUD')
                    random_g = MultiplexBUD('B', random_multi_A, 'Densities', g.get('Densities'));
                else
                    random_g = MultiplexBUT('B', random_multi_A, 'Thresholds', g.get('Thresholds'));
                end
                
            else % MultilayerWU
                random_multi_A = cell(1, l);
                for li = 1:1:l
                    Aii = A{li, li};
                    random_A = GraphWU.randomize_A(Aii, attempts_per_edge, number_of_weights);
                    random_multi_A(li) = {random_A};
                end
                random_g = MultilayerWU('B', random_multi_A);
            end
end