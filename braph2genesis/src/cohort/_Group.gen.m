%% ¡header!
Group < Element (gr, group of subjects) is a group of subjects.

%%% ¡description!
Group represents a group of subjects whose class is defined in the constructor.
Group provides the methods necessary to handle groups of subjects. 
It manages the subjects as a dictionary of subjects. Group can inspect
inside the dictionary to search for specific subjects. Group can add or 
remove subjects from the dictionary.

%%% ¡seealso!
Element, Subject

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the group of subjects.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group of subjects.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group of subjects.

%%% ¡prop!
SUB_CLASS (parameter, class) is the class of the subjects of the group.
%%%% ¡settings!
'Subject'

%%% ¡prop!
SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.
%%%% ¡settings!
'Subject'

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Instantiation
%%%% ¡code!
sub1 = Subject('ID','id1', 'LABEL', 'label1', 'NOTES', 'notes1')
sub2 = Subject('ID','id2', 'LABEL', 'label2', 'NOTES', 'notes2')
sub3 = Subject('ID','id3', 'LABEL', 'label3', 'NOTES', 'notes3')

subject_dict = IndexedDictionary( ...
    'id', 'subject_idict', ...
    'it_class', 'Subject', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', {sub1, sub2, sub3} ...
    );

group = Group('ID', 'id', 'LABEL', 'label', 'NOTES', 'notes', 'SUB_DICT', subject_dict);
