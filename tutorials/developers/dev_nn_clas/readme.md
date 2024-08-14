# Implement a new Neural Network Classifier

[![Tutorial Implement a new Neural Network Classifier](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_nn_clas.pdf)

This is the developer tutorial for implementing a new neural network classifier. 
In this tutorial, you will learn how to create the generator file "*.gen.m" for a new neural network classifier, which can then be compiled by `braph2genesis`. All kinds of neural network models are (direct or indirect) extensions of the base element `NNBase`. Here, you will use as example the neural network classifier `NNClassifierMLP` (multi-layer perceptron classifier).


## Table of Contents
> [Implementation of a neural network classifier (`NNClassifierMLP`)](#Implementation-of-a-neural-network-classifier-NNClassifierMLP)
>



<a id="Implementation-of-a-neural-network-classifier-NNClassifierMLP"></a>
## Implementation of a neural network classifier (`NNClassifierMLP`)  [⬆](#Table-of-Contents)

You will start by implementing in detail `NNClassifierMLP`, which is a direct extension of `NNBase`.
A multi-layer perceptron classifier `NNClassifierMLP` comprises a multi-layer perceptron classifier model and a given dataset.


> **Code 1.** **NNClassifierMLP element header.**
> 		The `header` section of the generator code for "_NNClassifierMLP.gen.m" provides the general information about the `NNClassifierMLP` element.
> ````matlab
> %% ¡header!
> NNClassifierMLP < NNBase (nn, multi-layer perceptron classifier) comprises a multi-layer perceptron classifier model and a given dataset.   ①
> 
> %%% ¡description!
> A neural network multi-layer perceptron classifier (NNClassifierMLP) comprises a multi-layer perceptron classifier model and a given dataset. NNClassifierMLP trains the multi-layer perceptron classifier with a formatted inputs ("CB", channel and batch) derived from the given dataset.
> 
> %%% ¡build!
> 1
> ````
> 
> ① defines `NNClassifierMLP` as a subclass of `NNBase`. The moniker will be `nn`.
> 


> **Code 2.** **NNClassifierMLP element prop update.**
> 		The `props_update` section of the generator code for "_NNClassifierMLP.gen.m" updates the properties of the `NNClassifierMLP` element. This defines the core properties of the data point.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of the neural network multi-layer perceptron classifier.
> %%%% ¡default!
> 'NNClassifierMLP'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron classifier.
> %%%% ¡default!
> 'A neural network multi-layer perceptron classifier (NNClassifierMLP) comprises a multi-layer perceptron classifier model and a given dataset. NNClassifierMLP trains the multi-layer perceptron classifier with a formatted inputs ("CB", channel and batch) derived from the given dataset.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron classifier.
> %%%% ¡settings!
> 'NNClassifierMLP'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for the neural network multi-layer perceptron classifier.
> %%%% ¡default!
> 'NNClassifierMLP ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron classifier.
> %%%% ¡default!
> 'NNClassifierMLP label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron classifier.
> %%%% ¡default!
> 'NNClassifierMLP notes'
> 
> %%% ¡prop!  ①
> D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
> %%%% ¡settings!
> 'NNDataset'
> %%%% ¡default!
> NNDataset('DP_CLASS', 'NNDataPoint_CON_CLA')
> 
> %%% ¡prop!
> DP_CLASSES (parameter, classlist) is the list of compatible data points. 
> %%%% ¡default!  ②
> {'NNDataPoint_CON_CLA' 'NNDataPoint_CON_FUN_MP_CLA' 'NNDataPoint_Graph_CLA' 'NNDataPoint_Measure_CLA'}
> 
> %%% ¡prop!
> INPUTS (query, cell) constructs the data in the CB (channel-batch) format.
> %%%% ¡calculate!  ③
> % inputs = nn.get('inputs', D) returns a cell array with the
> %  inputs for all data points in dataset D.
> if isempty(varargin)
>     value = {};
>     return
> end
> d = varargin{1};
> inputs_group = d.get('INPUTS');
> if isempty(inputs_group)
>     value = {};
> else
>     flattened_inputs_group = [];
>     for i = 1:1:length(inputs_group)
>         inputs_individual = inputs_group{i};
>         flattened_inputs_individual = [];
>         while ~isempty(inputs_individual)
>             currentData = inputs_individual{end};  % Get the last element from the stack
>             inputs_individual = inputs_individual(1:end-1);   % Remove the last element
> 
>             if iscell(currentData)
>                 % If it's a cell array, add its contents to the stack
>                 inputs_individual = [inputs_individual currentData{:}];
>             else
>                 % If it's numeric or other data, append it to the vector
>                 flattened_inputs_individual = [currentData(:); flattened_inputs_individual];
>             end
>         end
>         flattened_inputs_group = [flattened_inputs_group; flattened_inputs_individual'];
>     end
>     value = {flattened_inputs_group};
> end
> 
> %%% ¡prop!
> TARGETS (query, cell) constructs the targets in the CB (channel-batch) format with one-hot vectors.
> %%%% ¡calculate!  ④
> % targets = nn.get('TARGETS', D) returns a cell array with the
> %  targets for all data points in dataset D with one-hot vectors.
> if isempty(varargin)
>     value = {};
>     return
> end
> d = varargin{1};
> 
> target_ids = nn.get('TARGET_IDS', d);
> value = onehotencode(categorical(target_ids), 2);
> 
> %%% ¡prop!
> MODEL (result, net) is a trained neural network model.
> %%%% ¡calculate!  ⑤
> inputs = cell2mat(nn.get('INPUTS', nn.get('D')));  ⑥
> targets = nn.get('TARGET_IDS', nn.get('D'));  ⑦
> if isempty(inputs) || isempty(targets)
>     value = network();
> else
>     number_features = size(inputs, 2);
>     number_targets = size(targets, 2);
>     targets = categorical(targets); 
>     number_classes = numel(categories(targets));
>     
>     layers = nn.get('LAYERS');  ⑧
>     nn_architecture = [featureInputLayer(number_features, 'Name', 'Input')];
>     for i = 1:1:length(layers)
>         nn_architecture = [nn_architecture
>             fullyConnectedLayer(layers(i), 'Name', ['Dense_' num2str(i)])
>             batchNormalizationLayer('Name', ['BatchNormalization_' num2str(i)])
>             dropoutLayer('Name', ['Dropout_' num2str(i)])
>             ];
>     end
>     nn_architecture = [nn_architecture
>         reluLayer('Name', 'Relu_output')
>         fullyConnectedLayer(number_classes, 'Name', 'Dense_output')
>         softmaxLayer
>         classificationLayer('Name', 'Output')
>         ];
> 
>     % specify trianing options   ⑨
>     options = trainingOptions(nn.get('SOLVER'), ...
>         'MiniBatchSize', nn.get('BATCH'), ...
>         'MaxEpochs', nn.get('EPOCHS'), ...
>         'Shuffle', nn.get('SHUFFLE'), ...
>         'Plots', nn.get('PLOT_TRAINING'), ...
>         'Verbose', nn.get('VERBOSE'));
> 
>     % train the neural network  ⑩
>     value = trainNetwork(inputs, targets, nn_architecture, options);
> end
> ````
> 
> ① defines `NNDataset` which contains the `NNDataPoint` to train this classifier.
> 
> ② defines the compatible `NNDataPoint` classes with this `NNClassifierMLP`.
> 
> ③ is a query that transforms the input data of `NNDataPoint` to the CB (channel-batch) format by flattening its included cells.
> 
> ④ is a query that constructs the one-hot vectors for the target classes.
> 
> ⑤ trains the classifier with the defined dataset by the code under `¡calculate!`.
> 
> ⑥ and ⑦ extract the inputs and targets.
> 
> ⑧ defines the neural network architecture with user specified number of neurons and number of layers.
> 
> ⑨ defines the neural network training options.
> 
> ⑩ trains the model with those parameters and the neural network architecture.
> 


> **Code 3.** **NNClassifierMLP element props.**
> 		The `props` section of generator code for "_NNClassifierMLP.gen.m" defines the properties to be used in "NNClassifierMLP".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop! 
> TARGET_IDS (query, stringlist) constructs the target IDs which represent the class of each data point.
> %%%% ¡calculate!   ①
> % targets = nn.get('TARGET_IDS', D) returns a cell array with the
> %  targets for all data points in dataset D.
> if isempty(varargin)
>     value = {''};
>     return
> end
> d = varargin{1};
> targets = d.get('TARGETS');
> if isempty(targets)
>     value = {''};
> else
>     nn_targets = [];
>     for i = 1:1:length(targets)
>         target = targets{i};
>         nn_targets = [nn_targets; target];
>     end
>     value = nn_targets;
> end
> 
> %%% ¡prop!  ②
> LAYERS (data, rvector) defines the number of layers and their neurons.
> %%%% ¡default!
> [32 32]
> %%%% ¡gui!
> pr = PanelPropRVectorSmart('EL', nn, 'PROP', NNClassifierMLP.LAYERS, ...
>     'MIN', 0, 'MAX', 2000, ...
>     'DEFAULT', NNClassifierMLP.getPropDefault('LAYERS'), ...
>     varargin{:});
> 
> %%% ¡prop!
> WAITBAR (gui, logical) detemines whether to show the waitbar.
> %%%% ¡default!
> true
> 
> %%% ¡prop!
> INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.
> %%%% ¡default!
> .001
> 
> %%% ¡prop!  ③
> FEATURE_IMPORTANCE (query, cell) evaluates the average significance of each feature by iteratively shuffling its values P times and measuring the resulting average decrease in model performance.
> %%%% ¡calculate!
> % fi = nn.get('FEATURE_IMPORTANCE', D, P, SEED) retrieves a cell array containing
> %  the feature importance values for the trained model, as assessed by
> %  evaluating it on the input dataset D.
> if isempty(varargin)
>     value = {};
>     return
> end
> d = varargin{1};
> P = varargin{2};
> seeds = varargin{3};
> 
> inputs = cell2mat(nn.get('INPUTS', d));
> if isempty(inputs)
>     value = {};
>     return
> end
> targets = nn.get('TARGETS', d);
> net = nn.get('MODEL');
> 
> number_features = size(inputs, 2);
> original_loss = crossentropy(net.predict(inputs), targets);
> 
> wb = braph2waitbar(nn.get('WAITBAR'), 0, ['Feature importance permutation ...']);
> 
> start = tic;
> for i = 1:1:P  ④
>     rng(seeds(i), 'twister')
>     parfor j = 1:1:number_features  ⑤
>         scrambled_inputs = inputs;
>         permuted_value = squeeze(normrnd(mean(inputs(:, j)), std(inputs(:, j)), squeeze(size(inputs(:, j))))) + squeeze(randn(size(inputs(:, j)))) + mean(inputs(:, j));
>         scrambled_inputs(:, j) = permuted_value;
>         scrambled_loss = crossentropy(net.predict(scrambled_inputs), targets);
>         feature_importance(j) = scrambled_loss;
>     end
> 
>     feature_importance_all_permutations{i} = feature_importance / original_loss;
> 
>     braph2waitbar(wb, i / P, ['Feature importance permutation ' num2str(i) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
>     if nn.get('VERBOSE')
>         disp(['** PERMUTATION FEATURE IMPORTANCE - sampling #' int2str(i) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
>     end
>     if nn.get('INTERRUPTIBLE')
>         pause(nn.get('INTERRUPTIBLE'))
>     end
> end
> 
> braph2waitbar(wb, 'close')
> 
> value = feature_importance_all_permutations;
> ````
> 
> ① is a query that collects all the target class for all data points.
> 
> ② defines the number of neuron per layer. For example, `[32 32]` represents two layers, each containing 32 neurons.
> 
> ③ is a query that calculates the permuation feature importance. Note that, other neural network architectures, such as convolutional neural network, have other techniques to obtain feature importance.
> 
> ④ and ⑤iteratively shuffle the feature values from any given dataset P times and measuring the resulting average decrease in model performance.
> 




> **Code 4.** **NNClassifierMLP element tests.**
> 		The `tests` section from the element generator "_NNClassifierMLP.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡test!
> %%%% ¡name!
> train the classifier with example data
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
> nn = NNClassifierMLP('D', d, 'LAYERS', [10 10 10]);
> trained_model = nn.get('MODEL');
> 
> % Check whether the number of fully-connected layer matches (excluding Dense_output layer)  ①
> assert(length(nn.get('LAYERS')) == sum(contains({trained_model.Layers.Name}, 'Dense')) - 1, ...
>     [BRAPH2.STR ':NNClassifierMLP:' BRAPH2.FAIL_TEST], ...
>     'NNClassifierMLP does not construct the layers correctly. The number of the inputs should be the same as the length of dense layers the property.' ...
>     )
> ````
> 
> ① checks whether the number of layers from the trained model is correctly set.
> 

%\bibliography{biblio}
%\bibliographystyle{plainnat}
