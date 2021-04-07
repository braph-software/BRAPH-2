%% ¡header!
OutInAssortativityEnsemble < OutInAssortativity (m, out-in-assortativity of a graph ensemble) is the out-in-assortativity of a graph ensemble.

%%% ¡description!
The out-in-assortativity coefficient of a graph is the correlation coefficient between 
the degrees/strengths of all nodes on two opposite ends of an edge within a layer.
The corresponding coefficient for directed and weighted networks is calculated by
using the weighted and directed variants of in-out-degree/in-out-strength.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged out-in-assortativity.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

out_in_assortativity_ensemble = cell(ge.layernumber(), 1);

out_in_assortativity_list = cellfun(@(x) x.getMeasure('OutInAssortativity').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    out_in_assortativity_li_list = cellfun(@(x) x{li}, out_in_assortativity_list, 'UniformOutput', false);
    out_in_assortativity_ensemble{li} = mean(cat(3, out_in_assortativity_li_list{:}), 3);
end

value = out_in_assortativity_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B = [
    0  1  0  0  0;
    0  0  1  0  0;
    0  0  0  1  0;
    0  1  0  0  1;
    1  0  0  1  0
    ];

known_out_in_assortativity = {(17/7-(11/7)^2)/(19/7-(11/7)^2)};

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

out_out_assortativity = OutInAssortativityEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(out_out_assortativity), 5), round(cell2mat(known_out_in_assortativity), 5)), ...
    [BRAPH2.STR ':OutInAssortativityEnsemble:' BRAPH2.BUG_ERR], ...
    'OutInAssortativityEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphWDEnsemble
%%%% ¡code!
B = [
    0  2  0  0  0;
    0  0  3  0  0;
    0  0  0  1  0;
    0  2  0  0  2;
    1  0  0  2  0
    ];

known_out_in_assortativity = {(17/7-(11/7)^2)/(19/7-(11/7)^2)};

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

out_out_assortativity = OutInAssortativityEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(out_out_assortativity), 5), round(cell2mat(known_out_in_assortativity), 5)), ...
    [BRAPH2.STR ':OutInAssortativityEnsemble:' BRAPH2.BUG_ERR], ...
    'OutInAssortativityEnsemble is not being calculated correctly for GraphWDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBDEnsemble
%%%% ¡code!
B11 = [
      0  1  0  0  0;
      0  0  1  0  0;
      0  0  0  1  0;
      0  1  0  0  1;
      1  0  0  1  0
      ];

B22 = [
      0  1  0  0  0;
      0  0  1  0  0;
      0  0  0  1  0;
      0  1  0  0  1;
      1  0  0  1  0
       ];
B = {B11 B22};

known_out_in_assortativity = {
                    (17/7-(11/7)^2)/(19/7-(11/7)^2)
                    (17/7-(11/7)^2)/(19/7-(11/7)^2)
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

out_out_assortativity = OutInAssortativityEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(out_out_assortativity), 5), round(cell2mat(known_out_in_assortativity), 5)), ...
    [BRAPH2.STR ':OutInAssortativityEnsemble:' BRAPH2.BUG_ERR], ...
    'OutInAssortativityEnsemble is not being calculated correctly for MultiplexBDEnsemble.')