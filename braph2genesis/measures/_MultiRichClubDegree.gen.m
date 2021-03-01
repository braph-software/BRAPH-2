%% ¡header!
MultiRichClubDegree < RichClubDegree (m, multi rich-club degree) is the graph multi rich-club degree.

%%% ¡description!
The multi rich-club degree of a node at level k is the sum of 
the edges that connect nodes of degree k or higher in all layers. 
The relevance of each layer is controlled by the coefficients c that are 
between 0 and 1; the default coefficients are (1/layernumber).

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.PARAMETRIC;

%%% ¡compatible_graphs!
MultiplexBD
MultiplexBU
MultiplexWD
MultiplexWU

%% ¡props!

%%% ¡prop! 
MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club degree coefficients
%%%% ¡default!
[0]

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multi rich-club degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
rich_club_degree = calculateValue@RichClubDegree(m, prop);   
L = g.layernumber();

if L == 0
    value = {};
else
    
    N = g.nodenumber();

    richclub_threshold = m.get('PARAMETRIC_VALUE'); % klevel

    multirichclub_coefficients = m.get('MULTIRICHCLUB_COEFFICIENTS');
    if length(multirichclub_coefficients) == L
        assert(all(multirichclub_coefficients <= 1) && all(multirichclub_coefficients >= 0), ...
            [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT], ...
            ['MultiRichClubDegree coefficients must be between 0 and 1 ' ...
            'while they are ' tostring(multirichclub_coefficients)])
        c = multirichclub_coefficients;

    else  % same relevance for each layer
        c = ones(1, L)/L;
    end

    multi_rich_club_degree = zeros(N(1), 1, richclub_threshold);
    for li = 1:1:L
        ri = rich_club_degree{li};  % to fix when making this measure also parametric
        % loop over the 3rd dimension of rich club degree (k_level)
        for k = 1:1:richclub_threshold
            multi_rich_club_degree(:, :, k) = multi_rich_club_degree(:, :, k) + c(li)*ri(:, :, k);
        end
    end
    value = {multi_rich_club_degree};
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

known_multi_rich_club_degree = {[5/2 5/2 2 1]'};   

g = MultiplexBU('B', B);
multi_rich_club_degree = MultiRichClubDegree('G', g).get('M');

assert(isequal(multi_rich_club_degree, known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.BUG_ERR], ...
    'MultiRichClubDegree is not being calculated correctly for MultiplexBU.')

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

mrich(:, 1, 1) = [5/2 3 13/6 5/3]';
mrich(:, 1, 2) = [4/3 4/3 2/3 0]';
known_multi_rich_club_degree = {mrich};

g = MultiplexBD('B', B);
multi_rich_club_degree = MultiRichClubDegree('G', g, 'PARAMETRIC_VALUE', 2, 'MULTIRICHCLUB_COEFFICIENTS', [2/3, 1/3]).get('M');

assert(isequal(round(multi_rich_club_degree{1}, 10), round(known_multi_rich_club_degree{1}, 10)), ...
    [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.BUG_ERR], ...
    'MultiRichClubDegree is not being calculated correctly for MultiplexBD.')

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

known_multi_rich_club_degree = {[9/4 9/4 2 1/2]'};   

g = MultiplexWU('B', B);
multi_rich_club_degree = MultiRichClubDegree('G', g, 'MULTIRICHCLUB_COEFFICIENTS', [3/4, 1/4]).get('M');

assert(isequal(multi_rich_club_degree, known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.BUG_ERR], ...
    'MultiRichClubDegree is not being calculated correctly for MultiplexWU.')

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

mrich(:, 1, 1) = [5/2 3 17/8 13/8]';
mrich(:, 1, 2) = [5/4 5/4 1/2 0]';
known_multi_rich_club_degree = {mrich};

g = MultiplexWD('B', B);
multi_rich_club_degree = MultiRichClubDegree('G', g, 'PARAMETRIC_VALUE', 2, 'MULTIRICHCLUB_COEFFICIENTS', [3/4, 1/4]).get('M');

assert(isequal(multi_rich_club_degree, known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.BUG_ERR], ...
    'MultiRichClubDegree is not being calculated correctly for MultiplexWD.')