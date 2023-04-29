%% ¡header!
CombineGroups_CON_FUN_MP < Element (co, combiner of CON and FUN subject groups) combines a group of subjects with connectivity data with a group of subjects with functional data.

%%% ¡description!
CombineGroups_CON_FUN_MP combines a group of subjects with connectivity 
 data (SubjectCON) with a group of subjects with functional data (SubjectFUN)
 into a group of subjects with connectivity and functional data 
 (SubjectCON_FUN_MP). The subject ids of the two groups must match.
The brain atlas and variables of interest are copied from the SubjectCON group.

%%% ¡seealso!
SubjectCON_FUN_MP, SubjectCON, SubjectFUN, SeparateGroups_CON_FUN

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP combines a group of subjects with connectivity data (SubjectCON) with a group of subjects with functional data (SubjectFUN) into a group of subjects with connectivity and functional data (SubjectCON_FUN_MP). The subject ids of the two groups must match. The brain atlas and variables of interest are copied from the SubjectCON group.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the combiner of CON and FUN subject groups.
%%% ¡settings!
'CombineGroups_CON_FUN_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP notes'

%% ¡props!

%%% ¡prop!
WAITBAR (metadata, logical) detemines whether to show the waitbar.

%%% ¡prop!
GR_CON (data, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'))
%%%% ¡check_prop!
check = any(strcmp(value.get('SUB_CLASS'), SubjectCON.getSubclasses());

%%% ¡prop!
GR_FUN (data, item) is a group of subjects with functional data.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'))
%%%% ¡check_prop!
check = any(strcmp(value.get('SUB_CLASS'), SubjectFUN.getSubclasses());

%%% ¡prop!
GR_CON_FUN_MP (result, item) is a group of subjects with connectivity and functional data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get('SUB_CLASS'), SubjectCON_FUN_MP.getSubclasses());
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'))
%%%% ¡calculate!
wb = braph2waitbar(co.get('WAITBAR'), 0, 'Combining subject groups ...');

% get connectivity and functional groups
gr_CON = co.get('GR_CON');
gr_FUN = co.get('GR_FUN');
if gr_CON.get('SUB_DICT').get('LENGTH') ~= gr_FUN.get('SUB_DICT').get('LENGTH')
    error( ...
        [BRAPH2.STR ':' class(co) ':' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':' class(co) ':' BRAPH2.WRONG_INPUT '\\n' ...
        'The groups to be combined must have the same number of subjects, ', ...
        'while group CON has ' int2str(gr_CON.get('SUB_DICT').get('LENGTH')) ' subjects and group FUN has ' int2str(gr_FUN.get('SUB_DICT').get('LENGTH')) ' subjects.'] ...
        )   
end
    
% creates empty group
gr = Group( ...
    'SUB_CLASS', 'SubjectCON_FUN_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP') ...
    'ID', [gr_CON.get('ID') ' + ' gr_FUN.get('ID')], ...
    'LABEL', [gr_CON.get('LABEL') ' -- ' gr_FUN.get('LABEL')], ...
    'NOTES', ['Group combining the connectivigy group ' gr_CON.get('ID') ' and the functional group ' gr_FUN.get('ID')] ...
    );

sub_dict = gr.get('SUB_DICT');
sub_dict_gr_CON = gr_CON.get('SUB_DICT');
sub_dict_gr_FUN = gr_FUN.get('SUB_DICT');

for i = 1:1:gr_CON.get('SUB_DICT').get('LENGTH')
    braph2waitbar(wb, .15 + .85 * i / gr_CON.get('SUB_DICT').get('LENGTH'), ['Combining subject ' num2str(i) ' of ' num2str(gr_CON.get('SUB_DICT').get('LENGTH')) ' ...'])

    sub_CON = sub_dict_gr_CON.get('IT', i);
    sub_id = sub_CON.get('ID');
    
    sub_FUN = sub_dict_gr_FUN.get('IT', sub_id);
    
    sub = SubjectCON_FUN_MP( ...
        'ID', sub_id, ...
        'BA', sub_CON.get('BA'), ...
        'VOI_DICT', sub_CON.get('VOI_DICT').copy(), ...
        'CON', sub_CON.get('CON'), ...
        'FUN', sub_FUN.get('FUN') ...
        );
    sub_dict.add(sub);
end

value = gr;

braph2waitbar(wb, 'close')

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basic functioning
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'atlas.txt']);
ba = im_ba.get('BA');

im_gr_CON = ImporterGroupSubjectCON_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.CON'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_CON = im_gr_CON.get('GR');

im_gr_FUN = ImporterGroupSubjectFUN_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.FUN'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_FUN = im_gr_FUN.get('GR');

co = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr_CON, ...
    'GR_FUN', gr_FUN ...
    );
gr = co.get('GR_CON_FUN_MP');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')

assert(gr.get('SUB_DICT').get('LENGTH') == gr_CON.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':CombineGroups_CON_FUN_MP:' BRAPH2.FAIL_TEST], ...
    'Problems combining the groups.')
for i = 1:1:gr_CON.get('SUB_DICT').get('LENGTH')
    sub_CON = gr_CON.get('IT', i);
    sub_FUN = gr_FUN.get('IT', i);
    sub = gr.get('IT', i);
    
    assert( ...
        isequal(sub.get('ID'), sub_CON.get('ID')) & ...
        isequal(sub.get('BA').get('ID'), sub_CON.get('BA').get('ID')) & ...
        isequal(sub.get('VOI_DICT').get('IT', 'Age').get('V'), sub_CON.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_CON.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub.get('CON'), sub_CON.get('CON')) & ...
        isequal(sub.get('FUN'), sub_FUN.get('FUN')), ...
        [BRAPH2.STR ':CombineGroups_CON_FUN_MP:' BRAPH2.FAIL_TEST], ...
        'Problems combining the groups.')    
end
