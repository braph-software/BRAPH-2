%% ¡header!
CategoricalPersistence < Measure (m, categorical persistence) is the graph categorical persistence.

%%% ¡description!
The categorical persistence of an unordered multilayer network is the 
sum over all pairs of layers of the number of nodes that 
do not change community assignments. It varies between 0 and 1.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexWU
MultiplexWD
MultiplexBU
MultiplexBD

%% ¡props!
%%% ¡prop! 
rule (metadata, OPTION) 
%%%% ¡settings!
{ 'louvain' 'newman'}
%%%% ¡default!
'louvain'

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the categorical persistence.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = g.nodenumber();
if isempty(N)
    N(1) = 1;
end
N = N(1);

S = MultilayerCommunityStructure('G', g).get('M');
S = cell2mat(S');
m.Ci = S;

S = {S};
all2all = N*[(-L+1):-1,1:(L-1)];
A = spdiags(ones(N*L, 2*L-2), all2all, N*L, N*L);
for i = 1:length(S)
    G = sparse(1:length(S{i}(:)), S{i}(:), 1);
    categorical_persistence_l = trace(G'*A*G)/(N*L*(L-1));
    categorical_persistence = {categorical_persistence_l};
end

value = categorical_persistence;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
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
 
known_categorical_persistence = {1};   
 
g = MultiplexBU('B', A);
categorical_persistence = CategoricalPersistence('G', g).get('M');

assert(isequal(categorical_persistence, known_categorical_persistence), ...
    [BRAPH2.STR ':CategoricalPersistence:' BRAPH2.BUG_ERR], ...
    'CategoricalPersistence is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
GraphBD
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
 
known_categorical_persistence = {1};   
 
g = MultiplexWD('B', A);
categorical_persistence = CategoricalPersistence('G', g).get('M');

assert(isequal(categorical_persistence, known_categorical_persistence), ...
    [BRAPH2.STR ':CategoricalPersistence:' BRAPH2.BUG_ERR], ...
    'CategoricalPersistence is not being calculated correctly for MultiplexGraphWD.')