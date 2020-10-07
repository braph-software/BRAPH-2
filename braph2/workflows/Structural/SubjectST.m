classdef SubjectST < Subject
    % SubjectST A subject of type Structural
    % SubjectST represents a subject of type Structural.
    % It is a subclass of Subject. It implements the methods initialize_datadict
    % and update_brainatlases.
    %
    % SubjectST methods (Access=protected):
    %   SubjectST               - Constructor
    %
    % SubjectST methods (Access=protected):
    %   initialize_datadict     - initializes the data dictionary DATADICT
    %   update_brainatlases     - updates the brain atlases in DATADICT
    %
    % SubjectST inspection methods (Static)
    %   getClass                - returns the class of SubjectST
    %   getName                 - returns the name of  SubjectST
    %   getDescription          - returns the description of SubjectST
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of SubjectST
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data for SubjectST
    %   getDataClasses          - returns the class of the type of all data of SubjectST
    %   getDataClass            - returns the class of the type of a data of SubjectST
    %   getSubject              - returns a new instantiation of SubjectST
    %
    % SubjectST load and save methods (Static):
    %   load_from_xls           - reads a '.xls' or '.xlsx' file, loads the data to a new subject
    %   save_to_xls             - saves the subject data to a '.xls' or '.xlsx' file
    %   load_from_txt           - reads a '.txt' file, loads the data to a new subject
    %   save_to_txt             - saves the subject data to a '.txt' file
    %   load_from_json          - reads a '.json' file, loads the data to a new subject
    %   save_to_json            - saves the subject data to a '.json' file
    %
    % See also Group, Cohort, Subject, SubjectST, SubjectCON, SubjectFNC.
 
    methods  % Constructor
        function sub = SubjectST(id, label, notes, atlas, varargin)
            % SUBJECTST creates a subject of type Structural
            %
            % SUBJECTST(ID, LABEL, NOTES, ATLASES) creates a subject of type Structural
            % with with ID, LABEL, NOTES. ATLAS is the brain atlas that
            % subject Structural will use (it can be either a BrainAtlas or a
            % cell array with a single BrainAtlas).
            %
            % SUBJECTST(ID, LABEL, NOTES, ATLASES, 'PROPERTYRULE1, 'VALUE1, ...)
            % creates a Structural subject with ubject ID, LABEL NOTES and ATLASES.
            % SubjectST will be initialized by the rules passed in the
            % VARARGIN.
            %
            % See also See also Group, Cohort, SubjectfMRI, SubjectDTI, Subject.
            
            if isa(atlas, 'BrainAtlas')
                atlases = {atlas};
            else
                assert(iscell(atlas) && length(atlas)==1, ...
                    ['BRAIN:SubjectST:AtlasErr'], ...
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
            % INITIALIZE_DATADICT(SUB, 'age', AGE, 'ST', DATA) initializes the data
            % ditionary with data type and data code of subject structural.
            %
            % See also update_brainatlases.
            
            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            
            age = get_from_varargin(0, 'age', varargin{:});
            structural = get_from_varargin(zeros(atlas.getBrainRegions().length(), 1), 'ST', varargin{:});  % column vector with the same number of elements as the BrainAtlas
            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas, age);
            sub.datadict('ST') = DataStructural(atlas, structural);
        end
        function update_brainatlases(sub, atlases)
            % UPDATE_BRAINATLASES updates the atlases of the subject Structural
            %
            % UPDATE_BRAINATLASES(SUB, ATLASES) updates the atlases of the
            % subject Structural using the new values ATLASES. ATLASES must be a
            % cell array with a single BrainAtlas.
            %
            % See also initialize_datadict.
            
            sub.atlases = atlases;
            atlas = atlases{1};
            
            d1 = sub.datadict('age');
            d1.setBrainAtlas(atlas)
            
            d2 = sub.datadict('ST');
            d2.setBrainAtlas(atlas);
        end
    end
    methods (Static)  % Inspection functions
        function subject_class = getClass()
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS() returns the class SubjectST
            %
            % See also getDescription, getName.
            
            subject_class = 'SubjectST';
        end
        function name = getName()
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME() returns the name: Subject Structural.
            %
            % See also getClass, getDescription.
            
            name = 'Subject Structural';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of SubjectST
            %
            % See also getName, getClass, getBrainAtlasNumber.
            
            description = [ ...
                'Subject with structural data, ' ...
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
            % subject data. For Subject Structural, the data list is:
            %   age            -    DataScalar.
            %   Structural            -    DataStructural.
            %
            % See also getList
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('ST') = 'DataStructural';
        end
        function data_number = getDataNumber()
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER() returns the number of data.
            %
            % See also getDataList, getBrainAtlasNumber.
            
            data_number = Subject.getDataNumber('SubjectST');
        end
        function data_codes = getDataCodes()
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject Structural data keys.
            %
            % See also getList, getDataClasses, getDataNumber
            
            data_codes = Subject.getDataCodes('SubjectST');
        end
        function data_classes = getDataClasses()
            % GETDATACLASSES returns the list of data classes
            %
            % CELL ARRAY = GETDATACLASSES(SUB) returns a cell array of
            % subject Structural data classes.
            %
            % CELL ARRAY = GETDATACLASSES(SUBJECT_CLASS) returns a
            % cell array of subject Structural data classes to the subject whose class is
            % SUBJECT_CLASS.
            %
            % See also getList, getDataCodes, getDataClass.
            
            data_classes = Subject.getDataClasses('SubjectST');
        end
        function data_class = getDataClass(data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE
            %
            % See also getList, getDataClasses.
            
            data_class = Subject.getDataNumber('SubjectST', data_code);
        end
    end
    methods (Static)  % Save/load functions
        function cohort = load_from_xls(tmp, varargin)
            % LOAD_FROM_XLS loads a '.xls' file to a Cohort with SubjectST
            %
            % COHORT = LOAD_FROM_XLS(TMP) opens a GUI to load a directory
            % where it reads '.xls' or '.xlsx' files. If TMP is a brain atlas
            % it will create a cohort of SubjectST. If TMP is a cohort
            % then it will load the file into the cohort.
            %
            % COHORT = LOAD_FROM_XLS(TMP, 'Directory', PATH) loads the directory
            % in PATH where it reads '.xls' or '.xlsx' files. If TMP is a
            % brain atlas the function whill create a cohort of SubjectST
            % If TMP is a cohort then the function will load the file into
            % the cohort.
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
            
            % Set/create cohort
            if isa(tmp, 'Cohort')
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
            else  % tmp is an atlas
                
                % search for cohort info file
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
                
                % creates new cohort
                subject_class = 'SubjectST';
                atlas = tmp;
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlas, {});
            end
            
            % supress warning
            warning_id = 'MATLAB:table:ModifiedAndSavedVarnames';
            warning('off', warning_id)
            
            raw = readtable(file);
            atlas = cohort.getBrainAtlases();
            
            % sneak peak to see if it is a subject
            id_tmp = raw{1, 1};
            labl_tmp = raw{1, 2};
            notes_tmp = raw{1, 3};
            data_tmp = raw{1, 4:size(raw, 2)};
            if iscell(id_tmp)
                id_tmp = id_tmp{1};
            end
            if iscell(labl_tmp)
                labl_tmp = labl_tmp{1};
            end
            if  iscell(notes_tmp)
                notes_tmp = notes_tmp{1};
            end
            
            sub_tmp = Subject.getSubject(subject_class, ...
                num2str(id_tmp), num2str(labl_tmp), num2str(notes_tmp), atlas, ...
                'ST', data_tmp');
            delete(sub_tmp);
                        
            % load subjects to cohort & add them to the group
            group = Group(subject_class,'', '', '', {});
            group_path = strsplit(file, filesep());
            group_id = group_path{length(group_path)};
            group_id = erase(group_id, '.xlsx');
            group_id = erase(group_id, '.xls');
            group.setID(group_id);
            cohort.getGroups().add(group.getID(), group);
            
            for i = 1:1:size(raw, 1)
                id_tmp = raw{i, 1};
                labl_tmp = raw{i, 2};
                notes_tmp = raw{i, 3};
                data_tmp = raw{i, 4:size(raw, 2)};
                if iscell(id_tmp)
                    id_tmp = id_tmp{1};
                end
                if iscell(labl_tmp)
                    labl_tmp = labl_tmp{1};
                end
                if  iscell(notes_tmp)
                    notes_tmp = notes_tmp{1};
                end
                subject = Subject.getSubject(subject_class, ...
                    num2str(id_tmp), num2str(labl_tmp), num2str(notes_tmp), atlas, ...
                    'ST', data_tmp');
                if ~cohort.getSubjects().contains(subject.getID())
                    cohort.getSubjects().add(subject.getID(), subject, i);
                end
                group.addSubject(subject);
            end
             % warning on
            warning('on', 'all')
        end
        function save_to_xls(cohort, varargin)
            % SAVE_TO_XLS saves the cohort of SubjectST to a '.xls' file
            %
            % SAVE_TO_XLS(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectST will be saved in '.xls' or 'xlsx'
            % format.
            %
            % SAVE_TO_XLS(COHORT, 'RootDirectory', PATH) saves the cohort
            % of SubjectST in '.xls' or 'xlsx' format in the
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
                row_datas{j, 1} = subject.getData('ST').getValue(); %#ok<AGROW>
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
            writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A1');
        end
        function cohort = load_from_txt(tmp, varargin)
            % LOAD_FROM_TXT loads a '.txt' file to a Cohort with SubjectST
            %
            % COHORT = LOAD_FROM_TXT(TMP) opens a GUI to load a directory
            % where it reads '.txt' files. If TMP is a brain atlas
            % it will create a cohort of SubjectST. If TMP is a cohort
            % then it will load the file into the cohort.
            %
            % COHORT = LOAD_FROM_TXT(TMP, 'Directory', PATH) loads the directory
            % in PATH where it reads '.txt' files. If TMP is a
            % brain atlas the function whill create a cohort of SubjectST
            % If TMP is a cohort then the function will load the file into
            % the cohort.
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
            
            % Set/create cohort
            if isa(tmp, 'Cohort')
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
            else
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
                subject_class = 'SubjectST';
                atlases = tmp;
                
                if exist(file_cohort, 'file')
                    raw_cohort = textread(file_cohort, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                    cohort_id = raw_cohort{1, 1};
                    cohort_label = raw_cohort{2, 1};
                    cohort_notes = raw_cohort{3, 1};
                end
                
                % creates cohort
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end
            
            % reads file
            raw = readtable(file, 'Delimiter', '\t');
            atlases = cohort.getBrainAtlases();
            
            % sneak peak to see if it is a subject
            id_tmp = raw{1, 1};
            labl_tmp = raw{1, 2};
            notes_tmp = raw{1, 3};
            data_tmp = raw{1, 4:size(raw, 2)};
            if iscell(id_tmp)
                id_tmp = id_tmp{1};
            end
            if iscell(labl_tmp)
                labl_tmp = labl_tmp{1};
            end
            if  iscell(notes_tmp)
                notes_tmp = notes_tmp{1};
            end
            
            sub_tmp = Subject.getSubject(subject_class, ...
                num2str(id_tmp), num2str(labl_tmp), num2str(notes_tmp), atlases, ...
                'ST', data_tmp');  
            delete(sub_tmp);
            
            % creates group
            group = Group(subject_class, '', '', '', {});
            group_path = strsplit(file, filesep());
            group_id = group_path{length(group_path)};
            group_id = erase(group_id, '.txt');
            group.setID(group_id);
            cohort.getGroups().add(group.getID(), group);
            
            for i = 1:1:size(raw, 1)  % first row is being read as table label
                id_tmp = raw{i, 1};
                labl_tmp = raw{i, 2};
                notes_tmp = raw{i, 3};
                data_tmp = raw{i, 4:size(raw, 2)};
                if iscell(id_tmp)
                    id_tmp = id_tmp{1};
                end
                if iscell(labl_tmp)
                    labl_tmp = labl_tmp{1};
                end
                if  iscell(notes_tmp)
                    notes_tmp = notes_tmp{1};
                end
                subject = Subject.getSubject(subject_class, ...
                    num2str(id_tmp), num2str(labl_tmp), num2str(notes_tmp), atlases, ...
                    'ST', data_tmp');
                if ~cohort.getSubjects().contains(subject.getID())
                    cohort.getSubjects().add(subject.getID(), subject, i);
                end
                group.addSubject(subject);
            end
            % warning on
            warning('on', 'all')
        end
        function save_to_txt(cohort, varargin)
            % SAVE_TO_TXT saves the cohort of SubjectST to a '.txt' file
            %
            % SAVE_TO_TXT(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectST will be saved in '.txt' format.
            %
            % SAVE_TO_TXT(COHORT, 'RootDirectory', PATH) saves the cohort
            % of SubjectST in '.txt' format in the specified PATH.
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
                row_datas{j, 1} = subject.getData('ST').getValue(); %#ok<AGROW>
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
        function cohort = load_from_json(tmp, varargin)
            % LOAD_FROM_JSON loads a '.json' file to a Cohort with SubjectST
            %
            % COHORT = LOAD_FROM_JSON(TMP) opens a GUI to load a directory
            % where it reads '.json' files. If TMP is a brain atlas
            % it will create a cohort of SubjectST. If TMP is a cohort
            % then it will load the file into the cohort.
            %
            % COHORT = LOAD_FROM_JSON(TMP, 'Directory', PATH) loads the directory
            % in PATH where it reads '.json' files. If TMP is a
            % brain atlas the function whill create a cohort of SubjectST
            % If TMP is a cohort then the function will load the file into
            % the cohort.
            %
            % See also save_to_json, load_from_xls, load_from_txt
            
            raw = JSON.Deserialize(varargin{:});
            
            if isa(tmp, 'Cohort')
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
                atlases = cohort.getBrainAtlases();
            else
                cohort_id = '';
                cohort_label = '';
                cohort_notes = '';
                % creates cohort
                subject_class = 'SubjectST';
                atlases = tmp;
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end
            
            % sneak peak
            subject_tmp = Subject.getSubject(subject_class, ...
                num2str(raw.Groups(1).SubjectData(1).id), num2str(raw.Groups(1).SubjectData(1).label), num2str(raw.Groups(1).SubjectData(1).notes), atlases, ...
                'ST', raw.Groups(1).SubjectData(1).data);
            delete(subject_tmp)
            
            % creates group
            for i = 1:1:length(raw.Groups)
                group = Group(subject_class, raw.Groups(i).ID, raw.Groups.Label, raw.Groups.Notes, {});
                cohort.getGroups().add(group.getID(), group);
                subject_data = raw.Groups(i).SubjectData;                
                for j = 1:1:length(subject_data)
                    subject = Subject.getSubject(subject_class, ...
                        num2str(subject_data(j).id), num2str(subject_data(j).label), num2str(subject_data(j).notes), atlases, ...
                        'ST', subject_data(j).data);
                    if ~cohort.getSubjects().contains(subject.getID())
                        cohort.getSubjects().add(subject.getID(), subject, j);
                    end
                    group.addSubject(subject);
                end
            end   
        end
        function structure = save_to_json(cohort, varargin)
            % SAVE_TO_JSON saves the cohort of SubjectST to a '.json' file
            %
            % SAVE_TO_JSON(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectST will be saved in '.json' format.
            %
            % SAVE_TO_JSON(COHORT, 'RootDirectory', PATH) saves the cohort
            % of SubjectST in '.json' format in the specified PATH.
            %
            % See also load_from_json, save_to_xls, save_to_txt
                       
            % get info            
            groups = cohort.getGroups().getValues(); 
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};  % must change
            % labels
            for i = 1:1:atlas.getBrainRegions().length()
                brain_regions{i} = atlas.getBrainRegions().getValue(i);  %#ok<AGROW>
            end
            row_data{1,:} = cellfun(@(x) x.getLabel, brain_regions, 'UniformOutput', false);
            labels = row_data;
            
            Group_structure = struct;
            Subject_Structure = struct;
            for i =1:1:length(groups)
                group = groups{i};
                subjects_list = group.getSubjects();
                
                for j = 1:1:group.subjectnumber()
                    % get subject data
                    subject = subjects_list{j};
                    
                    Subject_Structure(j).id = subject.getID();
                    Subject_Structure(j).label = subject.getLabel(); 
                    Subject_Structure(j).notes = subject.getNotes();
                    Subject_Structure(j).data = subject.getData('ST').getValue();
                end

                Group_structure(i).ID = group.getID(); 
                Group_structure(i).Label = group.getLabel(); 
                Group_structure(i).Notes = group.getNotes(); 
                Group_structure(i).SubjectData = Subject_Structure;
            end

            % create structure to be save
            structure_to_be_saved = struct( ...
                'Braph', BRAPH2.NAME, ...
                'Build', BRAPH2.BUILD, ...
                'BrainAtlas', BrainAtlas.save_to_json(atlas), ...
                'Groups', Group_structure ...
                );
            
            % save
            structure = structure_to_be_saved;           
        end
        function cohort = load_from_struct(tmp, varargin)
            if isa(tmp, 'Cohort')
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
                atlases = cohort.getBrainAtlases();
            else
                cohort_id = '';
                cohort_label = '';
                cohort_notes = '';
                % creates cohort
                subject_class = 'SubjectST';
                atlases = tmp;
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end
            
            raw = get_from_varargin([], 'SubjectStructure', varargin{:});
            % sneak peak
            subject_tmp = Subject.getSubject(subject_class, ...
                num2str(raw.Groups(1).SubjectData(1).id), num2str(raw.Groups(1).SubjectData(1).label), num2str(raw.Groups(1).SubjectData(1).notes), atlases, ...
                'ST', raw.Groups(1).SubjectData(1).data);
            delete(subject_tmp)
            
            % creates group
            for i = 1:1:length(raw.Groups)
                group = Group(subject_class, raw.Groups(i).ID, raw.Groups.Label, raw.Groups.Notes, {});
                cohort.getGroups().add(group.getID(), group);
                subject_data = raw.Groups(i).SubjectData;                
                for j = 1:1:length(subject_data)
                    subject = Subject.getSubject(subject_class, ...
                        num2str(subject_data(j).id), num2str(subject_data(j).label), num2str(subject_data(j).notes), atlases, ...
                        'ST', subject_data(j).data);
                    if ~cohort.getSubjects().contains(subject.getID())
                        cohort.getSubjects().add(subject.getID(), subject, j);
                    end
                    group.addSubject(subject);
                end
            end   
        end
    end
end
