%% ¡header!
NNRegressorData_ST < NNRegressorData (nnd, data of a neural network regressor with structural data) produces a dataset to train or test a neural netowrk regressor using structural data. 

%% ¡description!
This dataset can be used to train or test a neural network regressor. The
INPUTS and TARGETS are the two cells for trianing a neurla network. The INPUTS 
cell is obtained direcly from structural data, and is represented as 
floating point feature cell. Feature selection procedure can be implemented 
when constructing the INPUTS. The TARGETS cell holds the target values for 
the trianing samples. 

%% ¡props_update!
%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡default!
'structural_data'

%%% ¡prop!
FEATURE_MASK_ANALYSIS (result, cvector) is an analysis for generating mask for selected features.
%%%% ¡calculate!
density = nnd.get('FEATURE_MASK');
data = nnd.data_construction(nnd.get('TRAIN_GR'));
if(isempty(data))
    value = [];
else
    y = nnd.get('TARGETS');
    y = y{1};
    for j = 1:size(data{1},1)
        for k = 1:size(data{1},2)
            data_per_feature = cellfun(@(v)v(j, k), data);
            label = y';
            mask(j, k) = nnd.mutual_information_analysis(data_per_feature, label, 5);
        end
    end
    [~,idx_all] = sort(mask(:), 'descend');
    num_top_idx = floor(density * size(mask, 1) * size(mask, 2));

    value = idx_all(1:num_top_idx);
end

%%% ¡prop!
INPUTS (result, cell) is the inputs for training or testing a neural network.
%%%% ¡calculate!
mask = nnd.get('FEATURE_MASK');
if length(mask) == 1 && abs(mask) <= 1
    mask = nnd.get('FEATURE_MASK_ANALYSIS');
end
value = nnd.input_construction(nnd.get('TRAIN_GR'), mask);

%%% ¡prop!
VAL_INPUTS (result, cell) is the inputs from validation set for testing a neural network.
%%%% ¡calculate!
mask = nnd.get('FEATURE_MASK');
if length(mask) == 1 && abs(mask) <= 1
    mask = nnd.get('FEATURE_MASK_ANALYSIS');
end
value = nnd.input_construction(nnd.get('VAL_GR'), mask);

%%% ¡prop!
TARGETS (result, cell) is the label for the dataset.
%%%% ¡calculate!
target_list = cellfun(@(x) x.get(nnd.get('TARGET_NAME')), nnd.get('TRAIN_GR').get('SUB_DICT').getItems, 'UniformOutput', false);
value = {cat(2, target_list{:})'};

%%% ¡prop!
VAL_TARGETS (result, cell) is the label for the validation dataset.
%%%% ¡calculate!
target_list = cellfun(@(x) x.get(nnd.get('TARGET_NAME')), nnd.get('VAL_GR').get('SUB_DICT').getItems, 'UniformOutput', false);
value = {cat(2, target_list{:})'};

%%% ¡prop!
TARGET_NAME (data, string) is the name of the traget.
%%%% ¡default!
'age'

%% ¡methods!
function inputs = input_construction(nnd, gr, mask)
    %INPUT_CONSTRUCTION constructs the inputs for neural networks.
    % 
    % INPUTS = INPUT_CONSTRUCTION(NN, GR) 
    %  constructs the input for training or testing neural networks. The 
    %  features for each subject will be extracted from thu SUB_DICT in 
    %  GR the group. Then the extracted features will be masked by MASK the 
    %  feature mask. The selected features will construct the eventual 
    %  inputs INPUTS for the neural network.
    
    data_gr = nnd.data_construction(gr);  
    inputs = cellfun(@(v)v(mask), data_gr, 'UniformOutput', false);
    inputs = {cat(2, inputs{:})};
end

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_NN_ST_Regression