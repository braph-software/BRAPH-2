%% ¡header!
SeparateGroups_CON_FUN_MP < ConcreteElement (se, separator of a CON_FUN_MP subject group) separates a group of subjects with connectivity and functiona data.

%%% ¡description!
SeparateGroups_CON_FUN_MP separates a group of subjects with connectivity 
 and functional data (SubjectCON_FUN_MP) into groups of SubjectCON and 
 SubjectCON_FUN.

%%% ¡seealso!
SubjectCON_FUN_MP, SubjectCON, SubjectFUN, CombineGroups_CON_FUN

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the separator of a CON_FUN_MP subject group.
%%%% ¡default!
'SeparateGroups_CON_FUN_MP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the separator of a CON_FUN_MP subject group.
%%%% ¡default!
'SeparateGroups_CON_FUN_MP separates a group of subjects with connectivity and functional data (SubjectCON_FUN_MP) into groups of SubjectCON and SubjectCON_FUN.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the separator of a CON_FUN_MP subject group.
%%% ¡settings!
'SeparateGroups_CON_FUN_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the separator of a CON_FUN_MP subject group.
%%%% ¡default!
'SeparateGroups_CON_FUN_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the separator of a CON_FUN_MP subject group.
%%%% ¡default!
'SeparateGroups_CON_FUN_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the separator of a CON_FUN_MP subject group.
%%%% ¡default!
'SeparateGroups_CON_FUN_MP notes'

%% ¡props!

%%% ¡prop!
WAITBAR (metadata, logical) determines whether to show the waitbar.

%%% ¡prop!
GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡check_prop!
check = any(strcmp(value.get('SUB_CLASS'), SubjectCON_FUN_MP.getSubclasses()));
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'))

%%% ¡prop!
GR_CON (result, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'))
%%%% ¡check_value!
check = any(strcmp(value.get('SUB_CLASS'), SubjectCON.getSubclasses()));
%%%% ¡calculate!
wb = braph2waitbar(se.get('WAITBAR'), 0, 'Extracting the connectivity group ...');

gr_CON = Group( ...
    'SUB_CLASS', 'SubjectCON', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'), ...
    'ID', 'SubjectCON' ...
    );
sub_dict_CON = gr_CON.get('SUB_DICT');

sub_dict = se.get('GR_CON_FUN_MP').get('SUB_DICT');
for i = 1:1:sub_dict.get('LENGTH')
    braph2waitbar(wb, .15 + .85 * i / sub_dict.get('LENGTH'), ['Separating subject ' num2str(i) ' of ' num2str(sub_dict.get('LENGTH')) ' ...'])

	sub = sub_dict.get('IT', i);
    
    sub_CON = SubjectCON( ...
        'ID', sub.get('ID'), ...
        'BA', sub.get('BA'), ...
        'VOI_DICT', sub.get('VOI_DICT').copy(), ...
        'CON', sub.get('CON') ...
        );
    sub_dict_CON.get('ADD', sub_CON);    
end

value = gr_CON;

braph2waitbar(wb, 'close')

%%% ¡prop!
GR_FUN (result, item) is a group of subjects with functional data.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'))
%%%% ¡check_value!
check = any(strcmp(value.get('SUB_CLASS'), SubjectFUN.getSubclasses()));
%%%% ¡calculate!
wb = braph2waitbar(se.get('WAITBAR'), 0, 'Extracting the functional group ...');

gr_FUN = Group( ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'), ...
    'ID', 'SubjectFUN' ...
    );
sub_dict_FUN = gr_FUN.get('SUB_DICT');

sub_dict = se.get('GR_CON_FUN_MP').get('SUB_DICT');
for i = 1:1:sub_dict.get('LENGTH')
    braph2waitbar(wb, .15 + .85 * i / sub_dict.get('LENGTH'), ['Separating subject ' num2str(i) ' of ' num2str(sub_dict.get('LENGTH')) ' ...'])

	sub = sub_dict.get('IT', i);
    
    sub_FUN = SubjectFUN( ...
        'ID', sub.get('ID'), ...
        'BA', sub.get('BA'), ...
        'VOI_DICT', sub.get('VOI_DICT').copy(), ...
        'FUN', sub.get('FUN') ...
        );
    sub_dict_FUN.get('ADD', sub_FUN);
end

value = gr_FUN;

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

copyfile( ...
    [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.vois.txt'], ...
    [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.CON.vois.txt'] ...
    )
im_gr_CON = ImporterGroupSubjectCON_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.CON'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_CON = im_gr_CON.get('GR');
delete([fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.CON.vois.txt'])

copyfile( ...
    [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.vois.txt'], ...
    [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.FUN.vois.txt'] ...
    )
im_gr_FUN = ImporterGroupSubjectFUN_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.FUN'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_FUN = im_gr_FUN.get('GR');
delete([fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.FUN.vois.txt'])

co = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr_CON, ...
    'GR_FUN', gr_FUN ...
    );
gr = co.get('GR_CON_FUN_MP');

se = SeparateGroups_CON_FUN_MP('GR_CON_FUN_MP', gr);

gr_CON_separated = se.get('GR_CON');
assert(gr_CON.get('SUB_DICT').get('LENGTH') == gr_CON_separated.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.FAIL_TEST], ...
    'Problems acombining and separatingthe groups.')
for i = 1:1:gr_CON.get('SUB_DICT').get('LENGTH')
    sub_CON = gr_CON.get('SUB_DICT').get('IT', i);
    sub_CON_separated = gr_CON_separated.get('SUB_DICT').get('IT', i);
    
    assert( ...
        isequal(sub_CON.get('ID'), sub_CON_separated.get('ID')) & ...
        isequal(sub_CON.get('BA').get('ID'), sub_CON_separated.get('BA').get('ID')) & ...
        isequal(sub_CON.get('VOI_DICT').get('IT', 'Age').get('V'), sub_CON_separated.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub_CON.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_CON_separated.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub_CON.get('CON'), sub_CON_separated.get('CON')), ...
        [BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.FAIL_TEST], ...
        'Problems acombining and separatingthe groups.')    
end

gr_FUN_separated = se.get('GR_FUN');
assert(gr_FUN.get('SUB_DICT').get('LENGTH') == gr_FUN_separated.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.FAIL_TEST], ...
    'Problems acombining and separatingthe groups.')
for i = 1:1:gr_FUN.get('SUB_DICT').get('LENGTH')
    sub_FUN = gr_FUN.get('SUB_DICT').get('IT', i);
    sub_FUN_separated = gr_FUN_separated.get('SUB_DICT').get('IT', i);
    
    assert( ...
        isequal(sub_FUN.get('ID'), sub_FUN_separated.get('ID')) & ...
        isequal(sub_FUN.get('BA').get('ID'), sub_FUN_separated.get('BA').get('ID')) & ...
        isequal(sub_FUN.get('VOI_DICT').get('IT', 'Age').get('V'), sub_FUN_separated.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub_FUN.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_FUN_separated.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub_FUN.get('FUN'), sub_FUN_separated.get('FUN')), ...
        [BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.FAIL_TEST], ...
        'Problems acombining and separatingthe groups.')    
end
