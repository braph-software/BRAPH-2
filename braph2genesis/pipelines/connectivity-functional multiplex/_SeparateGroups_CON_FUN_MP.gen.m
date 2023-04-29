%% ¡header!
SeparateGroups_CON_FUN_MP < Element (se, separator of a CON_FUN_MP subject group) separates a group of subjects with connectivity and functiona data.

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
GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP')

%%% ¡prop!
GRS (result, cell) is a idict containing two group of subjects with connectivity data and functional data.
%%%% ¡calculate!
wb = braph2waitbar(se.get('WAITBAR'), 0, 'Separating subject groups ...');

gr = se.get('GR_CON_FUN_MP');
gr_subdict = gr.get('SUB_DICT');
if ~isa(gr_subdict, 'NoValue') && gr_subdict.length() > 0
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
    
    % declare variables
    gr_con = Group( ...
        'SUB_CLASS', 'SubjectCON', ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
        );
    subdict_con = gr_con.get('SUB_DICT');
    gr_fun = Group( ...
        'SUB_CLASS', 'SubjectFUN', ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
        );
    subdict_fun = gr_fun.get('SUB_DICT');
    
    % cycle for data and creation of different groups
    for i = 1:1:gr_subdict.length()
        braph2waitbar(wb, .30 + .70 * i / gr_subdict.length(), ['Separating subject ' num2str(i) ' of ' num2str(gr.get('SUB_DICT').length()) ' ...'])

        sub = gr_subdict.getItem(i);
        sub_data = sub.get('CON_FUN_MP'); 
        sub_con = SubjectCON( ...
            'ID', sub.get('ID'), ...
            'BA', ba, ...
            'age', sub.get('AGE'), ...
            'sex', sub.get('SEX'), ...
            'CON', sub_data{1} ...
            );
        sub_fun = SubjectFUN( ...
            'ID', sub.get('ID'), ...
            'BA', ba, ...
            'age', sub.get('AGE'), ...
            'sex', sub.get('SEX'), ...
            'FUN', sub_data{2} ...
            );
        subdict_con.add(sub_con);
        subdict_fun.add(sub_fun);
    end
    
    gr_con.set('sub_dict', subdict_con);
    gr_fun.set('sub_dict', subdict_fun);
    
    % declare result variable and set it with result
    grs = cell(2, 1);
    grs{1} = gr_con;
    grs{2} = gr_fun;
else
    grs = {};
end

braph2waitbar(wb, 'close')

value = grs;