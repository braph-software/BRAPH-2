%% ¡header!
ImporterGroupSubjectFUNTXT < Importer (im, importer of FUN subject group from TXT) imports a group of subjects with connectivity data from a series of TXT file.

%%% ¡description!
ImporterGroupSubjectFUNTXT imports a group of subjects with connectivity data from a series of TXT file and their covariates from another TXT file.
All these files must be in the same folder; also, no other files should be in the folder.
Each file contains a table with each row correspoding to a time serie and each column to a brain region.
The TXT file containing the covariates must be inside another folder in the same directory 
than file with data and consists of of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectFUNTXT

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the FUN subject group files from which to load the subject group.

%%% ¡prop!
FILE_COVARIATES (data, string) is the TXT file from where to load the covariates age and sex of the FUN subject group.
%%%% ¡default!
''

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with functional data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectFUN', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
    );

directory = im.get('DIRECTORY');
file_covariates = im.memorize('FILE_COVARIATES');
if isfolder(directory)
    % sets group props
    f = waitbar(0, 'Reading Directory ...', 'Name', BRAPH2.NAME);
    change_figure_icon(f)
    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
        );
    
    % analyzes file
    files = dir(fullfile(directory, '*.txt'));
    
    % Check if there are covariates to add (age and sex)
    if isfile(file_covariates)       
        raw_covariates = readtable(file_covariates, 'Delimiter', '	');
        age = raw_covariates{:, 2};
        sex = raw_covariates{:, 3};
    else
        age = ones(length(files), 1);
        unassigned =  {'unassigned'};
        sex = unassigned(ones(length(files), 1));
    end
    
    waitbar(.15, f, 'Loading your data ...');
    if length(files) > 0        
        % brain atlas
        ba = im.get('BA');
        br_number = ba.get('BR_DICT').length;
        subdict = gr.get('SUB_DICT');
        
        % adds subjects
        for i = 1:1:length(files)
            if i == floor(length(files)/2)
                waitbar(.70, f, 'Almost there ...')
            end
            % read file
            FUN = table2array(readtable(fullfile(directory, files(i).name), 'Delimiter', '	'));
            
            % brain atlas
            ba = im.get('BA');
            br_number = size(FUN, 2);   
            if ba.get('BR_DICT').length ~= br_number
                ba = BrainAtlas();
                idict = ba.get('BR_DICT');
                for j = 1:1:br_number
                    br_id = ['br' int2str(j)];
                    br = BrainRegion('ID', br_id);
                    idict.add(br)
                end
                ba.set('br_dict', idict);
            end
            subdict = gr.get('SUB_DICT');
            
            [~, sub_id] = fileparts(files(i).name);
            sub = SubjectFUN( ...
                'ID', sub_id, ...
                'BA', ba, ...
                'age', age(i), ...
                'sex', sex{i} ...
                );
            
            sub.set('FUN', FUN);
            subdict.add(sub);
        end
        gr.set('sub_dict', subdict);
    end
end
if exist('f', 'var')
    waitbar(1, f, 'Finishing')
    pause(.5)
    close(f)
end
value = gr;

%% ¡methods!
function uigetdir(im)
    % UIGETDIR opens a dialog box to set the directory from where to load the TXT files of the FUN subject group.

    directory = uigetdir('Select directory');
    if isfolder(directory)
        im.set('DIRECTORY', directory);
    end
end

function uigetfile(im)
    % UIGETFILE opens a dialog box to set the TXT file from where to load the FUN subject group.
    
    [filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end