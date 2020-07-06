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
            
            % search for cohort info file           
            file_path = strsplit(file1, filesep());
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
            
            [~, ~, raw1] = xlsread(file1);
            [~, ~, raw2] = xlsread(file2);           
            % Assert both files have the same size (they should contain
            % same number of regions and same number of subjects)
            assert(size(raw1, 1) == size(raw2, 1) && size(raw1, 2) == size(raw2, 2), ...
                [BRAPH2.STR ':SubjectMultiplexMRI:' BRAPH2.WRONG_INPUT], ...
                'The input excel files must have the same number of subjects with data from the same brain regions')
            
            for i = 5:1:size(raw1, 1)
                subject = Subject.getSubject(subject_class, ...
                    char(raw1{i, 1}), char(raw1{i, 2}), char(raw1{i, 3}), atlases, ...
                    'MRI1', cell2mat(raw1(i, 4:size(raw1, 2))'), ...
                    'MRI2', cell2mat(raw2(i, 4:size(raw2, 2))'));
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            group = Group(subject_class,'', '', '', cohort.getSubjects().getValues());
            path1 = [fileparts(which(file1))]; %#ok<NBRAK>
            file_name1 = erase(file1, path1);
            file_name1 = erase(file_name1, filesep());
            file_name1 = erase(file_name1, '.xlsx');
            file_name1 = erase(file_name1, '.xls'); 
            group.setID(file_name1);
            group.setLabel(raw1{2, 1});  % set group info
            group.setNotes(raw1{3, 1});
            cohort.getGroups().add(group.getID(), group);
        end
        function save_to_xls(cohort, varargin)
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
            
            % cohort info           
            file_path = strsplit(file1, filesep());
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
                row_datas1{j, 1} = subject.getData('MRI1').getValue(); %#ok<AGROW>
                row_datas2{j, 1} = subject.getData('MRI2').getValue(); %#ok<AGROW>
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
            first_row_table1 = [first_row_table1(:, 2) first_row_table1(:, 3) ...
                first_row_table1(:, 4) first_row_table1(:, 1)];
            first_row_table2 = table(row_data, 'VariableNames', {'row_datas2'});
            first_row_table2.row_ids = row_id;
            first_row_table2.row_labels = row_label;
            first_row_table2.row_notes = row_notes;
            first_row_table2 = [first_row_table2(:, 2) first_row_table2(:, 3) ...
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
            writecell(group_info, file1);
            writecell(group_info, file2);
            writetable(tab1, file1, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A4');
            writetable(tab2, file2, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A4');
        end
        function cohort = load_from_txt(subject_class, atlases, varargin)
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
            
            % search for cohort info file
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

            if exist(file_cohort, 'file')
                raw_cohort = textread(file_cohort, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
                cohort_id = raw_cohort{1, 1};
                cohort_label = raw_cohort{2, 1};
                cohort_notes = raw_cohort{3, 1};
            end
            
            % creates cohort
            cohort = Cohort(cohort_id, cohort_label, cohort_notes, subject_class, atlases, {});
            
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
            raw1 = readtable(file1, 'Delimiter', '\t');
            raw2 = readtable(file2, 'Delimiter', '\t');
            assert(size(raw1, 1) == size(raw2, 1) && size(raw1, 2) == size(raw2, 2), ...
                [BRAPH2.STR ':SubjectMultiplexMRI:' BRAPH2.WRONG_INPUT], ...
                'The input txt files must have the same number of subjects with data from the same brain regions')
            
            for i = 1:1:size(raw1, 1)  % first row is being read as table label
                subject = Subject.getSubject(subject_class, ...                    
                    char(raw1{i, 1}), char(raw1{i, 2}), char(raw1{i, 3}), atlases, ...
                    'MRI1', raw1{i, 4:size(raw1, 2)}', ...
                    'MRI2', raw2{i, 4:size(raw2, 2)}');
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            % creates group
            group = Group(subject_class, group_id, group_label, group_notes, cohort.getSubjects().getValues());
            path = [fileparts(which(file1))]; %#ok<NBRAK>
            file_name = erase(file1, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.txt');
            group.setID(file_name);
            group.setLabel(group_label);
            group.setNotes(group_notes);
            cohort.getGroups().add(group.getID(), group);
        end
        function save_to_txt(cohort, varargin)
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
            
            % cohort info
            file_path = strsplit(file1, filesep());
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
                row_datas1{j, 1} = subject.getData('MRI1').getValue(); %#ok<AGROW>
                row_datas2{j, 1} = subject.getData('MRI2').getValue(); %#ok<AGROW>
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
            fid = fopen(f_2);
            C = textscan(fid, '%s', 'delimiter', '\t');
            fclose(fid);
            for k=1:numel(C{1, 1})
                tmp = regexp(C{1, 1}(k),'"'); % find quotation marks
                C{1,1}{k,1}(tmp{1, 1}) = ''; % substitute with empty spaces
            end
            % print new file2
            fName = file2;
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
            delete(f_2);
            fclose(fid);
        end
        function cohort = load_from_json(subject_class, atlases, varargin)
            % file1 (fullpath)
            file1 = get_from_varargin('', 'File1', varargin{:});
            if isequal(file1, '')  % select file
                msg = get_from_varargin(BRAPH2.JSON_MSG_GETFILE, 'MSG', varargin{:});
                [filename1, filepath1, filterindex1] = uigetfile(BRAPH2.JSON_EXTENSION, msg);
                file1 = [filepath1 filename1];
                
                if ~filterindex1
                    return
                end
            end
            % file2 (fullpath)
            file2 = get_from_varargin('', 'File2', varargin{:});
            if isequal(file2, '')  % select file
                msg = get_from_varargin(BRAPH2.JSON_MSG_GETFILE, 'MSG', varargin{:});
                [filename2, filepath2, filterindex2] = uigetfile(BRAPH2.JSON_EXTENSION, msg);
                file2 = [filepath2 filename2];
                
                if ~filterindex2
                    return
                end
            end
            
            % creates cohort
            cohort = Cohort('', '', '', subject_class, atlases, {});
            
            raw1 = jsondecode(fileread(file1)); 
            raw2 = jsondecode(fileread(file2)); 
            assert(length(raw1.SubjectData) == length(raw2.SubjectData), ...
                [BRAPH2.STR ':SubjectMultiplexMRI:' BRAPH2.WRONG_INPUT], ...
                'The input json files must have the same number of subjects with data from the same brain regions')
            
            % get cohort and group info
            cohort_id = raw1.CohortData.id;
            cohort_label = raw1.CohortData.label;
            cohort_notes = raw1.CohortData.notes;
            group_id = raw1.GroupData.id;
            group_label = raw1.GroupData.label;
            group_notes = raw1.GroupData.notes;

            for i = 1:1:length(raw1.SubjectData)
                id = raw1.SubjectData(i).id;
                label = raw1.SubjectData(i).label;
                notes = raw1.SubjectData(i).notes;
                data1 = raw1.SubjectData(i).data;
                data2 = raw2.SubjectData(i).data;
                subject = Subject.getSubject(subject_class, ...                   
                    id, label, notes, atlases, ...
                    'MRI1', data1, 'MRI2', data2);
                cohort.getSubjects().add(subject.getID(), subject, i);
            end
            
            cohort.setID(cohort_id);
            cohort.setLabel(cohort_label);
            cohort.setNotes(cohort_notes);
            
            % creates group
            group = Group(subject_class, group_id, group_label, group_notes, cohort.getSubjects().getValues());
            path = [fileparts(which(file1))]; %#ok<NBRAK>
            file_name = erase(file1, path);
            file_name = erase(file_name, filesep());
            file_name = erase(file_name, '.json');
            group.setID(file_name);
            cohort.getGroups().add(group.getID(), group);
        end
        function save_to_json(cohort, varargin)
            % file1 (fullpath)
            file1 = get_from_varargin('', 'File1', varargin{:});
            if isequal(file1, '')  % select file
                msg = get_from_varargin(BRAPH2.JSON_MSG_GETFILE, 'MSG', varargin{:});
                [filename1, filepath1, filterindex1] = uigetfile(BRAPH2.JSON_EXTENSION, msg);
                file1 = [filepath1 filename1];
                
                if ~filterindex1
                    return
                end
            end
            % file2 (fullpath)
            file2 = get_from_varargin('', 'File2', varargin{:});
            if isequal(file2, '')  % select file
                msg = get_from_varargin(BRAPH2.JSON_MSG_GETFILE, 'MSG', varargin{:});
                [filename2, filepath2, filterindex2] = uigetfile(BRAPH2.JSON_EXTENSION, msg);
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
                row_datas1{j, 1} = subject.getData('MRI1').getValue(); %#ok<AGROW>
                row_datas2{j, 1} = subject.getData('MRI2').getValue(); %#ok<AGROW>
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
            structure_to_be_saved1 = struct( ...
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
                'data', row_datas1) ...
                );
            structure_to_be_saved2 = struct( ...
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
                'data', row_datas2) ...
                );
            
            % save json 1
            json_structure1 = jsonencode(structure_to_be_saved1);      
            fid = fopen(file1, 'w');
            if fid == -1, error('Cannot create JSON file'); end
            fwrite(fid, json_structure1, 'char');
            fclose(fid);
            % save json 2
            json_structure2 = jsonencode(structure_to_be_saved2); 
            fid = fopen(file2, 'w');
            if fid == -1, error('Cannot create JSON file'); end
            fwrite(fid, json_structure2, 'char');
            fclose(fid);
        end
    end
end
