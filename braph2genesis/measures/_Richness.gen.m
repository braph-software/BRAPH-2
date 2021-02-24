%% ¡header!
Richness < Degree (m, richness) is the graph richness.

%%% ¡description!
The richness of a node is the sum of the edges that connect nodes
of higher degree within a layer.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphBU
GraphWD
GraphWU
MultiplexGraphBD
MultiplexGraphBU
MultiplexWD
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the richness.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = g.nodenumber();

richness = cell(L, 1); 
directionality_type = g.getDirectionalityType(L);    
for li = 1:1:L
    
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);

    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
        
        degree = calculateValue@Degree(m, prop);    
        k = degree{li};
        
    else  % directed graphs
                
        in_degree = InDegree('G', g).get('M');        
        out_degree = OutDegree('G', g).get('M');        
        
        k = in_degree{li} + out_degree{li};
    end
    
    kMinus = zeros(size(k));
    kPlus = zeros(size(k));
    
    for i = 1:N(li)
        lrInd = k <= k(i); % Indices of nodes with Lower Richness (LR)
        hrInd = k > k(i); % Indices of nodes with Higher Richness (HR)
        lrA = Aii;
        lrA(i, hrInd) = 0;
        lrA(hrInd, i) = 0;
        hrA = Aii;
        hrA(i, lrInd) = 0;
        hrA(lrInd, i) = 0;
        
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            kMinusForI = sum(lrA, 1)';
            kPlusForI = sum(hrA, 1)';
        else
            kMinusForI = (sum(lrA, 1)' + sum(lrA, 2))/2;
            kPlusForI = (sum(hrA, 1)' + sum(hrA, 2))/2;
        end
        kMinus(i) = kMinusForI(i);
        kPlus(i) = kPlusForI(i);
    end
    richness(li) = {kPlus};  % add richness of layer li
end

value = richness;

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

known_richness = {[1 0 1 1]'};

g = GraphBU('B', A);
richness = Richness('G', g).get('M');

assert(isequal(richness, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
A = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness = {[1 0 2 3/2]'};

g = GraphBD('B', A);
richness = Richness('G', g).get('M');

assert(isequal(richness, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for GraphBD.')

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
A = {A11 A22};
             
known_richness = {
                 [1 0 2 3/2]'
                 [1 0 1 2]'
                 };    

g = MultiplexGraphBD('B', A);
richness = Richness('G', g).get('M');

assert(isequal(richness, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for MultiplexGraphBD.')


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

known_richness = {
                 [.6 0 2 .7]'
                 [.6 0 1 21/20]'
                 };   

g = MultiplexWD('B', A);
richness = Richness('G', g).get('M');
richness = cellfun(@(s) round(s, 4), richness, 'UniformOutput', false);

assert(isequal(richness, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for MultiplexWD.')
