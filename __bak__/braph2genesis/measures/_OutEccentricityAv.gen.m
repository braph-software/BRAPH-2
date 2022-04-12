%% ¡header!
OutEccentricityAv < OutEccentricity (m, average out-eccentricity) is the graph average out-eccentricity.

%%% ¡description!
The average out-eccentricity of a node is the sum of the nodal out-eccentricities divided by their number within a layer.

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
MultiplexBD

%% ¡props_update!
%%% ¡prop!
M (result, cell) is the average out-eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
L = g.layernumber();
eccentricity_rule = m.get('rule');
out_eccentricity = OutEccentricity('G', g, 'rule', eccentricity_rule).get('M'); 

out_eccentricity_av = cell(L, 1);
for li = 1:1:L
    out_eccentricity_av(li) = {mean(out_eccentricity{li})};
end
value = out_eccentricity_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

known_out_eccentricity_subgraphs = {mean([1 1 1 1 0])};
known_out_eccentricity_default = {mean([Inf Inf Inf Inf Inf])};

g = GraphBD('B', B);
m_outside_g = OutEccentricityAv('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for GraphBD.')

g = GraphBD('B', B);
m_inside_g = g.getMeasure('OutEccentricityAv', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for GraphBD.')

g = GraphBD('B', B);
m_outside_g = OutEccentricityAv('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for GraphBD.')

g = GraphBD('B', B);
m_inside_g = g.getMeasure('OutEccentricityAv', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

known_out_eccentricity_subgraphs = {mean([10 5 5 10 0])};
known_out_eccentricity_default = {mean([Inf Inf Inf Inf Inf])};

g = GraphWD('B', B);
m_outside_g = OutEccentricityAv('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for GraphWD.')

g = GraphWD('B', B);
m_inside_g = g.getMeasure('OutEccentricityAv', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for GraphWD.')

g = GraphWD('B', B);
m_outside_g = OutEccentricityAv('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for GraphWD.')

g = GraphWD('B', B);
m_inside_g = g.getMeasure('OutEccentricityAv', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B22 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B = {
    B11 B22
    };

known_out_eccentricity_subgraphs = { 
                                mean([1 1 1 1 0])
                                mean([1 1 1 1 0])
                               };
known_out_eccentricity_default = {
                             mean([Inf Inf Inf Inf Inf])
                             mean([Inf Inf Inf Inf Inf])
                             };

g = MultiplexBD('B', B);
m_outside_g = OutEccentricityAv('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for MultiplexBD.')

g = MultiplexBD('B', B);
m_inside_g = g.getMeasure('OutEccentricityAv', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for MultiplexBD.')

g = MultiplexBD('B', B);
m_outside_g = OutEccentricityAv('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for MultiplexBD.')

g = MultiplexBD('B', B);
m_inside_g = g.getMeasure('OutEccentricityAv', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for MultiplexBD.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B22 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B = {
    B11 B22
    };

known_out_eccentricity_subgraphs = {
                                mean([10 5 5 10 0])
                                mean([10 5 5 10 0])
                               };
known_out_eccentricity_default = {
                             mean([Inf Inf Inf Inf Inf])
                             mean([Inf Inf Inf Inf Inf])
                             };
                           
g = MultiplexWD('B', B);
m_outside_g = OutEccentricityAv('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for MultiplexWD.')

g = MultiplexWD('B', B);
m_inside_g = g.getMeasure('OutEccentricityAv', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for MultiplexWD.')

g = MultiplexWD('B', B);
m_outside_g = OutEccentricityAv('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for MultiplexWD.')

g = MultiplexWD('B', B);
m_inside_g = g.getMeasure('OutEccentricityAv', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricityAv:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAv is not being calculated correctly for MultiplexWD.')