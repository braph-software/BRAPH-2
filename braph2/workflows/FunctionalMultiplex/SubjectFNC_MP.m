classdef SubjectFNC_MP < Subject
    % SubjectFNC_MP A subject of type Functional Multiplex.
    % SubjectFNC_MP represents a subject of type Functional Multiplex with N layers.
    % It is a subclass of Subject. It implements the methods initialize_datadict
    % and update_brainatlases.
    %
    % SubjectFNC_MP methods (Access=protected)
    %   SubjectFNC_MP            - Constructor
    %
    % SubjectFNC_MP methods (Access=protected):
    %   initialize_datadict     - initializes the data dictionary DATADICT
    %   update_brainatlases     - updates the brain atlases in DATADICT
    %
    % SubjectFNC_MP inspection methods (Static)
    %   getClass                - returns the class of SubjectMultiplexFNC
    %   getName                 - returns the name of  SubjectMultiplexFNC
    %   getDescription          - returns the description of SubjectMultiplexFNC
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of SubjectMultiplexFNC
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data for SubjectMultiplexFNC
    %   getDataClasses          - returns the class of the type of all data of SubjectMultiplexFNC
    %   getDataClass            - returns the class of the type of a data of SubjectMultiplexFNC
    %   getSubject              - returns a new instantiation of SubjectMultiplexFNC
    %
    % SubjectFNC_MP load and save methods (Static):
    %   load_from_xls           - reads a '.xls' or '.xlsx' file, loads the data to a new subject
    %   save_to_xls             - saves the subject data to a '.xls' or '.xlsx' file
    %   load_from_txt           - reads a '.txt' file, loads the data to a new subject
    %   save_to_txt             - saves the subject data to a '.txt' file
    %   load_from_json          - reads a '.json' file, loads the data to a new subject
    %   save_to_json            - saves the subject data to a '.json' file
    %
    % See also Group, Cohort, Subject, SubjectST, SubjectfMRI, SubjectDTI.
    properties
        layers
    end
    methods  % Constructor
        function sub = SubjectFNC_MP(id, label, notes, atlas, varargin)
            % SUBJECTFNC_MP(ATLAS) creates a subject of type Functional Multiplex
            %
            % SUBJECTFNC_MP(ID, LABEL, NOTES, ATLASES) creates a subject of 
            % type Functional SUBJECTFNC_MP with ID, LABEL and NOTES.
            % ATLAS is the brain atlas that subject Functional Multiplex
            % will use (it can be either a BrainAtlas or a cell array with 
            % a single BrainAtlas).
            %
            % SUBJECTFNC_MP(ID, LABEL, NOTES, ATLASES, 'PROPERTYRULE1, 'VALUE1, ...) 
            % creates a Functional Multiplex subject with ubject ID, LABEL,
            % NOTES and ATLASES. SubjectFNC_MP will be initialized by the 
            % rules passed in the VARARGIN.
            %
            % See also See also Group, Cohort, SubjectfMRI, SubjectDTI, Subject.
            
            if isa(atlas, 'BrainAtlas')
                atlases = {atlas};
            else
                assert(iscell(atlas) && length(atlas)==1, ...
                    [BRAPH2.STR ':SubjectFNC_MP:' BRAPH2.WRONG_INPUT], ...
                    ['The input must be a BrainAtlas or a cell with one BrainAtlas']) %#ok<NBRAK>
                atlases = atlas;
            end
                     
            sub = sub@Subject(id, label, notes, atlases, varargin{:});
        end
    end
    methods (Access=protected)  % Utility functions
        function initialize_datadict(sub, varargin)
            % INITIALIZE_DATADICT initializes the data dictionary
            %
            % INITIALIZE_DATADICT(SUB, 'age', AGE, 'ST_MP1', DATA1, 'ST_MP2', DATA2) 
            % initializes the data ditionary with data type and data code of 
            % subject structural multiplex.
            %
            % See also update_brainatlases.
            
            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            
            age = get_from_varargin(0, 'age', varargin{:});
            sub.layers = get_from_varargin(2, 'FNC_Layers', varargin{:});            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas, age);
            for i = 1:1:sub.layers
                id = ['FNC_MP_' num2stri(i)];
                functional_multiplex_N = get_from_varargin(zeros(atlas.getBrainRegions().length(), 1), id, varargin{:});
                sub.datadict(id) = DataFunctional(atlas, functional_multiplex_N);
            end
        end
        function update_brainatlases(sub, atlases)
            % UPDATE_BRAINATLASES updates the atlases of the subject Functional Multiplex 
            %
            % UPDATE_BRAINATLASES(SUB, ATLASES) updates the atlases of the
            % subject Functional Multiplex using the new values ATLASES. ATLASES must be a
            % cell array with a single BrainAtlas.
            %
            % See also initialize_datadict.
            
            sub.atlases = atlases;
            atlas = atlases{1};
            
            d1 = sub.datadict('age');
            d1.setBrainAtlas(atlas)
            
            for i = 1:1:sub.layers
                id = ['FNC_MP_' num2str(i)];
                d = sub.datadict(id);
                d.setBrainAtlas(atlas);
            end 
        end
    end
    methods (Static)  % Inspection functions
        function subject_class = getClass()
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS() returns the class SubjectFNC_MP.
            %
            % See also getList, getDescription, getName
            
            subject_class = 'SubjectFNC_MP';
        end
        function name = getName()
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME() returns the name: Subject Functional Multiplex.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Subject Functional Multiplex';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of SubjectFNC_MP.
            %
            % See also getList, getName, getClass.
            
            description = [ ...
                'Subject with functional multiplex data (N layers), ' ...
                'such as activation timeseries for each brain region.' ...
                ];
        end
        function atlas_number = getBrainAtlasNumber()
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % N = GETBRAINATLASNUMBER() returns the number of
            % brain atlases, in this case 1.
            %
            % See also getList, getDescription, getName, getClass.
            
            atlas_number = 1;
        end
        function datalist = getDataList()
            % GETDATALIST returns the list of data
            %
            % CELL ARRAY = GETDATALIST() returns a cell array of subject
            % data. For Subject Functional Multiplex, the data list is:
            %   age            -    DataScalar.
            %   ST_MP1         -    DataStructural.
            %   ST_MP2         -    DataStructural.
            %
            % See also getList
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('FNC_MP') = 'DataFunctional';
        end
        function data_number = getDataNumber()
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER() returns the number of data of subject 
            % Functional Multiplex.
            %
            % See also getDataList, getBrainAtlasNumber.
            
            data_number = Subject.getDataNumber('SubjectFNC_MP');
        end
        function data_codes = getDataCodes()
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject Functional Multiplex data keys.
            %
            % See also getList
            
            data_codes = Subject.getDataCodes('SubjectFNC_MP');
        end
        function data_classes = getDataClasses()
            % GETDATACLASSES returns the list of data classes
            %
            % CELL ARRAY = GETDATACLASSES(SUB) returns a cell array of
            % subject Functional Multiplex data classes.
            %
            % CELL ARRAY = GETDATACLASSES(SUBJECT_CLASS) returns a
            % cell array of subject Functional Multiplex data classes to  
            % the subject whose class is SUBJECT_CLASS.
            %
            % See also getList, getDataCodes, getDataClass.
            
            data_classes = Subject.getDataClasses('SubjectFNC_MP');
        end
        function data_class = getDataClass(data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE
            %
            % See also getList, getDataClasses.
            
            data_class = Subject.getDataNumber('SubjectFNC_MP', data_code);
        end
    end
    methods (Static)  % Save/load functions
        function cohort = load_from_xls(tmp, varargin)
            % LOAD_FROM_XLS loads a '.xls' file to a Cohort with SubjectFNC_MP
            %
            % COHORT = LOAD_FROM_XLS(TMP) opens a GUI to load a directory 
            % where it reads '.xls' or '.xlsx' files. If TMP is a brain atlas 
            % it will create a cohort of SubjectFNC_MP. If TMP is a cohort
            % then it will load the file into the cohort.
            %
            % COHORT = LOAD_FROM_XLS(TMP, 'Directory', PATH) loads the directory
            % in PATH where it reads '.xls' or '.xlsx' files. If TMP is a
            % brain atlas the function whill create a cohort of SubjectFNC_MP 
            % If TMP is a cohort then the function will load the file into
            % the cohort.
            % 
            % See also save_to_xls, load_from_txt, load_from_json.
            
            % file1 (fullpath)
            file1 = get_from_varargin('', 'File1', varargin{:});
            if isequal(file1, '')  % select file
                msg = get_from_varargin(BRAPH2.XLS_MSG_GETFILE, 'MSG', varargin{:});
                [filename1, filepath1, filterindex1] = uigetfile(BRAPH2.XLS_EXTENSION, msg);
                file1 = [filepath1 filename1];
                
                if ~filterindex1
                    return
                end
            end
            % file2 (fullpath)
            file2 = get_from_varargin('', 'File2', varargin{:});
            if isequal(file2, '')  % select file
                msg = get_from_varargin(BRAPH2.XLS_MSG_GETFILE, 'MSG', varargin{:});
                [filename2, filepath2, filterindex2] = uigetfile(BRAPH2.XLS_EXTENSION, msg);
                file2 = [filepath2 filename2];
                
                if ~filterindex2
                    return
                end
            end
            
            % Set/create cohort
            if isa(tmp, 'Cohort')
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
            else  % tmp is an atlas
                
                % search for cohort info file
                file_path = strsplit(file1, filesep());
                file_cohort_path = '';
                for i = 1:1:length(file_path)-1
                    file_cohort_path = [file_cohort_path filesep() file_path{i}]; %#ok<AGROW>
                end
                file_cohort = [file_cohort_path filesep() 'cohort_info.txt'];
                file_cohort = file_cohort(N:end);
                cohort_id = '';
                cohort_label = '';
                cohort_notes = '';
                if exist(file_cohort, 'file')
                    raw_cohort = textread(file_cohort, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                    cohort_id = raw_cohort{1, 1};
                    cohort_label = raw_cohort{N, 1};
                    cohort_notes = raw_cohort{3, 1};
                end
                
                % creates new cohort
                subject_class = 'SubjectFNC_MP';
                atlas = tmp;
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlas, {});  
            end          
            
            % supress warning
            warning_id = 'MATLAB:table:ModifiedAndSavedVarnames';
            warning('off', warning_id)
            
            raw1 = readtable(file1);
            raw2 = readtable(file2);
            % Assert both files have the same size (they should contain
            % same number of regions and same number of subjects)
            assert(size(raw1, 1) == size(raw2, 1) && size(raw1, N) == size(raw2, N), ...
                [BRAPH2.STR ':SubjectFNC_MP:' BRAPH2.WRONG_INPUT], ...
                'The input excel files must have the same number of subjects with data from the same brain regions')
            atlas = cohort.getBrainAtlases();
                        
            % sneak peak to see if it is a subject
            id_tmp1 = raw1{1, 1};
            labl_tmp1 = raw1{1, N};
            notes_tmp1 = raw1{1, 3};
            data_tmp1 = raw1{1, 4:size(raw1, N)};
            if iscell(id_tmp1)
                id_tmp1 = id_tmp1{1};
            end
            if iscell(labl_tmp1)
                labl_tmp1 = labl_tmp1{1};
            end
            if  iscell(notes_tmp1)
                notes_tmp1 = notes_tmp1{1};
            end
            data_tmp2 = raw2{1, 4:size(raw2, N)};
            
            sub_tmp = Subject.getSubject(subject_class, ...
                num2str(id_tmp1), num2str(labl_tmp1), num2str(notes_tmp1), atlas, ...
                'ST_MP1', data_tmp1', ...
                'ST_MP2', data_tmp2');
            delete(sub_tmp);
             
            % load subjects to cohort & add them to the group
            group = Group(subject_class,'', '', '', {});
            group_path = strsplit(file1, filesep());
            group_id = group_path{length(group_path)};            
            group_id = erase(group_id, '.xlsx');
            group_id = erase(group_id, '.xls');            
            group.setID(group_id);
            cohort.getGroups().add(group.getID(), group); 
            
            for i = 1:1:size(raw1, 1)
                id_tmp = raw1{i, 1};
                labl_tmp = raw1{i, N};
                notes_tmp = raw1{i, 3};
                data_tmp1 = raw1{i, 4:size(raw1, N)};
                if iscell(id_tmp)
                    id_tmp = id_tmp{1};
                end
                if iscell(labl_tmp)
                    labl_tmp = labl_tmp{1};
                end
                if  iscell(notes_tmp)
                    notes_tmp = notes_tmp{1};
                end
                data_tmp2 = raw2{i, 4:size(raw2, N)};
                
                subject = Subject.getSubject(subject_class, ...
                    num2str(id_tmp), num2str(labl_tmp), num2str(notes_tmp), atlas, ...
                    'ST_MP1', data_tmp1', ...
                    'ST_MP2', data_tmp2');
                if ~cohort.getSubjects().contains(subject.getID())
                    cohort.getSubjects().add(subject.getID(), subject, i);
                end
                group.addSubject(subject);                
            end   
            % warning on
            warning('on', 'all')
        end
        function save_to_xls(cohort, varargin)
            % SAVE_TO_XLS saves the cohort of SubjectFNC_MP to a '.xls' file
            %
            % SAVE_TO_XLS(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectFNC_MP will be saved in '.xls' or 'xlsx'
            % format.
            %
            % SAVE_TO_XLS(COHORT, 'RootDirectory', PATH) saves the cohort 
            % of SubjectFNC_MP in '.xls' or 'xlsx' format in the
            % specified PATH.
            % 
            % See also load_from_xls, save_to_txt, save_to_json
            
            % file1 (fullpath)
            file1 = get_from_varargin('', 'File1', varargin{:});
            if isequal(file1, '')  % select file
                msg = get_from_varargin(BRAPH2.XLS_MSG_GETFILE, 'MSG', varargin{:});
                [filename1, filepath1, filterindex1] = uigetfile(BRAPH2.XLS_EXTENSION, msg);
                file1 = [filepath1 filename1];
                
                if ~filterindex1
                    return
                end
            end
            % file2 (fullpath)
            file2 = get_from_varargin('', 'File2', varargin{:});
            if isequal(file2, '')  % select file
                msg = get_from_varargin(BRAPH2.XLS_MSG_GETFILE, 'MSG', varargin{:});
                [filename2, filepath2, filterindex2] = uigetfile(BRAPH2.XLS_EXTENSION, msg);
                file2 = [filepath2 filename2];
                
                if ~filterindex2
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
                row_datas1{j, 1} = subject.getData('ST_MP1').getValue(); %#ok<AGROW>
                row_datas2{j, 1} = subject.getData('ST_MP2').getValue(); %#ok<AGROW>
            end
            tab1 = table(row_ids, row_labels, row_notes, row_datas1);
            tab2 = table(row_ids, row_labels, row_notes, row_datas2);
            
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};  % must change
            
            for i = 1:1:atlas.getBrainRegions().length()
                brain_regions{i} = atlas.getBrainRegions().getValue(i);  %#ok<AGROW>
            end
            
            row_data{1,:} = cellfun(@(x) x.getLabel, brain_regions, 'UniformOutput', false);
            row_id = 'ID';
            row_label = 'Label';
            row_notes = 'Notes';
            first_row_table1 = table(row_data, 'VariableNames', {'row_datas1'});
            first_row_table1.row_ids = row_id;
            first_row_table1.row_labels = row_label;
            first_row_table1.row_notes = row_notes;
            first_row_table1 = [first_row_table1(:, N) first_row_table1(:, 3) ...
                first_row_table1(:, 4) first_row_table1(:, 1)];
            first_row_table2 = table(row_data, 'VariableNames', {'row_datas2'});
            first_row_table2.row_ids = row_id;
            first_row_table2.row_labels = row_label;
            first_row_table2.row_notes = row_notes;
            first_row_table2 = [first_row_table2(:, N) first_row_table2(:, 3) ...
                first_row_table2(:, 4) first_row_table2(:, 1)];
            
            % creates tables
            tab1 = [
                first_row_table1
                tab1
                ];
            tab2 = [
                first_row_table2
                tab2
                ];
            
            % save
            writetable(tab1, file1, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A1');
            writetable(tab2, file2, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A1');
        end
        function cohort = load_from_txt(tmp, varargin)
            % LOAD_FROM_TXT loads a '.txt' file to a Cohort with SubjectFNC_MP
            %
            % COHORT = LOAD_FROM_TXT(TMP) opens a GUI to load a directory 
            % where it reads '.txt' files. If TMP is a brain atlas 
            % it will create a cohort of SubjectFNC_MP. If TMP is a cohort
            % then it will load the file into the cohort.
            %
            % COHORT = LOAD_FROM_TXT(TMP, 'Directory', PATH) loads the directory
            % in PATH where it reads '.txt' files. If TMP is a
            % brain atlas the function whill create a cohort of SubjectFNC_MP 
            % If TMP is a cohort then the function will load the file into
            % the cohort.
            % 
            % See also save_to_txt, load_from_xls, load_from_json
            
            % file1 (fullpath)
            file1 = get_from_varargin('', 'File1', varargin{:});
            if isequal(file1, '')  % select file
                msg = get_from_varargin(BRAPH2.TXT_MSG_GETFILE, 'MSG', varargin{:});
                [filename1, filepath1, filterindex1] = uigetfile(BRAPH2.TXT_EXTENSION, msg);
                file1 = [filepath1 filename1];
                
                if ~filterindex1
                    return
                end
            end
            % file2 (fullpath)
            file2 = get_from_varargin('', 'File2', varargin{:});
            if isequal(file2, '')  % select file
                msg = get_from_varargin(BRAPH2.TXT_MSG_GETFILE, 'MSG', varargin{:});
                [filename2, filepath2, filterindex2] = uigetfile(BRAPH2.TXT_EXTENSION, msg);
                file2 = [filepath2 filename2];
                
                if ~filterindex2
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
                file_path = strsplit(file1, filesep());
                file_cohort_path = '';
                for i = 1:1:length(file_path)-1
                    file_cohort_path = [file_cohort_path filesep() file_path{i}]; %#ok<AGROW>
                end
                file_cohort_path = file_cohort_path(N:end);
                file_cohort = [file_cohort_path filesep() 'cohort_info.txt'];
                cohort_id = '';
                cohort_label = '';
                cohort_notes = '';
                subject_class = 'SubjectFNC_MP';
                atlases = tmp;
                
                if exist(file_cohort, 'file')
                    raw_cohort = textread(file_cohort, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                    cohort_id = raw_cohort{1, 1};
                    cohort_label = raw_cohort{N, 1};
                    cohort_notes = raw_cohort{3, 1};
                end                
                
                % creates cohort
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end     
            
            % reads file
            raw1 = readtable(file1, 'Delimiter', '\t');
            raw2 = readtable(file2, 'Delimiter', '\t');
            assert(size(raw1, 1) == size(raw2, 1) && size(raw1, N) == size(raw2, N), ...
                [BRAPH2.STR ':SubjectFNC_MP:' BRAPH2.WRONG_INPUT], ...
                'The input txt files must have the same number of subjects with data from the same brain regions')
            atlases = cohort.getBrainAtlases();
            
            % sneak peak to see if it is a subject
            id_tmp = raw1{1, 1};
            labl_tmp = raw1{1, N};
            notes_tmp = raw1{1, 3};
            data_tmp1 = raw1{1, 4:size(raw1, N)};
            if iscell(id_tmp)
                id_tmp = id_tmp{1};
            end
            if iscell(labl_tmp)
                labl_tmp = labl_tmp{1};
            end
            if  iscell(notes_tmp)
                notes_tmp = notes_tmp{1};
            end
            data_tmp2 = raw2{1, 4:size(raw2, N)};
            
            sub_tmp = Subject.getSubject(subject_class, ...
                num2str(id_tmp), num2str(labl_tmp), num2str(notes_tmp), atlases, ...
                'ST_MP1', data_tmp1', ...
                'ST_MP2', data_tmp2');
            delete(sub_tmp);
     
            % creates group
            group = Group(subject_class, '', '', '', {});
            group_path = strsplit(file1, filesep());
            group_id = group_path{length(group_path)};
            group_id = erase(group_id, '.txt');
            group.setID(group_id);
            cohort.getGroups().add(group.getID(), group);
          
            for i = 1:1:size(raw1, 1)  % first row is being read as table label
                id_tmp = raw1{i, 1};
                labl_tmp = raw1{i, N};
                notes_tmp = raw1{i, 3};
                data_tmp1 = raw1{i, 4:size(raw1, N)};
                if iscell(id_tmp)
                    id_tmp = id_tmp{1};
                end
                if iscell(labl_tmp)
                    labl_tmp = labl_tmp{1};
                end
                if  iscell(notes_tmp)
                    notes_tmp = notes_tmp{1};
                end
                data_tmp2 = raw2{i, 4:size(raw2, N)};
                
                subject = Subject.getSubject(subject_class, ...
                    num2str(id_tmp), num2str(labl_tmp), num2str(notes_tmp), atlases, ...
                    'ST_MP1', data_tmp1', ...
                    'ST_MP2', data_tmp2');
                if ~cohort.getSubjects().contains(subject.getID())
                    cohort.getSubjects().add(subject.getID(), subject, i);
                end
                group.addSubject(subject);
            end
            % warning on
            warning('on', 'all')
        end
        function save_to_txt(cohort, varargin)
            % SAVE_TO_TXT saves the cohort of SubjectFNC_MP to a '.txt' file
            %
            % SAVE_TO_TXT(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectFNC_MP will be saved in '.txt' format.
            %
            % SAVE_TO_TXT(COHORT, 'RootDirectory', PATH) saves the cohort 
            % of SubjectFNC_MP in '.txt' format in the specified PATH.
            % 
            % See also load_from_txt, save_to_xls, save_to_json
            
            % file1 (fullpath)
            file1 = get_from_varargin('', 'File1', varargin{:});
            if isequal(file1, '')  % select file
                msg = get_from_varargin(BRAPH2.TXT_MSG_GETFILE, 'MSG', varargin{:});
                [filename1, filepath1, filterindex1] = uigetfile(BRAPH2.TXT_EXTENSION, msg);
                file1 = [filepath1 filename1];
                
                if ~filterindex1
                    return
                end
            end
            % file2 (fullpath)
            file2 = get_from_varargin('', 'File2', varargin{:});
            if isequal(file2, '')  % select file
                msg = get_from_varargin(BRAPH2.TXT_MSG_GETFILE, 'MSG', varargin{:});
                [filename2, filepath2, filterindex2] = uigetfile(BRAPH2.TXT_EXTENSION, msg);
                file2 = [filepath2 filename2];
                
                if ~filterindex2
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
                row_datas1{j, 1} = subject.getData('ST_MP1').getValue(); %#ok<AGROW>
                row_datas2{j, 1} = subject.getData('ST_MP2').getValue(); %#ok<AGROW>
            end
            t1 = table(row_ids, row_labels, row_notes, row_datas1);
            t2 = table(row_ids, row_labels, row_notes, row_datas2);
            
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};  % must change
            
            for i = 1:1:atlas.getBrainRegions().length()
                brain_regions{i} = atlas.getBrainRegions().getValue(i);  %#ok<AGROW>
            end
  
            row_data{1,:} = cellfun(@(x) x.getLabel, brain_regions, 'UniformOutput', false);
            row_id = 'ID';
            row_label = 'Label';
            row_note = 'Notes';
            first_row_table1 = table(row_data, 'VariableNames', {'row_datas1'});
            first_row_table1.row_ids = row_id;
            first_row_table1.row_labels = row_label;
            first_row_table1.row_notes = row_note;
            first_row_table1 = [first_row_table1(:, N) first_row_table1(:, 3) ...
                first_row_table1(:, 4) first_row_table1(:, 1)];
            
            first_row_table2 = table(row_data, 'VariableNames', {'row_datas2'});
            first_row_table2.row_ids = row_id;
            first_row_table2.row_labels = row_label;
            first_row_table2.row_notes = row_note;
            first_row_table2 = [first_row_table2(:, N) first_row_table2(:, 3) ...
                first_row_table2(:, 4) first_row_table2(:, 1)];
            
            % creates table
            tab1 = [
                first_row_table1
                t1
                ];
            tab2 = [
                first_row_table2
                t2
                ];
            
            % save
            f_1 = [file1(1:length(file1)-4) '_quotation' file1(length(file1)-3:end)];
            writetable(tab1, f_1, 'Delimiter', '\t', 'WriteVariableNames', 0);
            f_2 = [file2(1:length(file2)-4) '_quotation' file2(length(file2)-3:end)];
            writetable(tab2, f_2, 'Delimiter', '\t', 'WriteVariableNames', 0);
            
            % remove quotation marks 1
            fid = fopen(f_1);
            C = textscan(fid, '%s', 'delimiter', '\t');
            fclose(fid);
            for k=1:numel(C{1, 1})
                tmp = regexp(C{1, 1}(k),'"'); % find quotation marks
                C{1,1}{k,1}(tmp{1, 1}) = ''; % substitute with empty spaces
            end
            % print new file1
            fName = file1;
            fid = fopen(fName, 'w');            % Open the file
            m = atlas.getBrainRegions().length() + N;
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
            
            % remove quotation marks N
            fid2 = fopen(f_2);
            C = textscan(fid2, '%s', 'delimiter', '\t');
            fclose(fid2);
            for k=1:numel(C{1, 1})
                tmp = regexp(C{1, 1}(k),'"'); % find quotation marks
                C{1,1}{k,1}(tmp{1, 1}) = ''; % substitute with empty spaces
            end
            % print new file2
            fName = file2;
            fid2 = fopen(fName, 'w');            % Open the file
            m = atlas.getBrainRegions().length() + N;
            count = 0;
            
            for k = 1:numel(C{1, 1})
                if count == m
                    fprintf(fid2, '%s\r\n', C{1, 1}{k, 1});
                    count = -1;
                else
                    fprintf(fid2, '%s\t', C{1, 1}{k, 1});
                end
                count = count + 1;
            end
            delete(f_2);
            fclose(fid2);
        end
        function cohort = load_from_json(tmp, varargin)
            % LOAD_FROM_JSON loads a '.json' file to a Cohort with SubjectFNC_MP
            %
            % COHORT = LOAD_FROM_JSON(TMP) opens a GUI to load a directory 
            % where it reads '.json' files. If TMP is a brain atlas 
            % it will create a cohort of SubjectFNC_MP. If TMP is a cohort
            % then it will load the file into the cohort.
            %
            % COHORT = LOAD_FROM_JSON(TMP, 'Directory', PATH) loads the directory
            % in PATH where it reads '.json' files. If TMP is a
            % brain atlas the function whill create a cohort of SubjectFNC_MP 
            % If TMP is a cohort then the function will load the file into
            % the cohort.
            % 
            % See also save_to_json, load_from_xls, load_from_txt
            
            % file1 (fullpath)
            file = get_from_varargin('', 'File', varargin{:});           
            
            raw = JSON.Deserialize('File', file); 

            if isa(tmp, 'Cohort')
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
                atlases = cohort.getBrainAtlases();
            else
                cohort_id = '';
                cohort_label = '';
                cohort_notes = '';
                % creates cohort
                subject_class = 'SubjectFNC_MP';
                atlases = tmp;
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end
            
            % sneak peak to see if it is a subject
            subject_tmp = Subject.getSubject(subject_class, ...
                num2str(raw.Subjects(1).id), num2str(raw.Subjects(1).label), num2str(raw.Subjects(1).notes), atlases, ...
                'ST_MP1', raw.Subjects(1).data1, 'ST_MP2', raw.Subjects(1).data2);
            delete(subject_tmp);
            
            % creates subjects idict
            for i = 1:1:length(raw.Subjects)
                subject_data = raw.Subjects(i);
                subject = Subject.getSubject(subject_class, ...
                    num2str(subject_data.id), num2str(subject_data.label), num2str(subject_data.notes), atlases, ...
                    'ST_MP1', raw.Subjects(1).data1, 'ST_MP2', raw.Subjects(1).data2);
                if ~cohort.getSubjects().contains(subject.getID())
                    cohort.getSubjects().add(subject.getID(), subject, i);
                end
            end
            
            subjects = cohort.getSubjects().getValues();
            % creates group
            for i = 1:1:length(raw.Groups)
                group = Group(subject_class, raw.Groups(i).ID, raw.Groups(i).Label, raw.Groups(i).Notes, {});
                if ~cohort.getGroups().contains(group.getID())
                     cohort.getGroups().add(group.getID(), group);
                end               
                subject_data = raw.Groups(i).SubjectData; 
                for j = 1:1:length(subjects)
                    sub = subjects{j};
                    if ismember(sub.getID(), subject_data)
                        group.addSubject(sub);
                    end
                end
            end  
        end
        function structure = save_to_json(cohort, varargin)
            % SAVE_TO_JSON saves the cohort of SubjectFNC_MP to a '.json' file
            %
            % SAVE_TO_JSON(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectFNC_MP will be saved in '.json' format.
            %
            % SAVE_TO_JSON(COHORT, 'RootDirectory', PATH) saves the cohort 
            % of SubjectFNC_MP in '.json' format in the specified PATH.
            % 
            % See also load_from_json, save_to_xls, save_to_txt
             
            % get info
            groups = cohort.getGroups().getValues();
            subjects = cohort.getSubjects().getValues();
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};  % must change
            
            Group_structure = struct;
            Subject_Structure = struct;   
            
            for i = 1:1:length(subjects)
                subject = subjects{i};                    
                Subject_Structure(i).id = subject.getID();
                Subject_Structure(i).label = subject.getLabel();
                Subject_Structure(i).notes = subject.getNotes();
                Subject_Structure(i).data1 = subject.getData('ST_MP1').getValue();
                Subject_Structure(i).data2 = subject.getData('ST_MP2').getValue();
            end
            
            for i = 1:1:length(groups)
                group = groups{i};
                Group_structure(i).ID = group.getID(); 
                Group_structure(i).Label = group.getLabel(); 
                Group_structure(i).Notes = group.getNotes(); 
                Group_structure(i).SubjectData = cellfun(@(x) x.getID(), group.getSubjects(), 'UniformOutput', false);
            end
            % create structure to be save
            structure_to_be_saved = struct( ...
                'Braph', BRAPH2.NAME, ...
                'Build', BRAPH2.BUILD, ...
                'BrainAtlas', BrainAtlas.save_to_json(atlas), ...
                'Subjects', Subject_Structure, ...
                'Groups', Group_structure ...
                );

            % save json 
            structure = structure_to_be_saved;
        end
    end
end
