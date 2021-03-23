%% ¡header!
ParticipationEnsemble < Participation (m, participation of a graph ensemble) is the participation of a graph ensemble.

%%% ¡description!
The participation of a node is the ratio of edges that a node forms within
a single layer community to the total number of edges that forms within the whole single layer graph.

%%% ¡compatible_graphs!
GraphBDEnsemble
GraphBUEnsemble
GraphWDEnsemble
GraphWUEnsemble
MultiplexBDEnsemble
MultiplexBUEnsemble
MultiplexWDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged participation.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

participation_ensemble = cell(ge.layernumber(), 1);
participation_rule = m.get('rule');
participation_list = cellfun(@(x) x.getMeasure('Participation', 'rule', participation_rule).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    participation_li_list = cellfun(@(x) x{li}, participation_list, 'UniformOutput', false);
    participation_ensemble{li} = mean(cat(3, participation_li_list{:}), 3);
end

value = participation_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0 1 1 1 0 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 1 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0
    ];

known_participation = {[0 4/9 3/8 4/9 12/25 0 0 0]'};

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

m_outside_g = ParticipationEnsemble('G', ge);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 5), round(cell2mat(known_participation), 5)), ...
    [BRAPH2.STR ':ParticipationEnsemble:' BRAPH2.BUG_ERR], ...
    'ParticipationEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B = [
    0 1 1 1 0 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 1 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0
    ];

ge = GraphBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

% out rule - default
known_participation_default_out = {[0 1/2 0 1/2 0 0 0 0]'};

m_outside_g = ParticipationEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_participation_default_out), ...
    [BRAPH2.STR ':ParticipationEnsemble:' BRAPH2.BUG_ERR], ...
    'ParticipationEnsemble is not being calculated correctly for GraphBDEnsemble.')

% in rule 
known_participation_in = {[0 -1 8/9 -1 5/9 0 0 1]'};

ge = GraphBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

m_outside_g = ParticipationEnsemble('G', ge, 'rule', 'in');
assert(isequal(round(cell2mat(m_outside_g.get('M')), 5), round(cell2mat(known_participation_in), 5)), ...
    [BRAPH2.STR ':ParticipationEnsemble:' BRAPH2.BUG_ERR], ...
    'ParticipationEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBUEnsemble
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
    ];
B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
    ];
B = {B11 B22};

known_participation = {
                 [0 0 0 0]'
                 [0 0 0 0]'
                 };

ge = MultiplexBUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
participation_ensemble = ParticipationEnsemble('G', ge);

assert(isequal(participation_ensemble.get('M'), known_participation), ...
    [BRAPH2.STR ':ParticipationEnsemble:' BRAPH2.BUG_ERR], ...
    'ParticipationEnsemble is not being calculated correctly for MultiplexBUEnsemble.')