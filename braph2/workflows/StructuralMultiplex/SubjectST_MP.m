classdef SubjectST_MP < Subject
    % SubjectST_MP A subject of type Structural Multiplex.
    % SubjectST_MP represents a subject of type Structural Multiplex with 2 layers.
    % It is a subclass of Subject. It implements the methods initialize_datadict
    % and update_brainatlases.
    %
    % SubjectST_MP methods (Access=protected)
    %   SubjectST_MP            - Constructor
    %
    % SubjectST_MP methods (Access=protected):
    %   initialize_datadict     - initializes the data dictionary DATADICT
    %   update_brainatlases     - updates the brain atlases in DATADICT
    %
    % SubjectST_MP inspection methods (Static)
    %   getClass                - returns the class of SubjectMultiplexMRI
    %   getName                 - returns the name of  SubjectMultiplexMRI
    %   getDescription          - returns the description of SubjectMultiplexMRI
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of SubjectMultiplexMRI
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data for SubjectMultiplexMRI
    %   getDataClasses          - returns the class of the type of all data of SubjectMultiplexMRI
    %   getDataClass            - returns the class of the type of a data of SubjectMultiplexMRI
    %   getSubject              - returns a new instantiation of SubjectMultiplexMRI
    %
    % SubjectST_MP load and save methods (Static):
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
        datalist
    end
    
    methods  % Constructor
        function sub = SubjectST_MP(id, label, notes, atlas, varargin)
            % SUBJECTST_MP(ATLAS) creates a subject of type Structural Multiplex
            %
            % SUBJECTST_MP(ID, LABEL, NOTES, ATLASES) creates a subject of 
            % type Structural SUBJECTST_MP with ID, LABEL and NOTES.
            % ATLAS is the brain atlas that subject Structural Multiplex
            % will use (it can be either a BrainAtlas or a cell array with 
            % a single BrainAtlas).
            %
            % SUBJECTST_MP(ID, LABEL, NOTES, ATLASES, 'PROPERTYRULE1, 'VALUE1, ...) 
            % creates a Structural Multiplex subject with ubject ID, LABEL,
            % NOTES and ATLASES. SubjectST_MP will be initialized by the 
            % rules passed in the VARARGIN.
            %
            % See also See also Group, Cohort, SubjectfMRI, SubjectDTI, Subject.
            
            if isa(atlas, 'BrainAtlas')
                atlases = {atlas};
            else
                assert(iscell(atlas) && length(atlas)==1, ...
                    [BRAPH2.STR ':SubjectST_MP:' BRAPH2.WRONG_INPUT], ...
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
            gender = get_from_varargin(-1, 'gender', varargin{:});
            education = get_from_varargin(0, 'education', varargin{:});
            sub.layers = get_from_varargin(2, 'ST_Layers', varargin{:});  
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas, age);
            sub.datadict('gender') = DataScalar(atlas, gender);
            sub.datadict('education') = DataScalar(atlas, education);
            if ~isempty(sub.layers)  % finds info
                for i = 1:1:sub.layers
                    id = ['ST_MP_' num2str(i)];
                    structural_multiplex_N = get_from_varargin(zeros(atlas.getBrainRegions().length(), 1), id, varargin{:});
                    if iscell(structural_multiplex_N)
                       structural_multiplex_N = [structural_multiplex_N{:}]';
                    end
                    sub.datadict(id) = DataStructural(atlas, structural_multiplex_N );
                end
            else  % default behaviour
                sub.datadict('ST_MP_1') = DataStructural(atlas, zeros(atlas.getBrainRegions().length(), 1));
                sub.datadict('ST_MP_2') = DataStructural(atlas, zeros(atlas.getBrainRegions().length(), 1));
            end  
            sub.init_internal_datalist();
        end
        function update_brainatlases(sub, atlases)
            % UPDATE_BRAINATLASES updates the atlases of the subject Structural Multiplex 
            %
            % UPDATE_BRAINATLASES(SUB, ATLASES) updates the atlases of the
            % subject Structural Multiplex using the new values ATLASES. ATLASES must be a
            % cell array with a single BrainAtlas.
            %
            % See also initialize_datadict.
            
            sub.atlases = atlases;
            atlas = atlases{1};
            
            data_codes = sub.get_internal_datacodes();
            for i = 1:1:length(data_codes)
                d = sub.datadict(data_codes{i});
                d.setBrainAtlas(atlas)
            end
        end
        function init_internal_datalist(sub)
            sub.datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            sub.datalist('age') = 'DataScalar';            
            sub.datalist('gender') = 'DataScalar';
            sub.datalist('education') = 'DataScalar'; 
            if ~isempty(sub.layers)  % finds info
                for i = 1:1:sub.layers
                    id = ['ST_MP_' num2str(i)];
                    sub.datalist(id) = 'DataStructural';
                end
            else  % default behaviour
                sub.datalist('ST_MP_1') = 'DataStructural';
                sub.datalist('ST_MP_2') = 'DataStructural';
            end
        end 
    end
    methods  % extra because N is variable
        function add_data_to_datadict(sub, info)
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
                remove(sub.datadict, info)
                remove(sub.datalist, info)
            end            
        end
        function datalist = get_internal_datalist(sub)
            datalist = sub.datalist;
        end
        function datacodes = get_internal_datacodes(sub)
            data_list = sub.get_internal_datalist();
            datacodes = keys(data_list);
        end
        function dict_number = getDataDictLength(sub)
            dict_number = length(sub.datadict);
        end
        function layers_n = getNumberOfLayers(sub)
            layers_n = sub.layers;
        end
    end
    methods (Static)  % Inspection functions
        function subject_class = getClass()
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS() returns the class SubjectST_MP.
            %
            % See also getList, getDescription, getName
            
            subject_class = 'SubjectST_MP';
        end
        function name = getName()
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME() returns the name: Subject Structural Multiplex.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Subject Structural Multiplex';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of SubjectST_MP.
            %
            % See also getList, getName, getClass.
            
            description = [ ...
                'Subject with structural multiplex data (N layers), ' ...
                'such as cortical thickness for each brain region' ...
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
            % data. For Subject Structural Multiplex, the data list is:
            %   age            -    DataScalar.
            %   gender         -    DataScalar.
            %   education      -    DataScalar.
            %   ST_MP1         -    DataStructural.
            %   ST_MP2         -    DataStructural.
            %
            % See also getList
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('gender') = 'DataScalar';
            datalist('education') = 'DataScalar';
            datalist('ST_MP_1') = 'DataStructural';
            datalist('ST_MP_2') = 'DataStructural';
        end
        function data_number = getDataNumber()
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER() returns the number of data of subject 
            % Structural Multiplex.
            %
            % See also getDataList, getBrainAtlasNumber.
            
            data_number = Subject.getDataNumber('SubjectST_MP');
        end
        function data_codes = getDataCodes()
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject Structural Multiplex data keys.
            %
            % See also getList
            
            data_codes = Subject.getDataCodes('SubjectST_MP');
        end
        function data_classes = getDataClasses()
            % GETDATACLASSES returns the list of data classes
            %
            % CELL ARRAY = GETDATACLASSES(SUB) returns a cell array of
            % subject Structural Multiplex data classes.
            %
            % CELL ARRAY = GETDATACLASSES(SUBJECT_CLASS) returns a
            % cell array of subject Structural Multiplex data classes to  
            % the subject whose class is SUBJECT_CLASS.
            %
            % See also getList, getDataCodes, getDataClass.
            
            data_classes = Subject.getDataClasses('SubjectST_MP');
        end
        function data_class = getDataClass(data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE
            %
            % See also getList, getDataClasses.
            
            data_class = Subject.getDataNumber('SubjectST_MP', data_code);
        end
    end
    methods (Static)  % Save/load functions
        function cohort = load_from_xls(tmp, varargin)
            % LOAD_FROM_XLS loads a '.xls' file to a Cohort with SubjectST_MP
            %
            % COHORT = LOAD_FROM_XLS(TMP) opens a GUI to load a directory 
            % where it reads '.xls' or '.xlsx' files. If TMP is a brain atlas 
            % it will create a cohort of SubjectST_MP. If TMP is a cohort
            % then it will load the file into the cohort.
            %
            % COHORT = LOAD_FROM_XLS(TMP, 'Directory', PATH) loads the directory
            % in PATH where it reads '.xls' or '.xlsx' files. If TMP is a
            % brain atlas the function whill create a cohort of SubjectST_MP 
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
                subject_class = 'SubjectST_MP';
                atlases = tmp;
                cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});  
            end          
            
            % find all group folders
            % find all subfolders get all groups
            groups_folders = dir(directory);
            groups_folders = groups_folders([groups_folders(:).isdir] == 1);
            groups_folders = groups_folders(~ismember({groups_folders(:).name}, {'.', '..'}));
            
            for i = 1:1:length(groups_folders)
                group_path = [directory filesep() groups_folders(i).name];
                files = dir(fullfile(group_path, '*.xlsx'));
                files2 = dir(fullfile(group_path, '*.xls'));
                len = length(files);
                for k = 1:1:length(files2)
                    files(len + k, 1) = files2(k, 1);
                end
                
                atlases = cohort.getBrainAtlases();
                
                % load subjects to cohort & add them to the group
                group = Group(subject_class,'', '', '', {});
                group.setID(groups_folders(i).name);
                cohort.getGroups().add(group.getID(), group);
                
                % peek into first file to get number of subjects per group
                raw_tmp = readtable(fullfile(group_path, files(1).name));
                number_subjects = height(raw_tmp);
                number_fields = width(raw_tmp) - 3;
                
                % I want to load all data into a cell, this is better since
                % it will assure N calls to xls file. Instead of
                % N*nSubjects calls to xls files.
                
                % layer, subject, field
                all_subjects_data = cell(length(files), number_subjects, number_fields);
                subjects_info = cell(number_subjects, 3);
                n_f = length(files);
                
                for k = 1:1:length(files)
                    raw = readtable(fullfile(group_path, files(k).name));
                    if k == 1  % just 1 time
                        % info
                        subjects_info(:, :) = raw{:, 1:3};
                        covariates = readtable(fullfile(group_path, files(k).name), 'Sheet', 2, 'ReadVariableNames', 1);
                    end
                    % data
                    data = raw{:, 4: width(raw_tmp)};  % we remove id, lbl, notes
                    all_subjects_data(k, :, :) = reshape(num2cell(data), [1 number_subjects number_fields]);
                    % create tags
                    tags{k} = ['ST_MP_' num2str(k)]; %#ok<AGROW>
                end                
                
                for k = 1:1:size(all_subjects_data, 2)  % cycle over subjects
                    subject_keys_layers(1, :) = tags;
                    layer_subject = reshape(all_subjects_data(:, k, :), [n_f number_fields]);
                    for l = 1:1:n_f
                        subject_keys_layers(2, l) = {layer_subject(l, :)'};
                    end

                    % transform covariates table to useful arrays
                    cov_keys = covariates.Properties.VariableNames;
                    cov_vals = table2array(covariates);
                    for j = 1:1:length(cov_keys)
                        covs{1, j} = cov_keys{j}; %#ok<AGROW>
                        covs{2, j} = cov_vals(k, j); %#ok<AGROW>                     
                    end
                    
                    % create subject
                    sub_id = subjects_info(k, 1);
                    sub_label = subjects_info(k, 2);
                    sub_notes = subjects_info(k, 3);
                    subject = Subject.getSubject(subject_class, ...
                        sub_id{:}, sub_label{:}, sub_notes{:}, atlases, ...
                        'ST_Layers', n_f, covs{:}, ...
                        subject_keys_layers{:});
                    
                    if ~cohort.getSubjects().contains(subject.getID())
                        cohort.getSubjects().add(subject.getID(), subject);
                    end
                    group.addSubject(subject);
                end
                
            end
        end
        function save_to_xls(cohort, varargin)
            % SAVE_TO_XLS saves the cohort of SubjectST_MP to a '.xls' file
            %
            % SAVE_TO_XLS(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectST_MP will be saved in '.xls' or 'xlsx'
            % format.
            %
            % SAVE_TO_XLS(COHORT, 'RootDirectory', PATH) saves the cohort 
            % of SubjectST_MP in '.xls' or 'xlsx' format in the
            % specified PATH.
            % 
            % See also load_from_xls, save_to_txt, save_to_json
            
            % directory (fullpath)
             root_directory = get_from_varargin('', 'Directory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);
            end
            
             % warning xls sheets off
            warning( 'off', 'MATLAB:xlswrite:AddSheet' ) ;
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};
            
             % creates groups folders
            for i=1:1:cohort.getGroups().length()
                if ~exist([root_directory filesep() cohort.getGroups().getValue(i).getID()], 'dir')
                    mkdir(root_directory, cohort.getGroups().getValue(i).getID());
                end
                
                % group info
                group = cohort.getGroups().getValue(i);
                group_directory = [root_directory filesep() cohort.getGroups().getValue(i).getID()];
                
                % create container tensor for all data we have to peek into
                % first subject
                % get subject info
                subjects_list = group.getSubjects();
                s_tmp = subjects_list{1};
                number_layers = s_tmp.getNumberOfLayers();
                number_elements = size(s_tmp.getData('ST_MP_1').getValue(), 1);
                number_covariates = s_tmp.getDataDictLength() - number_layers;                
                all_data = cell(number_layers, group.subjectnumber(), number_elements);
                subjects_info = cell(group.subjectnumber(), 3); 
                covs_vals = cell(group.subjectnumber(), number_covariates);
                covs_keys = cell(1, number_covariates);
                
                for j = 1:1:group.subjectnumber()
                    subject = subjects_list{j};
                    subjects_info{j, 1} = subject.getID();
                    subjects_info{j, 2} = subject.getLabel();
                    subjects_info{j, 3} = subject.getNotes();
                    layers = subject.getNumberOfLayers();
                    for k = 1:1:layers
                        id_layer = ['ST_MP_' num2str(k)];
                        data_val = subject.getData(id_layer).getValue();
                        all_data(k, j, :) = num2cell(data_val');
                    end
                    
                    % covariates
                    data_codes = subject.get_internal_datacodes();
                    for k = 1:1:length(data_codes)
                        d = data_codes{k};
                        if ~contains(d, 'ST_MP_')
                            cov_keys{k} = d; %#ok<AGROW>
                            cov_vals{k} = subject.getData(d).getValue(); %#ok<AGROW>
                        end
                    end
                    cov_keys(cellfun('isempty', cov_keys)) = [];
                    cov_vals(cellfun('isempty', cov_vals)) = [];
                    if j == 1
                        covs_keys(1, :) = cov_keys;
                    end
                    covs_vals(j, :) = cov_vals;
                    cov_vals = [];
                    cov_keys = [];
                end
                
                % save info
                t = cell2table(covs_vals);
                t.Properties.VariableNames = covs_keys;
                
                for j =1:1:number_layers
                    file_id = [group.getID() '_' num2str(j) '.xlsx'];
                    % save id lbl notes
                    tab_id = cell2table(subjects_info);
                    tab_id.Properties.VariableNames = {'id', 'label', 'notes'};
                    writetable(tab_id, [group_directory filesep() file_id], 'Sheet', 1, 'WriteVariableNames', 1, 'Range', 'A1');
                    
                    % save data
                    tab_data =  cell2table(reshape(all_data(j, :, :), [group.subjectnumber(), number_elements]));
                    tab_data.Properties.VariableNames = atlas.getBrainRegions().getKeys();
                    writetable(tab_data, [group_directory filesep() file_id], 'Sheet', 1, 'WriteVariableNames', 1, 'Range', 'D1');
                    
                    % save covariates
                    if j == 1
                        writetable(t, [group_directory filesep() file_id], 'Sheet', 2, 'WriteVariableNames', 1, 'Range', 'A1');
                    end
                end
            end
            %
            warning('on', 'MATLAB:xlswrite:AddSheet');
          
        end
        function cohort = load_from_txt(tmp, varargin)
            % LOAD_FROM_TXT loads a '.txt' file to a Cohort with SubjectST_MP
            %
            % COHORT = LOAD_FROM_TXT(TMP) opens a GUI to load a directory 
            % where it reads '.txt' files. If TMP is a brain atlas 
            % it will create a cohort of SubjectST_MP. If TMP is a cohort
            % then it will load the file into the cohort.
            %
            % COHORT = LOAD_FROM_TXT(TMP, 'Directory', PATH) loads the directory
            % in PATH where it reads '.txt' files. If TMP is a
            % brain atlas the function whill create a cohort of SubjectST_MP 
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
                file_cohort_path = file_cohort_path(2:end);
                file_cohort = [file_cohort_path filesep() 'cohort_info.txt'];
                cohort_id = '';
                cohort_label = '';
                cohort_notes = '';
                subject_class = 'SubjectST_MP';
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
            raw1 = readtable(file1, 'Delimiter', '\t');
            raw2 = readtable(file2, 'Delimiter', '\t');
            assert(size(raw1, 1) == size(raw2, 1) && size(raw1, 2) == size(raw2, 2), ...
                [BRAPH2.STR ':SubjectST_MP:' BRAPH2.WRONG_INPUT], ...
                'The input txt files must have the same number of subjects with data from the same brain regions')
            atlases = cohort.getBrainAtlases();
            
            % sneak peak to see if it is a subject
            id_tmp = raw1{1, 1};
            labl_tmp = raw1{1, 2};
            notes_tmp = raw1{1, 3};
            data_tmp1 = raw1{1, 4:size(raw1, 2)};
            if iscell(id_tmp)
                id_tmp = id_tmp{1};
            end
            if iscell(labl_tmp)
                labl_tmp = labl_tmp{1};
            end
            if  iscell(notes_tmp)
                notes_tmp = notes_tmp{1};
            end
            data_tmp2 = raw2{1, 4:size(raw2, 2)};
            
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
                labl_tmp = raw1{i, 2};
                notes_tmp = raw1{i, 3};
                data_tmp1 = raw1{i, 4:size(raw1, 2)};
                if iscell(id_tmp)
                    id_tmp = id_tmp{1};
                end
                if iscell(labl_tmp)
                    labl_tmp = labl_tmp{1};
                end
                if  iscell(notes_tmp)
                    notes_tmp = notes_tmp{1};
                end
                data_tmp2 = raw2{i, 4:size(raw2, 2)};
                
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
            % SAVE_TO_TXT saves the cohort of SubjectST_MP to a '.txt' file
            %
            % SAVE_TO_TXT(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectST_MP will be saved in '.txt' format.
            %
            % SAVE_TO_TXT(COHORT, 'RootDirectory', PATH) saves the cohort 
            % of SubjectST_MP in '.txt' format in the specified PATH.
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
            first_row_table1 = [first_row_table1(:, 2) first_row_table1(:, 3) ...
                first_row_table1(:, 4) first_row_table1(:, 1)];
            
            first_row_table2 = table(row_data, 'VariableNames', {'row_datas2'});
            first_row_table2.row_ids = row_id;
            first_row_table2.row_labels = row_label;
            first_row_table2.row_notes = row_note;
            first_row_table2 = [first_row_table2(:, 2) first_row_table2(:, 3) ...
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
            
            % remove quotation marks 2
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
            m = atlas.getBrainRegions().length() + 2;
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
            % LOAD_FROM_JSON loads a '.json' file to a Cohort with SubjectST_MP
            %
            % COHORT = LOAD_FROM_JSON(TMP) opens a GUI to load a directory 
            % where it reads '.json' files. If TMP is a brain atlas 
            % it will create a cohort of SubjectST_MP. If TMP is a cohort
            % then it will load the file into the cohort.
            %
            % COHORT = LOAD_FROM_JSON(TMP, 'Directory', PATH) loads the directory
            % in PATH where it reads '.json' files. If TMP is a
            % brain atlas the function whill create a cohort of SubjectST_MP 
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
                subject_class = 'SubjectST_MP';
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
            % SAVE_TO_JSON saves the cohort of SubjectST_MP to a '.json' file
            %
            % SAVE_TO_JSON(COHORT) opens a GUI to choose the path where the
            % cohort of SubjectST_MP will be saved in '.json' format.
            %
            % SAVE_TO_JSON(COHORT, 'RootDirectory', PATH) saves the cohort 
            % of SubjectST_MP in '.json' format in the specified PATH.
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
