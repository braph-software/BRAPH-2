%% ¡header!
CombineGroups_CON_FUN < Element (co, combines the CON subject group with the FUN subject group) combines a group of subjects with connectivity data with a group of subjects with functional data.
%%% ¡description!
CombineGroups_CON_FUN combines a group of subjects with connectivity data with a group of subjects with functional data.
Combines the data uploaded through the connectivity and functional workflows. The ID and covariates of subjects are
copied from the first group, in this case connectivity.

%%% ¡seealso!
Element

%% ¡props!

%%% ¡prop!
GR1 (data, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
GR2 (data, item) is a group of subjects with functional data.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
GR (result, item) is a group of subjects with connectivity and functional data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON_FUN_MP', [], [], true)));
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectCON_FUN_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP') ...
    );

% get connectivity and functional groups
group1 = co.get('GR1');
group2 = co.get('GR2');

% assert that the 2 groups have the same number of subjects
assert(isequal(group1.get('SUB_DICT').length(), group2.get('SUB_DICT').length()), ...
    [BRAPH2.STR ':CombineGroups_CON_FUN:' BRAPH2.BUG_ERR], ...
    ['The 2 groups to be combined need to have the same number of subjects while ', ...
    'group 1 has ' tostring(group1.get('SUB_DICT').length()) 'subjects and group 2 has ' tostring(group2.get('SUB_DICT').length())])

% sets group props
[~, name] = fileparts(directory);
gr.set( ...
    'ID', group1.get('ID'), ...
    'LABEL', group1.get('LABEL'), ...
    'NOTES', 'Combined group with CON and FUN data'...
    );

subdict = gr.get('SUB_DICT');
subdict_gr1 = group1.get('SUB_DICT');
subdict_gr2 = group2.get('SUB_DICT');

for i = 1:1:group1.get('SUB_DICT').length()
    CON_FUN_MP = cell(2, 1);
    CON_FUN_MP(1) = {subdict_gr1.get('CON')};
    CON_FUN_MP(2) = {subdict_gr2.get('FUN')};
    
    % add CON_FUN_MP subject
    sub = SubjectCON( ...
        'ID', subdict_gr1.get('ID'), ...
        'BA', subdict_gr1.get('BA'), ...
        'L', 2, ...
        'CON_FUN_MP', CON_FUN_MP, ...
        'age', subdict_gr1.get('age'), ...
        'sex', subdict_gr1.get('sex') ...
        );
    subdict.add(sub);
end
gr.set('sub_dict', subdict);