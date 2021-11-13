%EXAMPLE_FUN_BUD
% Script example workflow FUN BUD

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_FUN_BUD')) filesep 'example data FUN (fMRI)' filesep 'craddock_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUNXLS( ...
    'DIRECTORY', [fileparts(which('example_FUN_BUD')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUNXLS( ...
    'DIRECTORY', [fileparts(which('example_FUN_BUD')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Analysis FUN WU
a_WU1 = AnalyzeEnsemble_FUN_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_FUN_WU( ...
    'GR', gr2 ...
    );

%% Collect features and links for each individual as input for GNN
gnn_graph_classifier = GNNFeatureSelector('A_1', a_WU1, 'A_2', a_WU2).get('GNN_Classification');
% a_BUD1_adjs = a_BUD1.get('G_DICT').getItems();
% features1 = {};
% links1 = {};
% for i = 1:length(a_BUD1_adjs)
%     features1{end+1} = cell2mat(a_BUD1_adjs{i}.getMeasure('Degree').get('M'));
%     links1{end+1} = cell2mat(a_BUD1_adjs{i}.get('A'));
% end
% 
% a_BUD2_adjs = a_BUD2.get('G_DICT').getItems();
% features2 = {};
% links2 = {};
% for i = 1:length(a_BUD2_adjs)
%     features2{end+1} = cell2mat(a_BUD2_adjs{i}.getMeasure('Degree').get('M'));
%     links2{end+1} = cell2mat(a_BUD2_adjs{i}.get('A'));
% end


%% Training and testing of GNN
% gnn_graph_classifier = GraphClassifierGNN_FUN( ...
%     'GR1', gr1, ...
%     'GR2', gr2, ...
%     'FEATURES1', features1, ...
%     'FEATURES2', features2, ...
%     'LINKS1', links1, ...
%     'LINKS2', links2 ...
%     );

% nn result calculation
gnn_graph_classifier.memorize('NEURAL_NETWORK_ANALYSIS');
test_acc = gnn_graph_classifier.get('TEST_ACCURACY');
train_acc = gnn_graph_classifier.get('TRAINING_ACCURACY');
