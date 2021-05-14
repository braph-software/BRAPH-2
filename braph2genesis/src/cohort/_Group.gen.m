%% ¡header!
Group < Element (gr, group of subjects) is a group of subjects.

%%% ¡description!
Group represents a group of subjects whose class is defined in the property SUB_CLASS.
Group provides the methods necessary to handle groups of subjects. 
It manages the subjects as an indexed dictionary of subjects SUB_DICT, 
whose methods can be used to inspect, add or remove subjects.

%%% ¡seealso!
Element, Subject, IndexedDictionary

%%% ¡gui!
%%%% ¡menu_importer!
subject = eval([gr.get('SUB_CLASS') '()']);
subject.getGUIMenuImport(f);

%%%% ¡menu_exporter!
subject = eval([gr.get('SUB_CLASS') '()']);
subject.getGUIMenuExport(f, gr);

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
%%%% ¡gui!
pl = PPGroupSubjectsIdict('EL', gr, 'PROP', Group.SUB_DICT, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Instantiation
%%%% ¡code!
sub1 = Subject('ID','id1', 'LABEL', 'label1', 'NOTES', 'notes1');
sub2 = Subject('ID','id2', 'LABEL', 'label2', 'NOTES', 'notes2');
sub3 = Subject('ID','id3', 'LABEL', 'label3', 'NOTES', 'notes3');

subject_dict = IndexedDictionary( ...
    'id', 'subject_idict', ...
    'it_class', 'Subject', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', {sub1, sub2, sub3} ...
    );

group = Group('ID', 'id', 'LABEL', 'label', 'NOTES', 'notes', 'SUB_DICT', subject_dict);
