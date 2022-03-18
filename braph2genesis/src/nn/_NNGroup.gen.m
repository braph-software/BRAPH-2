%% ¡header!
NNGroup < Group (gr, group of subjects) is a group of subjects.

%%% ¡description!
NNGroup represents a group of NNSubjects whose class is defined in the property SUB_CLASS.
Group provides the methods necessary to handle groups of subjects. 
It manages the subjects as an indexed dictionary of NNSubjects SUB_DICT, 
whose methods can be used to inspect, add or remove subjects.

%%% ¡seealso!
Element, Subject, IndexedDictionary

%% ¡props!

%%% ¡prop!
FEATURE_MASK (metadata, cell) is an feature mask for all the NN subjects in the group.
