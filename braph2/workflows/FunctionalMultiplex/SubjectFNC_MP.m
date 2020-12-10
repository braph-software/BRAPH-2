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
            if isempty(sub.layers)  % finds info
                for i = 1:1:sub.layers
                    id = ['FNC_MP_' num2str(i)];
                    functional_multiplex_N = get_from_varargin(zeros(atlas.getBrainRegions().length(), 1), id, varargin{:});
                    sub.datadict(id) = DataFunctional(atlas, functional_multiplex_N);
                end
            else  % default behaviour
                sub.datadict() = DataFunctional(atlas, );
                sub.datadict() = DataFunctional(atlas, );
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
    methods  % extra because n is variable
        function dict_number = getDataDictLength(sub)
            dict_number = length(sub.datadict);
        end
        function ids = getDataDictKeys(sub)
            ids = keys(sub.datadict);
        end
        function data = getDataDict(sub)
            data = sub.datadict;
        end
        function layers_n = getNumberOfLayers(sub)
            layers_n = sub.layers;
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
            datalist('FNC_MP_1') = 'DataFunctional';
            datalist('FNC_MP_2') = 'DataFunctional';
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
            
            % directory
            directory = get_from_varargin('', 'Directory', varargin{:});
            if isequal(directory, '')  % select file
                msg = get_from_varargin(BRAPH2.MSG_GETDIR, 'MSG', varargin{:});                
                directory = uigetdir(msg);
            end
            
            % find all subfolders get all groups
            sub_folders_group = dir(directory);
            sub_folders_group = sub_folders_group([sub_folders_group(:).isdir] == 1);
            sub_folders_group = sub_folders_group(~ismember({sub_folders_group(:).name}, {'.', '..'}));

            % Set/create cohort
            if isa(tmp, 'Cohort')
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
            else  % tmp is an atlas
                
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
                atlases = tmp;
                subject_class = 'SubjectFNC_MP';
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            end  
            
             % find all subjects subfolders from groups folders
            for i = 1:1:length(sub_folders_group)
                path_group_folder = [directory filesep() sub_folders_group(i).name];
                subject_folders = dir(path_group_folder);
                subject_folders = subject_folders([subject_folders(:).isdir] == 1);
                subject_folders = subject_folders(~ismember({subject_folders(:).name}, {'.', '..'})); 
                
                % get all layers per subject folder
                for j = 1:1:length(subject_folders)
                    subjects_paths = [path_group_folder filesep() subject_folders(j).name];
                    files = dir(fullfile(subjects_paths, '*.xlsx'));
                    files2 = dir(fullfile(subjects_paths, '*.xls'));
                    len = length(files);
                    for k = 1:1:length(files2)
                        files(len + k, 1) = files2(k, 1);
                    end
                    
                    atlases = cohort.getBrainAtlases();
                    subject_keys_layers = cell(2, length(files));
                    for k = 1:1:length(files)
                        [num, ~, ~] = xlsread(fullfile(path, files(k).name));
                        subject_keys_layers{1, k} = ['FNC_MP_' num2str(k)];
                        subject_keys_layers{2, k} = num;                         
                        
                        if k == 1
                            sub_id = erase(files(i).name, '.xlsx');
                            sub_id = erase(sub_id, '.xls');  % quitarle el _1
                            sub_lab = '';
                            sub_not = '';
                            
                            % covariate data could be in another sheet of
                            % first layer. or could come in another xls. i
                            % vote first option.
                            % raw = xlsread(fullfile(path, fikes(k).name, 'Sheet2');
                           
                        end
                    end
                    
                    % create subject
                    subject = Subject.getSubject(subject_class, ...
                        sub_id, sub_lab, sub_not, atlases, ...
                        'FNC_Layers', length(files), ...
                        subject_keys_layers{:});
                    cohort.getSubjects().add(subject.getID(), subject);
                    subjects{j} = subject;                    %#ok<AGROW>
                    
                end
                
                group = Group(subject_class, ['Group_' num2str(i)], '', '', subjects);
                cohort.getGroups().add(group.getID(), group, i);
            end                     
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
             root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);                
            end
            
            % creates groups folders
            for i=1:1:cohort.getGroups().length()
                if ~exist([root_directory filesep() cohort.getGroups().getValue(i).getID()], 'dir')
                    mkdir(root_directory, cohort.getGroups().getValue(i).getID());
                end
                
                % group info
                group = cohort.getGroups().getValue(i);
                group_directory = [root_directory filesep() cohort.getGroups().getValue(i).getID()];
                
                % get subject info
                subjects_list = group.getSubjects();
                for j = 1:1:group.subjectnumber()
                    % get subject data
                    subject = subjects_list{j};
                    id = subject.getID();
                    if ~exist([group_directory filesep() id], 'dir')
                        mkdir(group_directory, id);
                    end
                    subject_directory = [group_directory filesep() id];
                    layers = subject.getNumberOfLayers();
                    for k = 1:1:layers
                        id_layer = ['FNC_MP_' num2str(k)];
                        data = subject.getData(id_layer);
                        
                        % create table
                        tab = table(data.getValue());
                        
                        % save
                        file = [subject_directory filesep() id '_' num2str(k) '.xlsx'];
                        writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A1');
                    end
                end
            end 
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
             
            
        end
    end
end
