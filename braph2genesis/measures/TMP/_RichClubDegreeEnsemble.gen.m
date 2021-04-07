%% ¡header!
RichClubDegreeEnsemble < RichClubDegree (m, rich-club rich-club degree of a graph ensemble) is the rich-club rich-club degree of a graph ensemble.

%%% ¡description!
The rich-club degree of a node at level k is the sum of 
the edges that connect nodes of degree k or higher within a layer. 
k is set by the user; the default value is equal to 1. 

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
M (result, measure) is the ensemble-averaged rich-club degree.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

rich_club_degree_ensemble = cell(ge.layernumber(), 1);
richclub_threshold = m.get('PARAMETRIC_VALUE');
rich_club_degree_list = cellfun(@(x) x.getMeasure('RichClubDegree', 'PARAMETRIC_VALUE', richclub_threshold).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    rich_club_degree_li_list = cellfun(@(x) x{li}, rich_club_degree_list, 'UniformOutput', false);
    rich_club_degree_ensemble{li} = mean(cat(4, rich_club_degree_li_list{:}), 4);
end

value = rich_club_degree_ensemble;

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

known_richclubdegree = {[2 2 2 0]'};

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

richclub_degree = RichClubDegreeEnsemble('G', ge).get('M');

assert(isequal(richclub_degree, known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubDegreeEnsemble is not being calculated correctly for GraphBUEnsemble.')

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

known_richclubdegree = {
                        [2 2 2 0]'
                        [0 0 0 0]'
                        };
            
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

richclub_degree = RichClubDegreeEnsemble('G', ge).get('M');

assert(isequal(richclub_degree, known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubDegreeEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

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

known_richclubdegree = {[2 2 2 0]'};

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

richclub_degree = RichClubDegreeEnsemble('G', ge).get('M');

assert(isequal(richclub_degree, known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubDegreeEnsemble is not being calculated correctly for GraphWUEnsemble.')

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

clear richclub_l1;
clear richclub_l2;
richclub_l1(:, 1, 1) = [5/2 3 2 3/2]';
richclub_l1(:, 1, 2) = [1 1 0 0]';

richclub_l2(:, 1, 1) = [5/2 3 5/2 2]';
richclub_l2(:, 1, 2) = [2 2 2 0]';

known_richclubdegree = {
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

richclub_degree = RichClubDegreeEnsemble('G', ge, 'PARAMETRIC_VALUE', 2).get('M');

assert(isequal(round(cell2mat(richclub_degree), 5), round(cell2mat(known_richclubdegree), 5)), ...
    [BRAPH2.STR ':RichClubDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubDegreeEnsemble is not being calculated correctly for MultiplexBDEnsemble.')