%% ¡header!
MultiplexCorePeriphery < Multirichness (m, richness) is the graph multiplex core periphery.

%%% ¡description!
The multiplex core periphery of a node is the value of the rank corresponding 
to the maximum multirichness nodes. It returns 1 for a node belonging to the 
core and zero otherwise. The relevance of each layer is controlled by the 
multirichness coefficients that are between 0 and 1, and add up to one; 
the default coefficients are (1/layernumber).

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexBD
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexWD
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex core periphery.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
multirichness = calculateValue@Multirichness(m, prop);
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    N = g.nodenumber();

    multirichness_coefficients = m.get('MULTIRICHNESS_COEFFICIENTS');
    assert(length(multirichness_coefficients) == ls(1) || all(multirichness_coefficients == 0), ...
        [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
        ['Multirichness coefficients must have the same length than the ' ...
        'number of layers (' tostring(ls(1)) ') while its length is ' tostring(length(multirichness_coefficients))])

    if length(multirichness_coefficients) == ls(1)
        assert(all(multirichness_coefficients <= 1) && all(multirichness_coefficients >= 0), ...
            [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
            ['Multirichness coefficients must be between 0 and 1 ' ...
            'while they are ' tostring(multirichness_coefficients)])
        c = multirichness_coefficients;

    else  % same relevance for each layer
        c = ones(1, l)/ls(1);
    end

    directionality_layer =  g.getDirectionalityType(l);
    connectivity_layer =  g.getConnectivityType(l);
    multiplex_core_periphery = cell(length(ls), 1);
    count = 1;
    for i = 1:1:length(ls)
        overlapping_coefficients = zeros(N(1), 1);
        multiplex_core_periphery_partition = zeros(N(1), 1);
        for li = count:1:ls(i) + count - 1
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
            overlapping_coefficients = overlapping_coefficients + c(li)*deg;
        end
        [~, rankingInd] = sort(overlapping_coefficients, 'descend');
        multirichness_partition = multirichness{i};
        [~, rankOfMaxMultirichness] = max(multirichness_partition(rankingInd));  
        multiplex_core_periphery_partition(rankingInd(1:rankOfMaxMultirichness)) = 1;
        count = count + ls(i);
        multiplex_core_periphery(i) = {multiplex_core_periphery_partition};
    end
    value = multiplex_core_periphery;
end

%% ¡tests!

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

known_multiplex_core_periphery = {[1 1 1 0]'};      

g = MultiplexBU('B', B);
multiplex_core_periphery = MultiplexCorePeriphery('G', g).get('M');

assert(isequal(multiplex_core_periphery, known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBUT
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

known_multiplex_core_periphery = {
                                 [1 1 1 0]'
                                 [1 0 0 0]'}; 

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
multiplex_core_periphery = MultiplexCorePeriphery('G', g).get('M');

assert(isequal(multiplex_core_periphery, known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexBUT.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

B22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
B = {B11 B22};
             
known_multiplex_core_periphery = {[1 1 1 0]'};      

g = MultiplexBD('B', B);
multiplex_core_periphery = MultiplexCorePeriphery('G', g, 'MULTIRICHNESS_COEFFICIENTS', [2/3, 1/3]).get('M');

assert(isequal(multiplex_core_periphery, known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexBD.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!             
B11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
B22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
B = {B11 B22};

known_multiplex_core_periphery = {[0 0 1 0]'};      

g = MultiplexWU('B', B);
multiplex_core_periphery = MultiplexCorePeriphery('G', g, 'MULTIRICHNESS_COEFFICIENTS', [3/4, 1/4]).get('M');

assert(isequal(multiplex_core_periphery, known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexWU.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];
B22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
B = {B11 B22};

known_multiplex_core_periphery = {[0 1 1 0]'};      

g = MultiplexWD('B', B);
multiplex_core_periphery = MultiplexCorePeriphery('G', g, 'MULTIRICHNESS_COEFFICIENTS', [3/4, 1/4]).get('M');

assert(isequal(multiplex_core_periphery, known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexWD.')