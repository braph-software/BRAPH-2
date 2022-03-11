%% ¡header!
NNClassifierData < NNData (nnd, data of a neural network classifier) produces a dataset to train or test a neural netowrk classifier.  

%% ¡description!
This dataset can be used to train or test a neural network classifier. The
INPUTS and TARGETS are the two cells for trianing a neurla network. The INPUTS 
cell is represented as floating point feature vectors obtained from adjacency
matrices. Feature selection procedure can be implemented when constructing the 
INPUTS. The TARGETS cell holds the target values for the trianing samples. 
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
GR1 (data, item) is the subject group 1.
%%%% ¡settings!
'Group'

%%% ¡prop!
GR2 (data, item) is the subject group 2.
%%%% ¡settings!
'Group'

%%% ¡prop!
TRAIN_NN_GR1 (result, item) is the subject group 1 for training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
nnGroup = 'NN_GR1';
train_nn_gr = NNGroup( ...
    'SUB_CLASS', nnd.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_nn_gr.set( ...
    'ID', nnd.get(nnGroup).get('ID'), ...
    'LABEL', nnd.get(nnGroup).get('LABEL'), ...
    'NOTES', nnd.get(nnGroup).get('NOTES'), ...
    'FEATURE_LABEL', nnd.get(nnGroup).get('FEATURE_LABEL'), ...
    'FEATURE_MASK', nnd.get(nnGroup).get('FEATURE_MASK') ...
    );

sub_dict = train_nn_gr.get('SUB_DICT');
subs = nnd.get(nnGroup).get('SUB_DICT').getItems();
selected_idx = setdiff(1:length(subs), nnd.get('SPLIT_GR1'));
selected_subs = subs(selected_idx);
for i = 1:1:length(selected_subs)
    sub = selected_subs{i};
    sub_dict.add(sub);
end
train_nn_gr.set('SUB_DICT', sub_dict);

value = train_nn_gr;

%%% ¡prop!
TRAIN_NN_GR2 (result, item) is the subject group 2 for taining set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
nnGroup = 'NN_GR2';
train_nn_gr = NNGroup( ...
    'SUB_CLASS', nnd.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_nn_gr.set( ...
    'ID', nnd.get(nnGroup).get('ID'), ...
    'LABEL', nnd.get(nnGroup).get('LABEL'), ...
    'NOTES', nnd.get(nnGroup).get('NOTES'), ...
    'FEATURE_LABEL', nnd.get(nnGroup).get('FEATURE_LABEL'), ...
    'FEATURE_MASK', nnd.get(nnGroup).get('FEATURE_MASK') ...
    );

sub_dict = train_nn_gr.get('SUB_DICT');
subs = nnd.get(nnGroup).get('SUB_DICT').getItems();
selected_idx = setdiff(1:length(subs), nnd.get('SPLIT_GR2'));
selected_subs = subs(selected_idx);
for i = 1:1:length(selected_subs)
    sub = selected_subs{i};
    sub_dict.add(sub);
end
train_nn_gr.set('SUB_DICT', sub_dict);

value = train_nn_gr;

%%% ¡prop!
VAL_NN_GR1 (result, item) is the subject group 1 for validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
nnGroup = 'NN_GR1';
val_nn_gr = NNGroup( ...
    'SUB_CLASS', nnd.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_nn_gr.set( ...
    'ID', nnd.get(nnGroup).get('ID'), ...
    'LABEL', nnd.get(nnGroup).get('LABEL'), ...
    'NOTES', nnd.get(nnGroup).get('NOTES'), ...
    'FEATURE_LABEL', nnd.get(nnGroup).get('FEATURE_LABEL'), ...
    'FEATURE_MASK', nnd.get(nnGroup).get('FEATURE_MASK') ...
    );

sub_dict = val_nn_gr.get('SUB_DICT');
subs = nnd.get(nnGroup).get('SUB_DICT').getItems();
selected_idx = nnd.get('SPLIT_GR1');
selected_subs = subs(selected_idx);
for i = 1:1:length(selected_subs)
    sub = selected_subs{i};
    sub_dict.add(sub);
end
val_nn_gr.set('SUB_DICT', sub_dict);

value = val_nn_gr;

%%% ¡prop!
VAL_NN_GR2 (result, item) is the subject group 2 for validation set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
nnGroup = 'NN_GR2';
val_nn_gr = NNGroup( ...
    'SUB_CLASS', nnd.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_nn_gr.set( ...
    'ID', nnd.get(nnGroup).get('ID'), ...
    'LABEL', nnd.get(nnGroup).get('LABEL'), ...
    'NOTES', nnd.get(nnGroup).get('NOTES'), ...
    'FEATURE_LABEL', nnd.get(nnGroup).get('FEATURE_LABEL'), ...
    'FEATURE_MASK', nnd.get(nnGroup).get('FEATURE_MASK') ...
    );

sub_dict = val_nn_gr.get('SUB_DICT');
subs = nnd.get(nnGroup).get('SUB_DICT').getItems();
selected_idx = nnd.get('SPLIT_GR2');
selected_subs = subs(selected_idx);
for i = 1:1:length(selected_subs)
    sub = selected_subs{i};
    sub_dict.add(sub);
end
val_nn_gr.set('SUB_DICT', sub_dict);

value = val_nn_gr;

%%% ¡prop!
SPLIT_GR1 (data, rvector) is a vector stating which subjects belong to validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnd.get('GR1').get('SUB_DICT').length());
    num_train = nnd.get('GR1').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%%% ¡prop!
SPLIT_GR2 (data, rvector) is a vector stating which subjects belong to validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnd.get('GR2').get('SUB_DICT').length());
    num_train = nnd.get('GR2').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%%% ¡prop!
FEATURE_MASK (data, cell) is a mask for selected features.
%%%% ¡default!
0.05

%%% ¡prop!
FEATURE_MASK_ANALYSIS (result, cell) is an analysis for generating mask for selected features.
%%%% ¡calculate!
density = nnd.get('FEATURE_MASK');

data = cellfun(@(x) x.get('INPUT'), nnd.get('NN_GR').get('SUB_DICT').getItems();, 'UniformOutput', false);
y = cellfun(@(x) x.get('TARGET'), nnd.get('NN_GR').get('SUB_DICT').getItems();, 'UniformOutput', false);

if(isempty(data))
    value = [];
else
    for j = 1:size(data{1}, 1)
        for k = 1:size(data{1}, 2)
            data_per_feature = cellfun(@(v)v(j, k), data);
            label = y;
            if(any(isinf(data_per_feature)))
                mask(j, k) = 0;
            else
                mask(j, k) = nnd.mutual_information_analysis(data_per_feature, label', 5);
            end
        end
    end
    [~,idx_all] = sort(mask(:), 'descend');
    num_top_idx = ceil(density * size(mask, 1) * size(mask, 2));

    value = idx_all(1:num_top_idx);
end

%%% ¡prop!
NN_GR1 (result, item) is the group composed of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
NN_GR2 (result, item) is the group composed of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
NN_GR1_FS (result, item) is the group composed of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
NN_GR2_FS (result, item) is the group composed of NN subjects.
%%%% ¡settings!
'NNGroup'

% % %%% ¡prop!
% % VAL_INPUTS (result, cell) is the inputs from validation set for testing a neural network.
% % %%%% ¡calculate!
% % mask = nnd.get('FEATURE_MASK');
% % if length(mask) == 1 && abs(mask) <= 1
% %     mask = nnd.get('FEATURE_MASK_ANALYSIS');
% % end
% % value = nnd.input_construction(nnd.get('VAL_G_DICT_1'), nnd.get('VAL_G_DICT_2'), nnd.get('INPUT_TYPE'), nnd.get('MEASURES'), mask);
% % 
% % %%% ¡prop!
% % TARGETS (result, cell) is the label for the dataset.
% % %%%% ¡calculate!
% % y1 = repmat(string(nnd.get('TRAIN_GR1').get('ID')), nnd.get('TRAIN_GR1').get('SUB_DICT').length(), 1);
% % y2 = repmat(string(nnd.get('TRAIN_GR2').get('ID')), nnd.get('TRAIN_GR2').get('SUB_DICT').length(), 1);
% % 
% % value = {onehotencode(categorical([y1; y2]), 2)};
% % 
% % %%% ¡prop!
% % VAL_TARGETS (result, cell) is the label for the validation dataset.
% % %%%% ¡calculate!
% % y1 = repmat(string(nnd.get('VAL_GR1').get('ID')), nnd.get('VAL_GR1').get('SUB_DICT').length(), 1);
% % y2 = repmat(string(nnd.get('VAL_GR2').get('ID')), nnd.get('VAL_GR2').get('SUB_DICT').length(), 1);
% % 
% % value = {onehotencode(categorical([y1; y2]), 2)};
% % 
% % %%% ¡prop!
% % TARGET_CLASS_NAMES (result, string) is the name of the traget for groups
% % %%%% ¡default!
% % 'Group1'
% % %%%% ¡calculate!
% % y1 = repmat(string(nnd.get('VAL_GR1').get('ID')), nnd.get('VAL_GR1').get('SUB_DICT').length(), 1);
% % y2 = repmat(string(nnd.get('VAL_GR2').get('ID')), nnd.get('VAL_GR2').get('SUB_DICT').length(), 1);
% % 
% % value = categories(categorical([y1; y2]));
% % 
% % 
% % %% ¡props_update!
% % %%% ¡prop!
% % INPUTS (result, cell) is the inputs for training or testing a neural network.
% % %%%% ¡calculate!
% % mask = nnd.get('FEATURE_MASK');
% % if length(mask) == 1 && abs(mask) <= 1
% %     mask = nnd.get('FEATURE_MASK_ANALYSIS');
% % end
% % value = nnd.input_construction(nnd.get('TRAIN_G_DICT_1'), nnd.get('TRAIN_G_DICT_2'), nnd.get('INPUT_TYPE'), nnd.get('MEASURES'), mask);

%% ¡methods!
function inputs = input_construction(nnd, g_dict_1, g_dict_2, input_type, measure_class, mask)
    %INPUT_CONSTRUCTION constructs the inputs for neural networks.
    % 
    % INPUTS = INPUT_CONSTRUCTION(NN, G_DICT_1, G_DICT_2) constructs
    %  the input for training or testing neural networks. The connectivity
    %  matrices will firstly extracted from graph dict G_DICT_1 and
    %  G_DICT_2. Then the extracted features will be masked by the feature
    %  mask. The selected features will construct the eventual inputs INPUTS 
    %  for the neural network.
    
    % get the connectivity matrices 

    data_gr_1 = nnd.data_construction_graph(g_dict_1, input_type, measure_class);
    data_gr_2 = nnd.data_construction_graph(g_dict_2, input_type, measure_class);
    data_gr = [data_gr_1 data_gr_2];
    inputs = cellfun(@(v)v(mask), data_gr, 'UniformOutput', false);
    inputs = {cat(2, inputs{:})};
end
