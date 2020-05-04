classdef SubjectMRI < Subject
    % SubjectMRI < Subject: A subject of type MRI.
    % SubjectMRI represents a subject of type MRI.
    %
    % SubjectMRI methods (Access=protected)
    %   SubjectMRI                 - Constructor.
    %
    % SubjectMRI methods (Access=protected)
    %   initialize_datadict     - initializes the data dictionary DATADICT.
    %   update_brainatlases     - updates the brain atlases in DATADICT.
    %
    % SubjectMRI methods (Static)
    %   getClass                - returns the class of SubjectMRI.
    %   getName                 - returns the name of  SubjectMRI.
    %   getDescription          - returns the description of SubjectMRI.
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of SubjectMRI
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data for SubjectMRI
    %   getDataClasses          - returns the class of the type of all data of SubjectMRI.
    %   getDataClass            - returns the class of the type of a data of SubjectMRI.
    %   getSubject              - returns a new instantiation of SubjectMRI
    %
    % See also Group, Cohort, SubjectfMRI, SubjectDTI, Subject.
    methods
        function sub = SubjectMRI(atlas, varargin)
            % SUBJECTMRI(ATLAS) creates a subject of type MRI.
            % ATLAS is the brain atlas that subject MRI will use (it can be
            % either a BrainAtlas or a cell array with a single BrainAtlas).
            %
            % SUBJECTMRI(ATLASES, 'SubjectID', ID) creates a subject with
            % subject id ID.
            %
            % SUBJECTMRI(ATLASES, 'age', AGE, 'MRI', MRI) creates a subject
            % with age AGE and MRI data MRI.
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
            
            sub = sub@Subject(atlases, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_datadict(sub, varargin)
            % INITIALIZE_DATADICT initializes the data dictionary
            %
            % INITIALIZE_DATADICT(SUB, 'age', AGE, 'MRI', MRI) initializes the data
            % ditionary with data type and data code of subject mri.
            %
            % See also update_brainatlases().
            
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
            % See also initialize_datadict().
            
            sub.atlases = atlases;
            atlas = atlases{1};
            
            d1 = sub.datadict('age');
            d1.setBrainAtlas(atlas)
            
            d2 = sub.datadict('MRI');
            d2.setBrainAtlas(atlas);
        end
    end
    methods (Static)
        function subject_class = getClass()
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS() returns the class SubjectMRI.
            %
            % See also getList(), getDescription(), getName()
            
            subject_class = 'SubjectMRI';
        end
        function name = getName()
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME() returns the name: Subject Functional MRI.
            %
            % See also getList(), getClass().
            
            name = 'Subject Structural MRI';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of SubjectMRI.
            %
            % See also getList(), getName(), getClass().
            
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
            % See also getList(), getDescription(), getName(), getClass().
            
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
            % See also getList()
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('MRI') = 'DataStructural';
        end
        function data_number = getDataNumber()
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER() returns the number of data.
            %
            % See also getDataList(), getBrainAtlasNumber().
            
            data_number = Subject.getDataNumber('SubjectMRI');
        end
        function data_codes = getDataCodes()
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject MRI data keys.
            %
            % See also getList()
            
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
            % See also getList(), getDataCodes(), getDataClass().
            
            data_classes = Subject.getDataClasses('SubjectMRI');
        end
        function data_class = getDataClass(data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE
            %
            % See also getList(), getDataClasses().
            
            data_class = Subject.getDataNumber('SubjectMRI', data_code);
        end
        function cohort = load_from_xls(subject_class, atlases, varargin)
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(Constant.XLS_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(Constant.XLS_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % creates cohort
            cohort = Cohort('', subject_class, atlases, {});
            
            [~, ~, raw] = xlsread(file);
            
            for i = 2:1:size(raw, 1)
                subject = Subject.getSubject(subject_class, ...
                    atlases, ...
                    'SubjectID', raw{i,1}, ...
                    'MRI', cell2mat(raw(i, 2:size(raw,2))'));
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            group = Group(subject_class, cohort.getSubjects().getValues());
            path = [fileparts(which(file))]; %#ok<NBRAK>
            file_name = erase(file, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.xls');
            file_name = erase(file_name, '.xlsx');
            group.setName(file_name);
            cohort.getGroups().add(group.getName(), group);
        end
        function save_to_xls(cohort, varargin)
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(Constant.XLS_MSG_PUTFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uiputfile(Constant.XLS_EXTENSION, msg);
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
                %                         name{j, 1}
                row_n = subject.getID();
                data = subject.getData('MRI');
                row_d = data.getValue()';
                row_names{j, 1} = row_n; %#ok<AGROW>
                row_datas{j, 1} = row_d; %#ok<AGROW>
            end
            tab = table(row_names, row_datas);
            
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};  % must change
            
            for i = 1:1:atlas.getBrainRegions().length()
                brain_regions{i} = atlas.getBrainRegions().getValue(i);  %#ok<AGROW>
            end
            
            row_data{1,:} = cellfun(@(x) x.getLabel, brain_regions, 'UniformOutput', false);
            row_name = 'Label';
            first_row_table = table(row_data, 'VariableNames', {'row_datas'});
            first_row_table.row_names = row_name;
            first_row_table = [first_row_table(:, 2) first_row_table(:, 1)];
            
            % creates table
            tab = [
                first_row_table
                tab
                ];
            
            % save
            writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0);
        end
        function cohort = load_from_txt(subject_class, atlases, varargin)
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(Constant.TXT_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(Constant.TXT_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % creates cohort
            cohort = Cohort('', subject_class, atlases, {});
            
            % reads file
            raw = readtable(file, 'Delimiter', '\t');
            
            for i = 1:1:size(raw, 1)  % first row is being read as table label
                subject = Subject.getSubject(subject_class, ...
                    atlases, ...
                    'SubjectID', num2str(raw{i,1}), ...
                    'MRI', raw{i, 2:size(raw, 2)}');
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            group = Group(subject_class, cohort.getSubjects().getValues());
            path = [fileparts(which(file))]; %#ok<NBRAK>
            file_name = erase(file, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.txt');
            group.setName(file_name);
            cohort.getGroups().add(group.getName(), group);
        end
        function save_to_txt(cohort, varargin)
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(Constant.TXT_MSG_PUTFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uiputfile(Constant.TXT_EXTENSION, msg);
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
                %                         name{j, 1}
                row_n = subject.getID();
                data = subject.getData('MRI');
                row_d = data.getValue()';
                row_names{j, 1} = row_n; %#ok<AGROW>
                row_datas{j, 1} = row_d; %#ok<AGROW>
            end
            tab = table(row_names, row_datas);
            
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};  % must change
            
            for i = 1:1:atlas.getBrainRegions().length()
                brain_regions{i} = atlas.getBrainRegions().getValue(i);  %#ok<AGROW>
            end
            
            row_data{1,:} = cellfun(@(x) x.getLabel, brain_regions, 'UniformOutput', false);
            row_name = 'Label';
            first_row_table = table(row_data, 'VariableNames', {'row_datas'});
            first_row_table.row_names = row_name;
            first_row_table = [first_row_table(:, 2) first_row_table(:, 1)];
            
            % creates table
            tab = [
                first_row_table
                tab
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
            m = atlas.getBrainRegions().length();
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
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(Constant.JSON_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(Constant.JSON_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % creates cohort
            cohort = Cohort('', subject_class, atlases, {});
            
            raw = jsondecode(fileread(file));     
            for i = 1:1:length(raw.SubjectData)
                name = raw.SubjectData(i).name;
                data = raw.SubjectData(i).data;
                subject = Subject.getSubject(subject_class, ...
                    atlases, ...
                    'SubjectID', num2str(name), ...
                    'MRI', data);
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            group = Group(subject_class, cohort.getSubjects().getValues());
            path = [fileparts(which(file))]; %#ok<NBRAK>
            file_name = erase(file, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.json');
            group.setName(file_name);
            cohort.getGroups().add(group.getName(), group);
        end
        function save_to_json(cohort, varargin)
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(Constant.XLS_MSG_PUTFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uiputfile(Constant.XLS_EXTENSION, msg);
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
                row_n = subject.getID();
                data = subject.getData('MRI');
                row_d = data.getValue()';
                row_names{j, 1} = row_n; %#ok<AGROW>
                row_datas{j, 1} = row_d; %#ok<AGROW>
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
                'Braph', Constant.VERSION, ...
                'Build', Constant.BUILD, ...
                'BrainRegionsLabels', labels, ...
                'SubjectData', struct( ...
                'name', row_names, ...
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
