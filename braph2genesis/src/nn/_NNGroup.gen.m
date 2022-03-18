%% ¡header!
NNGroup < Group (gr, group of subjects) is a group of subjects.

%%% ¡description!
NNGroup represents a group of NNSubjects whose class is defined in the property SUB_CLASS.
Group provides the methods necessary to handle groups of subjects. 
It manages the subjects as an indexed dictionary of NNSubjects SUB_DICT, 
whose methods can be used to inspect, add or remove subjects.

%%% ¡seealso!
Group, NNSubject

%% ¡props!

%%% ¡prop!
INPUTS (data, cell) is an feature label for feature mask.
%%%% ¡calculate!
if nn_gr.get('SUB_DICT').length() == 0
    inputs = {};
else
    inputs = cellfun(@(x) x.get('MASKED_INPUT'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false);
end

value = inputs;

%%% ¡prop!
TARGETS (data, cell) is an feature mask for all the NN subjects in the group.
%%%% ¡calculate!
if nn_gr.get('SUB_DICT').length() == 0
    targets = {};
else
    targets = cellfun(@(x) x.get('TARGET'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false);
end

value = targets;