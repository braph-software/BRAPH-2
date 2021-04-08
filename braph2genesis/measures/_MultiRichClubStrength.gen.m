%% ¡header!
MultiRichClubStrength < RichClubStrength (m, multi rich-club strength) is the graph multi rich-club strength.

%%% ¡description!
The multi rich-club strength of a node at level s is the sum of the
weighted edges that connect nodes of strength s or higher in all layers.
The relevance of each layer is controlled by the coefficients c that are 
between 0 and 1; the default coefficients are (1/layernumber).

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.PARAMETRIC;

%%% ¡compatible_graphs!
MultiplexWD
MultiplexWU

%% ¡props!

%%% ¡prop! 
WEIGHTED_MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club strength coefficients
%%%% ¡default!
[0]

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multi rich-club strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
rich_club_strength = calculateValue@RichClubStrength(m, prop);   
L = g.layernumber();

if L == 0
    value = {};
else
    
    N = g.nodenumber();

    weighted_rich_club_threshold = m.get('PARAMETRIC_VALUE');
    s_levels = abs(weighted_rich_club_threshold);

    weighted_multi_rich_club_coefficients = m.get('WEIGHTED_MULTIRICHCLUB_COEFFICIENTS');
    assert(length(weighted_multi_rich_club_coefficients) == L || all(weighted_multi_rich_club_coefficients == 0), ...
        [BRAPH2.STR ':WeightedMultiRichClubCoefficients:' BRAPH2.WRONG_INPUT], ...
        ['WeightedMultiRichClubCoefficients coefficients must have the same length than the ' ...
        'number of layers (' tostring(L) ') while its length is ' tostring(length(weighted_multi_rich_club_coefficients))])
    
    if length(weighted_multi_rich_club_coefficients) == L
        assert(all(weighted_multi_rich_club_coefficients <= 1) && all(weighted_multi_rich_club_coefficients >= 0), ...
            [BRAPH2.STR ':WeightedMultiRichClubCoefficients:' BRAPH2.WRONG_INPUT], ...
            ['WeightedMultiRichClubCoefficients coefficients must be between 0 and 1 ' ...
            'while they are ' tostring(weighted_multi_rich_club_coefficients)])
        c = weighted_multi_rich_club_coefficients;
    else  % same relevance for each layer
        c = ones(1, L)/L;
    end
    
    multi_rich_club_strength = zeros(N(1), 1, length(s_levels));
    for li = 1:1:L
        wrich = rich_club_strength{li};
        % loop over the 3rd dimension of richness (s_level)
        for s = 1:1:length(s_levels)
            multi_rich_club_strength(:, :, s) = multi_rich_club_strength(:, :, s) + c(li)*wrich(:, :, s);
        end
    end
    value = {multi_rich_club_strength};
end

%% ¡tests!

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

known_multi_rich_club_strength = {[5.4/4 5.2/4 2 1.8/4]'};      

g = MultiplexWU('B', B);
multi_rich_club_strength = MultiRichClubStrength('G', g, 'PARAMETRIC_VALUE', 1, 'WEIGHTED_MULTIRICHCLUB_COEFFICIENTS', [3/4, 1/4]).get('M');

assert(isequal(multi_rich_club_strength, known_multi_rich_club_strength), ...
    [BRAPH2.STR ':MultiRichClubStrength:' BRAPH2.BUG_ERR], ...
    'MultiRichClubStrength is not being calculated correctly for MultiplexWU.')

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


wmultirich(:, 1, 1) = [1.6 1.6 2 0]';
wmultirich(:, 1, 2) = [0 .5 .5 0]';
known_multi_rich_club_strength = {wmultirich};

g = MultiplexWD('B', B);
multi_rich_club_strength = MultiRichClubStrength('G', g, 'PARAMETRIC_VALUE', [1.5, 2]).get('M');

assert(isequal(multi_rich_club_strength, known_multi_rich_club_strength), ...
    [BRAPH2.STR ':MultiRichClubStrength:' BRAPH2.BUG_ERR], ...
    'MultiRichClubStrength is not being calculated correctly for MultiplexWD.')