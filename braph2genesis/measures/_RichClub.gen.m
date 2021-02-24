%% ¡header!
RichClub < Degree (m, rich club) is the graph rich club.

%%% ¡description!
The rich-club of a node at level k is the fraction of the
edges that connect nodes of degree k or higher out of the
maxium number of edges that such nodes might share within a
layer. k is set by the user, the default value is equal to 1.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.PARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphBU
GraphWD
GraphWU
MultiplexGraphBD
MultiplexGraphBU
MultiplexWD
MultiplexWU

%% ¡props!
%%% ¡prop! 
PARAMETRIC_VALUE (parameter, SCALAR) 
%%%% ¡default!
1

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the rich club.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();

rich_club = cell(L, 1);
directionality_type = g.getDirectionalityType(L);  
richclub_threshold = m.get('PARAMETRIC_VALUE');
assert(mod(richclub_threshold, 1) == 0, ...
    [BRAPH2.STR ':RichClub:' BRAPH2.WRONG_INPUT], ...
    ['RichClub threshold must be an integer value ' ...
    'while it is ' tostring(richclub_threshold)])

k_level = abs(richclub_threshold);
for li = 1:1:L
    
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);
      
    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
        
        degree = calculateValue@Degree(m, prop);        
        deg = degree{li};
        
    else  % directed graphs        
        
        in_degree = InDegree('G', g).get('M');        
        out_degree = OutDegree('G', g).get('M');
        deg = (in_degree{li} + out_degree{li})/2;
    end
    
    richclub_layer = zeros(1, 1, k_level);
    Nk = zeros(1, k_level);
    Ek = zeros(1, k_level);
    for k = 1:1:k_level
        low_rich_nodes = find(deg <= k);  % get lower rich nodes with degree <= k
        Aii = binarize(Aii);  % binarizes the adjacency matrix
        subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <= k of Aii
        subAii(low_rich_nodes, :) = [];  % remove rows
        subAii(:, low_rich_nodes) = [];  % remove columns
        Nk(k) = size(subAii, 2);  % number of nodes with degree > k
        Ek(k) = sum(subAii(:));  % total number of connections in subgraph
        richclub_layer(1, 1, k) = Ek(k)/(Nk(k)*(Nk(k)-1));  % unweighted rich-club coefficient
    end
    richclub_layer(isnan(richclub_layer)) = 0;  % Should return zeros, since NaN happens when subAii has zero nodes with degree > k
    rich_club(li) = {richclub_layer};  % add rich club degree of layer li
end

value = rich_club;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!

A = [
    0  1  1  0;
    1  0  1  1;
    1  1  0  0;
    0  1  0  0
    ];

r(1, 1, 1) = 1;
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;

known_richclub = {r};

g = GraphBU('B', A);
richclub = RichClub('G', g, 'PARAMETRIC_VALUE', 3).get('M');

assert(isequal(richclub, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for GraphBU.')

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

r(1, 1, 1) = 3/4;
r(1, 1, 2) = 1;
r(1, 1, 3) = 0;

known_richclub = {r}; 

g = GraphWD('B', A);
richclub = RichClub('G', g, 'PARAMETRIC_VALUE', 3).get('M');

assert(isequal(richclub, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
%%%% ¡code!

A11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

A22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
A = {A11  A22};

richclub_l1(1, 1, 1) = 3/4;
richclub_l1(1, 1, 2) = 1;

richclub_l2(1, 1, 1) = 5/6;
richclub_l2(1, 1, 2) = 1;

known_richclub = {
                 richclub_l1
                 richclub_l2
                 };      

g = MultiplexGraphBD('B', A);
richclub = RichClub('G', g, 'PARAMETRIC_VALUE', 2).get('M');

assert(isequal(richclub, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for MultiplexGraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!

A11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];
A22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
A = {A11 A22};

richclub_l1(1, 1, 1) = 3/4;
richclub_l1(1, 1, 2) = 1;

richclub_l2(1, 1, 1) = 5/6;
richclub_l2(1, 1, 2) = 1;

known_richclub = {
                 richclub_l1
                 richclub_l2
                 };  

g = MultiplexWD('B', A);
richclub = RichClub('G', g, 'PARAMETRIC_VALUE', 2).get('M');

assert(isequal(richclub, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for MultiplexWD.')

