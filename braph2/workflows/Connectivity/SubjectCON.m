classdef SubjectCON < Subject
    % SubjectCON A subject of type CON
    % SubjectCON represents a subject of type CON.
    % It is a subclass of Subject. It implements the methods initialize_datadict
    % and update_brainatlases.
    %
    % SubjectCON methods (Access = protected):
    %   SubjectCON              - Constructor
    %
    % SubjectCON methods (Access=protected):
    %   initialize_datadict     - initializes the data dictionary DATADICT
    %   update_brainatlases     - updates the brain atlases in DATADICT
    %
    % SubjectCON inspection methods (Static)
    %   getClass                - returns the class of SubjectCON
    %   getName                 - returns the name of  SubjectCON
    %   getDescription          - returns the description of SubjectCON
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of SubjectCON
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data for SubjectCON
    %   getDataClasses          - returns the class of the type of all data of SubjectCON
    %   getDataClass            - returns the class of the type of a data of SubjectCON
    %   getSubject              - returns a new instantiation of SubjectCON
    %
    % Subject load and save methods (Static):
    %   load_from_xls           - reads a '.xls' or '.xlsx' file, loads the data to a new subject
    %   save_to_xls             - saves the subject data to a '.xls' or '.xlsx' file
    %   load_from_txt           - reads a '.txt' file, loads the data to a new subject
    %   save_to_txt             - saves the subject data to a '.txt' file
    %   load_from_json          - reads a '.json' file, loads the data to a new subject
    %   save_to_json            - saves the subject data to a '.json' file
    %
    % See also Group, Cohort, SubjectMRI, SubjectfMRI, Subject.
    properties
        datalist
    end
    methods
        function sub = SubjectCON(id, label, notes, atlas, varargin)
            % SUBJECTCON creates a subject of type CON
            %
            % SUBJECTCON(ID, LABEL, NOTES, ATLASES) creates a subject of type CON
            % with ID, LABEL, NOTES. ATLAS is the brain atlas that
            % subject CON will use (it can be either a BrainAtlas or a
            % cell array with a single BrainAtlas).
            %
            % SUBJECTCON(ID, LABEL, NOTES, ATLASES, 'PROPERTYRULE1, 'VALUE1, ...)
            % creates a CON subject with ID, LABEL NOTES and ATLASES.
            % SubjectCON will be initialized by the rules passed in the
            % VARARGIN.
            %
            % See also See also Group, Cohort, SubjectMRI, SubjectfMRI, Subject.
            
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
    methods (Access=protected)  % Utility functions
        function initialize_datadict(sub, varargin)
            % INITIALIZE_DATADICT initializes the data dictionary
            %
            % INITIALIZE_DATADICT(SUB, 'age', AGE, 'CON', CON) initializes the data
            % ditionary with data type and data code of subject CON.
            %
            % See also update_brainatlases.
            
            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            
            age = get_from_varargin(0, 'age', varargin{:});
            CON = get_from_varargin(zeros(atlas.getBrainRegions().length(), atlas.getBrainRegions().length()), 'CON', varargin{:});
            gender = get_from_varargin('other', 'gender', varargin{:});
            education = get_from_varargin('other', 'education', varargin{:});
            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas, age);
            sub.datadict('CON') = DataConnectivity(atlas, CON);
            sub.datadict('gender') = DataGender(atlas, gender);
            sub.datadict('education') = DataEducation(atlas, education);
            
            init_internal_datalist(sub);
        end
        function update_brainatlases(sub, atlases)
            % UPDATE_BRAINATLASES updates the atlases of the subject CON
            %
            % UPDATE_BRAINATLASES(SUB, ATLASES) updates the atlases of the
            % subject CON using the new values ATLASES. ATLASES must be a
            % cell array with a single BrainAtlas.
            %
            % See also initialize_datadict.
            
            sub.atlases = atlases;
            atlas = atlases{1};
            
            d1 = sub.datadict('age');
            d1.setBrainAtlas(atlas)
            
            d2 = sub.datadict('CON');
            d2.setBrainAtlas(atlas);
        end
        function init_internal_datalist(sub)
            sub.datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            sub.datalist('age') = 'DataScalar';
            sub.datalist('CON') = 'DataConnectivity';
            sub.datalist('gender') = 'DataGender';
            sub.datalist('education') = 'DataEducation'; 
        end 
    end
    methods
        function add_data_to_datadict(sub, info)  % data, titulo, info
            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            data_structure = Data.getDataStructure(info{1});
            if isequal(data_structure, 'char')
            elseif isequal(data_structure, 'numeric')
                info{3} = str2double(info{3});
            else
                info{3} = [];
            end
            sub.datalist(info{2}) = info{1};
            sub.datadict(info{2}) = Data.getData(info{1}, atlas, info{3});
        end
        function delete_data_from_datadict(sub, info)
            if ismember(info, keys(sub.datalist))
                remove(sub.datalist, info)
            end            
        end
        function datalist = get_internal_datalist(sub)
            datalist = sub.datalist;
        end
        function datacodes = get_internal_datacodes(sub)
            datalist = sub.get_internal_datalist(); %#ok<PROP>
            datacodes = keys(datalist); %#ok<PROP>
        end
    end
    methods (Static)  % Inspection functions
        function subject_class = getClass()
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS() returns the class SubjectCON
            %
            % See also getDescription, getName.
            
            subject_class = 'SubjectCON';
        end
        function name = getName()
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME() returns the name: Subject CON.
            %
            % See also getClass, getDescription.
            
            name = 'Subject Connectivity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of SubjectCON
            %
            % See also getName, getClass, getBrainAtlasNumber.
            
            description = [ ...
                'Subject with CON connectivity matrix, ' ...
                'such as activation timeseries for each brain region' ...
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
            % subject data. For Subject CON, the data list is:
            %   age             -    DataScalar.
            %   CON             -    DataConnectivity.
            %
            % See also getList
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('CON') = 'DataConnectivity';
            datalist('gender') = 'DataGender';
            datalist('education') = 'DataEducation'; 
        end
        function data_number = getDataNumber()
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER() returns the number of data.
            %
            % See also getDataList, getBrainAtlasNumber.
            
            data_number = Subject.getDataNumber('SubjectCON');
        end
        function data_codes = getDataCodes()
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject CON data keys.
            %
            % See also getList, getDataClasses, getDataNumber
            
            data_codes = Subject.getDataCodes('SubjectCON');
        end
        function data_classes = getDataClasses()
            % GETDATACLASSES returns the list of data classes
            %
            % CELL ARRAY = GETDATACLASSES(SUB) returns a cell array of
            % subject CON data classes.
            %
            % CELL ARRAY = GETDATACLASSES(SUBJECT_CLASS) returns a
            % cell array of subject CON data classes to the subject whose class is
            % SUBJECT_CLASS.
            %
            % See also getList, getDataCodes, getDataClass.
            
            data_classes = Subject.getDataClasses('SubjectCON');
        end
        function data_class = getDataClass(data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE
            %
            % See also getList, getDataClasses.
            
            data_class = Subject.getDataNumber('SubjectCON', data_code);
        end
    end
    methods (Static)  % Save/load functions
        function cohort = load_from_xls(tmp, varargin)
            % LOAD_FROM_XLS loads '.xls' files to a Cohort with SubjectCON
            %
            % COHORT = LOAD_FROM_XLS(SUBJECT_CLASS, ATLASES) opens a GUI to
            % load a directory where it reads '.xls' or '.xlsx' files. It
            % creates a cohort of SubjectCON with brain atlas ATLASES.
            %
            % COHORT = LOAD_FROM_XLS(SUBJECT_CLASS, ATLASES, 'Directory', PATH)
            % loads the directory in PATH where it reads '.xls' or '.xlsx'
            % files. It creates a cohort of SubjectCON with brain atlas ATLASES.
            %
            % See also save_to_xls, load_from_txt, load_from_json
            
            % directory
            directory = get_from_varargin('', 'Directory', varargin{:});
            if isequal(directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_GETDIR, 'MSG', varargin{:});
                directory = uigetdir(msg);
            end
            
            % find all subfolders
            sub_folders = dir(directory);
            sub_folders = sub_folders([sub_folders(:).isdir] == 1);
            sub_folders = sub_folders(~ismember({sub_folders(:).name}, {'.', '..'}));
            
            if isa(tmp, 'Cohort')
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
            else
                % cohort information
                file_cohort = [directory filesep() 'cohort_info.txt'];
                cohort_id = '';
                cohort_label = '';
                cohort_notes = '';
                
                if exist(file_cohort, 'file')
                    raw_cohort = textread(file_cohort, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                    cohort_id = raw_cohort{1, 1};
                    cohort_label = raw_cohort{2, 1};
                    cohort_notes = raw_cohort{3, 1};
                end
                
                % creates cohor
                atlases = tmp;
                subject_class = 'SubjectCON';
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end
            
            
            % find all xls or xlsx files per sub folder
            for j = 1:1: length(sub_folders)
                path = [directory filesep() sub_folders(j).name];
                files = dir(fullfile(path, '*.xlsx'));
                files2 = dir(fullfile(path, '*.xls'));
                len = length(files);
                for i = 1:1:length(files2)
                    files(len + i, 1) = files2(i, 1);
                end
                
                % load subjects
                for i = 1:1:length(files)
                    % read file
                    [num, ~, raw] = xlsread(fullfile(path, files(i).name));
                    atlases = cohort.getBrainAtlases();
                    % get age
                    
                    % create subject
                    sub_id = erase(files(i).name, '.xlsx');
                    sub_id = erase(sub_id, '.xls');
                    subject = Subject.getSubject(subject_class, ...
                        sub_id, char(raw{1, 1}), char(raw{2, 1}), atlases, ...                     
                        'CON', num);
                    
                    cohort.getSubjects().add(subject.getID(), subject);
                    subjects{i} = subject; %#ok<AGROW>
                end
                
                % creates a group per subfolder
                group = Group(subject_class, ['Group_' num2str(j)], '', '', subjects);
                cohort.getGroups().add(group.getID(), group, j);
            end
        end
        function save_to_xls(cohort, varargin)
            % SAVE_TO_XLS saves the cohort of SubjectsCON to '.xls' files
            %
            % SAVE_TO_XLS(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectCON will be saved in '.xls' or 'xlsx'
            % format.
            %
            % SAVE_TO_XLS(COHORT, 'RootDirectory', PATH) saves the cohort
            % of SubjectCON in '.xls' or 'xlsx' format in the
            % specified PATH.
            %
            % See also load_from_xls, save_to_txt, save_to_json
            
            % get Root Directory
            root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);
                
            end
            
            % save cohort info
            
            % creates groups folders
            for i=1:1:cohort.getGroups().length()
                if ~exist([root_directory filesep() cohort.getGroups().getValue(i).getID()], 'dir')
                    mkdir(root_directory, cohort.getGroups().getValue(i).getID());
                end
                
                % group info
                group = cohort.getGroups().getValue(i);
                
                % get subject info
                subjects_list = group.getSubjects();
                for j = 1:1:group.subjectnumber()
                    % get subject data
                    subject = subjects_list{j};
                    id = subject.getID();
                    label = subject.getLabel(); %#ok<NASGU>
                    notes = subject.getNotes(); %#ok<NASGU>
                    data = subject.getData('CON');
                    
                    % create table
                    tab = table(data.getValue());
                    
                    % save
                    file = [root_directory filesep() cohort.getGroups().getValue(i).getID() filesep() id '.xlsx'];
                    %                     writematrix(string(label), file, 'Sheet', 1, 'Range', 'A1');
                    %                     writematrix(string(notes), file, 'Sheet', 1, 'Range', 'A2');
                    writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A1');
                end
            end
        end
        function cohort = load_from_txt(tmp, varargin)
            % LOAD_FROM_TXT loads a '.txt' file to a Cohort with SubjectCON
            %
            % COHORT = LOAD_FROM_TXT(SUBJECT_CLASS, ATLASES) opens a GUI to
            % load a directory where it reads '.txt' files. It
            % creates a cohort of SubjectCON with brain atlas ATLASES.
            %
            % COHORT = LOAD_FROM_TXT(SUBJECT_CLASS, ATLASES, 'Directory', PATH)
            % loads the directory in PATH where it reads '.txt' files.
            % It creates a cohort of SubjectCON with brain atlas ATLASES.
            %
            % See also save_to_txt, load_from_xls, load_from_json
            
            % directory
            directory = get_from_varargin('', 'Directory', varargin{:});
            if isequal(directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_GETDIR, 'MSG', varargin{:});
                directory = uigetdir(msg);
            end
            
            % find all txt files
            files = dir(fullfile(directory, '*.txt'));
            
            % cohort information
            if isa(tmp, 'Cohort')
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
                atlases = cohort.getBrainAtlases();
                atlases = atlases{1};
            else
                cohort_folder = '';
                parts = strsplit(directory, filesep());
                for k = 1:1:length(parts)-1
                    cohort_folder = [cohort_folder filesep() parts{k}]; %#ok<AGROW>
                end
                cohort_folder =cohort_folder(2:end);
                file_cohort = [cohort_folder filesep() 'cohort_info.txt'];
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
                atlases = tmp;
                subject_class = 'SubjectCON';
                % creates cohort
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end
            
            
            % load subjects
            for i = 1:1:length(files)
                
                if isequal(files(i).name, 'group_info.txt')
                    continue;
                end
                % read file
                raw = textread(fullfile(directory, files(i).name), '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                
                raw = raw(~cellfun('isempty', raw));  % remove empty cells
                
                % create subject
                sub_id = erase(files(i).name, '.txt');
                label = raw{1, 1};
                notes = raw{2, 1};
                B = raw(1:end, 1);
                B = reshape(B, [atlases.getBrainRegions().length() atlases.getBrainRegions().length()]);
                B = B';
                C = cellfun(@(x) str2double(x), B);
                
                subject = Subject.getSubject(subject_class, ...
                    sub_id, char(label), char(notes), atlases, ...
                    'CON', C);
                
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            
            % creates group
            if i == length(files)
                [~, groupname] = fileparts(directory);
                group = Group(subject_class, groupname, '', '',  cohort.getSubjects().getValues());
                cohort.getGroups().add(group.getID(), group);
            end
        end
        function save_to_txt(cohort, varargin)
            % SAVE_TO_TXT saves the cohort of SubjectsCON to '.json' files
            %
            % SAVE_TO_TXT(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectCON will be saved in '.txt' format.
            %
            % SAVE_TO_TXT(COHORT, 'RootDirectory', PATH) saves the cohort
            % of SubjectCON in '.txt' format in the specified PATH.
            %
            % See also load_from_txt, save_to_xls, save_to_json
            
            % get Root Directory
            root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);
                
            end
            
            % creates groups folders
            for i=1:1:cohort.getGroups().length()
                mkdir(root_directory, cohort.getGroups().getValue(i).getID());
                
                % get info
                group = cohort.getGroups().getValue(i);
                subjects_list = group.getSubjects();
                for j = 1:1:group.subjectnumber()
                    % get subject data
                    subject = subjects_list{j};
                    id = subject.getID();
                    data = subject.getData('CON').getValue();
                    
                    % create table
                    tab = num2cell(data);
                    
                    % save
                    file = [root_directory filesep() cohort.getGroups().getValue(i).getID() filesep() id '.txt'];
                    writetable(cell2table(tab), file, 'Delimiter', '\t', 'WriteVariableNames', 0);
                end
            end
        end
        function cohort = load_from_json(tmp, varargin)
            % LOAD_FROM_JSON loads a '.json' file to a Cohort with SubjectCON
            %
            % COHORT = LOAD_FROM_JSON(SUBJECT_CLASS, ATLASES) opens a GUI to
            % load a directory where it reads '.json' files. It
            % creates a cohort of SubjectCON with brain atlas ATLASES.
            %
            % COHORT = LOAD_FROM_JSON(SUBJECT_CLASS, ATLASES, 'Directory', PATH)
            % loads the directory in PATH where it reads '.json' files.
            % It creates a cohort of SubjectCON with brain atlas ATLASES.
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
                subject_class = 'SubjectCON';
                atlases = tmp;
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end
            
            % sneak peak
             subject_tmp = Subject.getSubject(subject_class, ...
                num2str(raw.Subjects(1).id), num2str(raw.Subjects(1).label), num2str(raw.Subjects(1).notes), atlases, ...
                'CON', raw.Subjects(1).data);
            delete(subject_tmp)
            
            % subjects idict
            for i = 1:1:length(raw.Subjects)
                subject_data = raw.Subjects(i);
                subject = Subject.getSubject(subject_class, ...
                    num2str(subject_data.id), num2str(subject_data.label), num2str(subject_data.notes), atlases, ...
                    'CON', subject_data.data);
                if ~cohort.getSubjects().contains(subject.getID())
                    cohort.getSubjects().add(subject.getID(), subject, i);
                end
            end
            
            % creates group
            subjects = cohort.getSubjects().getValues();
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
            % SAVE_TO_JSON saves the cohort of SubjectsCON to '.json' files
            %
            % SAVE_TO_JSON(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectCON will be saved in '.json' format.
            %
            % SAVE_TO_JSON(COHORT, 'RootDirectory', PATH) saves the cohort
            % of SubjectCON in '.json' format in the specified PATH.
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
                Subject_Structure(i).data = subject.getData('CON').getValue();
            end
            
            for i =1:1:length(groups)
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
                subject_class = 'SubjectCON';
                atlases = tmp;
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end
            
            % sneak peak
             subject_tmp = Subject.getSubject(subject_class, ...
                num2str(raw.Subjects(1).id), num2str(raw.Subjects(1).label), num2str(raw.Subjects(1).notes), atlases, ...
                'CON', raw.Subjects(1).data);
            delete(subject_tmp)
            
            % subjects idict
            for i = 1:1:length(raw.Subjects)
                subject_data = raw.Subjects(i);
                subject = Subject.getSubject(subject_class, ...
                    num2str(subject_data.id), num2str(subject_data.label), num2str(subject_data.notes), atlases, ...
                    'CON', subject_data.data);
                if ~cohort.getSubjects().contains(subject.getID())
                    cohort.getSubjects().add(subject.getID(), subject, i);
                end
            end
            
            % creates group
            subjects = cohort.getSubjects().getValues();
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
    end
end