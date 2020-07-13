classdef SubjectMRI < Subject
    % SubjectMRI A subject of type MRI
    % SubjectMRI represents a subject of type MRI.
    % It is a subclass of Subject. It implements the methods initialize_datadict
    % and update_brainatlases.
    %
    % SubjectMRI methods (Access=protected):
    %   SubjectMRI              - Constructor
    %
    % SubjectMRI methods (Access=protected):
    %   initialize_datadict     - initializes the data dictionary DATADICT
    %   update_brainatlases     - updates the brain atlases in DATADICT
    %
    % SubjectMRI inspection methods (Static)
    %   getClass                - returns the class of SubjectMRI
    %   getName                 - returns the name of  SubjectMRI
    %   getDescription          - returns the description of SubjectMRI
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of SubjectMRI
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data for SubjectMRI
    %   getDataClasses          - returns the class of the type of all data of SubjectMRI
    %   getDataClass            - returns the class of the type of a data of SubjectMRI
    %   getSubject              - returns a new instantiation of SubjectMRI
    %
    % Subject load and save methods (Static):
    %   load_from_xls           - reads a '.xls' or '.xlsx' file, loads the data to a new subject
    %   save_to_xls             - saves the subject data to a '.xls' or '.xlsx' file
    %   load_from_txt           - reads a '.txt' file, loads the data to a new subject
    %   save_to_txt             - saves the subject data to a '.txt' file
    %   load_from_json          - reads a '.json' file, loads the data to a new subject
    %   save_to_json            - saves the subject data to a '.json' file
    %
    % See also Group, Cohort, SubjectDTI, SubjectMRI, Subject.
 
    methods  % Constructor
        function sub = SubjectMRI(id, label, notes, atlas, varargin)
            % SUBJECTMRI creates a subject of type MRI
            %
            % SUBJECTMRI(ID, LABEL, NOTES, ATLASES) creates a subject of type MRI
            % with with ID, LABEL, NOTES. ATLAS is the brain atlas that 
            % subject MRI will use (it can be either a BrainAtlas or a
            % cell array with a single BrainAtlas).
            %
            % SUBJECTMRI(ID, LABEL, NOTES, ATLASES, 'PROPERTYRULE1, 'VALUE1, ...) 
            % creates a MRI subject with ubject ID, LABEL NOTES and ATLASES.
            % SubjectfMRI will be initialized by the rules passed in the
            % VARARGIN.
            %
            % See also See also Group, Cohort, SubjectfMRI, SubjectDTI, Subject.
            
            if isa(atlas, 'BrainAtlas')
                atlases = {atlas};
            else
                assert(iscell(atlas) && length(atlas)==1, ...
                    ['BRAIN:SubjectMRI:AtlasErr'], ...
                    ['The input must be a BrainAtlas or a cell with one BrainAtlas']) %#ok<NBRAK>
                atlases = atlas;
            end
            
            sub = sub@Subject(id, label, notes, atlases, varargin{:});
        end
    end
    methods (Access=protected)  % Utilifty functions
        function initialize_datadict(sub, varargin)
           % INITIALIZE_DATADICT initializes the data dictionary
            %
            % INITIALIZE_DATADICT(SUB, 'age', AGE, 'MRI', DATA) initializes the data
            % ditionary with data type and data code of subject mri.
            %
            % See also update_brainatlases.
            
            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            
            age = get_from_varargin(0, 'age', varargin{:});
            mri = get_from_varargin(zeros(atlas.getBrainRegions().length(), 1), 'MRI', varargin{:});  % column vector with the same number of elements as the BrainAtlas
            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas, age);
            sub.datadict('MRI') = DataStructural(atlas, mri);
        end
        function update_brainatlases(sub, atlases)
            % UPDATE_BRAINATLASES updates the atlases of the subject MRI
            %
            % UPDATE_BRAINATLASES(SUB, ATLASES) updates the atlases of the
            % subject MRI using the new values ATLASES. ATLASES must be a
            % cell array with a single BrainAtlas.
            %
            % See also initialize_datadict.
            
            sub.atlases = atlases;
            atlas = atlases{1};
            
            d1 = sub.datadict('age');
            d1.setBrainAtlas(atlas)
            
            d2 = sub.datadict('MRI');
            d2.setBrainAtlas(atlas);
        end
    end
    methods (Static)  % Inspection functions
        function subject_class = getClass()
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS() returns the class SubjectMRI
            %
            % See also getDescription, getName.
            
            subject_class = 'SubjectMRI';
        end
        function name = getName()
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME() returns the name: Subject MRI.
            %
            % See also getClass, getDescription.
            
            name = 'Subject Structural MRI';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of SubjectMRI
            %
            % See also getName, getClass, getBrainAtlasNumber.
            
            description = [ ...
                'Subject with structural MRI data, ' ...
                'such as cortical thickness for each brain region' ...
                ];
        end
        function atlas_number = getBrainAtlasNumber()
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % N = GETBRAINATLASNUMBER() returns the number of
            % brain atlases, in this case 1.
            %
            % See also getDescription, getName, getClass.
            
            atlas_number = 1;
        end
        function datalist = getDataList()
            % GETDATALIST returns the list of data
            %
            % CELL ARRAY = GETDATALIST() returns a cell array of
            % subject data. For Subject MRI, the data list is:
            %   age            -    DataScalar.
            %   MRI            -    DataStructural.
            %
            % See also getList
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('MRI') = 'DataStructural';
        end
        function data_number = getDataNumber()
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER() returns the number of data.
            %
            % See also getDataList, getBrainAtlasNumber.
            
            data_number = Subject.getDataNumber('SubjectMRI');
        end
        function data_codes = getDataCodes()
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject MRI data keys.
            %
            % See also getList, getDataClasses, getDataNumber
            
            data_codes = Subject.getDataCodes('SubjectMRI');
        end
        function data_classes = getDataClasses()
            % GETDATACLASSES returns the list of data classes
            %
            % CELL ARRAY = GETDATACLASSES(SUB) returns a cell array of
            % subject MRI data classes.
            %
            % CELL ARRAY = GETDATACLASSES(SUBJECT_CLASS) returns a
            % cell array of subject MRI data classes to the subject whose class is
            % SUBJECT_CLASS.
            %
            % See also getList, getDataCodes, getDataClass.
            
            data_classes = Subject.getDataClasses('SubjectMRI');
        end
        function data_class = getDataClass(data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE
            %
            % See also getList, getDataClasses.
            
            data_class = Subject.getDataNumber('SubjectMRI', data_code);
        end
    end
    methods (Static)  % Save/load functions
        function cohort = load_from_xls(cohort, subject_class, atlases, varargin)
            % LOAD_FROM_XLS loads a '.xls' file to a Cohort with SubjectMRI
            %
            % COHORT = LOAD_FROM_XLS([], SUBJECT_CLASS, ATLASES) opens a GUI to
            % load a directory where it reads '.xls' or '.xlsx' files. It 
            % creates a cohort of SubjectMRI with brain atlas ATLASES.
            %
            % COHORT = LOAD_FROM_XLS(COHORT, SUBJECT_CLASS, ATLASES, 'Directory', PATH)
            % loads the directory in PATH where it reads '.xls' or '.xlsx'
            % files. It creates a cohort of SubjectMRI with brain atlas ATLASES.
            %
            % COHORT = LOAD_FROM_XLS(COHORT, SUBJECT_CLASS, ATLASES) opens a GUI to
            % load a directory where it reads '.xls' or '.xlsx' files. It 
            % loads to the COHORT of SubjectMRI with brain atlas ATLASES.
            %
            % COHORT = LOAD_FROM_XLS(COHORT, SUBJECT_CLASS, ATLASES, 'Directory', PATH)
            % loads the directory in PATH where it reads '.xls' or '.xlsx'
            % files. It loads to the COHORT of SubjectMRI with brain atlas ATLASES.
            % 
            % See also save_to_xls, load_from_txt, load_from_json.
            
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.XLS_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(BRAPH2.XLS_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            if isempty(cohort)
                file_path = strsplit(file, filesep());
                file_cohort_path = '';
                for i = 1:1:length(file_path)-1
                    file_cohort_path = [file_cohort_path filesep() file_path{i}]; %#ok<AGROW>
                end
                file_cohort = [file_cohort_path filesep() 'cohort_info.txt'];
                file_cohort = file_cohort(2:end);
                cohort_id = '';
                cohort_label = '';
                cohort_notes = '';
                
                if exist(file_cohort, 'file')
                    raw_cohort = textread(file_cohort, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                    cohort_id = raw_cohort{1, 1};
                    cohort_label = raw_cohort{2, 1};
                    cohort_notes = raw_cohort{3, 1};
                end                
                
                % creates cohort
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});  
            end
            
            % search for cohort info file
         
            [~, ~, raw] = xlsread(file);
            
            for i = 5:1:size(raw, 1)
                subject = Subject.getSubject(subject_class, ...                    
                    char(raw{i, 1}), char(raw{i, 2}), char(raw{i, 3}), atlases, ...
                    'MRI', cell2mat(raw(i, 4:size(raw, 2))'));
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            group = Group(subject_class,'', '', '', cohort.getSubjects().getValues());
            path = [fileparts(which(file))]; %#ok<NBRAK>
            file_name = erase(file, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.xlsx');
            file_name = erase(file_name, '.xls');            
            group.setID(file_name);
            group.setLabel(raw{2, 1});  % set group info
            group.setNotes(raw{3, 1});
            cohort.getGroups().add(group.getID(), group);
        end
        function save_to_xls(cohort, varargin)
            % SAVE_TO_XLS saves the cohort of SubjectMRI to a '.xls' file
            %
            % SAVE_TO_XLS(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectMRI will be saved in '.xls' or 'xlsx'
            % format.
            %
            % SAVE_TO_XLS(COHORT, 'RootDirectory', PATH) saves the cohort 
            % of SubjectMRI in '.xls' or 'xlsx' format in the
            % specified PATH.
            % 
            % See also load_from_xls, save_to_txt, save_to_json
            
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.XLS_MSG_PUTFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uiputfile(BRAPH2.XLS_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % cohort info           
            file_path = strsplit(file, filesep());
            file_cohort_path = '';
            for i = 1:1:length(file_path)-1
                file_cohort_path = [file_cohort_path filesep() file_path{i}]; %#ok<AGROW>
            end
            file_cohort = [file_cohort_path filesep() 'cohort_info.txt'];
            file_cohort = file_cohort(2:end);
            cohort_info = cell(3, 1);
            cohort_info{1, 1} = cohort.getID();
            cohort_info{2, 1} = cohort.getLabel();
            cohort_info{3, 1} = cohort.getNotes();
            writecell(cohort_info, file_cohort, 'Delimiter', '\t');
            
            % get info
            groups = cohort.getGroups().getValues();
            group = groups{1};  % must change
            subjects_list = group.getSubjects();
            
            % group info
            group_info = cell(3, 1);
            group_info{1, 1} = group.getID();
            group_info{2, 1} = group.getLabel();
            group_info{3, 1} = group.getNotes();
            
            for j = 1:1:group.subjectnumber()
                % get subject data
                subject = subjects_list{j};
                row_ids{j, 1} = subject.getID(); %#ok<AGROW>
                row_labels{j, 1} = subject.getLabel(); %#ok<AGROW>
                row_notes{j, 1} = subject.getNotes(); %#ok<AGROW>
                row_datas{j, 1} = subject.getData('MRI').getValue(); %#ok<AGROW>
            end
            tab = table(row_ids, row_labels, row_notes, row_datas);
            
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};  % must change
            
            for i = 1:1:atlas.getBrainRegions().length()
                brain_regions{i} = atlas.getBrainRegions().getValue(i);  %#ok<AGROW>
            end
            
            row_data{1,:} = cellfun(@(x) x.getLabel, brain_regions, 'UniformOutput', false);
            row_id = 'ID';
            row_label = 'Label';
            row_notes = 'Notes';
            first_row_table = table(row_data, 'VariableNames', {'row_datas'});
            first_row_table.row_ids = row_id;
            first_row_table.row_labels = row_label;
            first_row_table.row_notes = row_notes;
            first_row_table = [first_row_table(:, 2) first_row_table(:, 3) ...
                first_row_table(:, 4) first_row_table(:, 1)];
            
            % creates table
            tab = [
                first_row_table
                tab
                ];
            
            % save
            writecell(group_info, file);
            writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A4');
        end
        function cohort = load_from_txt(cohort, subject_class, atlases, varargin)
            % LOAD_FROM_TXT loads a '.txt' file to a Cohort with SubjectMRI
            %
            % COHORT = LOAD_FROM_TXT(SUBJECT_CLASS, ATLASES) opens a GUI to
            % load a directory where it reads '.txt' files. It 
            % creates a cohort of SubjectMRI with brain atlas ATLASES.
            %
            % COHORT = LOAD_FROM_TXT(SUBJECT_CLASS, ATLASES, 'Directory', PATH)
            % loads the directory in PATH where it reads '.txt' files.
            % It creates a cohort of SubjectMRI with brain atlas ATLASES.
            % 
            % See also save_to_txt, load_from_xls, load_from_json
            
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.TXT_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(BRAPH2.TXT_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % supress warning
            warning_id = 'MATLAB:table:ModifiedAndSavedVarnames';
            warning('off', warning_id)
            
            if isempty(cohort)
            
                % search for cohort info file
                file_path = strsplit(file, filesep());
                file_cohort_path = '';
                for i = 1:1:length(file_path)-1
                    file_cohort_path = [file_cohort_path filesep() file_path{i}]; %#ok<AGROW>
                end
                file_cohort_path = file_cohort_path(2:end);
                file_cohort = [file_cohort_path filesep() 'cohort_info.txt'];
                cohort_id = '';
                cohort_label = '';
                cohort_notes = '';
                
                if exist(file_cohort, 'file')
                    raw_cohort = textread(file_cohort, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                    cohort_id = raw_cohort{1, 1};
                    cohort_label = raw_cohort{2, 1};
                    cohort_notes = raw_cohort{3, 1};
                end
                
                % creates cohort
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end
            
            % get group info
            file_group = [file_cohort_path filesep() 'group_info.txt'];
            group_id = '';
            group_label = '';
            group_notes = '';
            if exist(file_group, 'file')
                raw_group = textread(file_group, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                group_id = raw_group{1, 1};
                group_label = raw_group{2, 1};
                group_notes = raw_group{3, 1};
            end        
                
            % reads file
            raw = readtable(file, 'Delimiter', '\t');
            
            for i = 1:1:size(raw, 1)  % first row is being read as table label
                subject = Subject.getSubject(subject_class, ...                    
                    char(raw{i, 1}), char(raw{i, 2}), char(raw{i, 3}), atlases, ...
                    'MRI', raw{i, 4:size(raw, 2)}');
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % warning on
            warning('on', 'all')
            
            % creates group
            group = Group(subject_class, group_id, group_label, group_notes, cohort.getSubjects().getValues());
            path = [fileparts(which(file))]; %#ok<NBRAK>
            file_name = erase(file, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.txt');
            group.setID(file_name);
            group.setLabel(group_label);
            group.setNotes(group_notes);
            cohort.getGroups().add(group.getID(), group);
        end
        function save_to_txt(cohort, varargin)
            % SAVE_TO_TXT saves the cohort of SubjectMRI to a '.txt' file
            %
            % SAVE_TO_TXT(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectMRI will be saved in '.txt' format.
            %
            % SAVE_TO_TXT(COHORT, 'RootDirectory', PATH) saves the cohort 
            % of SubjectMRI in '.txt' format in the specified PATH.
            % 
            % See also load_from_txt, save_to_xls, save_to_json
            
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.TXT_MSG_PUTFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uiputfile(BRAPH2.TXT_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
           % cohort info           
            file_path = strsplit(file, filesep());
            file_cohort_path = '';
            for i = 1:1:length(file_path)-1
                file_cohort_path = [file_cohort_path filesep() file_path{i}]; %#ok<AGROW>
            end
            file_cohort_path = file_cohort_path(2:end);
            file_cohort = [file_cohort_path filesep() 'cohort_info.txt'];            
            cohort_info = cell(3, 1);
            cohort_info{1, 1} = cohort.getID();
            cohort_info{2, 1} = cohort.getLabel();
            cohort_info{3, 1} = cohort.getNotes();
            writecell(cohort_info, file_cohort, 'Delimiter', '\t');
            
            % get info
            groups = cohort.getGroups().getValues();
            group = groups{1};  % must change
            subjects_list = group.getSubjects();
            
            % group info
            file_group = [file_cohort_path filesep() 'group_info.txt'];
            group_info = cell(3, 1);
            group_info{1, 1} = group.getID();
            group_info{2, 1} = group.getLabel();
            group_info{3, 1} = group.getNotes();
            writecell(group_info, file_group, 'Delimiter', '\t');
            
            
            for j = 1:1:group.subjectnumber()
                % get subject data
                subject = subjects_list{j};
                row_ids{j, 1} = subject.getID(); %#ok<AGROW>
                row_labels{j, 1} = subject.getLabel(); %#ok<AGROW>
                row_notes{j, 1} = subject.getNotes(); %#ok<AGROW>
                row_datas{j, 1} = subject.getData('MRI').getValue(); %#ok<AGROW>
            end
            t = table(row_ids, row_labels, row_notes, row_datas);

            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};  % must change
            
            for i = 1:1:atlas.getBrainRegions().length()
                brain_regions{i} = atlas.getBrainRegions().getValue(i);  %#ok<AGROW>
            end
            
            row_data{1,:} = cellfun(@(x) x.getLabel, brain_regions, 'UniformOutput', false);
            row_id = 'ID';
            row_label = 'Label';
            row_note = 'Notes';
            first_row_table = table(row_data, 'VariableNames', {'row_datas'});
            first_row_table.row_ids = row_id;
            first_row_table.row_labels = row_label;
            first_row_table.row_notes = row_note;
            first_row_table = [first_row_table(:, 2) first_row_table(:, 3) ...
                first_row_table(:, 4) first_row_table(:, 1)];
            
            % creates table
            tab = [
                first_row_table
                t
                ];
            
            % save
            f_1 = [file(1:length(file)-4) '_quotation' file(length(file)-3:end)];
            writetable(tab, f_1, 'Delimiter', '\t', 'WriteVariableNames', 0);
            
            % remove quotation marks
            fid = fopen(f_1);
            C = textscan(fid, '%s', 'delimiter', '\t');
            fclose(fid);
            for k=1:numel(C{1, 1})
                tmp = regexp(C{1, 1}(k),'"'); % find quotation marks
                C{1,1}{k,1}(tmp{1, 1}) = ''; % substitute with empty spaces
            end
            % print new file
            fName = file;
            fid = fopen(fName, 'w');            % Open the file
            m = atlas.getBrainRegions().length() + 2;
            count = 0;
            
            for k = 1:numel(C{1, 1})
                if count == m
                    fprintf(fid, '%s\r\n', C{1, 1}{k, 1});
                    count = -1;
                else
                    fprintf(fid, '%s\t', C{1, 1}{k, 1});
                end
                count = count + 1;
            end
            delete(f_1);
            fclose(fid);
        end
        function cohort = load_from_json(subject_class, atlases, varargin)
            % LOAD_FROM_JSON loads a '.json' file to a Cohort with SubjectMRI
            %
            % COHORT = LOAD_FROM_JSON(SUBJECT_CLASS, ATLASES) opens a GUI to
            % load a directory where it reads '.json' files. It 
            % creates a cohort of SubjectMRI with brain atlas ATLASES.
            %
            % COHORT = LOAD_FROM_JSON(SUBJECT_CLASS, ATLASES, 'Directory', PATH)
            % loads the directory in PATH where it reads '.json' files.
            % It creates a cohort of SubjectMRI with brain atlas ATLASES.
            % 
            % See also save_to_json, load_from_xls, load_from_txt
            
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.JSON_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(BRAPH2.JSON_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % creates cohort
            cohort = Cohort('', '', '', subject_class, atlases, {});
            
            raw = jsondecode(fileread(file)); 
            
             % get cohort and group info
                cohort_id = raw.CohortData.id;
                cohort_label = raw.CohortData.label;
                cohort_notes = raw.CohortData.notes;
                group_id = raw.GroupData.id;
                group_label = raw.GroupData.label;
                group_notes = raw.GroupData.notes;
                
            for i = 1:1:length(raw.SubjectData)
                id = raw.SubjectData(i).id;
                label = raw.SubjectData(i).label;
                notes = raw.SubjectData(i).notes;
                data = raw.SubjectData(i).data;
                subject = Subject.getSubject(subject_class, ...                   
                    id, label, notes, atlases, ...
                    'MRI', data);
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            cohort.setID(cohort_id);
            cohort.setLabel(cohort_label);
            cohort.setNotes(cohort_notes);
            
            % creates group
            group = Group(subject_class, group_id, group_label, group_notes, cohort.getSubjects().getValues());
            path = [fileparts(which(file))]; %#ok<NBRAK>
            file_name = erase(file, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.json');
            group.setID(file_name);
            cohort.getGroups().add(group.getID(), group);
        end
        function save_to_json(cohort, varargin)
            % SAVE_TO_JSON saves the cohort of SubjectMRI to a '.json' file
            %
            % SAVE_TO_JSON(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectMRI will be saved in '.json' format.
            %
            % SAVE_TO_JSON(COHORT, 'RootDirectory', PATH) saves the cohort 
            % of SubjectMRI in '.json' format in the specified PATH.
            % 
            % See also load_from_json, save_to_xls, save_to_txt
            
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.XLS_MSG_PUTFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uiputfile(BRAPH2.XLS_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % get info
            groups = cohort.getGroups().getValues();
            group = groups{1};  % must change
            subjects_list = group.getSubjects();
            
            for j = 1:1:group.subjectnumber()
                % get subject data
                subject = subjects_list{j};
               
                row_ids{j, 1} = subject.getID(); %#ok<AGROW>
                row_labels{j, 1} = subject.getLabel(); %#ok<AGROW>
                row_notes{j, 1} = subject.getNotes(); %#ok<AGROW>
                row_datas{j, 1} = subject.getData('MRI').getValue(); %#ok<AGROW>
            end
            
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};  % must change
            
            % labels
            for i = 1:1:atlas.getBrainRegions().length()
                brain_regions{i} = atlas.getBrainRegions().getValue(i);  %#ok<AGROW>
            end            
            row_data{1,:} = cellfun(@(x) x.getLabel, brain_regions, 'UniformOutput', false);
            labels = row_data;
            
            % create structure to be save
            structure_to_be_saved = struct( ...
                'Braph', BRAPH2.NAME, ...
                'Build', BRAPH2.BUILD, ...
                'BrainRegionsLabels', labels, ...
                'CohortData', struct( ...
                'id', cohort.getID(), ...
                'label', cohort.getLabel(), ...
                'notes', cohort.getNotes()), ...
                'GroupData', struct( ...
                'id', group.getID(), ...
                'label', group.getLabel(), ...
                'notes', group.getNotes()), ...
                'SubjectData', struct( ...
                'id', row_ids, ...
                'label', row_labels, ...
                'notes', row_notes, ...
                'data', row_datas) ...
                );
            
            % save
            json_structure = jsonencode(structure_to_be_saved);      
            fid = fopen(file, 'w');
            if fid == -1, error('Cannot create JSON file'); end
            fwrite(fid, json_structure, 'char');
            fclose(fid);
        end
    end
end
