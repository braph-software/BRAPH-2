%% ¡header!
SCore < Measure (m, s-core) is the graph s-core.

%%% ¡description!
The s-core of a graph is the largest subnetwork comprising nodes of strength
s or higher. s is set by the user; the default value is equal to 1.

%%% ¡shape!
shape = Measure.BINODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
GraphWU
MultiplexWU
MultiplexWD

%% ¡props!
%%% ¡prop! 
SCoreThreshold (parameter, scalar) is the strength threshold.
%%%% ¡default!
1

%% ¡props_update!
%%% ¡prop!
M (result, cell) is the s-core.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell matrix for graph, multigraph, or multiplex, etc
L = g.layernumber();

score_threshold = m.get('SCoreThreshold');
assert(isnumeric(score_threshold) == 1, ...
    [BRAPH2.STR ':SCore:' BRAPH2.WRONG_INPUT], ...
    ['SCore threshold must be a positive number ' ...
    'while it is ' tostring(score_threshold)])

s_core = cell(L, 1);
directionality_type =  g.getDirectionalityType(L);
for li = 1:1:L    
    
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);

    iter = 0;
    subAii = Aii;
    while 1
        % get strengths of matrix
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            st = sum(subAii, 1)';  % degree undirected graphs
        else
            st = (sum(subAii, 1)' + sum(subAii, 2));  % strength directed
        end
        
        % find nodes with degree < k
        low_s_nodes = find((st < score_threshold) & (st > 0));
        
        % if none found -> stop
        if (isempty(low_s_nodes)) break; end; %#ok<SEPEX>
        
        % peel away found nodes
        iter = iter + 1;
        subAii(low_s_nodes, :) = 0;
        subAii(:, low_s_nodes) = 0;
    end
    s_core(li) = {subAii};  % add s-core of layer li
end
value = s_core;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
A = [
    0   .5  1  0; 
    .5  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_score = {[
                0   .5  1  0;
                .5  0   1  0;
                1   1   0  0;
                0   0   0  0
                ]};

g = GraphWU('B', A);
score = Score('G', g, 'SCoreThreshold', 1.5).get('M');

assert(isequal(score, known_score), ...
    [BRAPH2.STR ':SCore:' BRAPH2.BUG_ERR], ...
    'SCore is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

known_score = {[
                0   1  1  0; 
                .2  0  1  0; 
                1   1  0  0;
                0   0  0  0
                ]};

g = GraphWD('B', A);
score = Score('G', g, 'SCoreThreshold', 3).get('M');

assert(isequal(score, known_score), ...
    [BRAPH2.STR ':SCore:' BRAPH2.BUG_ERR], ...
    'SCore is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
A11 = [
    0   .5  1  0; 
    .5  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .5  1  0; 
    .5  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
A = {A11 A22};
             
known_score(1) = {[
                0   .5  1  0;
                .5  0   1  0;
                1   1   0  0;
                0   0   0  0
                ]};
known_score(2, 1) = {[
                0   .5  1  0;
                .5  0   1  0;
                1   1   0  0;
                0   0   0  0
                ]};            

g = MultiplexWU('B', A);
score = Score('G', g, 'SCoreThreshold', 1.5).get('M');

assert(isequal(score, known_score), ...
    [BRAPH2.STR ':SCore:' BRAPH2.BUG_ERR], ...
    'SCore is not being calculated correctly for MultiplexWU.')
