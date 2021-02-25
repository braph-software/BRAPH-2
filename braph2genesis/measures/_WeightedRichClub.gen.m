%% ¡header!
WeightedRichClub < Strength (m, weighted rich club) is the graph weighted rich club.

%%% ¡description!
The weighted rich-club of a node at level s is the fraction of the
edges weights that connect nodes of strength s or higher out of the 
maxium number of edges weights that such nodes might share within a layer.
s is set by the user and it can be a vector containting all the 
strength thresholds; the default value is equal to 1.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.PARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphWU
MultiplexGraphWU
MultiplexGraphWU

%% ¡props!
%%% ¡prop! 
WRC_PARAMETER (parameter, RVECTOR) is the threshold
%%%% ¡default!
1

%% ¡props_update!
%%% ¡prop!
M (result, cell) is the weighted rich club.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell matrix for graph, multigraph, or multiplex, etc
L = g.layernumber();
N = g.nodenumber();

weighted_rich_club = cell(L, 1);
directionality_type =  g.getDirectionalityType(L);
weighted_rich_club_threshold = m.get('WRC_PARAMETER');
assert(isnumeric(weighted_rich_club_threshold) == 1, ...
    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT], ...
    ['WeightedRichClub threshold must be a positive number ' ...
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

    weighted_rich_club_layer = zeros(1, 1, length(s_levels));
    wrank = sort(Aii(:), 'descend');  % wrank contains the ranked weights of the network, with strongest connections on top
    count = 1;
    
    for s = s_levels
        low_rich_nodes = find(st < s);  % get lower rich nodes with strength < s
        subAii = Aii;  % extract subnetwork of nodes >=s by removing nodes < s of Aii
        subAii(low_rich_nodes, :) = [];  % remove rows
        subAii(:, low_rich_nodes) = [];  % remove columns

        Wr = sum(subAii(:));  % total weight of connections in subgraph > s
        Er = length(find(subAii~=0));  % total number of connections in subgraph
        wrank_r = wrank(1:1:Er);  % E>r number of connections with max weight in network
        % Calculate weighted rich-club coefficient
        weighted_rich_club_layer(1, 1, count) = Wr / sum(wrank_r);
        count = count + 1;
    end
    weighted_rich_club_layer(isnan(weighted_rich_club_layer)) = 0;  % Should return zeros, since NaN happens when subAii has zero nodes with strength > s
    weighted_rich_club(li) = {weighted_rich_club_layer};  % add rich club strength of layer li
end
value = weighted_rich_club;

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

r(1, 1, 1) = 3/4;
r(1, 1, 2) = 1;
r(1, 1, 3) = 0;
known_weighted_rich_club = {r};  

g = GraphWU('B', A);
weighted_rich_club = WeightedRichClub('G', g, 'WRC_PARAMETER', [1, 1.5, 2]).get('M');

assert(isequal(round(weighted_rich_club{1}, 10), round(known_weighted_rich_club{1}, 10)), ...
    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.BUG_ERR], ...
    'WeightedRichClub is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWU
%%%% ¡code!
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {A11 A22};

known_weighted_rich_club = {
                           3/4
                           1
                           };      

g = MultiplexGraphWU('B', A);
weighted_rich_club = WeightedRichClub('G', g).get('M');

assert(isequal(round(weighted_rich_club{1}, 10), round(known_weighted_rich_club{1}, 10)), ...
    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.BUG_ERR], ...
    'WeightedRichClub is not being calculated correctly for MultiplexGraphWU.')

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
A = {A11  A22};

wrichclub_l1(1, 1, 1) = 13/15;
wrichclub_l1(1, 1, 2) = 1;

wrichclub_l2(1, 1, 1) = 13/15;
wrichclub_l2(1, 1, 2) = 1;

known_weighted_rich_club = {
                 wrichclub_l1
                 wrichclub_l2
                 };             

g = MultiplexGraphWD('B', A);
weighted_rich_club = WeightedRichClub('G', g, 'WRC_PARAMETER', [1.5, 2]).get('M');

assert(isequal(weighted_rich_club, known_weighted_rich_club), ...
    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.BUG_ERR], ...
    'WeightedRichClub is not being calculated correctly for MultiplexGraphWD.')