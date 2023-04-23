%% ¡header!
ImporterGroupSubjectST_XLS < Importer (im, importer of ST subject group from XLS/XLSX) imports a group of subjects with structural data from an XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectST_XLS imports a group of subjects with structural data and their covariates (optional) from an XLS/XLSX file.
The XLS/XLSX file consists of the following columns (Sheet 1): 
Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
BrainRegions (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.
The covariates must be on the second Sheet of the same XLS/XLSX file. Sheet 2 consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.
It throws an error is problems occur during the import.

%%% ¡seealso!
Group, SubjectST, ExporterGroupSubjectST_XLS

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS imports a group of subjects with structural data and their covariates (optional) from an XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST subject group importer from XLS/XLSX.

%%% ¡prop!
ID (data, string) is a few-letter code for the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to set the XLS/XLSX file from where to load the ST subject group.
%%%% ¡settings!
'ImporterGroupSubjectST_XLS'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
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
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading Directory ...');
    
    [~, ~, raw] = xlsread(file);
    
% % %     % Check if there are covariates to add (age and sex)
% % %     sheets = sheetnames(file);
% % %     if length(sheets) > 1
% % %         [~, ~, raw_covariates] = xlsread(file, 2);
% % %         age = raw_covariates(2:end, 2);
% % %         sex = raw_covariates(2:end, 3);
% % %     else
% % %         age = {[0]};
% % %         age = age(ones(size(raw, 1)-1,1));
% % %         unassigned =  {'unassigned'};
% % %         sex = unassigned(ones(size(raw, 1)-1, 1));
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
        br_number = size(raw, 2) - 3;
        if ba.get('BR_DICT').get('LENGTH') ~= br_number
            ba = BrainAtlas();
            idict = ba.get('BR_DICT');
            for j = 4:1:length(raw)
                br_id = raw{1, j};
                br = BrainRegion('ID', br_id);
                idict.get('ADD', br)
            end
            ba.set('br_dict', idict);
        end
        
        sub_dict = gr.get('SUB_DICT');
        
        % adds subjects
        for i = 2:1:size(raw, 1)
            braph2waitbar(wb, .25 + .75 * (i - 1) / size(raw, 1), ['Loading subject ' num2str(i - 1) ' of ' num2str(size(raw, 1) - 1) ' ...'])
            
            ST = zeros(br_number, 1);
            for j = 1:1:length(ST)
                ST(j) = raw{i, 3 + j};
            end
            sub = SubjectST( ...
                'ID', num2str(raw{i, 1}), ...
                'LABEL', num2str(raw{i, 2}), ...
                'NOTES', num2str(raw{i, 3}), ...
                'BA', ba, ...
                'ST', ST, ... % % % 'age', age{i-1}, ... % % % 'sex', sex{i-1} ...
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
    error([BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.CANCEL_IO] '\\n' ...
        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectST_XLS.GET_FILE]