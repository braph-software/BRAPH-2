%% ¡header!
NNDataSplit < ConcreteElement (dsp, splitter of a neural network data) splits a dataset into several partitioned datasets based on specified indices or proportions.

%%% ¡description!
NNDataSplit allows users to split a given dataset into multiple smaller datasets, each forming a partition. The splitting can be achieved by providing either specific indices or proportions for the datapoints in each partitioned dataset.
For example usage, to split the dataset into two partitions, one containing datapoints 1 and 2, and the other containing datapoints 3, 4, and 5, the SPLIT property should be set as {[1 2], [3 4 5]}.
Alternatively, using the SPLIT property as {0.2, 0.8}, NNDataSplit will randomly assign datapoints to two datasets, with the first dataset containing approximately 20 percent of the total datapoints (datapoints 1 and 3, for instance), and the second dataset containing the remaining 80 percent of the datapoints (datapoints 2, 4, and 5).

%%% ¡seealso!
NNData

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit allows users to split a given dataset into multiple smaller datasets, each forming a partition. The splitting can be achieved by providing either specific indices or proportions for the datapoints in each partitioned dataset. For example usage, to split the dataset into two partitions, one containing datapoints 1 and 2, and the other containing datapoints 3, 4, and 5, the SPLIT property should be set as {[1 2], [3 4 5]}. Alternatively, using the SPLIT property as {0.2, 0.8}, NNDataSplit will randomly assign datapoints to two datasets, with the first dataset containing approximately 20 percent of the total datapoints (datapoints 1 and 3, for instance), and the second dataset containing the remaining 80 percent of the datapoints (datapoints 2, 4, and 5).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the splitter of a neural network data.
%%%% ¡settings!
'NNDataSplit'

%%% ¡prop!
ID (data, string) is a few-letter code for the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit notes'
    
%% ¡props!

%%% ¡prop!
D (data, item) is a dataset for neural network analysis.
%%%% ¡settings!
'NNData'
%%%% ¡default!
NNData('DP_CLASS', 'NNDataPoint', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint'))

%%% ¡prop!
SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
%%%% ¡check_value!
check = all(cellfun(@(x) all(round(x) == x & all(x <= dsp.get('D').get('DP_DICT').get('LENGTH'))), dsp.get('SPLIT')));
%%%% ¡postset!
value = dsp.get('SPLIT');
if all(cellfun(@isscalar, value)) & sum(cell2mat(value)) <= 1 & sum(cell2mat(value)) > 0 
    num_sub = dsp.get('D').get('DP_DICT').get('LENGTH');
    lengths = round(cell2mat(value) * num_sub);
    indices = randperm(num_sub);
    
    startIndex = 1;
    value = cell(numel(lengths), 1);
    for i = 1:numel(lengths)
        endIndex = startIndex + lengths(i) - 1;
        value{i} = sort(indices(startIndex:endIndex));
        startIndex = endIndex + 1;
    end
    
    dsp.set('SPLIT', value);
end

%%% ¡prop!
D_SPLIT (result, itemlist) is the itemlist of splitted neural network datasets.
%%%% ¡calculate!
d = dsp.get('D');
dp_list = d.get('DP_DICT').get('IT_LIST');
split = dsp.get('SPLIT');
value = cellfun(@(x) NNData('DP_DICT', IndexedDictionary(...
    'IT_CLASS', 'NNDataPoint', ...
    'IT_LIST',  dp_list(x) ...
    )), split, 'UniformOutput', false);

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Splitting dataset with assigned indexes
%%%% ¡code!

% create a NNDataPoint itemlist
num_dp = 10; 
dp_ids = cell(1, num_dp);
for i = 1:num_dp
    dp_ids{i} = ['dp_', num2str(i)];
end

dp_list = cellfun(@(x) NNDataPoint('ID', x), dp_ids(1:num_dp), 'UniformOutput', false);

dp_dict = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint', ...
        'IT_LIST',  dp_list ...
        );

% create NNData containing the NNDataPoints
d = NNData('DP_DICT', dp_dict);

% create NNDataCombine to combine the two NNDatas
split = {[1 3 5 7 9], [2 4 6 8 10]};
d_split = NNDataSplit('SPLIT', split, 'D', d).get('D_SPLIT');

% Check whether the number of dp matches
for i = 1:length(split)
    check(i) = d_split{i}.get('DP_DICT').get('LENGTH') == length(split{i});
end
assert(all(check), ...
    [BRAPH2.STR ':NNDataSplit:' BRAPH2.FAIL_TEST], ...
    'NNDataSplit does not split the datasets correctly. The number of the datapoint should be same as the vector length in th specified property SPLIT.' ...
    )

%%% ¡test!
%%%% ¡name!
Splitting dataset with random indexes
%%%% ¡code!

% create a NNDataPoint itemlist
num_dp = 10; 
dp_ids = cell(1, num_dp);
for i = 1:num_dp
    dp_ids{i} = ['dp_', num2str(i)];
end

dp_list = cellfun(@(x) NNDataPoint('ID', x), dp_ids(1:num_dp), 'UniformOutput', false);

dp_dict = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint', ...
        'IT_LIST',  dp_list ...
        );

% create NNData containing the NNDataPoints
d = NNData('DP_DICT', dp_dict);

% create NNDataCombine to combine the two NNDatas
split = {0.3, 0.7};
dsp = NNDataSplit('D', d, 'SPLIT', split);
d_split = dsp.get('D_SPLIT');

% Check whether the number of dp matches
split = dsp.get('SPLIT');
for i = 1:length(split)
    check(i) = d_split{i}.get('DP_DICT').get('LENGTH') == length(split{i});
end
assert(all(check), ...
    [BRAPH2.STR ':NNDataSplit:' BRAPH2.FAIL_TEST], ...
    'NNDataSplit does not split the datasets correctly. The number of the datapoint should be same as the vector length in th specified property SPLIT.' ...
    )