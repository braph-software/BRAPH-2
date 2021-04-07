%% ¡header!
RichClubEnsemble < RichClub (m, rich-club of a graph ensemble) is the rich-club of a graph ensemble.

%%% ¡description!
The rich-club of a node at level k is the fraction of the
edges that connect nodes of degree k or higher out of the
maxium number of edges that such nodes might share within a
layer. k is set by the user, the default value is equal to 1.

%%% ¡compatible_graphs!
GraphBDEnsemble
GraphBUEnsemble
MultigraphBUDEnsemble
MultigraphBUTEnsemble
GraphWDEnsemble
GraphWUEnsemble
MultiplexBDEnsemble
MultiplexBUEnsemble
MultiplexWDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, measure) is the ensemble-averaged rich-club.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

rich_club_ensemble = cell(ge.layernumber(), 1);
richclub_threshold = m.get('PARAMETRIC_VALUE');
rich_club_list = cellfun(@(x) x.getMeasure('RichClub', 'PARAMETRIC_VALUE', richclub_threshold).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    rich_club_li_list = cellfun(@(x) x{li}, rich_club_list, 'UniformOutput', false);
    rich_club_ensemble{li} = mean(cat(4, rich_club_li_list{:}), 4);
end

value = rich_club_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0  1  1  0;
    1  0  1  1;
    1  1  0  0;
    0  1  0  0
    ];

r(1, 1, 1) = 1;
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;

known_richclub = {r};

ge = GraphBUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphBU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

richclub = RichClubEnsemble('G', ge, 'PARAMETRIC_VALUE', 3).get('M');

assert(isequal(richclub, known_richclub), ...
    [BRAPH2.STR ':RichClubEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultigraphBUTEnsemble
%%%% ¡code!
B = [
    0  1  1  0;
    1  0  1  1;
    1  1  0  0;
    0  1  0  0
    ];

r(1, 1, 1) = 1;
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;
r2(1, 1, 1) = 0;
r2(1, 1, 2) = 0;
r2(1, 1, 3) = 0;

known_richclub = {
                r
                r2};
            
thresholds = [0 1];

ge = MultigraphBUTEnsemble('THRESHOLDS', thresholds);
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultigraphBUT( ...
        'ID', ['g ' int2str(i)], ...
        'THRESHOLDS', ge.get('THRESHOLDS'), ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

richclub = RichClubEnsemble('G', ge, 'PARAMETRIC_VALUE', 3).get('M');

assert(isequal(richclub, known_richclub), ...
    [BRAPH2.STR ':RichClubEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphWDEnsemble
%%%% ¡code!
B = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

r(1, 1, 1) = 3/4;
r(1, 1, 2) = 1;
r(1, 1, 3) = 0;

known_richclub = {r}; 

ge = GraphWDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphWD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

richclub = RichClubEnsemble('G', ge, 'PARAMETRIC_VALUE', 3).get('M');

assert(isequal(richclub, known_richclub), ...
    [BRAPH2.STR ':RichClubEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubEnsemble is not being calculated correctly for GraphWDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBDEnsemble
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
B = {B11  B22};

richclub_l1(1, 1, 1) = 3/4;
richclub_l1(1, 1, 2) = 1;

richclub_l2(1, 1, 1) = 5/6;
richclub_l2(1, 1, 2) = 1;

known_richclub = {
                 richclub_l1
                 richclub_l2
                 };      

ge = MultiplexBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBD( ...
        'ID', ['g ' int2str(i)], ...        
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

richclub = RichClubEnsemble('G', ge, 'PARAMETRIC_VALUE', 2).get('M');

assert(isequal(round(cell2mat(richclub), 5), round(cell2mat(known_richclub), 5)), ...
    [BRAPH2.STR ':RichClubEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubEnsemble is not being calculated correctly for MultiplexBDEnsemble.')