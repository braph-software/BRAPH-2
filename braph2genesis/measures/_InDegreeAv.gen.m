%% ¡header!
InDegreeAv < InDegree (m, degree) is the graph average in-degree.

%%% ¡description!
The average in-degree of a graph is the average of all number of inward edges connected to a node within a layer. 

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
M (result, cell) is the average in-degree.
%%%% ¡calculate!
in_degree = calculateValue@InDegree(m, prop);	
g = m.get('G'); % graph from measure class

in_degree_av = cell(g.layernumber(), 1);

parfor li = 1:1:g.layernumber()
    in_degree_av(li) = {mean(in_degree{li})};
end

value = in_degree_av;

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

known_in_degree_av = {mean([1 1 1]')};

g = GraphBD('B', B);

m_outside_g = InDegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for GraphBD.')

m_inside_g = g.getMeasure('InDegreeAv');
assert(isequal(m_inside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_in_degree_av = {mean([1 1 2]')};

g = GraphWD('B', B);

m_outside_g = InDegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for GraphWD.')

m_inside_g = g.getMeasure('InDegreeAv');
assert(isequal(m_inside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
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
B = {B11 B22};

known_in_degree_av = { 
                     mean([1 1 1]')
                     mean([2 2 1]')
                     };

g = MultiplexBD('B', B);

m_outside_g = InDegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for MultiplexBD.')

m_inside_g = g.getMeasure('InDegreeAv');
assert(isequal(m_inside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for MultiplexBD.')

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
B = {B11 B22};

known_in_degree_av = {
                     mean([1 1 2]')
                     mean([1 2 2]')
                     };

g = MultiplexWD('B', B);

m_outside_g = InDegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for MultiplexWD.')

m_inside_g = g.getMeasure('InDegreeAv');
assert(isequal(m_inside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for MultiplexWD.')