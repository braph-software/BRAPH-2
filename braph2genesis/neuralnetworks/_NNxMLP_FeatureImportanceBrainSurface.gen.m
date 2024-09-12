%% ¡header!
NNxMLP_FeatureImportanceBrainSurface < NNxMLP_FeatureImportance (nnfib, neural network feature importace for multi-layer perceptron) manages the visuazation of the feature importance on the brain surface within neural network evaluators.

%%% ¡description!
A neural network feature importace for multi-layer perceptron for visualizing on brain surface (NNxMLP_FeatureImportanceBrainSurface) 
 assesses the importance of features and visualizes on a brain surface. 
It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the 
 original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical 
 analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.

%%% ¡seealso!
NNxMLP_FeatureImportance, NNxMLP_FeatureImportanceAcrossMeasures 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.ID
%%%% ¡title!
Feature Importance MLP ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.LABEL
%%%% ¡title!
Feature Importance MLP LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.D
%%%% ¡title!
Neural Networks Dataset

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.NN
%%%% ¡title!
Neural Networks

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.P
%%%% ¡title!
Permutation Number

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
CONFIDENCE INTERVALS ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.SIG_LEVEL
%%%% ¡title!
SIGNIFICANT LEVEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.FEATURE_IMPORTANCE
%%%% ¡title!
FEATURE IMPORTANCE SCORE

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurface'

%%% ¡prop!
NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'Feature Importace for Multi-layer Perceptron on Brain Surface'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) manages the visualization of feature importance within neural network evaluators, particularly on the brain surface. It handles different types of neural network inputs, including graph data (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures), and the subject data (connectivity data or structural data).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡settings!
'NNxMLP_FeatureImportanceBrainSurface'

%%% ¡prop!
ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurface ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurface label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurface notes'
  
%%% ¡prop!
FEATURE_IMPORTANCE (result, cell) is determined by obtaining the average value from the feature importance element list.
%%%% ¡gui!
input_dataset = nnfib.get('D');
dp_class = input_dataset.get('DP_CLASS');
graph_dp_classes = {NNDataPoint_Graph_CLA().get('ELCLASS'), NNDataPoint_Graph_REG().get('ELCLASS')};
measure_dp_classes = {NNDataPoint_Measure_CLA().get('ELCLASS'), NNDataPoint_Measure_REG().get('ELCLASS')};

if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Graph('EL', nnfib, 'D', input_dataset, 'PROP', NNxMLP_FeatureImportanceBrainSurface.FEATURE_IMPORTANCE, varargin{:});
elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Measure('EL', nnfib, 'D', input_dataset, 'PROP', NNxMLP_FeatureImportanceBrainSurface.FEATURE_IMPORTANCE, varargin{:});
else % DATA input
    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Data('EL', nnfib, 'D', input_dataset, 'PROP', NNxMLP_FeatureImportanceBrainSurface.FEATURE_IMPORTANCE, varargin{:});
end

%% ¡props!

%%% ¡prop!
BA (parameter, item) is the brain atlas.
%%%% ¡settings!
'BrainAtlas'

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
create_data_NN_CLA_CON_FUN_MP_XLS() % only creates files if the example folder doesn't already exist

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_CON = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_CON = im_gr2.get('GR');

im_gr3 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group3_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr3_CON = im_gr3.get('GR');

% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_FUN = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_FUN = im_gr2.get('GR');

im_gr3 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group3_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr3_FUN = im_gr3.get('GR');

% Combine Groups of SubjectCON with Groups of SubjectFUN
co_gr1 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr1_CON, ...
    'GR_FUN', gr1_FUN, ...
    'WAITBAR', true ...
    );
gr1 = co_gr1.get('GR_CON_FUN_MP');

co_gr2 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr2_CON, ...
    'GR_FUN', gr2_FUN, ...
    'WAITBAR', true ...
    );
gr2 = co_gr2.get('GR_CON_FUN_MP');

co_gr3 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr3_CON, ...
    'GR_FUN', gr3_FUN, ...
    'WAITBAR', true ...
    );
gr3 = co_gr3.get('GR_CON_FUN_MP');

% Analysis CON BUD
densities = 5;

a_BUD1 = AnalyzeEnsemble_CON_FUN_MP_BUD( ...
    'GR', gr1, ...
    'DENSITIES', densities ...
    );

a_BUD2 = AnalyzeEnsemble_CON_FUN_MP_BUD( ...
    'TEMPLATE', a_BUD1, ...
    'GR', gr2, ...
    'DENSITIES', densities ...
    );

a_BUD3 = AnalyzeEnsemble_CON_FUN_MP_BUD( ...
    'TEMPLATE', a_BUD1, ...
    'GR', gr3, ...
    'DENSITIES', densities ...
    );

a_BUD1.get('MEASUREENSEMBLE', 'OverlappingDeg').get('M');
a_BUD1.get('MEASUREENSEMBLE', 'OverlappingDegAv').get('M');
a_BUD1.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

a_BUD2.get('MEASUREENSEMBLE', 'OverlappingDeg').get('M');
a_BUD2.get('MEASUREENSEMBLE', 'OverlappingDegAv').get('M');
a_BUD2.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

a_BUD3.get('MEASUREENSEMBLE', 'OverlappingDeg').get('M');
a_BUD3.get('MEASUREENSEMBLE', 'OverlappingDegAv').get('M');
a_BUD3.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

% Create NNData composed of corresponding NNDataPoints
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', a_BUD1.get('ME_DICT').get('KEYS'), ...
    'TARGET_IDS', {group_folder_name}), ...
    a_BUD1.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', a_BUD2.get('ME_DICT').get('KEYS'), ...
    'TARGET_IDS', {group_folder_name}), ...
    a_BUD2.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr3.get('DIRECTORY'));
it_list3 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', a_BUD3.get('ME_DICT').get('KEYS'), ...
    'TARGET_IDS', {group_folder_name}), ...
    a_BUD3.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_Measure_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list2 ...
        );

dp_list3 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list3 ...
        );

% create a NNDataset containing the NNDataPoint_Measure_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list2 ...
    );

d3 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list3 ...
    );

% Split the NNData into training set and test set
d_split1 = NNDatasetSplit('D', d1, 'SPLIT', {0.7, 0.3});
d_split2 = NNDatasetSplit('D', d2, 'SPLIT', {0.7, 0.3});
d_split3 = NNDatasetSplit('D', d3, 'SPLIT', {0.7, 0.3});

d_training = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 1), d_split2.get('D_LIST_IT', 1), d_split3.get('D_LIST_IT', 1)}).get('D');
d_test = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 2), d_split2.get('D_LIST_IT', 2), d_split3.get('D_LIST_IT', 2)}).get('D');

% Create a MLP classifier with training set
nn = NNClassifierMLP('D', d_training, 'LAYERS', [20 20]);
nn.get('TRAIN');

% Evaluate the feature importance
fi = NNxMLP_FeatureImportanceAcrossMeasures('D', d_test, 'NN', nn, 'P', 5, 'APPLY_BONFERRONI', false, 'APPLY_CONFIDENCE_INTERVALS', false, 'VERBOSE', true);
fi_score = fi.get('RESHAPED_FEATURE_IMPORTANCE');
input_measure = it_list1{1}.get('M_LIST');

assert(isequal(size(cell2mat(fi_score)), size(input_measure)), ...
	        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
	        'NNxMLP_FeatureImportance does not have the feature importance score array of the same feature size as the input data.' ...
	        )

fi_score = cell2mat(fi_score);
for i = 1:length(input_measure)
    check(i) = ~isequal(fi_score(i), 0);
end
assert(all(check), ...
    [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
    'NNxMLP_FeatureImportance does not calculate feature importance score array correctly. Each feature should hold a non-zero number because there is no bonferroni correction.' ...
    )