%% ¡header!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation < NNxMLP_FeatureImportance_CrossValidation (nnficv, neural network feature importace for multi-layer perceptron) provides feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.

%%% ¡description!
Neural Network Feature Importance Across Graph Measures with Cross-Validation (NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation) 
 assesses the importance of graph measures by measuring the increase in model error when specific graph measure values are randomly shuffled. 
The feature importance score for each measure is then averaged across all folds. 
It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, 
 such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.

%%% ¡seealso!
NNxMLP_FeatureImportanceAcrossMeasures, NNClassifierMLP_CrossValidation, NNRegressorMLP_CrossValidation

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.ID
%%%% ¡title!
Feature Importance MLP ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.LABEL
%%%% ¡title!
Feature Importance MLP LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.NNCV
%%%% ¡title!
Neural Networks Cross Validation

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.FI_TEMPLATE
%%%% ¡title!
Template for Feature Importance Analysis

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.P
%%%% ¡title!
Permutation TIMES

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
Confidence Intervals ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.SIG_LEVEL
%%%% ¡title!
Significant Level

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.AV_FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance Score

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation'

%%% ¡prop!
NAME (constant, string) is the name of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'Feature Importace for Multi-layer Perceptron'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'Neural Network Feature Importance Across Graph Measures with Cross-Validation (NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation) assesses the importance of graph measures by measuring the increase in model error when specific graph measure values are randomly shuffled. The feature importance score for each measure is then averaged across all folds. It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡settings!
'NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation'

%%% ¡prop!
ID (data, string) is a few-letter code of the the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation notes'
    
%%% ¡prop!
AV_FEATURE_IMPORTANCE (result, cell) is determined by applying FDR correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
%%%% ¡gui!
fi_list = nnficv.get('FI_LIST');
m_list = fi_list{1}.get('D').get('DP_DICT').get('IT', 1).get('M_LIST');
pr = PanelPropCell('EL', nnficv, 'PROP', NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.AV_FEATURE_IMPORTANCE, ...
    'TABLE_HEIGHT', s(40), ...
    'ROWNAME', {}, ...
    'COLUMNNAME', m_list, ...
    varargin{:});

%%% ¡prop!
FEATURE_IMPORTANCE_FOLDS (result, cell) is determined by applying FDR correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
%%%% ¡calculate!


%%%% ¡gui!
fi_list = nnficv.get('FI_LIST');
m_list = fi_list{1}.get('D').get('DP_DICT').get('IT', 1).get('M_LIST');
pr = PanelPropCell('EL', nnficv, 'PROP', NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.AV_FEATURE_IMPORTANCE, ...
    'TABLE_HEIGHT', s(40), ...
    'ROWNAME', {}, ...
    'COLUMNNAME', m_list, ...
    varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation.FI_TEMPLATE]