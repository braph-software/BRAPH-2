%EXAMPLE_CLASSIFICATIONNN_ST
% Script example workflow for classification using nn with ST

clear variables %#ok<*NASGU>

%% Neural networls CON WU
nn_classifier = ClassifierNN_ST( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'mradni.csv'] ...
    );

% nn result calculation
nn_classifier.memorize('NEURAL_NETWORK_ANALYSIS');
test_acc = nn_classifier.get('TEST_ACCURACY');
train_acc = nn_classifier.get('TRAINING_ACCURACY');
%confusion_matrix_training = nn_CON_WU.getTrainingConfusionMatrix();
%confusion_matrix_test = nn_CON_WU.getTestConfusionMatrix();

