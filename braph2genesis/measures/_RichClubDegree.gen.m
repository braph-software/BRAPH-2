%% ¡header!
RichClubDegree < Degree (m, rich club degree) is the graph rich club degree.

%%% ¡description!
The rich-club degree of a node at level k is the sum of 
the edges that connect nodes of degree k or higher within a layer. 
k is set by the user; the default value is equal to 1. 

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.PARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphBU
GraphWD
GraphWU
MultiplexBD
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
M (result, cell) is the degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = g.nodenumber();

rich_club_degree = cell(L, 1); 
directionality_type = g.getDirectionalityType(L);
richclub_threshold = m.get('PARAMETRIC_VALUE');
assert(mod(richclub_threshold, 1) == 0, ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.WRONG_INPUT], ...
    ['RichClubDegree threshold must be an integer value ' ...
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

    richclub_layer = zeros(N(1), 1, k_level);
    for k = 1:1:k_level
        low_rich_nodes = find(deg <= k);  % get lower rich nodes with degree <= k
        Aii = binarize(Aii);  % binarizes the adjacency matrix
        subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <= k of Aii
        subAii(low_rich_nodes, :) = 0;  % remove rows
        subAii(:, low_rich_nodes) = 0;  % remove columns

        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            richclub_layer(:, :, k) = sum(subAii, 1)';  % degree of high rich nodes
        else
            richclub_layer(:, :, k) = (sum(subAii, 1)' + sum(subAii, 2))/2;  % degree of high rich nodes
        end

    end
    rich_club_degree(li) = {richclub_layer};  % add rich club degree of layer li          
end

value = rich_club_degree;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
     0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richclubdegree = {[2 2 2 0]'};

g = GraphBU('B', B);

richclubdegree = RichClubDegree('G', g);
assert(isequal(richclubdegree.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for GraphBU.')


%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_richclubdegree = {[2 2 2 0]'};

g = GraphWU('B', A);
richclubdegree = RichClubDegree('G', g, 'PARAMETRIC_VALUE', 1).get('M');

assert(isequal(richclubdegree, known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
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
A = {A11 A22};

richness_l1(:, 1, 1) = [5/2 3 2 3/2]';
richness_l1(:, 1, 2) = [1 1 0 0]';

richness_l2(:, 1, 1) = [5/2 3 5/2 2]';
richness_l2(:, 1, 2) = [2 2 2 0]';

known_richclubdegree = {
                 richness_l1
                 richness_l2
                 };      

g = MultiplexBD('B', A);
richclubdegree = RichClubDegree('G', g, 'PARAMETRIC_VALUE', 2).get('M');

assert(isequal(richclubdegree, known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for MultiplexBD.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!

A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {A11 A22};


known_richclubdegree = {
    [2 2 2 0]'
    [3 3 2 2]'
    };

g = MultiplexWU('B', A);
richclubdegree = RichClubDegree('G', g, 'PARAMETRIC_VALUE', 1).get('M');

assert(isequal(richclubdegree, known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for MultiplexWU.')
