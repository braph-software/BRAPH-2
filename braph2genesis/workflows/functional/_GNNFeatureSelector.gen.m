%% ¡header!
GNNFeatureSelector < ClassifierGNN (gnn, graph classifier with functional data) is a graph neural network classifier using functional data for classification.

%% ¡description!
This classifier classifies graphs using functional data with graph neural network. The graph classification task is one where an algorithm, in this example, a GNN has to predict the labels of unlabelled graphs.
In this example, a graph is represented by a connectom of individual. Nodal graph measures represent nodes in the graph and the correlation betweeens brain regions obtained from functional time series represent links in the graph.
Graph labels are the diagnosis of individual, for example, MCI. As such, input to the GNN are connectom along with graph nodal measures and the outputs are predictions of the type of diagnosis.

%% ¡props!
%%% ¡prop!
A_1 (data, item) is the analysis 1
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
A_2 (data, item) is the analysis 2
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
GNN_Classification (result, item) is the GNN object
%%%% ¡calculate!
a_1 = el.get('A_1');
a_BUD1_adjs = a_1.get('G_DICT').getItems();
features1 = {};
links1 = {};
for i = 1:length(a_BUD1_adjs)
    features1{end+1} = cell2mat(a_BUD1_adjs{i}.getMeasure('Degree').get('M'));
    links1{end+1} = cell2mat(a_BUD1_adjs{i}.get('A'));
end

a_2 = el.get('A_2');
a_BUD2_adjs = a_2.get('G_DICT').getItems();
features2 = {};
links2 = {};
for i = 1:length(a_BUD2_adjs)
    features2{end+1} = cell2mat(a_BUD2_adjs{i}.getMeasure('Degree').get('M'));
    links2{end+1} = cell2mat(a_BUD2_adjs{i}.get('A'));
end

gr1 = a_1.get('GR');
gr2 = a_2.get('GR');

value = GraphClassifierGNN_FUN( ...
    'GR1', gr1, ...
    'GR2', gr2, ...
    'FEATURES1', features1, ...
    'FEATURES2', features2, ...
    'LINKS1', links1, ...
    'LINKS2', links2 ...
    );

