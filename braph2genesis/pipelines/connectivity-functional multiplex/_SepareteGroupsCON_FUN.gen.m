%% ¡header!
SepareteGroupsCON_FUN < Element (se, separetes the CON subject group and the FUN subject group from a CON_FUN group) separetes a group of subjects with connectivity data with a group of subjects with functional data.
%%% ¡description!
SepareteGroups_CON_FUN separetes a group of subjects with connectivity data with a group of subjects with functional data.
Separetes the data uploaded through the connectivity and functional workflows. The ID and covariates of subjects are
copied from the first group, in this case connectivity.

%%% ¡seealso!
Element

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the group combiner.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group combiner.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group combiner.

%%% ¡prop!
WAITBAR (metadata, logical) determines whether to show the waitbar.

%%% ¡prop!
GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP')

%%% ¡prop!
GRS (result, cell) is a idict containing two group of subjects with connectivity data and functional data.
%%%% ¡calculate!
if se.get('WAITBAR')
    wb = waitbar(0, 'Separating subject groups ...', 'Name', BRAPH2.NAME);
    set_braph2icon(wb)
end

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
        if se.get('WAITBAR')
            waitbar(.30 + .70 * i / gr_subdict.length(), wb, ['Separating subject ' num2str(i) ' of ' num2str(gr.get('SUB_DICT').length()) ' ...'])
        end
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


if se.get('WAITBAR')
    close(wb)
end

value = grs;