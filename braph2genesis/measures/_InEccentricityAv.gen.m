%% ¡header!
InEccentricityAv < InEccentricity (m, average in-eccentricity) is the graph average in-eccentricity.

%%% ¡description!
The average in-eccentricity of a node is the sum of the nodal 
in-eccentricities divided by their number within a layer.

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
M (result, cell) is the average in-eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
L = g.layernumber();
eccentricity_rule = m.get('rule');
in_eccentricity = InEccentricity('G', g, 'rule', eccentricity_rule).get('M'); 

in_eccentricity_av = cell(L, 1);
for li = 1:1:L
    in_eccentricity_av(li) = {mean(in_eccentricity{li})};
end
value = in_eccentricity_av;

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

known_in_eccentricity_av_subgraphs = {mean([1 1 1 1 0])};
known_in_eccentricity_av_default = {mean([Inf Inf Inf Inf Inf])};

g = GraphBD('B', B);
m_outside_g = InEccentricityAv('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_in_eccentricity_av_subgraphs), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for GraphBD.')

g = GraphBD('B', B);
m_inside_g = g.getMeasure('InEccentricityAv', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_in_eccentricity_av_subgraphs), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for GraphBD.')

g = GraphBD('B', B);
m_outside_g = InEccentricityAv('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_in_eccentricity_av_default), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for GraphBD.')

g = GraphBD('B', B);
m_inside_g = g.getMeasure('InEccentricityAv', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_in_eccentricity_av_default), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for GraphBD.')

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

known_in_eccentricity_av_subgraphs = {mean([5 10 10 5 0])};
known_in_eccentricity_av_default = {mean([Inf Inf Inf Inf Inf])};

g = GraphWD('B', B);
m_outside_g = InEccentricityAv('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_in_eccentricity_av_subgraphs), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for GraphWD.')

g = GraphWD('B', B);
m_inside_g = g.getMeasure('InEccentricityAv', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_in_eccentricity_av_subgraphs), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for GraphWD.')

g = GraphWD('B', B);
m_outside_g = InEccentricityAv('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_in_eccentricity_av_default), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for GraphWD.')

g = GraphWD('B', B);
m_inside_g = g.getMeasure('InEccentricityAv', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_in_eccentricity_av_default), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for GraphWD.')

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

known_in_eccentricity_av_subgraphs = { 
                                mean([1 1 1 1 0])
                                mean([1 1 1 1 0])
                               };
known_in_eccentricity_av_default = {
                             mean([Inf Inf Inf Inf Inf])
                             mean([Inf Inf Inf Inf Inf])
                             };

g = MultiplexBD('B', B);
m_outside_g = InEccentricityAv('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_in_eccentricity_av_subgraphs), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for MultiplexBD.')

g = MultiplexBD('B', B);
m_inside_g = g.getMeasure('InEccentricityAv', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_in_eccentricity_av_subgraphs), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for MultiplexBD.')

g = MultiplexBD('B', B);
m_outside_g = InEccentricityAv('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_in_eccentricity_av_default), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for MultiplexBD.')

g = MultiplexBD('B', B);
m_inside_g = g.getMeasure('InEccentricityAv', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_in_eccentricity_av_default), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for MultiplexBD.')

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

known_in_eccentricity_av_subgraphs = {
                                mean([5 10 10 5 0])
                                mean([5 10 10 5 0])
                               };
known_in_eccentricity_av_default = {
                             mean([Inf Inf Inf Inf Inf])
                             mean([Inf Inf Inf Inf Inf])
                             };
                           
g = MultiplexWD('B', B);
m_outside_g = InEccentricityAv('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_in_eccentricity_av_subgraphs), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for MultiplexWD.')

g = MultiplexWD('B', B);
m_inside_g = g.getMeasure('InEccentricityAv', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_in_eccentricity_av_subgraphs), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for MultiplexWD.')

g = MultiplexWD('B', B);
m_outside_g = InEccentricityAv('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_in_eccentricity_av_default), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for MultiplexWD.')

g = MultiplexWD('B', B);
m_inside_g = g.getMeasure('InEccentricityAv', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_in_eccentricity_av_default), ...
    [BRAPH2.STR ':InEccentricityAv:' BRAPH2.BUG_ERR], ...
    'InEccentricityAv is not being calculated correctly for MultiplexWD.')