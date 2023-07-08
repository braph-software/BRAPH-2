%% ¡header!
Group < ConcreteElement (gr, group of subjects) is a group of subjects.

%%% ¡description!
Group represents a group of subjects whose class is defined in the property SUB_CLASS.
Group provides the methods necessary to handle groups of subjects. 
It manages the subjects as an indexed dictionary of subjects SUB_DICT, 
whose methods can be used to inspect, add or remove subjects.

%%% ¡seealso!
Subject, IndexedDictionary

%% ¡gui!

%%% ¡menu_import!
eval([el.get('SUB_CLASS') '.getGUIMenuImport(el, menu_import, pe)']);
im_sub_menus = get(menu_import, 'Children');
delete(im_sub_menus(end)); % delete one sub menu to import JSON

%%% ¡menu_export!
eval([el.get('SUB_CLASS') '.getGUIMenuExport(el, menu_export, pe)']);
ex_sub_menus = get(menu_export, 'Children');
delete(ex_sub_menus(end)); % delete one sub menu to export JSON

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Group.ID
%%%% ¡title!
Group ID

%%% ¡prop!
%%%% ¡id!
Group.LABEL
%%%% ¡title!
Group NAME

%%% ¡prop!
%%%% ¡id!
Group.SUB_CLASS
%%%% ¡title!
Group SUBJECT CLASS

%%% ¡prop!
%%%% ¡id!
Group.SUB_DICT
%%%% ¡title!
Group SUBJECTS

%%% ¡prop!
%%%% ¡id!
Group.NOTES
%%%% ¡title!
Group NOTES

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the group of subjects.
%%%% ¡default!
'Group'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group of subjects.
%%%% ¡default!
'Group represents a group of subjects whose class is defined in the property SUB_CLASS. Group provides the methods necessary to handle groups of subjects. It manages the subjects as an indexed dictionary of subjects SUB_DICT, whose methods can be used to inspect, add or remove subjects.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group of subjects.
%%% ¡settings!
'Group'

%%% ¡prop!
ID (data, string) is a few-letter code for the group of subjects.
%%%% ¡default!
'Group ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group of subjects.
%%%% ¡default!
'Group label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group of subjects.
%%%% ¡default!
'Group notes'

%% ¡props!

%%% ¡prop!
SUB_CLASS (parameter, class) is the class of the subjects of the group.
%%%% ¡settings!
'Subject'

%%% ¡prop!
SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.
%%%% ¡settings!
'Subject'
%%%% ¡gui!
[order, title] = load_layout(gr.get(Group.SUB_DICT).get(IndexedDictionary.IT_CLASS));
cols(1) = PanelPropIDictTable.SELECTOR;
columnname = {''};
for i = 1:1:length(order)
    if isfinite(order(i))
        cols(order(i) + 1) = i;
        columnname{order(i) + 1} = title{i};
    end
end
pr = PanelPropIDictTable('EL', gr, 'PROP', Group.SUB_DICT, ... 
    'ROWNAME', 'numbered', ...
    'COLS', cols, ...
    'COLUMNNAME', columnname, ...
    'MENU_OPEN_ITEMS', true, ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Instantiation
%%%% ¡code!
sub1 = Subject('ID','id1', 'LABEL', 'label1', 'NOTES', 'notes1');
sub2 = Subject('ID','id2', 'LABEL', 'label2', 'NOTES', 'notes2');
sub3 = Subject('ID','id3', 'LABEL', 'label3', 'NOTES', 'notes3');

subject_dict = IndexedDictionary( ...
    'ID', 'subject_idict', ...
    'IT_CLASS', 'Subject', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', {sub1, sub2, sub3} ...
    );

group = Group('ID', 'id', 'LABEL', 'label', 'NOTES', 'notes', 'SUB_DICT', subject_dict);
