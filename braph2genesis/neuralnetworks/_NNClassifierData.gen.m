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
TRAIN_GR1 (result, item) is the subject group 1 for training set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
train_gr_1 = Group( ...
    'SUB_CLASS', nnd.get('GR1').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_gr_1.set( ...
    'ID', nnd.get('GR1').get('ID'), ...
    'LABEL', nnd.get('GR1').get('LABEL'), ...
    'NOTES', nnd.get('GR1').get('NOTES') ...
    );

subdict = train_gr_1.get('SUB_DICT');
sub = nnd.get('GR1').get('SUB_DICT').getItems();
selected_idx = setdiff(1:length(sub), nnd.get('SPLIT_GR1'));
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
train_gr_1.set('SUB_DICT', subdict);

value = train_gr_1;

%%% ¡prop!
TRAIN_GR2 (result, item) is the subject group 2 for taining set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
train_gr_2 = Group( ...
    'SUB_CLASS', nnd.get('GR2').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_gr_2.set( ...
    'ID', nnd.get('GR2').get('ID'), ...
    'LABEL', nnd.get('GR2').get('LABEL'), ...
    'NOTES', nnd.get('GR2').get('NOTES') ...
    );

subdict = train_gr_2.get('SUB_DICT');
sub = nnd.get('GR2').get('SUB_DICT').getItems();
selected_idx = setdiff(1:length(sub), nnd.get('SPLIT_GR2'));
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
train_gr_2.set('SUB_DICT', subdict);

value = train_gr_2;

%%% ¡prop!
VAL_GR1 (result, item) is the subject group 1 for validation set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
val_gr_1 = Group( ...
    'SUB_CLASS', nnd.get('GR1').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_gr_1.set( ...
    'ID', nnd.get('GR1').get('ID'), ...
    'LABEL', nnd.get('GR1').get('LABEL'), ...
    'NOTES', nnd.get('GR1').get('NOTES') ...
    );

subdict = val_gr_1.get('SUB_DICT');
sub = nnd.get('GR1').get('SUB_DICT').getItems();
selected_idx = nnd.get('SPLIT_GR1');
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
val_gr_1.set('SUB_DICT', subdict);

value = val_gr_1;

%%% ¡prop!
VAL_GR2 (result, item) is the subject group 2 for validation set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
val_gr_2 = Group( ...
    'SUB_CLASS', nnd.get('GR2').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_gr_2.set( ...
    'ID', nnd.get('GR2').get('ID'), ...
    'LABEL', nnd.get('GR2').get('LABEL'), ...
    'NOTES', nnd.get('GR2').get('NOTES') ...
    );

subdict = val_gr_2.get('SUB_DICT');
sub = nnd.get('GR2').get('SUB_DICT').getItems();
selected_idx = nnd.get('SPLIT_GR2');
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
val_gr_2.set('SUB_DICT', subdict);

value = val_gr_2;

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
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡settings!
{'adjacency_matrices' 'graph_measures'}

%%% ¡prop!
MEASURES (data, classlist) is the graph measures as input to NN.
%%%% ¡settings!
{'Measure'}
%%%% ¡default!
{'DegreeAv', 'Degree'}

%%% ¡prop!
FEATURE_MASK (data, cvector) is a mask for selected features.
%%%% ¡default!
0.05

%%% ¡prop!
FEATURE_MASK_ANALYSIS (result, cvector) is an analysis for generating mask for selected features.
%%%% ¡calculate!
density = nnd.get('FEATURE_MASK');
if string(nnd.get('INPUT_TYPE')) == 'adjacency_matrices'
    adjs_gr_1 = nnd.get('TRAIN_G_DICT_1').getItems();
    data_gr_1 = {};
    for i = 1:length(adjs_gr_1)
        data_gr_1{end+1} = cell2mat(adjs_gr_1{i}.get('A'));
    end

    adjs_gr_2 = nnd.get('TRAIN_G_DICT_1').getItems();
    data_gr_2 = {};
    for i = 1:length(adjs_gr_2)
        data_gr_2{end+1} = cell2mat(adjs_gr_2{i}.get('A'));
    end

    data = [data_gr_1 data_gr_2];
else
    adjs_gr_1 = nnd.get('TRAIN_G_DICT_1').getItems();
    data_gr_1 = {};
    measure_class = nnd.get('MEASURES');
    for i = 1:length(adjs_gr_1)
        m = [];
        for j = 1:length(measure_class)
            m = [m; cell2mat(adjs_gr_1{i}.getMeasure(measure_class{j}).get('M'))];
        end
        data_gr_1{end+1} = m;
    end

    adjs_gr_2 = nnd.get('TRAIN_G_DICT_2').getItems();
    data_gr_2 = {};
    measure_class = nnd.get('MEASURES');
    for i = 1:length(adjs_gr_2)
        m = [];
        for j = 1:length(measure_class)
            m = [m; cell2mat(adjs_gr_2{i}.getMeasure(measure_class{j}).get('M'))];
        end
        data_gr_1{end+1} = m;
    end

    data = [data_gr_1 data_gr_2];
end
if(isempty(data))
    value = {};
else
    y = nnd.get('TARGETS');
    y = y{1};
    for j = 1:size(data{1}, 1)
        for k = 1:size(data{1}, 2)
            data_per_feature = cellfun(@(v)v(j, k), data);
            label = y;
            mask(j, k) = nnd.mutual_information_analysis(data_per_feature, label', 5);
        end
    end
    [~,idx_all] = sort(mask(:), 'descend');
    num_top_idx = ceil(density * size(mask, 1) * size(mask, 2));

    value = idx_all(1:num_top_idx);
end

%%% ¡prop!
TRAIN_G_DICT_1 (result, idict) is the graph obtained from subject group 1 in training set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
TRAIN_G_DICT_2 (result, idict) is the graph obtained from subject group 2 in training set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
VAL_G_DICT_1 (result, idict) is the graph obtained from subject group 1 in validation set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
VAL_G_DICT_2 (result, idict) is the graph obtained from subject group 2 in validation set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
VAL_INPUTS (result, cell) is the inputs from validation set for testing a neural network.
%%%% ¡calculate!
value = nnd.input_construction(nnd.get('VAL_G_DICT_1'), nnd.get('VAL_G_DICT_2'));

%%% ¡prop!
TARGETS (result, cell) is the label for the dataset.
%%%% ¡calculate!
y1 = repmat(string(nnd.get('TRAIN_GR1').get('ID')), nnd.get('TRAIN_GR1').get('SUB_DICT').length(), 1);
y2 = repmat(string(nnd.get('TRAIN_GR2').get('ID')), nnd.get('TRAIN_GR2').get('SUB_DICT').length(), 1);

value = {onehotencode(categorical([y1; y2]), 2)};

%%% ¡prop!
VAL_TARGETS (result, cell) is the label for the validation dataset.
%%%% ¡calculate!
y1 = repmat(string(nnd.get('VAL_GR1').get('ID')), nnd.get('VAL_GR1').get('SUB_DICT').length(), 1);
y2 = repmat(string(nnd.get('VAL_GR2').get('ID')), nnd.get('VAL_GR2').get('SUB_DICT').length(), 1);

value = {onehotencode(categorical([y1; y2]), 2)};

%%% ¡prop!
TARGET_NAME_GR1 (result, string) is the name of the traget for group 1.
%%%% ¡default!
'Group1'
%%%% ¡calculate!
value = nnd.get('VAL_GR1').get('ID');

%%% ¡prop!
TARGET_NAME_GR2 (result, string) is the name of the traget for group 2.
%%%% ¡default!
'Group2'
%%%% ¡calculate!
value = nnd.get('VAL_GR2').get('ID');

%% ¡props_update!
%%% ¡prop!
INPUTS (result, cell) is the inputs for training or testing a neural network.
%%%% ¡calculate!
value = nnd.input_construction(nnd.get('TRAIN_G_DICT_1'), nnd.get('TRAIN_G_DICT_2'));

%% ¡methods!
function inputs = input_construction(nnd, g_dict_1, g_dict_2)
    %INPUT_CONSTRUCTION constructs the inputs for neural networks.
    % 
    % INPUTS = INPUT_CONSTRUCTION(NN, G_DICT_1, G_DICT_2) constructs
    %  the input for training or testing neural networks. The connectivity
    %  matrices will firstly extracted from graph dict G_DICT_1 and
    %  G_DICT_2. Then the extracted features will be masked by the feature
    %  mask. The selected features will construct the eventual inputs INPUTS 
    %  for the neural network.
    
    % get the connectivity matrices 

    if string(nnd.get('INPUT_TYPE')) == 'adjacency_matrices'
        adjs_gr_1 = g_dict_1.getItems();
        data_gr_1 = {};
        for i = 1:length(adjs_gr_1)
            data_gr_1{end+1} = cell2mat(adjs_gr_1{i}.get('A'));
        end
    
        adjs_gr_2 = g_dict_2.getItems();
        data_gr_2 = {};
        for i = 1:length(adjs_gr_2)
            data_gr_2{end+1} = cell2mat(adjs_gr_2{i}.get('A'));
        end
        
        data = [data_gr_1 data_gr_2];
    else
        adjs_gr_1 = g_dict_1.getItems();
        data_gr_1 = {};
        measure_class = nnd.get('MEASURES');
        for i = 1:length(adjs_gr_1)
            m = [];
            for j = 1:length(measure_class)
                m = [m; cell2mat(adjs_gr_1{i}.getMeasure(measure_class{j}).get('M'))];
            end
            data_gr_1{end+1} = m;
        end
    
        adjs_gr_2 = g_dict_2.getItems();
        data_gr_2 = {};
        measure_class = nnd.get('MEASURES');
        for i = 1:length(adjs_gr_2)
            m = [];
            for j = 1:length(measure_class)
                m = [m; cell2mat(adjs_gr_1{i}.getMeasure(measure_class{j}).get('M'))];
            end
            data_gr_1{end+1} = m;
        end
    
        data = [data_gr_1 data_gr_2];
    end
    
    % get the feature mask
    mask = nnd.get('FEATURE_MASK');
    if length(mask) == 1 && abs(mask) <= 1 
        mask = nnd.get('FEATURE_MASK_ANALYSIS');
    end
    
    % construct the inputs
    inputs = cellfun(@(v)v(mask), data, 'UniformOutput', false);
    inputs = {cat(2, inputs{:})};
end
