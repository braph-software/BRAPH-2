%% ¡header!
Modularity < CommunityStructure (m, modularity) is the graph modularity.

%%% ¡description!
The modularity of a graph is the quality of the resulting partition of the network. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBU
GraphBD
GraphWU
GraphWD
MultigraphBUD
MultigraphBUT

%% ¡props_update!
%%% ¡prop!
M (result, cell) is the modularity.
%%%% ¡calculate!
community_structure = calculateValue@CommunityStructure(m, prop);
Q = 0;
if ~isempty(community_structure{1})
    Q = m.get('quality_function');
end
modularity = {Q};  % assign normalized quality function
value = modularity;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
b = rand(10);
g = GraphBU('B', b);
m = Modularity('G', g).get('M');

assert(~isempty(m), ...
    [BRAPH2.STR ':Modularity:' BRAPH2.BUG_ERR], ...
    'Modularity is not being calculated correctly for GraphBU.');