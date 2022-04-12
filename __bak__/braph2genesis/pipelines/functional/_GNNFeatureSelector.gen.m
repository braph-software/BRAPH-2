%% ¡header!
GNNFeatureSelector < ClassifierGNN (gnn, graph classifier with functional data) is a graph neural network classifier using functional data for classification.

%% ¡description!
Class used to retrieve features and create a init a GraphClassifierGNN_FUN

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
a_1 = gnn.get('A_1');
a_BUD1_adjs = a_1.get('G_DICT').getItems();
features1 = {};
links1 = {};
f = waitbar(0, 'Selecting Features ...', 'Name', BRAPH2.NAME, 'Visible', 'off');
set_icon(f)
set(f, 'Visible', 'on');
waitbar(.15, f, 'Selecting Features for first analysis ...');
for i = 1:length(a_BUD1_adjs)
    features1{end+1} = cell2mat(a_BUD1_adjs{i}.getMeasure('Degree').get('M'));
    links1{end+1} = cell2mat(a_BUD1_adjs{i}.get('A'));
end

a_2 = gnn.get('A_2');
a_BUD2_adjs = a_2.get('G_DICT').getItems();
features2 = {};
links2 = {};
waitbar(.55, f, 'Selecting Features for second analysis ...');
for i = 1:length(a_BUD2_adjs)
    features2{end+1} = cell2mat(a_BUD2_adjs{i}.getMeasure('Degree').get('M'));
    links2{end+1} = cell2mat(a_BUD2_adjs{i}.get('A'));
end

gr1 = a_1.get('GR');
gr2 = a_2.get('GR');

waitbar(.85, f, 'Creating Classifier GNN ...');

if exist('f', 'var')
    waitbar(1, f, 'Finishing')
    pause(.5)
    close(f)
end

value = GraphClassifierGNN_FUN( ...
    'GR1', gr1, ...
    'GR2', gr2, ...
    'FEATURES1', features1, ...
    'FEATURES2', features2, ...
    'LINKS1', links1, ...
    'LINKS2', links2 ...
    );


