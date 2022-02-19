%% ¡header!
NNRegressorData < NNData (nnd, data of a neural network regressor) produces a dataset to train or test a neural netowrk regressor.  

%% ¡description!
This dataset can be used to train or test a neural network regressor. The
INPUTS and TARGETS are the two cells for trianing a neurla network. The INPUTS 
cell is represented as floating point feature vectors. Feature selection procedure
can be implemented when constructing the INPUTS. The TARGETS cell holds the 
target values for the trianing samples. Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
GR (data, item) is the subject group.
%%%% ¡settings!
'Group'

%%% ¡prop!
TRAIN_GR (result, item) is the subject group for training set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
train_gr = Group( ...
    'SUB_CLASS', nnd.get('GR').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_gr.set( ...
    'ID', nnd.get('GR').get('ID'), ...
    'LABEL', nnd.get('GR').get('LABEL'), ...
    'NOTES', nnd.get('GR').get('NOTES') ...
    );

subdict = train_gr.get('SUB_DICT');
sub = nnd.get('GR').get('SUB_DICT').getItems();
selected_idx = setdiff(1:length(sub), nnd.get('SPLIT'));
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
train_gr.set('SUB_DICT', subdict);

value = train_gr;

%%% ¡prop!
VAL_GR (result, item) is the subject group for validation set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
val_gr = Group( ...
    'SUB_CLASS', nnd.get('GR').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_gr.set( ...
    'ID', nnd.get('GR').get('ID'), ...
    'LABEL', nnd.get('GR').get('LABEL'), ...
    'NOTES', nnd.get('GR').get('NOTES') ...
    );

subdict = val_gr.get('SUB_DICT');
sub = nnd.get('GR').get('SUB_DICT').getItems();
selected_idx = nnd.get('SPLIT');
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
val_gr.set('SUB_DICT', subdict);

value = val_gr;

%%% ¡prop!
SPLIT (data, rvector) is a vector stating which subjects belong to validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnd.get('GR').get('SUB_DICT').length());
    num_train = nnd.get('GR').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%%% ¡prop!
FEATURE_MASK (data, cvector) is a mask for selected features.
%%%% ¡default!
0.05

%%% ¡prop!
FEATURE_MASK_ANALYSIS (result, cvector) is an analysis for generating mask for selected features.
%%%% ¡calculate!
density = nnd.get('FEATURE_MASK');
data = nnd.data_construction_graph(nnd.get('TRAIN_G_DICT'), nnd.get('INPUT_TYPE'), nnd.get('MEASURES'));
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
TRAIN_G_DICT (result, idict) is the graph obtained from subjects in training set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
VAL_G_DICT (result, idict) is the graph obtained from subjects in validation set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
VAL_INPUTS (result, cell) is the inputs from validation set for testing a neural network.
%%%% ¡calculate!
mask = nnd.get('FEATURE_MASK');
if length(mask) == 1 && abs(mask) <= 1
    mask = nnd.get('FEATURE_MASK_ANALYSIS');
end
value = nnd.input_construction(nnd.get('VAL_G_DICT'), nnd.get('INPUT_TYPE'), nnd.get('MEASURES'), mask);

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

%% ¡props_update!
%%% ¡prop!
INPUTS (result, cell) is the inputs for training or testing a neural network.
%%%% ¡calculate!
mask = nnd.get('FEATURE_MASK');
if length(mask) == 1 && abs(mask) <= 1
    mask = nnd.get('FEATURE_MASK_ANALYSIS');
end
value = nnd.input_construction(nnd.get('TRAIN_G_DICT'), nnd.get('INPUT_TYPE'), nnd.get('MEASURES'), mask);

%% ¡methods!
function inputs = input_construction(nnd, g_dict, input_type, measure_class, mask)
    %INPUT_CONSTRUCTION constructs the inputs for neural networks.
    % 
    % INPUTS = INPUT_CONSTRUCTION(NN, G_DICT, INPUT_TYPE, MEASURE_CLASS, MASK) 
    %  constructs the input for training or testing neural networks. Based
    %  on the INPUT_TYPE, either the adjacency matrices or the graph
    %  measures in MEASURE_CLASS will firstly extracted from graph dict G_DICT. 
    %  Then the extracted features will be masked by the feature mask. The 
    %  selected features will construct the eventual inputs INPUTS for the
    %  neural network.
    
    data_gr = nnd.data_construction_graph(g_dict, input_type, measure_class);  
    inputs = cellfun(@(v)v(mask), data_gr, 'UniformOutput', false);
    inputs = {cat(2, inputs{:})};
end