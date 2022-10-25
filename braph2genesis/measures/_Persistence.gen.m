%% ¡header!
Persistence < MultilayerCommunityStructure (m, persistence) is the graph persistence.

%%% ¡description!
The persistence of a multilayer network is calculated as the normalized 
sum of the number of nodes that do not change community assignments. It 
varies between 0 and 1. 
In categorical multilayer networks, it is the sum over all pairs of layers 
of the number of nodes that do not change community assignments, whereas 
in ordinal multilayer networks (e.g. temporal), it is the number of nodes 
that do not change community assignments between consecutive layers.

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
%S = MultilayerCommunityStructure('G', g).get('M');
S = calculateValue@MultilayerCommunityStructure(m, prop);
S = cell2mat(S');
S = {S};
persistence = zeros(length(S), 1); 

if g.is_multiplex(g) || g.is_multilayer(g)
    % categorical  
    all2all = N*[(-L+1):-1,1:(L-1)];
    A = spdiags(ones(N*L, 2*L-2), all2all, N*L, N*L);
    for i = 1:length(S)
        G = sparse(1:length(S{i}(:)), S{i}(:), 1);
        persistence(i) = trace(G'*A*G)/(N*L*(L-1));
    end
  
elseif g.is_ordered_multiplex(g) || g.is_ordered_multilayer(g)
    % ordinal
    for i = 1:length(S)
        persistence(i) = sum(sum(S{i}(:,1:end-1)==S{i}(:,2:end)))/(N*(L-1));
    end 
end

value = {persistence};

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
 
known_persistence = {1};   
 
g = MultiplexBU('B', A);
persistence = Persistence('G', g).get('M');

assert(isequal(persistence, known_persistence), ...
    [BRAPH2.STR ':Persistence:' BRAPH2.BUG_ERR], ...
    'CategoricalPersistence is not being calculated correctly for MultiplexBU.')

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
 
known_persistence = {1};   
 
g = MultiplexWD('B', A);
persistence = Persistence('G', g).get('M');

assert(isequal(persistence, known_persistence), ...
    [BRAPH2.STR ':Persistence:' BRAPH2.BUG_ERR], ...
    'Persistence is not being calculated correctly for MultiplexWD.')