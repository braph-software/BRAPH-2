%% ¡header!
AssortativityEnsemble < Assortativity (m, assortativity of a graph ensemble) is the assortativity of a graph ensemble.

%%% ¡description!
The assortativity coefficient of a graph is the correlation coefficient 
between the degrees/strengths of all nodes on two opposite ends of an edge within a layer.
The corresponding coefficient for directed and weighted networks is calculated
by using the weighted and directed variants of degree/strength.

%%% ¡compatible_graphs!
GraphBUEnsemble
GraphWUEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged assortativity.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

assortativity_ensemble = cell(ge.layernumber(), 1);

assortativity_list = cellfun(@(x) x.getMeasure('Assortativity').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    assortativity_li_list = cellfun(@(x) x{li}, assortativity_list, 'UniformOutput', false);
    assortativity_ensemble{li} = mean(cat(3, assortativity_li_list{:}), 3);
end

value = assortativity_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    1 1 0 0 1;
    1 1 1 1 0;
    0 1 1 1 0;
    0 1 1 1 1;
    1 0 0 1 0];

known_assortativity = {(37/6-(15/6)^2)/(39/6-(15/6)^2)};

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

m_outside_g = AssortativityEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_assortativity), ...
    [BRAPH2.STR ':AssortativityEnsemble:' BRAPH2.BUG_ERR], ...
    'AssortativityEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('AssortativityEnsemble');
assert(isequal(m_inside_g.get('M'), known_assortativity), ...
    [BRAPH2.STR ':AssortativityEnsemble:' BRAPH2.BUG_ERR], ...
    'AssortativityEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWUEnsemble
B11 = [
       1  2  0  0  1;
       2  1  3  2  0;
       0  3  1  1  0;
       0  2  1  1  2;
       1  0  0  2  1];
B22 = [
       1  2  0  0  1;
       2  1  3  2  0;
       0  3  1  1  0;
       0  2  1  1  2;
       1  0  0  2  1];

B = {B11 B22};

known_assortativity = {
    (37/6-(15/6)^2)/(39/6-(15/6)^2)
    (37/6-(15/6)^2)/(39/6-(15/6)^2)
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
assortativity = AssortativityEnsemble('G', ge);

assert(isequal(assortativity.get('M'), known_assortativity), ...
    [BRAPH2.STR ':AssortativityEnsemble:' BRAPH2.BUG_ERR], ...
    'AssortativityEnsemble is not being calculated correctly for MultiplexWUEnsemble.')