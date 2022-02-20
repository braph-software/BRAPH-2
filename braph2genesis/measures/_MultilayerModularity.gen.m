%% ¡header!
MultilayerModularity < MultilayerCommunityStructure (m, multilayer modularity) is the graph multilayer modularity.

%%% ¡description!
The multilayer modularity of a multilayer graph is the quality of the 
resulting partition of the multilayer network. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexBD
MultiplexWU
MultiplexWD

%% ¡props_update!
%%% ¡prop!
M (result, cell) is the multilayer modularity.
%%%% ¡calculate!
multilayer_community_structure = calculateValue@MultilayerCommunityStructure(m, prop);
Q = 0;
if ~isempty(cell2mat(multilayer_community_structure))
    Q = m.get('quality_function');
end
multilayer_modularity = {Q};  % assign normalized quality function
value = multilayer_modularity;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
A = rand(5, 5);
B = {A A};
g = MultiplexBU('B', B);
multilayer_modularity = MultilayerModularity('G', g).get('M');

assert(~isempty(multilayer_modularity), ...
    [BRAPH2.STR ':MultilayerModularity:' BRAPH2.BUG_ERR], ...
    'MultilayerModularity is not being calculated correctly for MultiplexBU.');