%% ¡header!
NNDatasetCombine < ConcreteElement (dco, splitter of a neural network data) combines neural network datasets.

%%% ¡description!
A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. 
The resulting combined dataset contains all the unique datapoints from the input datasets, 
and any overlapping datapoints are excluded to ensure data consistency.

%%% ¡seealso!
NNDataset, NNDatasetSplit

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the combier of a neural network data.
%%%% ¡default!
'NNDatasetCombine'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the combier of a neural network data.
%%%% ¡default!
'A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. The resulting combined dataset contains all the unique datapoints from the input datasets, and any overlapping datapoints are excluded to ensure data consistency.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the combier of a neural network data.
%%%% ¡settings!
'NNDatasetCombine'

%%% ¡prop!
ID (data, string) is a few-letter code for the combier of a neural network data.
%%%% ¡default!
'NNDatasetCombine ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the combier of a neural network data.
%%%% ¡default!
'NNDatasetCombine label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the combier of a neural network data.
%%%% ¡default!
'NNDatasetCombine notes'
    
%% ¡props!

%%% ¡prop!
D_LIST (data, itemlist) is a items of datasets to be combined.
%%%% ¡settings!
'NNDataset'

%%% ¡prop!
D (result, item) is the combined neural network dataset.
%%%% ¡settings!
'NNDataset'
%%%% ¡calculate!
dp_list = cellfun(@(x) x.get('DP_DICT').get('IT_LIST'), dco.get('D_LIST'), 'UniformOutput', false);

% concatenate all subjectID
dp_list = horzcat(dp_list{:});

% inspect whether there are overlapping datapoints
if isempty(dp_list)
    unique_dp_list = {};
else
    dp_ids = cellfun(@(x) x.get('ID'), dp_list, 'UniformOutput', false);
    [C, i_dp_ids] = unique(dp_ids);
    unique_dp_list = dp_list(sort(i_dp_ids));
end

% create the combined NNDataset
combined_dp_dict = IndexedDictionary(...
    'IT_CLASS', 'NNDataPoint', ...
    'IT_LIST',  unique_dp_list ...
    );

value = NNDataset('DP_DICT', combined_dp_dict);

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Combining test
%%%% ¡code!

% create two NNDataPoint itemlists with one datapoint overlapped
num_dp1 = 10; num_dp2 = 11; num_dp_all = num_dp1 + num_dp2;
dp_ids = cell(1, num_dp_all);
for i = 1:num_dp_all
    dp_ids{i} = ['dp_', num2str(i)];
end

dp_list1 = cellfun(@(x) NNDataPoint('ID', x), dp_ids(1:num_dp1), 'UniformOutput', false);
dp_list2 = cellfun(@(x) NNDataPoint('ID', x), dp_ids(num_dp1:num_dp_all), 'UniformOutput', false);

dp_dict1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint', ...
        'IT_LIST',  dp_list1 ...
        );
dp_dict2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint', ...
        'IT_LIST',  dp_list2 ...
        );

dp_dict = {dp_dict1, dp_dict2};

% create NNDataset itemlist containing two NNDataset
d_list = cellfun(@(x) NNDataset('DP_DICT', x), dp_dict, 'UniformOutput', false);

% create NNDatasetCombine to combine the two NNDataset
d_combined = NNDatasetCombine('D_LIST', d_list).get('D');

% Check whether the number of dp matches
assert(d_combined.get('DP_DICT').get('LENGTH') == num_dp_all, ...
    [BRAPH2.STR ':NNDatasetCombine:' BRAPH2.FAIL_TEST], ...
    'NNDatasetCombine does not combine the datasets correctly. The number of the datapoint should be same as the sum of all input datasets.' ...
    )