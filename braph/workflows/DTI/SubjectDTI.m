classdef SubjectDTI < Subject
    % SubjectDTI < Subject: A subject of type DTI.
    % SubjectDTI represents a subject of type DTI.
    %
    % SubjectDTI methods (Access=protected)
    %   SubjectDTI              - Constructor.
    %
    % SubjectDTI methods (Access=protected)
    %   initialize_datadict     - initializes the data dictionary DATADICT.
    %   update_brainatlases     - updates the brain atlases in DATADICT.
    %
    % SubjectDTI methods (Static)
    %   getClass                - returns the class of SubjectDTI.
    %   getName                 - returns the name of  SubjectDTI.
    %   getDescription          - returns the description of SubjectDTI.
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of SubjectDTI
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data for SubjectDTI
    %   getDataClasses          - returns the class of the type of all data of SubjectDTI.
    %   getDataClass            - returns the class of the type of a data of SubjectDTI.
    %   getSubject              - returns a new instantiation of SubjectDTI
    %
    % See also Group, Cohort, SubjectMRI, SubjectfMRI, Subject.
    methods
        function sub = SubjectDTI(atlas, varargin)
            % SUBJECTDTI(ATLAS) creates a subject of type DTI.
            % ATLAS is the brain atlas that subject DTI will use (it can be
            % either a BrainAtlas or a cell array with a single BrainAtlas).
            %
            % SUBJECT(ATLASES, 'SubjectID', ID) creates a subject with
            % subject id ID.
            %
            % SUBJECT(ATLASES, 'age', AGE, 'DTI', DTI) creates a subject
            % with age AGE and DTI matrix DTI.
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
            
            sub = sub@Subject(atlases, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_datadict(sub, varargin)
            % INITIALIZE_DATADICT initializes the data dictionary
            %
            % INITIALIZE_DATADICT(SUB, 'age', AGE, 'DTI', DTI) initializes the data
            % ditionary with data type and data code of subject dti.
            %
            % See also update_brainatlases().
            
            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            
            age = get_from_varargin(0, 'age', varargin{:});
            dti = get_from_varargin(zeros(atlas.getBrainRegions().length(), atlas.getBrainRegions().length()), 'DTI', varargin{:});
            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas, age);
            sub.datadict('DTI') = DataConnectivity(atlas, dti);
        end
        function update_brainatlases(sub, atlases)
            % UPDATE_BRAINATLASES updates the atlases of the subject dti
            %
            % UPDATE_BRAINATLASES(SUB, ATLASES) updates the atlases of the
            % subject dti using the new values ATLASES. ATLASES must be a
            % cell array with a single BrainAtlas.
            %
            % See also initialize_datadict().
            
            sub.atlases = atlases;
            atlas = atlases{1};
            
            d1 = sub.datadict('age');
            d1.setBrainAtlas(atlas)
            
            d2 = sub.datadict('DTI');
            d2.setBrainAtlas(atlas);
        end
    end
    methods (Static)
        function subject_class = getClass()
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS() returns the class SubjectDTI
            %
            % See also getList(), getDescription(), getName().
            
            subject_class = 'SubjectDTI';
        end
        function name = getName()
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME() returns the name: Subject DTI.
            %
            % See also getList(), getClass().
            
            name = 'Subject DTI';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of SubjectDTI
            %
            % See also getList(), getName(), getClass().
            
            description = [ ...
                'Subject with DTI connectivity matrix, ' ...
                'such as activation timeseries for each brain region' ...
                ];
        end
        function atlas_number = getBrainAtlasNumber()
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % N = GETBRAINATLASNUMBER() returns the number of
            % brain atlases, in this case 1.
            %
            % See also getList(), getDescription(), getName(), getClass().
            
            atlas_number = 1;
        end
        function datalist = getDataList()
            % GETDATALIST returns the list of data
            %
            % CELL ARRAY = GETDATALIST() returns a cell array of
            % subject data. For Subject DTI, the data list is:
            %   age             -    DataScalar.
            %   DTI             -    DataConnectivity.
            %
            % See also getList()
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('DTI') = 'DataConnectivity';
        end
        function data_number = getDataNumber()
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER() returns the number of data.
            %
            % See also getDataList(), getBrainAtlasNumber().
            
            data_number = Subject.getDataNumber('SubjectDTI');
        end
        function data_codes = getDataCodes()
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject dti data keys.
            %
            % See also getList()
            
            data_codes = Subject.getDataCodes('SubjectDTI');
        end
        function data_classes = getDataClasses()
            % GETDATACLASSES returns the list of data classes
            %
            % CELL ARRAY = GETDATACLASSES(SUB) returns a cell array of
            % subject dti data classes.
            %
            % CELL ARRAY = GETDATACLASSES(SUBJECT_CLASS) returns a
            % cell array of subject dti data classes to the subject whose class is
            % SUBJECT_CLASS.
            %
            % See also getList(), getDataCodes(), getDataClass().
            
            data_classes = Subject.getDataClasses('SubjectDTI');
        end
        function data_class = getDataClass(data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE
            %
            % See also getList(), getDataClasses().
            
            data_class = Subject.getDataNumber('SubjectDTI', data_code);
        end
        function cohort = load_from_xls(subject_class, atlases, varargin)
            % directory
            directory = get_from_varargin('', 'Directory', varargin{:});
            if isequal(directory, '')  % no path, open gui
                msg = get_from_varargin(Constant.MSG_GETDIR, 'MSG', varargin{:});
                directory = uigetdir(msg);
            end
            
            % find all xls or xlsx files
            files = dir(fullfile(directory, '*.xlsx'));
            files2 = dir(fullfile(directory, '*.xls'));
            len = length(files);
            for i =1:1:length(files2)
                files(len+i,1) = files2(i, 1);
            end
            
            % creates cohort
            cohort = Cohort('', subject_class, atlases, {});
            
            % load subjects
            for i = 1:1:length(files)
                % read file
                [~, ~, raw] = xlsread(fullfile(directory, files(i).name));
                
                % get age
                
                % create subject
                sub_name = erase(files(i).name, '.xls');
                sub_name = erase(sub_name, '.xlsx');
                subject = Subject.getSubject(subject_class, atlases, ...
                    'SubjectID', sub_name, ...
                    'DTI', cell2mat(raw));
                
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            if i == length(files)
                [~, groupname] = fileparts(directory);
                group = Group(subject_class, cohort.getSubjects().getValues());
                group.setName(groupname);
                cohort.getGroups().add(group.getName(), group);
            end
        end
        function save_to_xls(cohort, varargin)
            % get Root Directory
            root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(Constant.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);
                
            end
            
            % creates groups folders
            for i=1:1:cohort.getGroups().length()
                mkdir(root_directory, cohort.getGroups().getValue(i).getName());
                
                % get info
                group = cohort.getGroups().getValue(i);
                subjects_list = group.getSubjects();
                for j = 1:1:group.subjectnumber()
                    % get subject data
                    subject = subjects_list{j};
                    name = subject.getID();
                    data = subject.getData('DTI');
                    
                    % create table
                    tab = table(data.getValue());
                    
                    % save
                    file = [root_directory filesep() cohort.getGroups().getValue(i).getName() filesep() name '.xlsx'];
                    writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0);
                end
            end
        end
        function cohort = load_from_txt(subject_class, atlases, varargin)
            % directory
            directory = get_from_varargin('', 'Directory', varargin{:});
            if isequal(directory, '')  % no path, open gui
                msg = get_from_varargin(Constant.MSG_GETDIR, 'MSG', varargin{:});
                directory = uigetdir(msg);
            end
            
            % find all txt files
            files = dir(fullfile(directory, '*.txt'));
            
            % creates cohort
            cohort = Cohort('', subject_class, atlases, {});
            
            % load subjects
            for i = 1:1:length(files)
                % read file
                raw = readtable(fullfile(directory, files(i).name));
                
                % get age
                
                % create subject
                sub_name = erase(files(i).name, '.txt');
                subject = Subject.getSubject(subject_class, atlases, ...
                    'SubjectID', sub_name, ...
                    'DTI', raw{:, :});
                
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            if i == length(files)
                [~, groupname] = fileparts(directory);
                group = Group(subject_class, cohort.getSubjects().getValues());
                group.setName(groupname);
                cohort.getGroups().add(group.getName(), group);
            end
        end
        function save_to_txt(cohort, varargin)
            % get Root Directory
            root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(Constant.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);
                
            end
            
            % creates groups folders
            for i=1:1:cohort.getGroups().length()
                mkdir(root_directory, cohort.getGroups().getValue(i).getName());
                
                % get info
                group = cohort.getGroups().getValue(i);
                subjects_list = group.getSubjects();
                for j = 1:1:group.subjectnumber()
                    % get subject data
                    subject = subjects_list{j};
                    name = subject.getID();
                    data = subject.getData('DTI');
                    
                    % create table
                    tab = table(data.getValue());
                    
                    % save
                    file = [root_directory filesep() cohort.getGroups().getValue(i).getName() filesep() name '.txt'];
                    writetable(tab, file, 'Delimiter', '\t', 'WriteVariableNames', 0);
                end
            end
        end
        function cohort = load_from_json(subject_class, atlases, varargin)
            % directory
            directory = get_from_varargin('', 'Directory', varargin{:});
            if isequal(directory, '')  % no path, open gui
                msg = get_from_varargin(Constant.MSG_GETDIR, 'MSG', varargin{:});
                directory = uigetdir(msg);
            end
            
            % find all txt files
            files = dir(fullfile(directory, '*.json'));
            
            % creates cohort
            cohort = Cohort('', subject_class, atlases, {});
            
            % load subjects
            for i = 1:1:length(files)
                % read file
                raw = jsondecode(fileread(fullfile(directory, files(i).name)));
                
                % get age
                
                % create subject
                sub_name = erase(files(i).name, '.json');
                subject = Subject.getSubject(subject_class, atlases, ...
                    'SubjectID', num2str(sub_name), ...
                    'DTI', raw.SubjectData.data);
                
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            if i == length(files)
                [~, groupname] = fileparts(directory);
                group = Group(subject_class, cohort.getSubjects().getValues());
                group.setName(groupname);
                cohort.getGroups().add(group.getName(), group);
            end
        end
        function save_to_json(cohort, varargin)
            % get Root Directory
            root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(Constant.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);
                
            end
            
            % creates groups folders
            for i=1:1:cohort.getGroups().length()
                mkdir(root_directory, cohort.getGroups().getValue(i).getName());
                
                % get info
                group = cohort.getGroups().getValue(i);
                subjects_list = group.getSubjects();
                for j = 1:1:group.subjectnumber()
                    % get subject data
                    subject = subjects_list{j};
                    name = subject.getID();
                    data = subject.getData('DTI');
                    
                    % create structure to be save
                    structure_to_be_saved = struct( ...
                        'Braph', Constant.VERSION, ...
                        'Build', Constant.BUILD, ...
                        'SubjectData', struct( ...
                        'name', name, ...
                        'data', data.getValue()) ...
                        );
                           
                    % save
                    json_structure = jsonencode(structure_to_be_saved);
                    file = [root_directory filesep() cohort.getGroups().getValue(i).getName() filesep() name '.json'];
                    fid = fopen(file, 'w');
                    if fid == -1, error('Cannot create JSON file'); end
                    fwrite(fid, json_structure, 'char');
                    fclose(fid);
                end
            end
        end
    end
end