# Implement a new Neural Network Cross Validation

[![Tutorial Implement a new Neural Network Cross Validation](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_nn_xval.pdf)

This is the developer tutorial for implementing a new neural network cross validation. 
In this Tutorial, we will explain how to create the generator file "*.gen.m" for a new neural network cross validation, which can then be compiled by `braph2genesis`. All kinds of neural network cross validation are (direct or indirect) extensions of the base element `NNCrossValidation`. Here, we will use as examples `NNRegressorMLP_CrossValidation` (a cross validation for multi-layer perceptron regressors) and `NNClassifierMLP_CrossValidation` (a cross validation for multi-layer perceptron classifiers).


## Table of Contents
> [Implementation of a Cross Validation for Regressors](#Implementation-of-a-Cross-Validation-for-Regressors)
>
> [Implementation of a Cross Validation for Classifiers](#Implementation-of-a-Cross-Validation-for-Classifiers)
>

%%%%% %%%%% %%%%% %%%%% %%%%%

<a id="Implementation-of-a-Cross-Validation-for-Regressors"></a>
## Implementation of a Cross Validation for Regressors  [⬆](#Table-of-Contents)

We will start by implementing in detail `NNRegressorMLP_CrossValidation`, which is a direct extension of `NNCrossValidation`.
A cross validation for multi-layer perceptron regressors (`NNRegressorMLP_CrossValidation`) is a procedure designed for evaluating multi-layer perceptron regressors using cross-validation. 


> **Code 1.** **NNRegressorMLP_CrossValidation element header.**
> 		The `header` section of the generator code for "_NNRegressorMLP_CrossValidation.gen.m" provides the general information about the `NNRegressorMLP_CrossValidation` element.
> ````matlab
> %% ¡header!
> NNRegressorMLP_CrossValidation < NNCrossValidation (nncv, neural network cross-validation) is a process for evaluating multi-layer perceptron regressors using cross-validation.  ①
> 
> %%% ¡description!
> A cross validation for multi-layer perceptron regressors (NNRegressorMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron regressors using cross-validation. 
>  It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
>  This helps in assessing the generalization performance of the model and detecting overfitting.
> 
> To train all the neural networks for all folds, use: nncv.get('TRAIN')
> ````
> 
> ①defines `NNRegressorMLP_CrossValidation.gen` as a subclass of `NNCrossValidation`. The moniker will be `nncv`.
> 


> **Code 2.** **NNRegressorMLP_CrossValidation element prop update.**
> 		The `props_update` section of the generator code for "_NNRegressorMLP_CrossValidation.gen.m" updates the properties of the `NNRegressorMLP_CrossValidation` element. This defines the core properties of the data point.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of the cross-validation.
> %%%% ¡default!
> 'NNRegressorMLP_CrossValidation'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of the cross-validation.
> %%%% ¡default!
> 'A cross validation for multi-layer perceptron regressors (NNRegressorMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron regressors using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of the nerual cross-validation.
> %%%% ¡settings!
> 'NNRegressorMLP_CrossValidation'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for the cross-validation.
> %%%% ¡default!
> 'NNRegressorMLP_CrossValidation ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of the cross-validation.
> %%%% ¡default!
> 'NNRegressorMLP_CrossValidation label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about the cross-validation.
> %%%% ¡default!
> 'NNRegressorMLP_CrossValidation notes'
> 
> %%% ¡prop!
> NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
> %%%% ¡settings!
> 'NNRegressorMLP'  ①
> 
> %%% ¡prop!
> NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.
> %%%% ¡settings!
> 'NNRegressorMLP_Evaluator'  ②
> 
> %%% ¡prop!
> NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.
> %%%% ¡calculate!
> d_list = nncv.get('D_LIST');
> 
> if isempty(d_list)
>     value = {};
> else
>     for i = 1:length(d_list)  ③
>         d_training_set{i} = d_list;
>         d_training_set{i}(i) = [];  % Exclude the i-th element
>         d_training_set{i} = NNDatasetCombine('D_LIST', d_training_set{i}).get('D');
>     end
> 
>     d_training_set = d_training_set';
> 
>     if ~isa(nncv.getr('NN_TEMPLATE'), 'NoValue')
>         nn_template = nncv.get('NN_TEMPLATE');  ④
>     else
>         nn_template = NNRegressorMLP( ...  ⑤
>             'EPOCHS', nncv.get('EPOCHS'), ...
>             'BATCH', nncv.get('BATCH'), ...
>             'SHUFFLE', nncv.get('SHUFFLE'), ...
>             'SOLVER', nncv.get('SOLVER'), ...
>             'VERBOSE', nncv.get('VERBOSE'), ...
>             'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
>     end
>     
>     value = cellfun(@(d) NNRegressorMLP( ...  ⑥
>         'TEMPLATE', nn_template, 'D', d), ...
>         d_training_set, 'UniformOutput', false);
> end
> 
> %%% ¡prop!
> EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
> %%%% ¡calculate!
> %%% ¡prop!
> EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
> %%%% ¡calculate!
> d_list = nncv.get('D_LIST');
> nn_list = nncv.get('NN_LIST');
> 
> if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
>     nne_template = nncv.get('NNEVALUATOR_TEMPLATE'); ⑦
> else
>     nne_template = NNRegressorMLP_Evaluator( ...   ⑧
>         'P', nncv.get('P'));
> end
> 
> value = cellfun(@(d, nn) NNRegressorMLP_Evaluator('TEMPLATE', nne_template, 'D', d, 'NN', nn), ...  ⑨
>     d_list, nn_list, 'UniformOutput', false);
> ````
> 
> ①defines the neural network template to be `NNRegressorMLP`, which will be used to set the parameters for all the neural network regressors for the cross validation.
> 
> ②defines the neural network evaluator template to be `NNRegressorMLP_Evaluator`, which will be used to set the parameters for all the neural network evaluators for the cross validation.
> 
> ③constructs the training sets iteratively by concatenating all of the remaining folds after exlcuding the one as the validation set.
> 
> ⑥initializes all of the `NNRegressorMLP`s.
> 
> ⑨initializes all of the `NNRegressorMLP_Evaluator`s.
> 


> **Code 3.** **NNRegressorMLP_CrossValidation element props.**
> 		The `props` section of generator code for "_NNRegressorMLP_CrossValidation.gen.m" defines the properties to be used in "NNRegressorMLP_CrossValidation".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!
> P (parameter, scalar) is the permutation number. ①
> %%%% ¡default!
> 1e+2
> %%%% ¡check_prop!
> check = value > 0 && value == round(value);
> 
> %%% ¡prop!
> AV_CORR (result, rvector) provides the metric of the correlation of coefficients.  ②
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> value = cellfun(@(e) e.get('CORR'), ...
>     e_list, 'UniformOutput', false);
> 
> if isempty(value)
>     value = [];
> else
>     value = mean(cell2mat(value), 1);
> end
> 
> %%% ¡prop!
> AV_DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.  ③
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> value = cellfun(@(e) e.get('DET'), ...
>     e_list, 'UniformOutput', false);
> 
> if isempty(value)
>     value = [];
> else
>     value = mean(cell2mat(value), 1);
> end
> 
> %%% ¡prop!
> AV_MAE (result, rvector) provides the metric of the mean absolute error.  ④
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> value = cellfun(@(e) e.get('MAE'), ...
>     e_list, 'UniformOutput', false);
> 
> if isempty(value)
>     value = [];
> else
>     value = mean(cell2mat(value), 1);
> end
> 
> %%% ¡prop!
> AV_MSE (result, rvector) provides the metric of the mean squared error.  ⑤
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> value = cellfun(@(e) e.get('MSE'), ...
>     e_list, 'UniformOutput', false);
> 
> if isempty(value)
>     value = [];
> else
>     value = mean(cell2mat(value), 1);
> end
> 
> %%% ¡prop!
> AV_RMSE (result, rvector) provides the metric of the root mean squared error. 
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> value = cellfun(@(e) e.get('RMSE'), ...
>     e_list, 'UniformOutput', false);
> 
> if isempty(value)
>     value = [];
> else
>     value = mean(cell2mat(value), 1);
> end
> 
> %%% ¡prop!
> AV_FEATURE_IMPORTANCE (result, cell) averages the feature importances across k folds.  ⑥
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> all_fi = cellfun(@(e) cell2mat(e.get('FEATURE_IMPORTANCE')), ...
>     e_list, 'UniformOutput', false);
> 
> if isempty(cell2mat(all_fi))
>     value = {};
> else
>     average_fi = zeros(size(all_fi{1}));
>     for i = 1:numel(all_fi)
>         % Add the current cell contents to the averageCell
>         average_fi = average_fi + all_fi{i};
>     end
>     average_fi = average_fi / numel(all_fi);
>     value = {average_fi};
> end
> ````
> 
> ①defines the number for permuation feature importance.
> 
> ⑥calculates the average feature importance. The feature importance obtained from each fold is by performing permutation feature importance. For a detailed explanation, please refer to "dev_nn_reg.pdf"
> 




> **Code 4.** **NNRegressorMLP_CrossValidation element tests.**
> 		The `tests` section from the element generator "_NNRegressorMLP_CrossValidation.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡test!
> %%%% ¡name!
> evaluate a regressor cross-validation with the example data
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
>     test_NNDataPoint_CON_REG % create example files
> end
> 
> % Load BrainAtlas
> im_ba = ImporterBrainAtlasXLS( ...
>     'FILE', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'], ...
>     'WAITBAR', true ...
>     );
> 
> ba = im_ba.get('BA');
> 
> % Load Groups of SubjectCON
> im_gr = ImporterGroupSubjectCON_XLS( ...
>     'DIRECTORY', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'CON_Group_XLS'], ...
>     'BA', ba, ...
>     'WAITBAR', true ...
>     );
> 
> gr = im_gr.get('GR');
> 
> % create a item list of NNDataPoint_CON_REG
> it_list = cellfun(@(x) NNDataPoint_CON_REG( ...
>     'ID', x.get('ID'), ...
>     'SUB', x, ...
>     'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
>     gr.get('SUB_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create a NNDataPoint_CON_REG DICT
> dp_list = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_CON_REG', ...
>         'IT_LIST', it_list ...
>         );
> 
> % create a NNData containing the NNDataPoint_CON_REG DICT
> d = NNDataset( ...
>     'DP_CLASS', 'NNDataPoint_CON_REG', ...
>     'DP_DICT', dp_list ...
>     );
> 
> kfolds = 3;
> nncv = NNRegressorMLP_CrossValidation('KFOLDS', kfolds, 'D', d);
> 
> nn_list = nncv.get('NN_LIST');
> assert(length(nn_list) == kfolds, ...  ①
>     [BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.FAIL_TEST], ...
>     'NNRegressorMLP_CrossValidation does not calculate the neural network list correctly.' ...
>     )
> e_list = nncv.get('EVALUATOR_LIST');
> assert(length(e_list) == kfolds, ...  ②
>     [BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.FAIL_TEST], ...
>     'NNRegressorMLP_CrossValidation does not calculate the evaluator list correctly.' ...
>     )
> ````
> 

%%%%% %%%%% %%%%% %%%%% %%%%%

<a id="Implementation-of-a-Cross-Validation-for-Classifiers"></a>
## Implementation of a Cross Validation for Classifiers  [⬆](#Table-of-Contents)

We can now use `NNRegressorMLP_CrossValidation` as the basis to implement the`NNClassifierMLP_CrossValidation`. The parts of the code that are modified are highlighted.
A cross validation for multi-layer perceptron classifier (`NNClassifierMLP_CrossValidation`) is a procedure designed for evaluating multi-layer perceptron classifiers using cross-validation. 


> **Code 5.** **NNClassifierMLP_CrossValidation element header.**
> 		The `header` section of the generator code for "_NNClassifierMLP_CrossValidation.gen.m" provides the general information about the `NNClassifierMLP_CrossValidation` element.
> ````matlab
> %% ¡header!
> NNClassifierMLP_CrossValidation < NNCrossValidation (nncv, neural network cross-validation) is a process for evaluating multi-layer perceptron classifiers using cross-validation.
> 
> %%% ¡description!
> A cross validation for multi-layer perceptron classifiers (NNClassifierMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron classifiers using cross-validation. 
>  It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
>  This helps in assessing the generalization performance of the model and detecting overfitting.
> 
> To train all the neural networks for all folds, use: nncv.get('TRAIN')
> ````
> 


> **Code 6.** **NNClassifierMLP_CrossValidation element prop update.**
> 		The `props_update` section of the generator code for "_NNClassifierMLP_CrossValidation.gen.m" updates the properties of the `NNClassifierMLP_CrossValidation` element. This defines the core properties of the data point.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of the cross-validation.
> %%%% ¡default!
> 'NNClassifierMLP_CrossValidation'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of the cross-validation.
> %%%% ¡default!
> 'A cross validation for multi-layer perceptron classifiers (NNClassifierMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron classifiers using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of the cross-validation.
> %%%% ¡settings!
> 'NNClassifierMLP_CrossValidation'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for the cross-validation.
> %%%% ¡default!
> 'NNClassifierMLP_CrossValidation ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of the cross-validation.
> %%%% ¡default!
> 'NNClassifierMLP_CrossValidation label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about the cross-validation.
> %%%% ¡default!
> 'NNClassifierMLP_CrossValidation notes'
> 
> %%% ¡prop!
> NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
> %%%% ¡settings!
> 'NNClassifierMLP' ①
> 
> %%% ¡prop!
> NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.
> %%%% ¡settings!
> 'NNClassifierMLP_Evaluator' ②
> 
> %%% ¡prop!
> NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.
> %%%% ¡calculate!
> d_list = nncv.get('D_LIST');
> 
> if isempty(d_list)
>     value = {};
> else
>     for i = 1:length(d_list)
>         d_training_set{i} = d_list;
>         d_training_set{i}(i) = [];  % Exclude the i-th element
>         d_training_set{i} = NNDatasetCombine('D_LIST', d_training_set{i}).get('D');
>     end
>     
>     d_training_set = d_training_set';
>     
>     if ~isa(nncv.getr('NN_TEMPLATE'), 'NoValue')
>         nn_template = nncv.get('NN_TEMPLATE');
>     else
>         nn_template = NNClassifierMLP( ...
>             'EPOCHS', nncv.get('EPOCHS'), ...
>             'BATCH', nncv.get('BATCH'), ...
>             'SHUFFLE', nncv.get('SHUFFLE'), ...
>             'SOLVER', nncv.get('SOLVER'), ...
>             'VERBOSE', nncv.get('VERBOSE'), ...
>             'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
>     end
>     
>     value = cellfun(@(d) NNClassifierMLP( ...
>         'TEMPLATE', nn_template, 'D', d), ...
>         d_training_set, 'UniformOutput', false);
> . . . . .
> 
> %%% ¡prop!
> EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
> %%%% ¡calculate!
> d_list = nncv.get('D_LIST');
> nn_list = nncv.get('NN_LIST');
> 
> if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
>     nne_template = nncv.get('NNEVALUATOR_TEMPLATE');
> else
>     nne_template = NNClassifierMLP_Evaluator( ...
>         'P', nncv.get('P'));
> . . . . .
> 
> value = cellfun(@(d, nn) NNClassifierMLP_Evaluator('TEMPLATE', nne_template, 'D', d, 'NN', nn), ...
>     d_list, nn_list, 'UniformOutput', false);
> ````
> 


> **Code 7.** **NNClassifierMLP_CrossValidation element props.**
> 		The `props` section of generator code for "_NNClassifierMLP_CrossValidation.gen.m" defines the properties to be used in "NNClassifierMLP_CrossValidation".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!
> P (parameter, scalar) is the permutation number.
> %%%% ¡default!
> 1e+2
> %%%% ¡check_prop!
> check = value > 0 && value == round(value);
> 
> %%% ¡prop!  ①
> AV_AUC (result, rvector) provides the average value of the area under the receiver operating characteristic curve across k folds.
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> aucs = cellfun(@(e) e.get('AUC'), ...
>     e_list, 'UniformOutput', false);
> 
> if isempty(aucs)
>     value = [];
> else
>     value = mean(cell2mat(aucs), 1);
> end
> 
> %%% ¡prop!  ②
> AV_MACRO_AUC (result, scalar) provides the metric of the average macro AUC value across k folds.
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> macro_aucs = cellfun(@(e) e.get('MACRO_AUC'), ...
>     e_list, 'UniformOutput', false);
> 
> if isempty(macro_aucs)
>     value = 0;
> else
>     value = mean(cell2mat(macro_aucs), 1);
> end
> 
> %%% ¡prop!  ③
> C_MATRIX (result, matrix) provides the confusion matrix across k folds.
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> c_matrices = cellfun(@(e) e.get('C_MATRIX'), ...
>     e_list, 'UniformOutput', false);
> 
> combined_c_matrix = cellfun(@(x) double(x), c_matrices, 'UniformOutput', false);
> value = sum(cat(3, combined_c_matrix{:}), 3);
> 
> %%% ¡prop!
> AV_FEATURE_IMPORTANCE (result, cell) averages the feature importances across k folds.
> %%%% ¡calculate!
> e_list = nncv.get('EVALUATOR_LIST');
> 
> all_fi = cellfun(@(e) cell2mat(e.get('FEATURE_IMPORTANCE')), ...
>     e_list, 'UniformOutput', false);
> 
> if isempty(cell2mat(all_fi))
>     value = {};
> else
>     average_fi = zeros(size(all_fi{1}));
>     for i = 1:numel(all_fi)
>         % Add the current cell contents to the averageCell
>         average_fi = average_fi + all_fi{i};
>     end
>     average_fi = average_fi / numel(all_fi);
>     value = {average_fi};
> end
> ````
> 
> ③aggregates the confusion matrix across k folds.
> 




> **Code 8.** **NNClassifierMLP_CrossValidation element tests.**
> 		The `tests` section from the element generator "_NNClassifierMLP_CrossValidation.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡test!
> %%%% ¡name!
> evaluate a classifier cross-validation with the example data
> %%%% ¡code!
> 
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     test_NNDataPoint_CON_CLA % create example files
> end
> 
> % Load BrainAtlas
> im_ba = ImporterBrainAtlasXLS( ...
>     'FILE', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'], ...
>     'WAITBAR', true ...
>     );
> 
> ba = im_ba.get('BA');
> 
> % Load Groups of SubjectCON
> im_gr1 = ImporterGroupSubjectCON_XLS( ...
>     'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_1_XLS'], ...
>     'BA', ba, ...
>     'WAITBAR', true ...
>     );
> 
> gr1 = im_gr1.get('GR');
> 
> im_gr2 = ImporterGroupSubjectCON_XLS( ...
>     'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_2_XLS'], ...
>     'BA', ba, ...
>     'WAITBAR', true ...
>     );
> 
> gr2 = im_gr2.get('GR');
> 
> % create item lists of NNDataPoint_CON_CLA
> [~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
> it_list1 = cellfun(@(x) NNDataPoint_CON_CLA( ...
>     'ID', x.get('ID'), ...
>     'SUB', x, ...
>     'TARGET_IDS', {group_folder_name}), ...
>     gr1.get('SUB_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> [~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
> it_list2 = cellfun(@(x) NNDataPoint_CON_CLA( ...
>     'ID', x.get('ID'), ...
>     'SUB', x, ...
>     'TARGET_IDS', {group_folder_name}), ...
>     gr2.get('SUB_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create NNDataPoint_CON_CLA DICT items
> dp_list1 = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_CON_CLA', ...
>         'IT_LIST', it_list1 ...
>         );
> 
> dp_list2 = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_CON_CLA', ...
>         'IT_LIST', it_list2 ...
>         );
> 
> % create a NNDataset containing the NNDataPoint_CON_CLA DICT
> d1 = NNDataset( ...
>     'DP_CLASS', 'NNDataPoint_CON_CLA', ...
>     'DP_DICT', dp_list1 ...
>     );
> 
> d2 = NNDataset( ...
>     'DP_CLASS', 'NNDataPoint_CON_CLA', ...
>     'DP_DICT', dp_list2 ...
>     );
> 
> % combine the two datasets
> d = NNDatasetCombine('D_LIST', {d1, d2}).get('D');
> 
> kfolds = 7;
> nncv = NNClassifierMLP_CrossValidation('KFOLDS', kfolds, 'D', d);
> 
> nn_list = nncv.get('NN_LIST');
> assert(length(nn_list) == kfolds, ...  ①
>     [BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.FAIL_TEST], ...
>     'NNClassifierMLP_CrossValidation does not calculate the neural network list correctly.' ...
>     )
> e_list = nncv.get('EVALUATOR_LIST');
> assert(length(e_list) == kfolds, ...  ②
>     [BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.FAIL_TEST], ...
>     'NNClassifierMLP_CrossValidation does not calculate the evaluator list correctly.' ...
>     )
> ````
> 

%\bibliography{biblio}
%\bibliographystyle{plainnat}
