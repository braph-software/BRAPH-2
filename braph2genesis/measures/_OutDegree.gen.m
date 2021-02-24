%% ¡header!
OutDegree < Measure (m, degree) is the graph out-degree.

%%% ¡description!
The out-degree of a node is the number of outward edges connected to the node within a layer. 
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
MultiplexWD
MultiplexGraphBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the out-degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

out_degree = cell(g.layernumber(), 1);

for li = 1:1:g.layernumber()
    Aii = A{li, li};
    Aii = binarize(Aii);  % binarizes the adjacency matrix
    out_degree(li) = {sum(Aii, 2)};  % calculates the out-degree of a node for layer li
end

value = out_degree;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   1   1
    0   0   0
    1   0   0
    ];

known_out_degree = {[2 0 1]'};

g = GraphBD('B', B);

m_outside_g = OutDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for GraphBD.')

m_inside_g = g.getMeasure('OutDegree');
assert(isequal(m_inside_g.get('M'), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_out_degree = {[2 1 1]'};

g = GraphWD('B', B);

m_outside_g = OutDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for GraphWD.')

m_inside_g = g.getMeasure('OutDegree');
assert(isequal(m_inside_g.get('M'), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
%%%% ¡code!
B11 = [
      0  1  1
      0  0  0
      1  0  0
      ];
B22 = [
       0  1  0
       1  0  1
       1  1  0
       ];
B = {
    B11 B22
    };

known_out_degree = { 
                   [2 0 1]'
                   [1 2 2]'
                   };

g = MultiplexGraphBD('B', B);

m_outside_g = OutDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for MultiplexGraphBD.')

m_inside_g = g.getMeasure('OutDegree');
assert(isequal(m_inside_g.get('M'), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for MultiplexGraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
      0   .2  1
      0   0   .8
      1   0   0
      ];
B22 = [
      0  1   .6
      1  0   .4
      0  .4  0
      ];
B = {
    B11 B22
    };

known_out_degree = {
                  [2 1 1]'
                  [2 2 1]'
                  };

g = MultiplexWD('B', B);

m_outside_g = OutDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for MultiplexWD.')

m_inside_g = g.getMeasure('OutDegree');
assert(isequal(m_inside_g.get('M'), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for MultiplexWD.')