%% ¡header!
NNClassifierData < NNData (nnd, data of a neural network classifier) produces NN groups to train or test a neural netowrk classifier.  

%% ¡description!
This dataset produce the NN Groups to train or test a neural network classifier.
The input for a neural network classifer can be obtained directly
from the structual data, the adjacency matrices, or the graph measures.
Feature selection procedure can be implemented.  
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
GR1 (data, item) is a group of subjects.
%%%% ¡settings!
'Group'

%%% ¡prop!
GR2 (data, item) is a group of subjects.
%%%% ¡settings!
'Group'

%%% ¡prop!
TARGET_NAME (data, string) is the name of the traget.
%%%% ¡default!
'diagnosis'

%%% ¡prop!
SPLIT_GR1 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnd.get('GR1').get('SUB_DICT').length());
    num_train = nnd.get('GR1').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%%% ¡prop!
SPLIT_GR2 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnd.get('GR2').get('SUB_DICT').length());
    num_train = nnd.get('GR2').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%%% ¡prop!
FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
%%%% ¡default!
num2cell(0.05)
%%%% ¡conditioning!
if ~iscell(value) & isnumeric(value)
    value = num2cell(value);
end

%%% ¡prop!
GR1_NN (result, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
GR2_NN (result, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
GR_TRAIN (result, item) is a group of NN subjects for the training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
% init a NNGroup
nnGroup = 'GR1_NN';
train_nn_gr = NNGroup( ...
    'SUB_CLASS', nnd.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_nn_gr.set( ...
    'ID', nnd.get(nnGroup).get('ID'), ...
    'LABEL', nnd.get(nnGroup).get('LABEL'), ...
    'NOTES', nnd.get(nnGroup).get('NOTES') ...
    );

% add subejcts from all groups
sub_dict = train_nn_gr.get('SUB_DICT');

if nnd.memorize('GR1_NN').get('SUB_DICT').length() > 0
    subs = nnd.memorize('GR1_NN').get('SUB_DICT').getItems();
    selected_idx = setdiff(1:length(subs), nnd.get('SPLIT_GR1'));
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_dict.add(sub);
    end
end

if nnd.memorize('GR2_NN').get('SUB_DICT').length() > 0
    subs = nnd.memorize('GR2_NN').get('SUB_DICT').getItems();
    selected_idx = setdiff(1:length(subs), nnd.get('SPLIT_GR2'));
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_dict.add(sub);
    end
end

if sub_dict.length() > 0
    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
    targets = onehotencode(categorical(target_names), 1);
    for i = 1:1:sub_dict.length()
        sub_dict.getItem(i).set('TARGET', {targets(:, i)});
    end
end

train_nn_gr.set('SUB_DICT', sub_dict);

value = train_nn_gr;

%%% ¡prop!
GR_VAL (result, item) is a group of NN subjects for the validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
% init a NNGroup
nnGroup = 'GR1_NN';
val_nn_gr = NNGroup( ...
    'SUB_CLASS', nnd.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_nn_gr.set( ...
    'ID', nnd.get(nnGroup).get('ID'), ...
    'LABEL', nnd.get(nnGroup).get('LABEL'), ...
    'NOTES', nnd.get(nnGroup).get('NOTES') ...
    );

% add subejcts from all groups
sub_dict = val_nn_gr.get('SUB_DICT');

if nnd.memorize('GR1_NN').get('SUB_DICT').length() > 0
    subs = nnd.memorize('GR1_NN').get('SUB_DICT').getItems();
    selected_idx = nnd.get('SPLIT_GR1');
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_dict.add(sub);
    end
end

if nnd.memorize('GR2_NN').get('SUB_DICT').length() > 0
    subs = nnd.memorize('GR2_NN').get('SUB_DICT').getItems();
    selected_idx = nnd.get('SPLIT_GR2');
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_dict.add(sub);
    end
end

if sub_dict.length() > 0
    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
    targets = onehotencode(categorical(target_names), 1);
    for i = 1:1:sub_dict.length()
        sub_dict.getItem(i).set('TARGET', {targets(:, i)});
    end
end

val_nn_gr.set('SUB_DICT', sub_dict);

value = val_nn_gr;

%%% ¡prop!
FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.
%%%% ¡calculate!
percentile = cell2mat(nnd.get('FEATURE_MASK'));
data = cellfun(@(x) x.get('INPUT'), nnd.get('GR_TRAIN').get('SUB_DICT').getItems(), 'UniformOutput', false);

if nnd.get('GR_TRAIN').get('SUB_DICT').length == 0
    value = {};
else
    y = cellfun(@(x) cell2mat(x.get('TARGET')), nnd.get('GR_TRAIN').get('SUB_DICT').getItems(), 'UniformOutput', false);
    y = cell2mat(y);
    label = y(1, :);
    num_feature_cluster = length(data{1});
    value = cell(size(data{1}));
    for k = 1:1:num_feature_cluster
        data_per_cluster = cellfun(@(v)v{k}, data, 'UniformOutput', false);
        mask = zeros(size(data_per_cluster{k}));
        if ~isempty(mask)
            for i = 1:numel(mask)
                data_per_feature = cellfun(@(v)v(i), data_per_cluster);
                if(any(isinf(data_per_feature)))
                    mask(i) = 0;
                else
                    mask(i) = nnd.mutual_information_analysis(data_per_feature, label, 5);
                end
            end

            [~, idx_all] = sort(mask(:), 'descend');
            num_top_idx = ceil(percentile * numel(mask));
            mask(idx_all(1:num_top_idx)) = 1;
            mask(idx_all(num_top_idx:end)) = 0;
        end
        value{k} = mask;
    end
end

%%% ¡prop!
GR_TRAIN_FS (result, item) is a group of NN subjects with feature mask for the training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr_copy = nnd.memorize('GR_TRAIN');
feature_mask = nnd.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnd.memorize('FEATURE_SELECTION_ANALYSIS');
end

if isempty(feature_mask)
    value = NNGroup();
else
    for i = 1:1:nn_gr_copy.get('SUB_DICT').length()
        nn_gr_copy.get('SUB_DICT').getItem(i).set('FEATURE_MASK', feature_mask);
    end
    value = nn_gr_copy;
end

%%% ¡prop!
GR_VAL_FS (result, item) is a group of NN subjects with feature mask for the validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr_copy = nnd.memorize('GR_VAL');
feature_mask = nnd.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnd.memorize('FEATURE_SELECTION_ANALYSIS');
end

if isempty(feature_mask)
    value = NNGroup();
else
    for i = 1:1:nn_gr_copy.get('SUB_DICT').length()
        nn_gr_copy.get('SUB_DICT').getItem(i).set('FEATURE_MASK', feature_mask);
    end
    value = nn_gr_copy;
end