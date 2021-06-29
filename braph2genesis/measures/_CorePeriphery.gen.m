%% ¡header!
CorePeriphery < Richness (m, core-periphery) is the graph multiplex core periphery.

%%% ¡description!
The core-periphery of a node is the value of the rank corresponding 
to the maximum richness nodes. It returns 1 for a node belonging to the 
core and zero otherwise. 

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphBU
MultigraphBUD
MultigraphBUT
GraphWD
GraphWU
MultiplexBD
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexWD
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the core-periphery.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
richness = calculateValue@Richness(m, prop);
L = g.layernumber();

if L == 0
    value = {};
else
    N = g.nodenumber();
    directionality_layer =  g.getDirectionalityType(L);
    connectivity_layer =  g.getConnectivityType(L);
    core_periphery = cell(L, 1);
    
    for li = 1:1:L
        core_periphery_partition = zeros(N(1), 1);
        
        if connectivity_layer == Graph.WEIGHTED  % weighted graphs
            if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                
                strength = Strength('G', g).get('M');
                deg = strength{li};
                
            else  % directed graphs
                
                in_strength = InStrength('G', g).get('M');
                out_strength = OutStrength('G', g).get('M');
                deg = (in_strength{li} + out_strength{li})/2;
            end
            
        else  % binary graphs
            if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                
                degree = Degree('G', g).get('M');
                deg = degree{li};
                
            else  % directed graphs
                
                in_degree = InDegree('G', g).get('M');
                out_degree = OutDegree('G', g).get('M');
                deg = (in_degree{li} + out_degree{li})/2;
            end
        end
        
        [~, rankingInd] = sort(deg, 'descend');
        richness_partition = richness{li};
        [~, rankOfMaxRichness] = max(richness_partition(rankingInd));  
        core_periphery_partition(rankingInd(1:rankOfMaxRichness)) = 1;
        core_periphery(li) = {core_periphery_partition};
    end
    value = core_periphery;
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_core_periphery = {[1 1 0 0]'};

g = GraphBU('B', B);

core_periphery = CorePeriphery('G', g).get('M');

assert(isequal(core_periphery, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.BUG_ERR], ...
    'CorePeriphery is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡code!
B = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_core_periphery = {
                 [1 1 0 0]'
                 [1 0 0 0]'};

g = MultigraphBUT('B', B, 'THRESHOLDS', [0 1]);
core_periphery = CorePeriphery('G', g).get('M');

assert(isequal(core_periphery, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.BUG_ERR], ...
    'CorePeriphery is not being calculated correctly for MultigraphBUT.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
B11 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

B22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    1  1  0  0
    ];
B = {B11 B22};

known_core_periphery = {
                     [1 1 0 0]'
                     [1 1 1 0]'};     

g = MultiplexBU('B', B);
core_periphery = CorePeriphery('G', g).get('M');

assert(isequal(core_periphery, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.BUG_ERR], ...
    'CorePeriphery is not being calculated correctly for MultiplexBU.')