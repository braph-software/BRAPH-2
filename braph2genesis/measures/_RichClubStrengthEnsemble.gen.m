%% ¡header!
RichClubStrengthEnsemble < RichClubStrength (m, rich-club rich-club strength of a graph ensemble) is the rich-club rich-club strength of a graph ensemble.

%%% ¡description!
The rich-club strength of a node at level s is the sum of the weighted edges 
that connect nodes of strength s or higher within a layer.
s is set by the user and it can be a vector containting all the strength thresholds
the default value is equal to 1 

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphWUEnsemble
MultiplexWDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, measure) is the ensemble-averaged rich-club strength.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

rich_club_strength_ensemble = cell(ge.layernumber(), 1);
richclub_threshold = m.get('PARAMETRIC_VALUE');
rich_club_strength_list = cellfun(@(x) x.getMeasure('RichClubStrength', 'PARAMETRIC_VALUE', richclub_threshold).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    rich_club_strength_li_list = cellfun(@(x) x{li}, rich_club_strength_list, 'UniformOutput', false);
    rich_club_strength_ensemble{li} = mean(cat(4, rich_club_strength_li_list{:}), 4);
end

value = rich_club_strength_ensemble;

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

known_rich_club_strength = {[1.1 1.1 2 0]'};

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

rich_club_strength = RichClubStrengthEnsemble('G', ge).get('M');

assert(isequal(round(cell2mat(rich_club_strength), 5), round(cell2mat(known_rich_club_strength), 5)), ...
    [BRAPH2.STR ':RichClubStrengthEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubStrengthEnsemble is not being calculated correctly for GraphWUEnsemble.')

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

wrich(:, 1, 1) = [1.6 1.6 2 0]';
wrich(:, 1, 2) = [0 0 0 0]';
known_rich_club_strength = {wrich};

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

rich_club_strength = RichClubStrengthEnsemble('G', ge, 'PARAMETRIC_VALUE', [1.5, 2]).get('M');

assert(isequal(round(cell2mat(rich_club_strength), 5), round(cell2mat(known_rich_club_strength), 5)), ...
    [BRAPH2.STR ':RichClubStrengthEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubStrengthEnsemble is not being calculated correctly for GraphWDEnsemble.')

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

clear w_rich_l1;
clear w_rich_l2;
w_rich_l1(:, 1, 1) = [1.6 1.6 2 0]';
w_rich_l1(:, 1, 2) = [0 0 0 0]';

w_rich_l2(:, 1, 1) = [1.6 1.6 2 0]';
w_rich_l2(:, 1, 2) = [0 1 1 0]';

known_rich_club_strength = {
                 w_rich_l1
                 w_rich_l2
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

rich_club_strength = RichClubStrengthEnsemble('G', ge, 'PARAMETRIC_VALUE', [1.5, 2]).get('M');

assert(isequal(round(cell2mat(rich_club_strength), 5), round(cell2mat(known_rich_club_strength), 5)), ...
    [BRAPH2.STR ':RichClubStrengthEnsemble:' BRAPH2.BUG_ERR], ...
    'RichClubStrengthEnsemble is not being calculated correctly for MultiplexWDEnsemble.')