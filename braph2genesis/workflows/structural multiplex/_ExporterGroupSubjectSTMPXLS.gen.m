%% ¡header!
ExporterGroupSubjectSTMPXLS < Exporter (ex, exporter of ST MP subject group in XLS/XLSX) exports a group of subjects with structural multiplex data to an XLSX file.

%%% ¡description!
ExporterGroupSubjectSTMPXLS exports a group of subjects with structural multiplex data  and their covariates (if existing) to an XLSX file.
The files from the same group containing the data from L layers are saved in the same folder.
Each XLS/XLSX file consists of the following columns: 
Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
BrainRegions of that layer (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.
The covariates must be on the second Sheet of the XLS/XLSX file containing data from layer 1. 
Sheet 2 consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Exporter, ImporterGroupSubjectSTMPXLS

%% ¡props!

%%% ¡prop!
GR (data, item) is a group of subjects with structural multiplex data.
%%%% ¡settings!
'Group'
%%%% ¡check!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST_MP', [], [], true))); 
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'))

%%% ¡prop!
DIRECTORY (data, string) is the directory name where to save the group of subjects with structural multiplex data.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
SAVE (result, empty) saves the group of subjects with structural multiplex data in XLS/XLSX files in the selected directory.
%%%% ¡calculate!
directory = ex.get('DIRECTORY');

if isfolder(directory)
    gr = ex.get('GR');

    gr_directory = [directory filesep() gr.get('ID')];
    if ~exist(gr_directory, 'dir')
        mkdir(gr_directory)
    end

    sub_dict = gr.get('SUB_DICT');
    sub_number = sub_dict.length();

    if sub_number ~= 0
        sub = sub_dict.getItem(1);
        ba = sub.get('BA');
        br_list = cellfun(@(i) ba.get('BR_DICT').getItem(i), ...
            num2cell([1:1:ba.get('BR_DICT').length()]), 'UniformOutput', false);
        br_labels = cellfun(@(br) br.get('LABEL'), br_list, 'UniformOutput', false);
        layers_number = sub_dict.getItem(1).get('L');
        br_number = length(br_labels);
        all_data = cell(layers_number, sub_number, br_number);
        subjects_info = cell(sub_number, 3);
        age = cell(sub_number, 1);
        sex = cell(sub_number, 1);
        
        for i = 1:1:sub_number
            sub = sub_dict.getItem(i);
            subjects_info{i, 1} = sub.get('ID');
            subjects_info{i, 2} = sub.get('LABEL');
            subjects_info{i, 3} = sub.get('NOTES');
            age{i} =  sub.get('AGE');
            sex{i} =  sub.get('SEX');
            
            for k = 1:1:layers_number
                data_val = sub.get('ST_MP');
                all_data(k, i, :) = num2cell(data_val{k}');
            end             
        end
        
        for j = 1:1:layers_number
            gr_id = gr.get('ID');
            % save id label notes
            tab_id = cell2table(subjects_info);
            tab_id.Properties.VariableNames = {'ID', 'Label', 'Notes'};
            writetable(tab_id, [gr_directory filesep() gr_id  '_' num2str(j) '.xlsx'], 'Sheet', 1, 'WriteVariableNames', 1, 'Range', 'A1');
            
            % save data
            tab_data =  cell2table(reshape(all_data(j, :, :), [sub_number, br_number]));
            tab_data.Properties.VariableNames = br_labels;
            writetable(tab_data, [gr_directory filesep() gr_id  '_' num2str(j) '.xlsx'], 'Sheet', 1, 'WriteVariableNames', 1, 'Range', 'D1');
        end
    end
    
    % if covariates save them in another file
    if sub_number ~= 0 && ~isequal(sex{:}, 'unassigned')  && ~isequal(age{:},  0) 
        tab2 = cell(1 + sub_number, 3);
        tab2{1, 1} = 'ID';
        tab2{1, 2} = 'Age';
        tab2{1, 3} = 'Sex';
        tab2(2:end, 1) = tab_id{:, 1};
        tab2(2:end, 2) = age;
        tab2(2:end, 3) = sex;
        tab2 = table(tab2);
        
        % save
        writetable(tab2, [gr_directory filesep() gr_id  '_1.xlsx'], 'Sheet', 2, 'WriteVariableNames', 0);
        warning('off', 'MATLAB:xlswrite:AddSheet');
    end
    
    % sets value to empty
    value = [];
else
    value = ex.getr('SAVE');    
end

%% ¡methods!
function uigetdir(ex)
    % UIGETDIR opens a dialog box to set the directory where to save the group of subjects with structural multiplex data.

    directory = uigetdir('Select directory');
    if isfolder(directory)
        ex.set('DIRECTORY', directory);
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Export and import
%%%% ¡code!
br1 = BrainRegion( ...
    'ID', 'ISF', ...
    'LABEL', 'superiorfrontal', ...
    'NOTES', 'notes1', ...
    'X', -12.6, ...
    'Y', 22.9, ...
    'Z', 42.4 ...
    );
br2 = BrainRegion( ...
    'ID', 'lFP', ...
    'LABEL', 'frontalpole', ...
    'NOTES', 'notes2', ...
    'X', -8.6, ...
    'Y', 61.7, ...
    'Z', -8.7 ...
    );
br3 = BrainRegion( ...
    'ID', 'lRMF', ...
    'LABEL', 'rostralmiddlefrontal', ...
    'NOTES', 'notes3', ...
    'X', -31.3, ...
    'Y', 41.2, ...
    'Z', 16.5 ...
    );
br4 = BrainRegion( ...
    'ID', 'lCMF', ...
    'LABEL', 'caudalmiddlefrontal', ...
    'NOTES', 'notes4', ...
    'X', -34.6, ...
    'Y', 10.2, ...
    'Z', 42.8 ...
    );
br5 = BrainRegion( ...
    'ID', 'lPOB', ...
    'LABEL', 'parsorbitalis', ...
    'NOTES', 'notes5', ...
    'X', -41, ...
    'Y', 38.8, ...
    'Z', -11.1 ...
    );

ba = BrainAtlas( ...
    'ID', 'TestToSaveCoolID', ...
    'LABEL', 'Brain Atlas', ...
    'NOTES', 'Brain atlas notes', ...
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_KEY', 1, 'IT_LIST', {br1, br2, br3, br4, br5}) ...
    );

sub1 = SubjectST_MP( ...
    'ID', 'SUB ST 1', ...
    'LABEL', 'Subejct ST 1', ...
    'NOTES', 'Notes on subject ST 1', ...
    'BA', ba, ...
    'age', 30, ...
    'sex', 'female', ...
    'L', 2, ...
    'ST_MP', {rand(ba.get('BR_DICT').length(), 1), rand(ba.get('BR_DICT').length(), 1)} ...
    );
sub2 = SubjectST_MP( ...
    'ID', 'SUB ST 2', ...
    'LABEL', 'Subejct ST 2', ...
    'NOTES', 'Notes on subject ST 2', ...
    'BA', ba, ...
    'age', 40, ...
    'sex', 'male', ...
    'L', 2, ...
    'ST_MP', {rand(ba.get('BR_DICT').length(), 1), rand(ba.get('BR_DICT').length(), 1)} ...
    );
sub3 = SubjectST_MP( ...
    'ID', 'SUB ST 3', ...
    'LABEL', 'Subejct ST 3', ...
    'NOTES', 'Notes on subject ST 3', ...
    'BA', ba, ...
    'age', 50, ...
    'sex', 'female', ...
    'L', 2, ...
    'ST_MP', {rand(ba.get('BR_DICT').length(), 1), rand(ba.get('BR_DICT').length(), 1)} ...
    );

gr = Group( ...
    'ID', 'GR ST MP', ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectST_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP', 'IT_KEY', 1, 'IT_LIST', {sub1, sub2, sub3}) ...
    );

directory = [fileparts(which('test_braph2')) filesep 'trial_group_subjects_ST_MP_to_be_erased'];
if ~exist(directory, 'dir')
    mkdir(directory)
end

ex = ExporterGroupSubjectSTMPXLS( ...
    'DIRECTORY', directory, ...
    'GR', gr ...
    );
ex.get('SAVE');

% import with same brain atlas
im1 = ImporterGroupSubjectSTMPXLS( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)], ...
    'BA', ba ...
    );
gr_loaded1 = im1.get('GR');

assert(gr.get('SUB_DICT').length() == gr_loaded1.get('SUB_DICT').length(), ...
	[BRAPH2.STR ':ExporterGroupSubjectSTMPXLS:' BRAPH2.BUG_IO], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').length(), gr_loaded1.get('SUB_DICT').length())
    sub = gr.get('SUB_DICT').getItem(i);
    sub_loaded = gr_loaded1.get('SUB_DICT').getItem(i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('LABEL'), sub_loaded.get('LABEL')) & ...
        isequal(sub.get('NOTES'), sub_loaded.get('NOTES')) & ...
        isequal(sub.get('BA'), sub_loaded.get('BA')) & ...
        isequal(sub.get('AGE'), sub_loaded.get('AGE')) & ...
        isequal(sub.get('SEX'), sub_loaded.get('SEX')) & ...
        isequal(sub.get('L'), sub_loaded.get('L')) & ...
        isequal(sub.get('ST_MP'), sub_loaded.get('ST_MP')), ...
        [BRAPH2.STR ':ExporterGroupSubjectSTMPXLS:' BRAPH2.BUG_IO], ...
        'Problems saving or loading a group.')    
end

% import with new brain atlas
im2 = ImporterGroupSubjectSTMPXLS( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)] ...
    );
gr_loaded2 = im2.get('GR');

assert(gr.get('SUB_DICT').length() == gr_loaded2.get('SUB_DICT').length(), ...
	[BRAPH2.STR ':ExporterGroupSubjectSTMPXLS:' BRAPH2.BUG_IO], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').length(), gr_loaded2.get('SUB_DICT').length())
    sub = gr.get('SUB_DICT').getItem(i);
    sub_loaded = gr_loaded2.get('SUB_DICT').getItem(i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('LABEL'), sub_loaded.get('LABEL')) & ...
        isequal(sub.get('NOTES'), sub_loaded.get('NOTES')) & ...
        ~isequal(sub.get('BA').get('ID'), sub_loaded.get('BA').get('ID')) & ...
        isequal(sub.get('AGE'), sub_loaded.get('AGE')) & ...
        isequal(sub.get('SEX'), sub_loaded.get('SEX')) & ...
        isequal(sub.get('L'), sub_loaded.get('L')) & ...
        isequal(sub.get('ST_MP'), sub_loaded.get('ST_MP')), ...
        [BRAPH2.STR ':ExporterGroupSubjectSTMPXLS:' BRAPH2.BUG_IO], ...
        'Problems saving or loading a group.')    
end

rmdir(directory, 's')