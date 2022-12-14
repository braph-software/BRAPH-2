%% ¡header!
Multirichness < Richness (m, multirichness) is the graph multirichness.

%%% ¡description!
The multirichness of a node is the sum of the edges that connect nodes 
of degree k or higher in all layers. The relevance of each layer is 
controlled by the coefficients c that are between 0 and 1; 
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
OrderedMultiplexWU

%% ¡props!
%%% ¡prop! 
MULTIRICHNESS_COEFFICIENTS (parameter, RVECTOR)
%%%% ¡default!
[0]

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multirichness.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
richness = calculateValue@Richness(m, prop);
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
    multirichness = cell(length(ls), 1);
    count = 1;
    for i = 1:1:length(ls)
        multirichness_partition = zeros(N(1), 1);
        for li = count:1:ls(i) + count - 1
            multirichness_partition = multirichness_partition + c(li)*richness{li};
        end
        count = count + ls(i);
        multirichness(i) = {multirichness_partition};
    end
    value = multirichness;
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

known_multirichness = {[1/2 0 3/2 3/2]'};      

g = MultiplexBU('B', B);
multirichness = Multirichness('G', g).get('M');

assert(isequal(multirichness, known_multirichness), ...
    [BRAPH2.STR ':Multirichness:' BRAPH2.BUG_ERR], ...
    'Multirichness is not being calculated correctly for MultiplexBU.')

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

known_multirichness = {
                        [1/2  0   3/2  3/2]'
                        [0    0   0    0]'
                        };      

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
multirichness = Multirichness('G', g).get('M');

assert(isequal(multirichness, known_multirichness), ...
    [BRAPH2.STR ':Multirichness:' BRAPH2.BUG_ERR], ...
    'Multirichness is not being calculated correctly for MultiplexBUT.')

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
             
known_multirichness = {[1 0 5/3 5/3]'};

g = MultiplexBD('B', B);
multirichness = Multirichness('G', g, 'MULTIRICHNESS_COEFFICIENTS', [2/3, 1/3]).get('M');

assert(isequal(round(cell2mat(multirichness), 5), round(cell2mat(known_multirichness), 5)), ...
    [BRAPH2.STR ':Multirichness:' BRAPH2.BUG_ERR], ...
    'Multirichness is not being calculated correctly for MultiplexBD.')  
             
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

known_multirichness = {[3/40 0 5/4 21/20]'};  

g = MultiplexWU('B', B);
multirichness = Multirichness('G', g, 'MULTIRICHNESS_COEFFICIENTS', [3/4, 1/4]).get('M');

assert(isequal(round(cell2mat(multirichness), 5), round(cell2mat(known_multirichness), 5)), ...
    [BRAPH2.STR ':Multirichness:' BRAPH2.BUG_ERR], ...
    'Multirichness is not being calculated correctly for MultiplexWU.')  

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

known_multirichness = {[3/5 0 3/2 7/8]'};

g = MultiplexWD('B', B);
multirichness = Multirichness('G', g, 'MULTIRICHNESS_COEFFICIENTS', [2/4, 2/4]).get('M');

assert(isequal(multirichness, known_multirichness), ...
    [BRAPH2.STR ':Multirichness:' BRAPH2.BUG_ERR], ...
    'Multirichness is not being calculated correctly for MultiplexWD.')  