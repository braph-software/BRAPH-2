%% ¡header!
InDegree < Measure (m, degree) is the graph degree.

%%% ¡description!
The degree of a node is the number of edges connected to the node within a layer. 
Connection weights are ignored in calculations.

The in-degree of a node is the number of inward edges connected to a node within a layer.
Connection weights are ignored in calculations.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
GraphBD
MultiplexGraphWD
MultiplexGraphBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the in-degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

in_degree = cell(g.layernumber(), 1);

for li = 1:1:g.layernumber()
    Aii = A{li, li};
    Aii = binarize(Aii);  % binarizes the adjacency matrix
    in_degree(li) = {sum(Aii, 1)'};  % calculates the in-degree of a node for layer li
end

value = in_degree;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   1   1
    1   0   0
    1   0   0
    ];

known_in_degree = {[1 1 1]'};

g = GraphBD('B', {B});

m_outside_g = InDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for GraphBD.')

m_inside_g = g.getMeasure('InDegree');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_in_degree = {[1 1 2]'};

g = GraphWD('B', {B});

m_outside_g = InDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for GraphWD.')

m_inside_g = g.getMeasure('InDegree');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
%%%% ¡code!
B11 = [
      0  1  1
      0  0  0
      1  0  0
      ];
B12 = eye(3);
B21 = eye(3);
B22 = [
       0  1  0
       1  0  1
       1  1  0
       ];
B = {
    A11     A12  
    A21     A22
    };

known_in_degree = { 
                  [1 1 1]'
                  [2 2 1]'
                  };

g = MultiplexGraphBD('B', {B});

m_outside_g = InDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for MultiplexGraphBD.')

m_inside_g = g.getMeasure('InDegree');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for MultiplexGraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWD
%%%% ¡code!
A11 = [
      0   .2  1
      0   0   .8
      1   0   0
      ];
A12 = eye(3);
A21 = eye(3);
A22 = [
      0  1   .6
      1  0   .4
      0  .4  0
      ];
A = {
    A11     A12  
    A21     A22
    };

known_in_degree = {
                  [1 1 2]'
                  [1 2 2]'
                  };

g = MultiplexGraphWD('B', {B});

m_outside_g = InDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for MultiplexGraphWD.')

m_inside_g = g.getMeasure('InDegree');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for MultiplexGraphWD.')