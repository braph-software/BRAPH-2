%% ¡header!
WeightedRichClubEnsemble < WeightedRichClub (m, weighted rich-club of a graph ensemble) is the weighted rich-club of a graph ensemble.

%%% ¡description!
The weighted rich-club of a node at level s is the fraction of the
edges weights that connect nodes of strength s or higher out of the 
maxium number of edges weights that such nodes might share within a layer.
s is set by the user and it can be a vector containting all the 
strength thresholds; the default value is equal to 1.


%%% ¡compatible_graphs!
GraphWDEnsemble
GraphWUEnsemble
MultiplexWDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, measure) is the ensemble-averaged weighted rich-club.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

weighted_rich_club_ensemble = cell(ge.layernumber(), 1);
weighted_rich_club_threshold = m.get('WRC_PARAMETER');
weighted_rich_club_list = cellfun(@(x) x.getMeasure('WeightedRichClub', 'WRC_PARAMETER', weighted_rich_club_threshold).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    weighted_rich_club_li_list = cellfun(@(x) x{li}, weighted_rich_club_list, 'UniformOutput', false);
    weighted_rich_club_ensemble{li} = mean(cat(4, weighted_rich_club_li_list{:}), 4);
end

value = weighted_rich_club_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

r(1, 1, 1) = 3/4;
r(1, 1, 2) = 1;
r(1, 1, 3) = 0;

known_weighted_rich_club = {r}; 

ge = GraphWUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphWU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

weighted_rich_club = WeightedRichClubEnsemble('G', ge, 'WRC_PARAMETER', [1, 1.5, 2]).get('M');

assert(isequal(round(cell2mat(weighted_rich_club), 5), round(cell2mat(known_weighted_rich_club), 5)), ...
    [BRAPH2.STR ':WeightedRichClubEnsemble:' BRAPH2.BUG_ERR], ...
    'WeightedRichClubEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWUEnsemble
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
B = {B11  B22};

known_weighted_rich_club = {
                           3/4
                           1
                           };        

ge = MultiplexWUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexWU( ...
        'ID', ['g ' int2str(i)], ...        
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

weighted_rich_club = WeightedRichClubEnsemble('G', ge).get('M');

assert(isequal(round(cell2mat(weighted_rich_club), 5), round(cell2mat(known_weighted_rich_club), 5)), ...
    [BRAPH2.STR ':WeightedRichClubEnsemble:' BRAPH2.BUG_ERR], ...
    'WeightedRichClubEnsemble is not being calculated correctly for MultiplexWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWDEnsemble
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
B = {B11  B22};

clear wrichclub_l1;
clear wrichclub_l2;
wrichclub_l1(1, 1, 1) = 13/15;
wrichclub_l1(1, 1, 2) = 1;

wrichclub_l2(1, 1, 1) = 13/15;
wrichclub_l2(1, 1, 2) = 1;

known_weighted_rich_club = {
                 wrichclub_l1
                 wrichclub_l2
                 };   
             
ge = MultiplexWDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexWD( ...
        'ID', ['g ' int2str(i)], ...        
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

weighted_rich_club = WeightedRichClubEnsemble('G', ge, 'WRC_PARAMETER', [1.5, 2]).get('M');

assert(isequal(round(cell2mat(weighted_rich_club), 5), round(cell2mat(known_weighted_rich_club), 5)), ...
    [BRAPH2.STR ':WeightedRichClubEnsemble:' BRAPH2.BUG_ERR], ...
    'WeightedRichClubEnsemble is not being calculated correctly for MultiplexWDEnsemble.')