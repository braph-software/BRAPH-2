%% ¡header!
ImporterGroupSubjectST_TXT < Importer (im, importer of ST subject group from TXT) imports a group of subjects with structural data from an TXT file.

%%% ¡description!
ImporterGroupSubjectST_TXT imports a group of subjects with structural data from an TXT file and their covariates from another TXT file.
The TXT file consists of the following columns: 
Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
BrainRegions (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.
The TXT file containing the covariates must be in the same directory and have the name as: groupname_covariates.txt
where groupname corresponds to the name of the file containing the data. It consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.
It throws an error if problems occur during the import.

%%% ¡seealso!
Group, SubjectFUN, ExporterGroupSubjectST_TXT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT imports a group of subjects with structural data from an TXT file and their covariates from another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST subject group importer from TXT.

%%% ¡prop!
ID (data, string) is a few-letter code for the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the TXT file from where to load the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to set the TXT file from where to load the ST subject group.
%%%% ¡settings!
'ImporterGroupSubjectST_TXT'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
if filterindex
    file = [filepath filename];
	im.set('FILE', file);
end
value = im;

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with structural data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectST', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
    );

gr.lock('SUB_CLASS');
% analyzes file
file = im.get('FILE');
if isfile(file)
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading File ...');
    
    raw = textread(file, '%s', 'delimiter', '\t', 'whitespace', '');
    raw = raw(~cellfun('isempty', raw));  % remove empty cells
    raw2 = readtable(file, 'Delimiter', '\t');
    
% % %     % Check if there are covariates to add (age and sex)
% % %     [filepath, filename, ~] = fileparts(file);
% % %     if isfile([filepath filesep() filename '_covariates.txt'])
% % %         raw_covariates = readtable([filepath filesep() filename '_covariates.txt'], 'Delimiter', '\t');
% % %         age = raw_covariates{:, 2};
% % %         sex = raw_covariates{:, 3};
% % %     else
% % %         age = ones(size(raw2, 1),1);
% % %         unassigned =  {'unassigned'};
% % %         sex = unassigned(ones(size(raw2, 1), 1));
% % %     end
    
    % sets group props
    braph2waitbar(wb, .15, 'Loading subject group ...')
        
    try
        [~, name, ext] = fileparts(file);
        gr.set( ...
            'ID', name, ...
            'LABEL', [name ext], ...
            'NOTES', ['Group loaded from ' file] ...
            );
        
        % brain atlas
        braph2waitbar(wb, .25, 'Loading brain atlas ...')
        
        ba = im.get('BA');
        br_number = size(raw2, 2) - 3;
        if ba.get('BR_DICT').length ~= br_number
            ba = BrainAtlas();
            idict = ba.get('BR_DICT');
            for j = 4:1:size(raw2, 2)
                br_id = raw{j, 1};
                br = BrainRegion('ID', br_id);
                idict.add(br)
            end
            ba.set('br_dict', idict);
        end
        
        sub_dict = gr.get('SUB_DICT');
        
        % adds subjects
        for i = 1:1:size(raw2, 1)
            braph2waitbar(wb, .25 + .75 * i / size(raw2, 1), ['Loading subject ' num2str(i) ' of ' num2str(size(raw2, 1)) ' ...'])
            
            ST = zeros(br_number, 1);
            for j = 1:1:length(ST)
                ST(j) = raw2{i, 3 + j};
            end
            sub = SubjectST( ...
                'ID', char(raw2{i, 1}), ...
                'LABEL', char(raw2{i, 2}), ...
                'NOTES', char(raw2{i, 3}), ...
                'BA', ba, ...
                'ST', ST ... % % % 'age', age(i), ... % % % 'sex', sex{i} ...
                );
            sub_dict.get('ADD', sub);
        end
        gr.set('sub_dict', sub_dict);
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectST_TXT.GET_FILE]