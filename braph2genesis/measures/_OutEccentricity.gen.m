%% ¡header!
OutEccentricity < Eccentricity (m, out-eccentricity) is the graph out-eccentricity.

%%% ¡description!
The out-eccentricity of a node is the maximal shortest out-path length between a node and any other node within a layer.

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
M (result, cell) is the out-eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
L = g.layernumber();

D = Distance('G', g).get('M'); 
eccentricity_rule = m.get('rule');
out_eccentricity = cell(L, 1);
for li = 1:1:L
    switch lower(eccentricity_rule)
        case {'subgraphs'}
            out_eccentricity(li)  = {max(D{li}.*(D{li}~=Inf), [], 2)}; 
        case {'all'}
            out_eccentricity(li)  = {max(D{li}, [], 2)};
    end
end
value = out_eccentricity;

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

known_out_eccentricity_subgraphs = {[1 1 1 1 0]'};
known_out_eccentricity_default = {[Inf Inf Inf Inf Inf]'};

g = GraphBD('B', B);
m_outside_g = OutEccentricity('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for GraphBD.')

g = GraphBD('B', B);
m_inside_g = g.getMeasure('OutEccentricity', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for GraphBD.')

g = GraphBD('B', B);
m_outside_g = OutEccentricity('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for GraphBD.')

g = GraphBD('B', B);
m_inside_g = g.getMeasure('OutEccentricity', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for GraphBD.')

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

known_out_eccentricity_subgraphs = {[10 5 5 10 0]'};
known_out_eccentricity_default = {[Inf Inf Inf Inf Inf]'};

g = GraphWD('B', B);
m_outside_g = OutEccentricity('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for GraphWD.')

g = GraphWD('B', B);
m_inside_g = g.getMeasure('OutEccentricity', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for GraphWD.')

g = GraphWD('B', B);
m_outside_g = OutEccentricity('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for GraphWD.')

g = GraphWD('B', B);
m_inside_g = g.getMeasure('OutEccentricity', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for GraphWD.')

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
                                [1 1 1 1 0]'
                                [1 1 1 1 0]'
                               };
known_out_eccentricity_default = {
                             [Inf Inf Inf Inf Inf]'
                             [Inf Inf Inf Inf Inf]'
                             };

g = MultiplexBD('B', B);
m_outside_g = OutEccentricity('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for MultiplexBD.')

g = MultiplexBD('B', B);
m_inside_g = g.getMeasure('OutEccentricity', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for MultiplexBD.')

g = MultiplexBD('B', B);
m_outside_g = OutEccentricity('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for MultiplexBD.')

g = MultiplexBD('B', B);
m_inside_g = g.getMeasure('OutEccentricity', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for MultiplexBD.')

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
                                [10 5 5 10 0]'
                                [10 5 5 10 0]'
                               };
known_out_eccentricity_default = {
                             [Inf Inf Inf Inf Inf]'
                             [Inf Inf Inf Inf Inf]'
                             };
                           
g = MultiplexWD('B', B);
m_outside_g = OutEccentricity('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for MultiplexWD.')

g = MultiplexWD('B', B);
m_inside_g = g.getMeasure('OutEccentricity', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for MultiplexWD.')

g = MultiplexWD('B', B);
m_outside_g = OutEccentricity('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for MultiplexWD.')

g = MultiplexWD('B', B);
m_inside_g = g.getMeasure('OutEccentricity', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricity:' BRAPH2.BUG_ERR], ...
    'OutEccentricity is not being calculated correctly for MultiplexWD.')