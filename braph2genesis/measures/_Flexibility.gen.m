%% ¡header!
Flexibility < MultilayerCommunity (m, flexibility) is the graph flexibility.

%%% ¡description!
The flexibility of each node in a multilayer network is calculated 
as the number of times that it changes community assignment, 
normalized by the total possible number of changes. In ordered 
multilayer networks (e.g. temporal, changes are possible only between 
adjacent layers, whereas in categorical multilayer networks, 
community assignment changes are possible between any pairs of layers.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the flexibility.
%%%% ¡default!
'Flexibility '

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the flexibility.
%%%% ¡default!
'The flexibility of each node in a multilayer network is calculated  as the number of times that it changes community assignment, normalized by the total possible number of changes. In ordered multilayer networks (e.g. temporal, changes are possible only between adjacent layers, whereas in categorical multilayer networks, community assignment changes are possible between any pairs of layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the flexibility.

%%% ¡prop!
ID (data, string) is a few-letter code of the flexibility.
%%%% ¡default!
'Flexibility ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the flexibility.
%%%% ¡default!
'Flexibility label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the flexibility.
%%%% ¡default!
'Flexibility notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

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
{'MultiplexBU' 'MultiplexWD' 'MultiplexBD' 'MultiplexWU' 'MultilayerBD' 'MultilayerBU' 'MultilayerWD' 'MultilayerWU' 'OrdMlWD' 'OrdMlWU' 'OrdMlBU' 'OrdMlBD' 'OrdMxWD' 'OrdMxWU' 'OrdMxBD' 'OrdMxBU'} ;%TBE % % % add any missing tests

%%% ¡prop!
M (result, cell) is the flexibility.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
if isempty(N)
    N(1) = 1;
end
N = N(1);
S = calculateValue@MultilayerCommunity(m, prop);
S = cell2mat(S');
flexibility = zeros(N, 1);

if g.get('GRAPH_TYPE') == 4 || g.get('GRAPH_TYPE') ==6
    % categorical 
    for i=1:L
        otherlayers = 1:L;
        otherlayers = otherlayers(otherlayers~=i); % all layers except the current one
        flexibility = flexibility + sum(repmat(S(:,i),1, (L-1)) ~= S(:,otherlayers), 2);
    end    
    flexibility = flexibility/(L*(L-1));
elseif g.get('GRAPH_TYPE') == 3 || g.get('GRAPH_TYPE') ==5
    % ordinal 
    for i=1:L-1
        flexibility = flexibility + S(:, i) ~= S(:, i+1);
    end
    flexibility = flexibility/(L-1);
end

value = {flexibility};

%% ¡tests!

%%% ¡excluded_props!
[Flexibility.PFM]

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
 
known_flexibility = {[0 0 0 0]'}; 

g = MultiplexBU('B', B);

m_outside_g = Flexibility('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Flexibility');
assert(isequal(m_inside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

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
 
known_flexibility = {[0 0 0 0]'};  

g = MultiplexWD('B', A);

m_outside_g = Flexibility('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Flexibility');
assert(isequal(m_inside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWD
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
 
known_flexibility = {[0 0 0 0]'};  

g = MultilayerWD('B', A);

m_outside_g = Flexibility('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Flexibility');
assert(isequal(m_inside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWD
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
 
known_flexibility = {[0 0 0 0]'};  

g = OrdMlWD('B', A);

m_outside_g = Flexibility('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Flexibility');
assert(isequal(m_inside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])