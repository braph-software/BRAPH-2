%% ¡header!
NNxMLP_FeatureImportanceBrainSurface_CV < NNxMLP_FeatureImportance_CV (nnficv, neural network feature importace for multi-layer perceptron) manages the visuazation of the feature importance on the brain surface within neural network evaluators.

%%% ¡description!
A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) 
 manages the visualization of feature importance within neural network evaluators, particularly on the brain surface.
It handles different types of neural network inputs, including graph data 
 (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures),
 and the subject data (connectivity data or structural data).

%%% ¡seealso!
NNEvaluator, NNDataPoint_Graph_CLA, NNDataPoint_Measure_REG, NNDataPoint_CON_CLA, NNDataPoint_ST_CLA

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.ID
%%%% ¡title!
Feature Importance MLP ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.LABEL
%%%% ¡title!
Feature Importance MLP LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.NNCV
%%%% ¡title!
Neural Networks Cross Validation

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE
%%%% ¡title!
Template for Feature Importance Analysis

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.P
%%%% ¡title!
Permutation TIMES

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
CONFIDENCE INTERVALS ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.SIG_LEVEL
%%%% ¡title!
SIGNIFICANT LEVEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.RESHAPED_AV_FEATURE_IMPORTANCE
%%%% ¡title!
FEATURE IMPORTANCE SCORE

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceBrainSurface_CV.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurface_CV'

%%% ¡prop!
NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'Feature Importace for Multi-layer Perceptron'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) manages the visualization of feature importance within neural network evaluators, particularly on the brain surface. It handles different types of neural network inputs, including graph data (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures), and the subject data (connectivity data or structural data).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡settings!
'NNFeatureImportanceBrainSurface'

%%% ¡prop!
ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface notes'
    
%%% ¡prop!
AV_FEATURE_IMPORTANCE (result, cell) is determined by obtaining the average value from the feature importance element list.
%%%% ¡gui!
fi_list = nnficv.get('FI_LIST');
input_dataset = fi_list{1}.get('D');
dp_class = input_dataset.get('DP_CLASS');
graph_dp_classes = {NNDataPoint_Graph_CLA().get('ELCLASS'), NNDataPoint_Graph_REG().get('ELCLASS')};
measure_dp_classes = {NNDataPoint_Measure_CLA().get('ELCLASS'), NNDataPoint_Measure_REG().get('ELCLASS')};

if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Graph('EL', nnficv, 'D', input_dataset, 'PROP', NNxMLP_FeatureImportanceBrainSurface_CV.RESHAPED_AV_FEATURE_IMPORTANCE, varargin{:});
elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Graph('EL', nnficv, 'D', input_dataset, 'PROP', NNxMLP_FeatureImportanceBrainSurface_CV.RESHAPED_AV_FEATURE_IMPORTANCE, varargin{:});
else % DATA input
    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Graph('EL', nnficv, 'D', input_dataset, 'PROP', NNxMLP_FeatureImportanceBrainSurface_CV.RESHAPED_AV_FEATURE_IMPORTANCE, varargin{:});
end

%% ¡props!

%%% ¡prop!
BA (parameter, item) is the brain atlas.
%%%% ¡settings!
'BrainAtlas'

%% ¡tests!

%%% ¡excluded_props!
[NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE]