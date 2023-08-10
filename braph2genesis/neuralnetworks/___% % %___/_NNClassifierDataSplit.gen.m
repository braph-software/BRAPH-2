%% ¡header!
NNClassifierDataSplit < NNDataSplit (nnds, data split for a neural network classifier) split a dataset into training set and validation set for classification.  

%% ¡description!
This NNRegressorDataSplit splits the NN group into two, one for training set,
and the other for validation set. GR_TRAIN and GR_test can be used to train
and test NN classifier. A Feature mask is generated from a feature selection
analysis on training set and applied to validation set. 

%% ¡props!
%%% ¡prop!
GR1 (data, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
GR2 (data, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
SPLIT_GR1 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
%%%% ¡conditioning!
if length(value) > 1
    if all(value < 1)
        value = value(1);
    else 
        value = abs(ceil(value));
    end
else
    if value == 0
        value = 0.2;
    end
end
%%%% ¡postprocessing!
value = nnds.get('SPLIT_GR1');
if length(value) == 1 & value < 1
    num_val = floor(value * nnds.get('GR1').get('SUB_DICT').length());
    num_train = nnds.get('GR1').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
    nnds.set('SPLIT_GR1', value);
end
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', nnds, 'PROP', NNClassifierDataSplit.SPLIT_GR1, 'MAX', 100000, 'MIN', 0, varargin{:});

%%% ¡prop!
SPLIT_GR2 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
%%%% ¡conditioning!
if length(value) > 1
    if all(value < 1)
        value = value(1);
    else 
        value = abs(ceil(value));
    end
else
    if value == 0
        value = 0.2;
    end
end
%%%% ¡postprocessing!
value = nnds.get('SPLIT_GR2');
if length(value) == 1 & value < 1
    num_val = floor(value * nnds.get('GR2').get('SUB_DICT').length());
    num_train = nnds.get('GR2').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
    nnds.set('SPLIT_GR2', value);
end
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', nnds, 'PROP', NNClassifierDataSplit.SPLIT_GR2, 'MAX', 100000, 'MIN', 0, varargin{:});

%% ¡props_update!

%%% ¡prop!
GR_TRAIN (result, item) is a group of NN subjects for the training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
subs1 = nnds.get('GR1').get('SUB_DICT').getItems();
selected_subs1 = subs1(setdiff(1:length(subs1), nnds.get('SPLIT_GR1')));

subs2 = nnds.get('GR2').get('SUB_DICT').getItems();
selected_subs2 = subs2(setdiff(1:length(subs2), nnds.get('SPLIT_GR2')));

subs = [selected_subs1 selected_subs2];

train_nn_gr = NNGroup( ...
    'ID', 'Training set', ...
    'LABEL', 'Training set', ...
    'NOTES', 'This training set is used to perform mutual information analysis and train the neural networks.', ...
    'SUB_CLASS', nnds.get('GR1').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject', 'IT_LIST', subs) ...
    );

sub_dict = train_nn_gr.get('SUB_DICT');

if sub_dict.length() > 0
    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
    targets = onehotencode(categorical(target_names), 1);
    for i = 1:1:sub_dict.length()
        sub_dict.getItem(i).set('TARGET', {targets(:, i)'});
    end
end

value = train_nn_gr;

%%% ¡prop!
GR_VAL (result, item) is a group of NN subjects for the validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
subs1 = nnds.get('GR1').get('SUB_DICT').getItems();
selected_subs1 = subs1(nnds.get('SPLIT_GR1'));

subs2 = nnds.get('GR2').get('SUB_DICT').getItems();
selected_subs2 = subs2(nnds.get('SPLIT_GR2'));

subs = [selected_subs1 selected_subs2];

val_nn_gr = NNGroup( ...
    'ID', 'Validation set', ...
    'LABEL', 'Validation set', ...
    'NOTES', 'This validation set is used to validate the performance of the neural networks.', ...
    'SUB_CLASS', nnds.get('GR1').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject', 'IT_LIST', subs) ...
    );

sub_dict = val_nn_gr.get('SUB_DICT');

if sub_dict.length() > 0
    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
    targets = onehotencode(categorical(target_names), 1);
    for i = 1:1:sub_dict.length()
        sub_dict.getItem(i).set('TARGET', {targets(:, i)'});
    end
end

value = val_nn_gr;

%%% ¡prop!
FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.
%%%% ¡calculate!
gr_train = nnds.memorize('GR_TRAIN');
data = cellfun(@(x) x.get('INPUT'), gr_train.get('SUB_DICT').getItems(), 'UniformOutput', false);

if nnds.get('GR_TRAIN').get('SUB_DICT').length == 0
    value = {};
else
    wb = braph2waitbar(nnds.get('WAITBAR'), 0, 'Initialing feature selection on training set ...');

    y = cellfun(@(x) cell2mat(x.get('TARGET')), gr_train.get('SUB_DICT').getItems(), 'UniformOutput', false);
    y = cell2mat(y);
    label = y(1, :);
    num_feature_cluster = numel(data{1});
    value = cell(size(data{1}));
    
    % setup counter for waitbar
    counter = 0;
    num_feature_all = 0;
    for k = 1:1:num_feature_cluster
        data_per_cluster = cellfun(@(v)v{k}, data, 'UniformOutput', false);
        num_feature_all = num_feature_all + numel(data_per_cluster{k});
    end

    for k = 1:1:num_feature_cluster
        data_per_cluster = cellfun(@(v)v{k}, data, 'UniformOutput', false);
        mask = zeros(size(data_per_cluster{k}));
        if ~isempty(mask)
            for i = 1:numel(mask)
                data_per_feature = cellfun(@(v)v(i), data_per_cluster);
                if(any(isinf(data_per_feature)) || any(isnan(data_per_feature)))
                    mask(i) = 0;
                else
                    mask(i) = nnds.mutual_information_analysis(data_per_feature, label, 5);
                end
                counter = counter + 1;
                
                braph2waitbar(wb, .30 + .70 * counter / num_feature_all, ['Performing feature selection, ' num2str(100 * counter / num_feature_all, '%.0f') '% done...'])
            end
        end
        value{k} = mask;
    end
    braph2waitbar(wb, 'close')
end

%%% ¡prop!
GR_TRAIN_FS (result, item) is a training group of NN subjects with feature selection analysis.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr = nnds.memorize('GR_TRAIN');
feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');

if nn_gr.get('SUB_DICT').length() == 0
    value = NNGroup();
else
    subs = nnds.get('GR_TRAIN').get('SUB_DICT').getItems();

    nn_gr_fs = NNGroup( ...
        'ID', nn_gr.get('ID'), ...
        'LABEL', nn_gr.get('LABEL'), ...
        'NOTES', nn_gr.get('NOTES'), ...
        'FEATURE_SELECTION_MASK', feature_mask, ...
        'SUB_CLASS',nn_gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject', 'IT_LIST', subs) ...
        );
    
    value = nn_gr_fs;
end

%%% ¡prop!
GR_VAL_FS (result, item) is a validation group of NN subjects with feature selection analysis.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr = nnds.memorize('GR_VAL');
feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');

if nn_gr.get('SUB_DICT').length() == 0
    value = NNGroup();
else
    subs = nnds.get('GR_VAL').get('SUB_DICT').getItems();

    nn_gr_fs = NNGroup( ...
        'ID', nn_gr.get('ID'), ...
        'LABEL', nn_gr.get('LABEL'), ...
        'NOTES', nn_gr.get('NOTES'), ...
        'FEATURE_SELECTION_MASK', feature_mask, ...
        'SUB_CLASS',nn_gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject', 'IT_LIST', subs) ...
        );
  
    value = nn_gr_fs;
end