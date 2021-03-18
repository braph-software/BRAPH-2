%% ¡header!
CommunityStructureEnsemble < CommunityStructure (m, community structure) is the community structure of a graph ensemble.

%%% ¡description!
The community structure of a graph is a subdivision of the network into
non-overlapping groups of nodes which maximizes the number of whitin group
edges, and minimizes the number of between group edges.

%%% ¡compatible_graphs!
GraphWUEnsemble
GraphBUEnsemble
GraphWDEnsemble
GraphBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged community structure.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

community_structure_ensemble = cell(ge.layernumber(), 1);
community_structure_list = cellfun(@(x) x.getMeasure('CommunityStructure').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    community_structure_li_list = cellfun(@(x) x{li}, community_structure_list, 'UniformOutput', false);
    community_structure_ensemble{li} = mean(cat(3, community_structure_li_list{:}), 3);
end

value = community_structure_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    1 0 1 1
    0 0 0 0
    1 0 1 0
    1 0 0 1
    ];

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

m_outside_g = CommunityStructureEnsemble('G', ge);
assert(iscell(m_outside_g.get('M')) && size(cell2mat(m_outside_g.get('M')), 1) == 4, ...
    [BRAPH2.STR ':CommunityStructureEnsemble:' BRAPH2.BUG_ERR], ...
    'CommunityStructureEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('CommunityStructureEnsemble');
assert(iscell(m_inside_g.get('M')) && size(cell2mat(m_outside_g.get('M')), 1) == 4, ...
    [BRAPH2.STR ':CommunityStructureEnsemble:' BRAPH2.BUG_ERR], ...
    'CommunityStructureEnsemble is not being calculated correctly for GraphBUEnsemble.')

