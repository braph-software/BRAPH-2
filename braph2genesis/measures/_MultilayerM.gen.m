%% ¡header!
MultilayerM < MultilayerCommunity  (m, multilayer modularity) is the graph multilayer modularity.

%%% ¡description!
The multilayer modularity of a multilayer graph is the multilayer 
quality function Q of the resulting partition of the multilayer network.  

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultilayerM.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultilayerM.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultilayerM.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultilayerM.M
%%%% ¡title!
MultilayerM

%%% ¡prop!
%%%% ¡id!
MultilayerM.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultilayerM.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultilayerM.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'MultilayerM'

%%% ¡prop!
NAME (constant, string) is the name of the multilayer modularity.
%%%% ¡default!
'MultilayerModularity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multilayer modularity.
%%%% ¡default!
'The multilayer modularity is the homogeneity of the number of inward neighbours of a node across the layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multilayer modularity.
%%%% ¡settings!
'MultilayerM'

%%% ¡prop!
ID (data, string) is a few-letter code of the multilayer modularity.
%%%% ¡default!
'MultilayerM ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multilayer modularity.
%%%% ¡default!
'MultilayerModularity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multilayer modularity.
%%%% ¡default!
'MultilayerModularity notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.GLOBAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
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
M (result, cell) is the multilayer modularity.
%%%% ¡calculate!
multilayer_community_structure = calculateValue@MultilayerCommunity(m, prop);
Q = 0;
if ~isempty(cell2mat(multilayer_community_structure))
    Q = m.get('QUALITY_FUNCTION');
end
multilayer_modularity = {Q};  % assign normalized quality function
value = multilayer_modularity;

%% ¡tests!

%%% ¡excluded_props!
[MultilayerM.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
A = rand(5, 5);
B = {A A};
g = MultiplexBU('B', B);

m_outside_g = MultilayerM('G', g);
assert(~isempty(m_outside_g.get('M')), ...
    [BRAPH2.STR ':MultilayerM:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultilayerM');
assert(~isempty(m_inside_g.get('M')), ...
    [BRAPH2.STR ':MultilayerM:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])