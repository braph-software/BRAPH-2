%% ¡header!
NNRegressorDataSplit < NNDataSplit (nnds, data split for a neural network regressor) split a dataset into training set and validation set for regression.  

%% ¡description!
This NNRegressorDataSplit splits the NN group into two, one for training set,
and the other for validation set. GR_TRAIN and GR_test can be used to train
and test NN regressor. A Feature mask is generated from a feature selection
analysis on training set and applied to validation set. 

%% ¡props!
%%% ¡prop!
GR (data, item) is a group of NN subjects
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
SPLIT (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnds.get('GR').get('SUB_DICT').length());
    num_train = nnds.get('GR').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%% ¡props_update!

%%% ¡prop!
GR_TRAIN (result, item) is a group of NN subjects for the training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
train_nn_gr = NNGroup( ...
    'SUB_CLASS', nnds.get('GR').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_nn_gr.set( ...
    'ID', nnds.get('GR').get('ID'), ...
    'LABEL', nnds.get('GR').get('LABEL'), ...
    'NOTES', nnds.get('GR').get('NOTES') ...
    );

% add subejcts
sub_dict = train_nn_gr.get('SUB_DICT');

if nnds.get('GR').get('SUB_DICT').length() > 0
    subs = nnds.get('GR').get('SUB_DICT').getItems();
    selected_idx = setdiff(1:length(subs), nnds.get('SPLIT'));
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_copy = NNSubject( ...
            'ID', sub.get('ID'), ...
            'LABEL', sub.get('LABEL'), ...
            'NOTES', sub.get('NOTES'),...
            'G', sub.get('G'),...
            'INPUT', sub.get('INPUT'),...
            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', num2cell(sub.get(sub.get('TARGET_NAME'))),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
    end
end

train_nn_gr.set('SUB_DICT', sub_dict);

value = train_nn_gr;

%%% ¡prop!
GR_VAL (result, item) is a group of NN subjects for the validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
val_nn_gr = NNGroup( ...
    'SUB_CLASS', nnds.get('GR').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_nn_gr.set( ...
    'ID', nnds.get('GR').get('ID'), ...
    'LABEL', nnds.get('GR').get('LABEL'), ...
    'NOTES', nnds.get('GR').get('NOTES') ...
    );

% add subejcts
sub_dict = val_nn_gr.get('SUB_DICT');

if nnds.get('GR').get('SUB_DICT').length() > 0
    subs = nnds.get('GR').get('SUB_DICT').getItems();
    selected_idx = nnds.get('SPLIT');
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_copy = NNSubject( ...
            'ID', sub.get('ID'), ...
            'LABEL', sub.get('LABEL'), ...
            'NOTES', sub.get('NOTES'),...
            'G', sub.get('G'),...
            'INPUT', sub.get('INPUT'),...
            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', num2cell(sub.get(sub.get('TARGET_NAME'))),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
    end
end

val_nn_gr.set('SUB_DICT', sub_dict);

value = val_nn_gr;

%%% ¡prop!
FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.
%%%% ¡calculate!
percentile = cell2mat(nnds.get('FEATURE_MASK'));
data = cellfun(@(x) x.get('INPUT'), nnds.get('GR_TRAIN').get('SUB_DICT').getItems(), 'UniformOutput', false);

if nnds.get('GR_TRAIN').get('SUB_DICT').length == 0
    value = {};
else
    if nnds.get('WAITBAR')
        wb = waitbar(0, 'Performing feature selection on training set ...', 'Name', BRAPH2.NAME);
        set_braph2_icon(wb)
    end
    y = cellfun(@(x) cell2mat(x.get('TARGET')), nnds.get('GR_TRAIN').get('SUB_DICT').getItems(), 'UniformOutput', false);
    label = cell2mat(y);
    num_feature_cluster = length(data{1});
    value = cell(size(data{1}));
    counter = 0;
    for k = 1:1:num_feature_cluster
        data_per_cluster = cellfun(@(v)v{k}, data, 'UniformOutput', false);
        mask = zeros(size(data_per_cluster{k}));
        if ~isempty(mask)
            for i = 1:numel(mask)
                data_per_feature = cellfun(@(v)v(i), data_per_cluster);
                if(any(isinf(data_per_feature)))
                    mask(i) = 0;
                else
                    mask(i) = nnds.mutual_information_analysis(data_per_feature, label, 5);
                end
                counter = counter + 1;
                if nnds.get('WAITBAR')
                    waitbar(.30 + .70 * counter / (numel(mask) * num_feature_cluster), wb, ['Performing feature selection, ' num2str(0.7 * counter / (numel(mask) * num_feature_cluster), '%.1f') '% done...'])
                end
            end

            [~, idx_all] = sort(mask(:), 'descend');
            num_top_idx = ceil(percentile * numel(mask));
            mask(idx_all(1:num_top_idx)) = 1;
            mask(idx_all(end-num_top_idx+1:end)) = 0;
        end
        value{k} = mask;
    end
    if nnds.get('WAITBAR')
        close(wb)
    end
end

%%% ¡prop!
GR_TRAIN_FS (result, item) is a group of NN subjects with feature mask for the training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr_copy = nnds.memorize('GR_TRAIN');
feature_mask = nnds.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');
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
nn_gr_copy = nnds.memorize('GR_VAL');
feature_mask = nnds.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');
end

if isempty(feature_mask)
    value = NNGroup();
else
    for i = 1:1:nn_gr_copy.get('SUB_DICT').length()
        nn_gr_copy.get('SUB_DICT').getItem(i).set('FEATURE_MASK', feature_mask);
    end
    value = nn_gr_copy;
end