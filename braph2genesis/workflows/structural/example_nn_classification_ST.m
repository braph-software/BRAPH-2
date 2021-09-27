%EXAMPLE_NN_CLASSIFICATION
% Script example workflow 

clear variables %#ok<*NASGU>


%% Neural network
nn_ST = ClassifierNN_ST( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'mr_adni.csv'] ...
    );

% nn result calculation
nn_CON_WU.memorize('NEURAL_NETWORK_ANALYSIS');
test_acc = nn_CON_WU.get('test_accuracy');
train_acc = nn_CON_WU.get('training_accuracy');
%confusion_matrix_training = nn_CON_WU.getTrainingConfusionMatrix();
%confusion_matrix_test = nn_CON_WU.getTestConfusionMatrix();

