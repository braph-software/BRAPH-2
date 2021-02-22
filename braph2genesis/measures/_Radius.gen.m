%% ¡header!
Radius < Measure (m, degree) is the graph degree.

%%% ¡description!
The radius is the minimum eccentricity among the vertice within a layer

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphBU
MultigraphBU
MultigraphBU

%% ¡props!
%%% ¡prop! 
rule (metadata, OPTION) 
%%%% ¡settings!
{'default', 'subgraphs'}
%%%% ¡default!
'default'

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
L = g.layernumber();

eccentricity = Eccentricity('G', g, 'rule', m.get('rule')).get('M');
radius = cell(L, 1);
for li = 1:1:L
    radius(li) = {min(eccentricity{li})};
end

value = radius;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
A = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];
    
known_radius_subgraphs = {0};

g = GraphBU(A);
radius = Radius('G', g, 'rule', 'subgraphs').get('M');

assert(isequal(radius, known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.BUG_ERR], ...
    'Radius is not being calculated correctly for GraphBU.')

known_radius_default = {Inf};

radius = Radius('G', g, 'rule', 'default').get('M');

assert(isequal(radius, known_radius_default), ...
    [BRAPH2.STR ':Radius:' BRAPH2.BUG_ERR], ...
    'Radius is not being calculated correctly for GraphBU.')


%%% ¡test!
%%%% ¡name!
MultiplexGraphWU
%%%% ¡code!
A11 = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

A22 = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

A = {A11 A22};

known_radius_subgraphs = {
                            0
                            0
                            };

g = MultiplexGraphWU(A);
radius = Radius('G', g, 'rule', 'subgraphs').get('M');

assert(isequal(radius, known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.BUG_ERR], ...
    'Radius is not being calculated correctly for MultiplexGraphWU.')

known_radius_default = {
                        Inf
                        Inf
                        };

radius = Radius('G', g).get('M');

assert(isequal(radius, known_radius_default), ...
    [BRAPH2.STR ':Radius:' BRAPH2.BUG_ERR], ...
    'Radius is not being calculated correctly for MultiplexGraphWU.')