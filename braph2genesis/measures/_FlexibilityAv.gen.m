%% ¡header!
FlexibilityAv < Flexibility (m, average flexibility) is the graph average flexibility.

%%% ¡description!
The average flexibility of a graph is the average of the flexibility 
of all nodes. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexBU
MultiplexBD
MultiplexWU
MultiplexWD
OrderedMultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average flexibility.
%%%% ¡calculate!
flexibility_av = calculateValue@Flexibility(m, prop);
flexibility_av = {mean(flexibility_av{1})};

value = flexibility_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexBU
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
A = {A11 A22};
 
known_flexibility_av = {0};   
 
g = MultiplexBU('B', A);
flexibility_av = FlexibilityAv('G', g).get('M');

assert(isequal(flexibility_av, known_flexibility_av), ...
    [BRAPH2.STR ':FlexibilityAv:' BRAPH2.BUG_ERR], ...
    'FlexibilityAv is not being calculated correctly for MultiplexBU.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
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
A = {A11 A22};
 
known_flexibility_av = {0};   
 
g = MultiplexWD('B', A);
flexibility_av = FlexibilityAv('G', g).get('M');

assert(isequal(flexibility_av, known_flexibility_av), ...
    [BRAPH2.STR ':FlexibilityAv:' BRAPH2.BUG_ERR], ...
    'FlexibilityAv is not being calculated correctly for MultiplexWD.')