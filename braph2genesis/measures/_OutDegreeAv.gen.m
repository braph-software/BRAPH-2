%% ¡header!
OutDegreeAv < OutDegree (m, degree) is the graph average out-degree.

%%% ¡description!
The average out-degree of a graph is the average of all number of outward edges connected to a node within a layer. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
GraphBD
MultiplexWD
MultiplexBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average out-degree.
%%%% ¡calculate!
out_degree = calculateValue@OutDegree(m, prop);	
g = m.get('G'); % graph from measure class

out_degree_av = cell(g.layernumber(), 1);

for li = 1:1:g.layernumber()
    out_degree_av(li) = {mean(out_degree{li})};
end

value = out_degree_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_out_degree_av = {mean([2 1 1]')};

g = GraphBD('B', B);

m_outside_g = OutDegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for GraphBD.')

m_inside_g = g.getMeasure('OutDegreeAv');
assert(isequal(m_inside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_out_degree_av = {mean([2 1 1])};

g = GraphWD('B', B);

m_outside_g = OutDegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for GraphWD.')

m_inside_g = g.getMeasure('OutDegreeAv');
assert(isequal(m_inside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
      0  1  1
      0  0  1
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

known_out_degree_av = { 
                      mean([2 1 1]')
                      mean([1 2 2]')
                      };

g = MultiplexBD('B', B);

m_outside_g = OutDegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for MultiplexBD.')

m_inside_g = g.getMeasure('OutDegreeAv');
assert(isequal(m_inside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for MultiplexBD.')

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

known_out_degree_av = {
                      mean([2 1 1]')
                      mean([2 2 1]')
                      };

g = MultiplexWD('B', B);

m_outside_g = OutDegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for MultiplexWD.')

m_inside_g = g.getMeasure('OutDegreeAv');
assert(isequal(m_inside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for MultiplexWD.') 