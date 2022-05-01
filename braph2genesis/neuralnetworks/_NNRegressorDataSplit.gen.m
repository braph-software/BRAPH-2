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
%%%% ¡postprocessing!
value = nnds.get('SPLIT');
if length(value) == 1 & value < 1
    num_val = floor(value * nnds.get('GR').get('SUB_DICT').length());
    num_train = nnds.get('GR').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
    nnds.set('SPLIT', value);
end
%%%% ¡gui!
pr = PlotPropSmartVector('EL', nnds, 'PROP', NNRegressorDataSplit.SPLIT, 'MAX', 10000000, 'MIN', 0, varargin{:});

%% ¡props_update!

%%% ¡prop!
GR_TRAIN (result, item) is a group of NN subjects for the training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
wb = braph2waitbar(nnds.get('WAITBAR'), 0, 'Constructing the training set ...');

train_nn_gr = NNGroup( ...
    'SUB_CLASS', nnds.get('GR').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_nn_gr.set( ...
    'ID', 'Training set', ...
    'LABEL', 'Training set', ...
    'NOTES', 'This training set is used to perform mutual information analysis and train the neural networks.' ...
    );

% setup counter for waitbar
counter = 0;
num_sub_all = length(setdiff(1:nnds.get('GR').get('SUB_DICT').length(), nnds.get('SPLIT')));

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
            'MEASURES', sub.get('MEASURES'), ...
            'INPUT', sub.get('INPUT'),...
            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', num2cell(sub.get(sub.get('TARGET_NAME'))),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
        counter = counter + 1;
        
        braph2waitbar(wb, .30 + .70 * counter / num_sub_all, ['Constructing training set, ' num2str(100 * counter / num_sub_all, '%.0f') '% done...'])
    end
end

train_nn_gr.set('SUB_DICT', sub_dict);

braph2waitbar(wb, 'close')

value = train_nn_gr;

%%% ¡prop!
GR_VAL (result, item) is a group of NN subjects for the validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
wb = braph2waitbar(nnds.get('WAITBAR'), 0, 'Constructing the validation set ...');

val_nn_gr = NNGroup( ...
    'SUB_CLASS', nnds.get('GR').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_nn_gr.set( ...
    'ID', 'Validation set', ...
    'LABEL', 'Validation set', ...
    'NOTES', 'This validation set is used to test the trained neural networks and it cooperates the feature mask derived from the training set.' ...
    );

% setup counter for waitbar
counter = 0;
num_sub_all = length(nnds.get('SPLIT'));

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
            'MEASURES', sub.get('MEASURES'), ...
            'INPUT', sub.get('INPUT'),...
            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', num2cell(sub.get(sub.get('TARGET_NAME'))),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
        counter = counter + 1;
        
        braph2waitbar(wb, .30 + .70 * counter / num_sub_all, ['Constructing validation set, ' num2str(100 * counter / num_sub_all, '%.0f') '% done...'])
    end
end

val_nn_gr.set('SUB_DICT', sub_dict);

braph2waitbar(wb, 'close')

value = val_nn_gr;

%%% ¡prop!
FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.
%%%% ¡calculate!
percentile = cell2mat(nnds.get('FEATURE_MASK'));
gr_train = nnds.memorize('GR_TRAIN');
data = cellfun(@(x) x.get('INPUT'), gr_train.get('SUB_DICT').getItems(), 'UniformOutput', false);

if nnds.get('GR_TRAIN').get('SUB_DICT').length == 0 || percentile == 0
    value = {};
else
    wb = braph2waitbar(nnds.get('WAITBAR'), 0, 'Initialing feature selection on training set ...');
    
    y = cellfun(@(x) cell2mat(x.get('TARGET')), gr_train.get('SUB_DICT').getItems(), 'UniformOutput', false);
    label = cell2mat(y);
    num_feature_cluster = length(data{1});
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
                if(any(isinf(data_per_feature)))
                    mask(i) = 0;
                else
                    mask(i) = nnds.mutual_information_analysis(data_per_feature, label, 5);
                end
                counter = counter + 1;
                
                braph2waitbar(wb, .30 + .70 * counter / num_feature_all, ['Performing feature selection, ' num2str(100 * counter / num_feature_all, '%.0f') '% done...'])
            end

            [~, idx_all] = sort(mask(:), 'descend');
            num_top_idx = ceil(percentile * numel(mask));
            mask(idx_all(1:num_top_idx)) = 1;
            mask(idx_all(end-(length(idx_all) - num_top_idx - 1):end)) = 0;
        end
        value{k} = mask;
    end
    
    braph2waitbar(wb, 'close')
end

%%% ¡prop!
GR_TRAIN_FS (result, item) is a group of NN subjects with feature mask for the training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr = nnds.memorize('GR_TRAIN');
feature_mask = nnds.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');
end

if nn_gr.get('SUB_DICT').length() == 0
    value = NNGroup();
else
    nn_gr_fs = NNGroup( ...
        'SUB_CLASS', nn_gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
        );

    nn_gr_fs.set( ...
        'ID', nn_gr.get('ID'), ...
        'LABEL', nn_gr.get('LABEL'), ...
        'NOTES', nn_gr.get('NOTES') ...
        );

    sub_dict = nn_gr_fs.get('SUB_DICT');

    for i = 1:1:nn_gr.get('SUB_DICT').length()
        sub = nn_gr.get('SUB_DICT').getItem(i);
        sub_copy = NNSubject( ...
            'ID', sub.get('ID'), ...
            'LABEL', sub.get('LABEL'), ...
            'NOTES', sub.get('NOTES'),...
            'G', sub.get('G'),...
            'MEASURES', sub.get('MEASURES'), ...
            'INPUT', sub.get('INPUT'),...
            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
            'FEATURE_MASK', feature_mask,...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', sub.get('TARGET'),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
    end
    nn_gr_fs.set('SUB_DICT', sub_dict);
    value = nn_gr_fs;
end

%%% ¡prop!
GR_VAL_FS (result, item) is a group of NN subjects with feature mask for the validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr = nnds.memorize('GR_VAL');
feature_mask = nnds.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');
end

if nn_gr.get('SUB_DICT').length() == 0
    value = NNGroup();
else
    nn_gr_fs = NNGroup( ...
        'SUB_CLASS', nn_gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
        );

    nn_gr_fs.set( ...
        'ID', nn_gr.get('ID'), ...
        'LABEL', nn_gr.get('LABEL'), ...
        'NOTES', nn_gr.get('NOTES') ...
        );

    sub_dict = nn_gr_fs.get('SUB_DICT');

    for i = 1:1:nn_gr.get('SUB_DICT').length()
        sub = nn_gr.get('SUB_DICT').getItem(i);
        sub_copy = NNSubject( ...
            'ID', sub.get('ID'), ...
            'LABEL', sub.get('LABEL'), ...
            'NOTES', sub.get('NOTES'),...
            'G', sub.get('G'),...
            'MEASURES', sub.get('MEASURES'), ...
            'INPUT', sub.get('INPUT'),...
            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
            'FEATURE_MASK', feature_mask,...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', sub.get('TARGET'),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
    end
    nn_gr_fs.set('SUB_DICT', sub_dict);
    value = nn_gr_fs;
end