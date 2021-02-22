%% ¡header!
Diameter < Measure (m, diameter) is the graph diameter.

%%% ¡description!
The diameter is the maximum eccentricity among the vertice within a layer.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphBU
MultiplexGraphBU
MultiplexGraphWU

%% ¡props!
%%% ¡prop! 
rule (metadata, OPTION) 
%%%% ¡settings!
{'all', 'subgraphs'}
%%%% ¡default!
'all'

%% ¡props_update!
%%% ¡prop!
M (result, cell) is the diameter.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell matrix for graph, multigraph, or multiplex, etc

eccentricity = Eccentricity('G', g, 'RULE', m.get('rule')).get('M');
diameter = cell(g.layernumber(), 1);

for li = 1:1:g.layernumber()
    diameter(li) = {max(eccentricity{li})};
end

value = diameter;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

known_diameter_subgraphs = {1};
known_diameter_default = {Inf};

g = GraphBU('B', B);
m_outside_g = Diameter('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphBU.')

g = GraphBU('B', B);
m_inside_g = g.getMeasure('Diameter', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphBU.')

g = GraphBU('B', B);
m_outside_g = Diameter('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphBU.')

g = GraphBU('B', B);
m_inside_g = g.getMeasure('Diameter', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

known_diameter_subgraphs = {5};
known_diameter_default = {Inf};

g = GraphWU('B', B);
m_outside_g = Diameter('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphWU.')

g = GraphWU('B', B);
m_inside_g = g.getMeasure('Diameter', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphWU.')

g = GraphWU('B', B);
m_outside_g = Diameter('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphWU.')

g = GraphWU('B', B);
m_inside_g = g.getMeasure('Diameter', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBU
%%%% ¡code!
B11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B = {
    B11 B22
    };

known_diameter_subgraphs = { 
                         1
                         1 
                         };
known_diameter_default = {
                       inf
                       inf
                       };

g = MultiplexGraphBU('B', B);
m_outside_g = Diameter('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphBU.')

g = MultiplexGraphBU('B', B);
m_inside_g = g.getMeasure('Diameter', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphBU.')

g = MultiplexGraphBU('B', B);
m_outside_g = Diameter('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphBU.')

g = MultiplexGraphBU('B', B);
m_inside_g = g.getMeasure('Diameter', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWU
%%%% ¡code!
B11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B = {
    B11 B22
    };

known_diameter_subgraphs = {
                         5
                         5
                         };
known_diameter_default = {
                       inf
                       inf
                       };
                           
g = MultiplexGraphWU('B', B);
m_outside_g = Diameter('G', g, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphWU.')

g = MultiplexGraphWU('B', B);
m_inside_g = g.getMeasure('Diameter', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphWU.')

g = MultiplexGraphWU('B', B);
m_outside_g = Diameter('G', g, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphWU.')

g = MultiplexGraphWU('B', B);
m_inside_g = g.getMeasure('Diameter', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphWU.')