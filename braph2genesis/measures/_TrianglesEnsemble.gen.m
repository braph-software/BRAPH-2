%% ¡header!
TrianglesEnsemble < Triangles (m, triangles of a graph ensemble) is the triangles of a graph ensemble.

%%% ¡description!
The triangles are calculated as the number of a nodes neighbor pairs that are
connected to each other within a layer. In weighted graphs, the triangles are
calculated as geometric mean of the weights of the edges forming the triangle.

%%% ¡compatible_graphs!
GraphBUEnsemble
GraphWUEnsemble
GraphBDEnsemble
GraphWDEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble
MultiplexBDEnsemble
MultiplexWDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged triangles.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

triangles_ensemble = cell(ge.layernumber(), 1);

triangles_list = cellfun(@(x) x.getMeasure('Triangles').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    triangles_li_list = cellfun(@(x) x{li}, triangles_list, 'UniformOutput', false);
    triangles_ensemble{li} = mean(cat(3, triangles_li_list{:}), 3);
end

value = triangles_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B_BU = [
     0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0;
    ];

known_triangles = {[2 1 2 1]'};

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

m_outside_g = TrianglesEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':TrianglesEnsemble:' BRAPH2.BUG_ERR], ...
    'TrianglesEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('TrianglesEnsemble');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':TrianglesEnsemble:' BRAPH2.BUG_ERR], ...
    'TrianglesEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B_BU = [
     0 0 1; 
    1 0 0; 
    0 1 0 
    ];

known_triangles = {[1 1 1]'};

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

m_outside_g = TrianglesEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':TrianglesEnsemble:' BRAPH2.BUG_ERR], ...
    'TrianglesEnsemble is not being calculated correctly for GraphBDEnsemble.')

m_inside_g = ge.getMeasure('TrianglesEnsemble');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':TrianglesEnsemble:' BRAPH2.BUG_ERR], ...
    'TrianglesEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBUEnsemble
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

known_triangles = {
    [2 1 2 1]'
    [2 1 2 1]'
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
triangles = TrianglesEnsemble('G', ge);

assert(isequal(triangles.get('M'), known_triangles), ...
    [BRAPH2.STR ':TrianglesEnsemble:' BRAPH2.BUG_ERR], ...
    'TrianglesEnsemble is not being calculated correctly for MultiplexBUEnsemble.')