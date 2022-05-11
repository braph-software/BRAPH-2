%% ¡header!
ImporterGroupSubjectCON_FUN_MP_XLS < Importer (im, importer of CON_FUN_MP subject group from XLS) imports a group of subjects with connectivity data from a series of XLS file.

%%% ¡description!
ImporterGroupSubjectCON_FUN_MP_XLS imports a group of subjects with connectivity data from a series of XLS file and their covariates (optional) from another XLS file.
All these files must be in the same folder; also, no other files should be in the folder.
Each file contains a table of values corresponding to the adjacency matrix.
The XLS file containing the covariates must be inside another folder in the same group directory 
and consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectCON_XLS

%% ¡props!

%%% ¡prop!
DIRECTORY_CON (data, string) is the directory containing the CON_FUN_MP subject group files of CON type  from which to load the subject group.

%%% ¡prop!
DIRECTORY_FUN (data, string) is the directory containing the CON_FUN_MP subject group files of FUN type from which to load the subject group.

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON_FUN_MP', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectCON_FUN_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP') ...
    );

gr.lock('SUB_CLASS');

% first CON
if ~braph2_testing()
    answer = questdlg('Please Upload a Connectivity Group', ...
        'User Request', ...
        'Ok', 'Cancel', 'Ok');
    switch answer
        case 'Ok'
            directory_CON = im.get('DIRECTORY_CON');
        case 'Cancel'
            return;
    end
else
    directory_CON = im.get('DIRECTORY_CON');
end
if ~isfolder(directory_CON)&& ~braph2_testing()
    im.uigetdir('DIR_TYPE', 'DIRECTORY_CON')
    directory_CON = im.get('DIRECTORY_CON');
end
if isfolder(directory_CON)  
    gr_con = ImporterGroupSubjectCON_XLS( ...
        'DIRECTORY',  directory_CON, ...
        'BA', im.get('ba'), ...
        'WAITBAR', im.get('WAITBAR') ...
        );
elseif ~braph2_testing()
    error([BRAPH2.STR ':ImporterGroupSubjectCON_FUN_MP_XLS: ' BRAPH2.BUG_IO]);
end

% second FUN
if ~braph2_testing()
    answerfun = questdlg('Please Upload a Functional Group', ...
        'User Request', ...
        'Ok', 'Cancel', 'Ok');
    switch answerfun
        case 'Ok'
            directory_FUN = im.get('DIRECTORY_FUN');
        case 'Cancel'
            return;
    end
else
    directory_FUN = im.get('DIRECTORY_FUN');
end
if ~isfolder(directory_FUN)&& ~braph2_testing()
    im.uigetdir('DIR_TYPE', 'DIRECTORY_FUN')
    directory_FUN = im.get('DIRECTORY_FUN');
end
if isfolder(directory_FUN)  
    gr_fun = ImporterGroupSubjectFUN_XLS( ...
        'DIRECTORY',  directory_FUN, ...
        'BA', im.get('ba'), ...
        'WAITBAR', im.get('WAITBAR') ...
        );
elseif ~braph2_testing()
    error([BRAPH2.STR ':ImporterGroupSubjectCON_FUN_MP_XLS: ' BRAPH2.BUG_IO]);
end

if exist('gr_con') && exist('gr_fun')
    co_gr = CombineGroups_CON_FUN( ...
        'GR1', gr_con.get('GR'), ...
        'GR2', gr_fun.get('GR'), ...
        'WAITBAR', true ...
        );
    
    gr = co_gr.get('GR');
    
end

value = gr;

%% ¡methods!
function uigetdir(im, varargin)
    % UIGETDIR opens a dialog box to set the directory from where to load the XLS files of the CON_FUN_MP subject group.

    directory = uigetdir('Select directory');
    dir_type = get_from_varargin('', 'DIR_TYPE', varargin{:});
    if ischar(directory) && isfolder(directory)
        im.set(dir_type, directory);
    end
end