%% ¡header!
NNDataPoint_CON_WU_REG < NNDataPoint (dp, ...) ...

...

%% ¡props_update!
...

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
...
    
%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
...

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with connectivity data.

%%% ¡prop!
XXXX (parameter, stringlist) is a list of variables of interest to be used as regression targets.

%% ¡tests!

...

%%% ¡test! 
create data

%%% !test!

gr = import data using Group of SubjectCON

create a NNData
d = NNData( ...
    'DP_CLASS', 'NNDataPoint_CON_WU', ...
    'DP_DICT', IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_WU', ...
        'IT_LIST', {@(x) NNDataPoint_CON_WU('ID', x.get('ID'), 'SUB', x, 'XXXX', x.get('VOI_DICT').get('KEYS')), gr.get('SUB_DICT').get('IT_LIST'), ... )} ...
        ) ...
    )

verify that input and target work
...


