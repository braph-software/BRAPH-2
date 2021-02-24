%% ¡header!
RichClubStrength < Strength (m, rich club strength) is the graph rich club strength.

%%% ¡description!
The rich-club strength of a node at level s is the sum of the weighted edges 
that connect nodes of strength s or higher within a layer.
s is set by the user and it can be a vector containting all the strength thresholds
the default value is equal to 1 

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.PARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
GraphWU
MultiplexGraphWD
MultiplexWU

%% ¡props!
%%% ¡prop! 
PARAMETRIC_VALUE (parameter, RVECTOR)
%%%% ¡default!
1

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the rich club strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = g.nodenumber();

rich_club_strength = cell(L, 1);
directionality_type = g.getDirectionalityType(L);
weighted_rich_club_threshold = m.get('PARAMETRIC_VALUE');
assert(isnumeric(weighted_rich_club_threshold) == 1, ...
    [BRAPH2.STR ':RichClubStrength:' BRAPH2.WRONG_INPUT], ...
    ['RichClubStrength threshold must be a positive number ' ...
    'while it is ' tostring(weighted_rich_club_threshold)])

s_levels = abs(weighted_rich_club_threshold);
    
for li = 1:1:L
    
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);
    
    if directionality_layer == Graph.UNDIRECTED  % undirected graphs

        strength = calculateValue@Strength(m, prop);        
        st = strength{li};
        
    else  % directed graphs        
        
        in_strength = InStrength('G', g).get('M');        
        out_strength = OutStrength('G', g).get('M');        
        
        st = (in_strength{li} + out_strength{li})/2;
    end

    rich_club_strength_layer = zeros(N(1), 1, length(s_levels));
    count = 1;
    for s = s_levels
        low_rich_nodes = find(st <= s);  % get lower rich nodes with strength <= s
        subAii = Aii;  % extract subnetwork of nodes >s by removing nodes <=s of Aii
        subAii(low_rich_nodes, :) = 0;  % remove rows
        subAii(:, low_rich_nodes) = 0;  % remove columns
        
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            rich_club_strength_layer(:, :, count) = round(sum(subAii, 1), 6)';  % strength of high rich nodes
        else
            rich_club_strength_layer(:, :, count) = round((sum(subAii, 1)' + sum(subAii, 2)), 6)/2;  % strength of high rich nodes
        end
        count = count + 1;
    end
    rich_club_strength(li) = {rich_club_strength_layer};  %#ok<SAGROW> % add rich club strength of layer li
end

value = rich_club_strength;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!

A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_rich_club_strength = {[1.1 1.1 2 0]'};

g = GraphWU('B', A);
rich_club_strength = RichClubStrength('G', g, 'PARAMETRIC_VALUE', 1).get('M');

assert(isequal(rich_club_strength, known_rich_club_strength), ...
    [BRAPH2.STR ':RichClubStrength:' BRAPH2.BUG_ERR], ...
    'RichClubStrength is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!

A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

wrich(:, 1, 1) = [1.6 1.6 2 0]';
wrich(:, 1, 2) = [0 0 0 0]';
known_rich_club_strength = {wrich};

g = GraphWD('B', A);
rich_club_strength = RichClubStrength('G', g, 'PARAMETRIC_VALUE', [1.5, 2]).get('M'); 

assert(isequal(rich_club_strength, known_rich_club_strength), ...
    [BRAPH2.STR ':RichClubStrength:' BRAPH2.BUG_ERR], ...
    'RichClubStrength is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWD
%%%% ¡code!

A11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];
A22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
A = {A11 A22};

w_richness_l1(:, 1, 1) = [1.6 1.6 2 0]';
w_richness_l1(:, 1, 2) = [0 0 0 0]';

w_richness_l2(:, 1, 1) = [1.6 1.6 2 0]';
w_richness_l2(:, 1, 2) = [0 1 1 0]';

known_rich_club_strength = {
                 w_richness_l1
                 w_richness_l2
                 };            

g = MultiplexGraphWD('B', A);
rich_club_strength = RichClubStrength('G', g, 'PARAMETRIC_VALUE', [1.5, 2]).get('M');

assert(isequal(rich_club_strength, known_rich_club_strength), ...
    [BRAPH2.STR ':RichClubStrength:' BRAPH2.BUG_ERR], ...
    'RichClubStrength is not being calculated correctly for MultiplexGraphWD.')
