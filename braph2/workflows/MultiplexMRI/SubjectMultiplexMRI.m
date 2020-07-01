classdef SubjectMultiplexMRI < Subject
    % SubjectMultiplexMRI A subject of type multiplex MRI.
    % SubjectMultiplexMRI represents a subject of type multiplex MRI with 2 layers.
    %
    % SubjectMultiplexMRI methods (Access=protected)
    %   SubjectMultiplexMRI     - constructor
    %
    % SubjectMultiplexMRI inspection methods (Static)
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
    % See also Group, Cohort, Subject, SubjectMRI, SubjectfMRI, SubjectDTI.
    
    methods  % Constructor
        function sub = SubjectMultiplexMRI(id, label, notes, atlas, varargin)
            % SUBJECTMULTIPLEXMRI(ATLAS) creates a subject of type multiplex MRI.
            % ATLAS is the brain atlas that subject multiplex MRI will use (it can
            % be either a BrainAtlas or a cell array with a single BrainAtlas).
            %
            % SUBJECTMULTIPLEXMRI(ATLASES, 'SubjectID', ID) creates a subject with
            % subject id ID.
            %
            % SUBJECTMULTIPLEXMRI(ATLASES, 'age', AGE, 'MRI1', MRI1, 'MRI2', MRI2) creates a subject
            % with age AGE, mri first layer data MRI1 and mri second layer data MRI2.
            %
            % See also See also Group, Cohort, SubjectfMRI, SubjectDTI, Subject.
            
            if isa(atlas, 'BrainAtlas')
                atlases = {atlas};
            else
                assert(iscell(atlas) && length(atlas)==1, ...
                    [BRAPH2.STR ':SubjectMultiplexMRI:' BRAPH2.WRONG_INPUT], ...
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
            % INITIALIZE_DATADICT(SUB, 'age', AGE, 'MRI1', MRI1, 'MRI2', MRI2) 
            % initializes the data ditionary with data type and data code of 
            % subject multiplex MRI.
            %
            % See also update_brainatlases().
            
            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            
            age = get_from_varargin(0, 'age', varargin{:});
            mri1 = get_from_varargin(zeros(atlas.getBrainRegions().length(), 1), 'MRI1', varargin{:});  % column vector with the same number of elements as the BrainAtlas
            mri2 = get_from_varargin(zeros(atlas.getBrainRegions().length(), 1), 'MRI2', varargin{:});  % column vector with the same number of elements as the BrainAtlas
            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas, age);
            sub.datadict('MRI1') = DataStructural(atlas, mri1);
            sub.datadict('MRI2') = DataStructural(atlas, mri2);
        end
        function update_brainatlases(sub, atlases)
            % UPDATE_BRAINATLASES updates the atlases of the subject multiplex MRI
            %
            % UPDATE_BRAINATLASES(SUB, ATLASES) updates the atlases of the
            % subject multiplex MRI using the new values ATLASES. ATLASES must be a
            % cell array with a single BrainAtlas.
            %
            % See also initialize_datadict().
            
            sub.atlases = atlases;
            atlas = atlases{1};
            
            d1 = sub.datadict('age');
            d1.setBrainAtlas(atlas)
            
            d2 = sub.datadict('MRI1');
            d2.setBrainAtlas(atlas);
            
            d3 = sub.datadict('MRI2');
            d3.setBrainAtlas(atlas);
        end
    end
    methods (Static)  % Inspection functions
        function subject_class = getClass()
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS() returns the class SubjectMultiplexMRI.
            %
            % See also getList(), getDescription(), getName()
            
            subject_class = 'SubjectMultiplexMRI';
        end
        function name = getName()
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME() returns the name: Subject multiplex structural MRI.
            %
            % See also getList(), getClass(), getDescription().
            
            name = 'Subject multiplex structural MRI';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of SubjectMultiplexMRI.
            %
            % See also getList(), getName(), getClass().
            
            description = [ ...
                'Subject with multiplex structural MRI data (2 layers), ' ...
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
            %   MRI1           -    DataStructural.
            %   MRI2           -    DataStructural.
            %
            % See also getList()
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('MRI1') = 'DataStructural';
            datalist('MRI2') = 'DataStructural';
        end
        function data_number = getDataNumber()
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER() returns the number of data of subject 
            % multiplex MRI.
            %
            % See also getDataList(), getBrainAtlasNumber().
            
            data_number = Subject.getDataNumber('SubjectMultiplexMRI');
        end
        function data_codes = getDataCodes()
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject multiplex MRI data keys.
            %
            % See also getList()
            
            data_codes = Subject.getDataCodes('SubjectMultiplexMRI');
        end
        function data_classes = getDataClasses()
            % GETDATACLASSES returns the list of data classes
            %
            % CELL ARRAY = GETDATACLASSES(SUB) returns a cell array of
            % subject multiplex MRI data classes.
            %
            % CELL ARRAY = GETDATACLASSES(SUBJECT_CLASS) returns a
            % cell array of subject multiplex MRI data classes to the 
            % subject whose class is SUBJECT_CLASS.
            %
            % See also getList(), getDataCodes(), getDataClass().
            
            data_classes = Subject.getDataClasses('SubjectMultiplexMRI');
        end
        function data_class = getDataClass(data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE
            %
            % See also getList(), getDataClasses().
            
            data_class = Subject.getDataNumber('SubjectMultiplexMRI', data_code);
        end
    end
    methods (Static)  % Save/load functions
        function cohort = load_from_xls(subject_class, atlases, varargin)
            % file (fullpath)
            file1 = get_from_varargin('', 'File1', varargin{:});
            if isequal(file1, '')  % select file
                msg = get_from_varargin(Constant.XLS_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(Constant.XLS_EXTENSION, msg);
                file1 = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            % file (fullpath)
            file2 = get_from_varargin('', 'File2', varargin{:});
            if isequal(file2, '')  % select file
                msg = get_from_varargin(Constant.XLS_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(Constant.XLS_EXTENSION, msg);
                file2 = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % creates cohort
            cohort = Cohort('', '', '', subject_class, atlases, {});
            
            [~, ~, raw1] = xlsread(file1);
            [~, ~, raw2] = xlsread(file2);
            
            % Assert both files have the same size (they should contain
            % same number of regions and same number of subjects)
            assert(size(raw1) && size(raw2), ...
                [BRAPH2.STR ':SubjectMultiplexMRI:' BRAPH2.WRONG_INPUT], ...
                'The input files must have the same number of subjects with data from the same brain regions')
            
            for i = 2:1:size(raw1, 1)
                subject = Subject.getSubject(subject_class, ...                    
                    raw1{i, 1}, raw1{i, 2}, raw1{i, 3}, atlases, ...
                    'MRI1', cell2mat(raw1(i, 4:size(raw1, 2))')), ...
                    'MRI2', cell2mat(raw2(i, 4:size(raw2, 2))')) ;
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            
            % creates group
            group = Group(subject_class,'', '', '', cohort.getSubjects().getValues());
            path = [fileparts(which(file))]; %#ok<NBRAK>
            file_name = erase(file, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.xls');
            file_name = erase(file_name, '.xlsx');
            group.setID(file_name);
            cohort.getGroups().add(group.getID(), group);
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
            cohort = Cohort('', '', '', subject_class, atlases, {});
            
            % reads file
            raw = readtable(file, 'Delimiter', '\t');
            
            for i = 1:1:size(raw, 1)  % first row is being read as table label
                subject = Subject.getSubject(subject_class, ...                    
                    char(raw{i, 1}), char(raw{i, 2}), char(raw{i, 3}), atlases, ...
                    'MRI', raw{i, 4:size(raw, 2)}');
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            group = Group(subject_class, '', '', '', cohort.getSubjects().getValues());
            path = [fileparts(which(file))]; %#ok<NBRAK>
            file_name = erase(file, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.txt');
            group.setID(file_name);
            cohort.getGroups().add(group.getID(), group);
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
            cohort = Cohort('', '', '', subject_class, atlases, {});
            
            raw = jsondecode(fileread(file));     
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
            
            % creates group
            group = Group(subject_class, '', '', '', cohort.getSubjects().getValues());
            path = [fileparts(which(file))]; %#ok<NBRAK>
            file_name = erase(file, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.json');
            group.setID(file_name);
            cohort.getGroups().add(group.getID(), group);
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
