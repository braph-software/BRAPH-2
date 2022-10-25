%% ¡header!
Flexibility < MultilayerCommunityStructure (m, flexibility) is the graph flexibility.

%%% ¡description!
The flexibility of each node in a multilayer network is calculated 
as the number of times that it changes community assignment, 
normalized by the total possible number of changes. In ordered 
multilayer networks (e.g. temporal, changes are possible only between 
adjacent layers, whereas in categorical multilayer networks, 
community assignment changes are possible between any pairs of layers.

%%% ¡shape!
shape = Measure.NODAL;

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
M (result, cell) is the flexibility.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = g.nodenumber();
if isempty(N)
    N(1) = 1;
end
N = N(1);
S = calculateValue@MultilayerCommunityStructure(m, prop);
S = cell2mat(S');
flexibility = zeros(N, 1);

if g.is_multiplex(g) || g.is_multilayer(g)
    % categorical 
    for i=1:L
        otherlayers = 1:L;
        otherlayers = otherlayers(otherlayers~=i); % all layers except the current one
        flexibility = flexibility + sum(repmat(S(:,i),1, (L-1)) ~= S(:,otherlayers), 2);
    end    
    flexibility = flexibility/(L*(L-1));
elseif g.is_ordered_multiplex(g) || g.is_ordered_multilayer(g)
    % ordinal 
    for i=1:L-1
        flexibility = flexibility + S(:, i) ~= S(:, i+1);
    end
    flexibility = flexibility/(L-1);
end

value = {flexibility};

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
 
known_flexibility = {[0 0 0 0]'};   
 
g = MultiplexBU('B', A);
flexibility = Flexibility('G', g).get('M');

assert(isequal(flexibility, known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.BUG_ERR], ...
    'Flexibility is not being calculated correctly for MultiplexBU.')

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
flexibility = Flexibility('G', g).get('M');

assert(isequal(flexibility, known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.BUG_ERR], ...
    'Flexibility is not being calculated correctly for MultiplexWD.')