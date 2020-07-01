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
        function sub = SubjectDTI(id, label, notes, atlas, varargin)
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
            
            sub = sub@Subject(id, label, notes, atlases, varargin{:});
        end
    end
    methods (Access=protected)  % Utilifty functions
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
    methods (Static)  % Inspection functions
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
    end
    methods (Static)  % Save/load functions
        function cohort = load_from_xls(subject_class, atlases, varargin)
            % directory
            directory = get_from_varargin('', 'Directory', varargin{:});
            if isequal(directory, '')  % no path, open gui
                msg = get_from_varargin(Constant.MSG_GETDIR, 'MSG', varargin{:});
                directory = uigetdir(msg);
            end
            
            % find all subfolders
            sub_folders = dir(directory);
            sub_folders = sub_folders([sub_folders(:).isdir] == 1);
            sub_folders = sub_folders(~ismember({sub_folders(:).name}, {'.', '..'}));
            
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
            
            % creates cohort          
            cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            
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
                    
                    % get age
                    
                    % create subject
                    sub_id = erase(files(i).name, '.xlsx');
                    sub_id = erase(sub_id, '.xls');
                    subject = Subject.getSubject(subject_class, ...
                        sub_id, raw{1, 1}, raw{2, 1}, atlases, ...                     
                        'DTI', num);
                    
                    cohort.getSubjects().add(subject.getID(), subject);
                    subjects{i} = subject; %#ok<AGROW>
                end
                
                % retrieve group information
                file_group = [directory filesep() sub_folders(j).name filesep() 'group_info.txt'];
                group_raw = textread(file_group, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                group_id = group_raw{1, 1};
                group_label = group_raw{2, 1};
                group_notes = group_raw{3, 1};
                
                % creates a group per subfolder
                group = Group(subject_class, group_id, group_label, group_notes, subjects);
                cohort.getGroups().add(group.getID(), group, j);                
            end
        end
        function save_to_xls(cohort, varargin)
            % get Root Directory
            root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(Constant.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);
                
            end
            
            % save cohort info
            
            % creates groups folders
            for i=1:1:cohort.getGroups().length()
                mkdir(root_directory, cohort.getGroups().getValue(i).getID());
                
                % cohort info
                file_info_cohort = [root_directory filesep() 'cohort_info.txt'];
                if ~isfile(file_info_cohort)
                    cohort_info = cell(3, 1);
                    cohort_info{1, 1} = cohort.getID();
                    cohort_info{2, 1} = cohort.getLabel();
                    cohort_info{3, 1} = cohort.getNotes();
                    writecell(cohort_info, file_info_cohort, 'Delimiter', '\t');
                end
                
                % group info
                group = cohort.getGroups().getValue(i);
                group_info = cell(3, 1);
                group_info{1, 1} = group.getID();
                group_info{2, 1} = group.getLabel();
                group_info{3, 1} = group.getNotes();
                writecell(group_info, [root_directory filesep() group.getID() filesep() 'group_info.txt'], 'Delimiter', '\t');
                
                % get subject info                
                subjects_list = group.getSubjects();
                for j = 1:1:group.subjectnumber()
                    % get subject data
                    subject = subjects_list{j};
                    id = subject.getID();
                    label = subject.getLabel();
                    notes = subject.getNotes();
                    data = subject.getData('DTI');
                    
                    % create table                    
                    tab = table(data.getValue());
                    
                    % save
                    file = [root_directory filesep() cohort.getGroups().getValue(i).getID() filesep() id '.xlsx'];
                    writematrix(label, file, 'Sheet', 1, 'Range', 'A1');
                    writematrix(notes, file, 'Sheet', 1, 'Range', 'A2');
                    writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A3');
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
            cohort = Cohort('', '', '', subject_class, atlases, {});
            
            % load subjects
            for i = 1:1:length(files)
                % read file  
                raw = textread(fullfile(directory, files(i).name), '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                
                raw = raw(~cellfun('isempty', raw));  % remove empty cells
                
                % create subject
                sub_id = erase(files(i).name, '.txt');
                label = raw{1, 1};
                notes = raw{2, 1};
                B = raw(3:end, 1);
                B = reshape(B, [atlases.getBrainRegions().length() atlases.getBrainRegions().length()]);
                B = B';
                C = cellfun(@(x) str2double(x), B);

                subject = Subject.getSubject(subject_class, ...
                        sub_id, label, notes, atlases, ...                     
                        'DTI', C);
                
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
            % get Root Directory
            root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(Constant.MSG_PUTDIR, 'MSG', varargin{:});
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
                    label = subject.getLabel();
                    notes = subject.getNotes();
                    data = subject.getData('DTI').getValue();
                    
                    % create table
                    extra_info = cell(2, size(data, 1));
                    extra_info{1, 1} = label;
                    extra_info{2, 1} = notes;
                    tab = [
                        extra_info;
                        num2cell(data)
                        ];
                    
                    % save
                    file = [root_directory filesep() cohort.getGroups().getValue(i).getID() filesep() id '.txt'];
                    writecell(tab, file, 'Delimiter', '\t');
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
            cohort = Cohort('', '', '', subject_class, atlases, {});
            
            % load subjects
            for i = 1:1:length(files)
                % read file
                raw = jsondecode(fileread(fullfile(directory, files(i).name)));
                
                % get age
                
                % create subject
                sub_id = erase(files(i).name, '.json');
                
                subject = Subject.getSubject(subject_class, ...
                    num2str(sub_id), raw.SubjectData.label, ...
                    raw.SubjectData.notes, atlases, ...
                    'DTI', raw.SubjectData.data);
                
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            if i == length(files)
                [~, groupname] = fileparts(directory);                
                group = Group(subject_class, groupname, '', '', cohort.getSubjects().getValues());
                cohort.getGroups().add(group.getID(), group);
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
                mkdir(root_directory, cohort.getGroups().getValue(i).getID());
                
                % get info
                group = cohort.getGroups().getValue(i);
                subjects_list = group.getSubjects();
                for j = 1:1:group.subjectnumber()
                    % get subject data
                    subject = subjects_list{j};
                    id = subject.getID();
                    label = subject.getLabel();
                    notes = subject.getNotes();
                    data = subject.getData('DTI');
                    
                    % create structure to be save
                    structure_to_be_saved = struct( ...
                        'Braph', BRAPH2.NAME, ...
                        'Build', BRAPH2.BUILD, ...
                        'SubjectData', struct( ...
                        'name', id, ...
                        'label', label, ...
                        'notes', notes, ...
                        'data', data.getValue()) ...
                        );
                           
                    % save
                    json_structure = jsonencode(structure_to_be_saved);
                    file = [root_directory filesep() cohort.getGroups().getValue(i).getID() filesep() id '.json'];
                    fid = fopen(file, 'w');
                    if fid == -1, error('Cannot create JSON file'); end
                    fwrite(fid, json_structure, 'char');
                    fclose(fid);
                end
            end
        end
    end
end