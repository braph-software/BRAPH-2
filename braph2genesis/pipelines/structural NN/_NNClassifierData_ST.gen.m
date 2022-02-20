%% ¡header!
NNClassifierData_ST < NNClassifierData (nnd, data of a neural network classifier with structural data) produces a dataset to a neural netowrk classifier using structural data. 

%% ¡description!
This dataset can be used to train or test a neural network classifier. The
INPUTS and TARGETS are the two cells for trianing a neurla network. The INPUTS 
cell is obtained direcly from structural data, and it is represented as 
floating point feature cell. Feature selection procedure can be implemented 
when constructing the INPUTS. The TARGETS cell holds the target values for 
the trianing samples. 

%% ¡props_update!
%%% ¡prop!
GR1 (data, item) is the subject group 1, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
GR2 (data, item) is the subject group 2, which also defines the subject class SubjectST.
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
data1 = nnd.data_construction(nnd.get('TRAIN_GR1'));
data2 = nnd.data_construction(nnd.get('TRAIN_GR1'));
data = [data1 data2];

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
value = nnd.input_construction(nnd.get('TRAIN_GR1'), nnd.get('TRAIN_GR2'), mask);

%%% ¡prop!
VAL_INPUTS (result, cell) is the inputs from validation set for testing a neural network.
%%%% ¡calculate!
mask = nnd.get('FEATURE_MASK');
if length(mask) == 1 && abs(mask) <= 1
    mask = nnd.get('FEATURE_MASK_ANALYSIS');
end
value = nnd.input_construction(nnd.get('VAL_GR1'), nnd.get('VAL_GR2'), mask);

%% ¡methods!
function inputs = input_construction(nnd, gr1, gr2, mask)
    %INPUT_CONSTRUCTION constructs the inputs for neural networks.
    % 
    % INPUTS = INPUT_CONSTRUCTION(NN, GR1, GR2, MASK) 
    %  constructs the input for training or testing neural networks. The 
    %  features for each subject will be extracted from thu SUB_DICT in 
    %  GR1 and GR2 the group. Then the extracted features will be masked by MASK the 
    %  feature mask. The selected features will construct the eventual 
    %  inputs INPUTS for the neural network.
    
    data_gr1 = nnd.data_construction(gr1);  
    data_gr2 = nnd.data_construction(gr2);  
    data_gr = [data_gr1 data_gr2];
    inputs = cellfun(@(v)v(mask), data_gr, 'UniformOutput', false);
    inputs = {cat(2, inputs{:})};
end

%% ¡tests!
%%% ¡test!
%%%% ¡name!
example
%%%% ¡code!
example_NN_ST_Classification
