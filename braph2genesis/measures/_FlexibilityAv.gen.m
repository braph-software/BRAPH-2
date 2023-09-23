%% ¡header!
FlexibilityAv < Flexibility (m, average flexibility) is the graph average flexibility.

%%% ¡description!
The average flexibility of a multilayer graph is the average of the flexibility 
of all nodes.

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'FlexibilityAv'

%%% ¡prop!
NAME (constant, string) is the name of the average flexibility.
%%%% ¡default!
'FlexibilityAv '

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the average flexibility.
%%%% ¡default!
'The average flexibility of a multilayer graph is the average of the flexibility of all nodes.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the average flexibility.
%%%% ¡settings!
'FlexibilityAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the average flexibility.
%%%% ¡default!
'FlexibilityAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the average flexibility.
%%%% ¡default!
'FlexibilityAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the average flexibility.
%%%% ¡default!
'FlexibilityAv notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.
%%%% ¡default!
Measure.GLOBAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.SUPERGLOBAL__.
%%%% ¡default!
Measure.SUPERGLOBAL

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'MultiplexWU' 'OrdMxWU' 'MultiplexBU' 'MultiplexBUT' 'MultiplexBUD' 'MultilayerBU' 'MultilayerWU' 'OrdMlWU'};

%%% ¡prop!
M (result, cell) is the average flexibility.
%%%% ¡calculate!
flexibility_av = calculateValue@Flexibility(m, prop);
flexibility_av = {mean(flexibility_av{1})};

value = flexibility_av;

%% ¡tests!

%%% ¡excluded_props!
[FlexibilityAv.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];

A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B = {A11 A22};
 
known_flexibility_av = {0};

g = MultiplexBU('B', B);

m_outside_g = FlexibilityAv('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility_av), ...
    [BRAPH2.STR ':FlexibilityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'FlexibilityAv');
assert(isequal(m_inside_g.get('M'), known_flexibility_av), ...
    [BRAPH2.STR ':FlexibilityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWU
%%%% ¡code!
A11 = [
      0  1 1 .5;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A22 = [
      0  1 1 .5;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A12 = rand(size(A11,1),size(A22,2));
A21 = A12';
A = {A11 A12;
     A21 A22};
 
known_flexibility_av = {0};  

g = MultilayerWU('B', A);

m_outside_g = FlexibilityAv('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility_av), ...
    [BRAPH2.STR ':FlexibilityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'FlexibilityAv');
assert(isequal(m_inside_g.get('M'), known_flexibility_av), ...
    [BRAPH2.STR ':FlexibilityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWU
%%%% ¡code!
A11 = [
      0  1 1 .5;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A22 = [
      0  1 1 .5;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A12 = rand(size(A11,1),size(A22,2));
A21 = A12';
A = {A11 A12;
     A21 A22};
 
known_flexibility_av = {0};  

g = OrdMlWU('B', A);

m_outside_g = FlexibilityAv('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility_av), ...
    [BRAPH2.STR ':FlexibilityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'FlexibilityAv');
assert(isequal(m_inside_g.get('M'), known_flexibility_av), ...
    [BRAPH2.STR ':FlexibilityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
