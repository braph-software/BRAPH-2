classdef Subject < handle & matlab.mixin.Copyable
    % Subject (Abstract) A subject 
    % Subject provides the methods necessary for all subjects
    % It is a subclass of handle & matlab.mixin.Copyable
    %
    % Instances of the class cannot be created. Use one of the subclasses
    % (e.g., SubjectMRI, SubjectfMRI, SubjectDTI). The subclasses must be
    % created inside the folder containing the respective workflow (e.g.,
    % ./braph/workflows/MRI/, ./braph/workflows/fMRI/,
    % ./braph/workflows/DTI/).
    %
    % Subject methods (Access = protected):
    %   Subject                 - Constructor
    %
    % Subject basic methods:    
    %   tostring                - returns a string representing the subject
    %   disp                    - displays the subject
    %
    % Subject methods (Abstract, Access=protected)
    %   initialize_datadict     - initializes the data dictionary
    %   update_brainatlases     - updates the brain atlases
    %
    % Subject set methods:
    %   setID                   - sets the ID
    %   setLabel                - sets the label
    %   setNotes                - sets the notes
    %   setBrainAtlases         - sets the brain atlas to the subject
    %
    % Subject get methods: 
    %   getID                   - returns the ID
    %   getLabel                - returns the label
    %   getNotes                - returns the notes
    %   setBrainAtlases         - sets the brain atlases 
    %   getData                 - returns the data from DATADICT
    %
    % Subject plot methods
    %   getDataPanel            - returns a uicontrol handle
    %
    % Subject inspection methods (Static):
    %   getList                 - returns a list with subclasses of Subject
    %   getClass                - returns the class of the subclass
    %   getName                 - returns the name of the subclass
    %   getDescription          - returns the description of the subclass
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of the subclass
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data
    %   getDataClasses          - returns the class of the type of all data of the subclass
    %   getDataClass            - returns the class of the type of a data of the subclass
    %   getSubject              - returns a new instantiation of a subclass
    %
    % Subject GUI methods (Static):
    %   getMenuAtlasPanel       - returns a GUIBrainAtlas uimenu handle
    %
    % Subject load and save methods (Abstract, Static):
    %   load_from_xls           - reads a '.xls' or '.xlsx' file, loads the data to a new subject
    %   save_to_xls             - saves the subject data to a '.xls' or '.xlsx' file
    %   load_from_txt           - reads a '.txt' file, loads the data to a new subject
    %   save_to_txt             - saves the subject data to a '.txt' file
    %   load_from_json          - reads a '.json' file, loads the data to a new subject
    %   save_to_json            - saves the subject data to a '.json' file
    %
    % See also Group, Cohort, SubjectDTI, SubjectMRI, SubjectfMRI.
    
    properties (GetAccess=protected, SetAccess=protected)
        id  % subject id
        label  % subject label
        notes  % subject notes
        atlases % cell array with brain atlases
        datadict  % dictionary with subject data
        h_panel
    end
    methods (Access=protected)  % Constructor
        function sub = Subject(id, label, notes, atlases, varargin)
            % SUBJECT creates a subject
            %
            % SUBJECT(ID, LABEL, NOTES, ATLASES) creates a subject with ID,
            % LABEL, NOTES and ATLASES which are the brain atlases that subject will use.
            % This method is only accessible by the subclasses of Subject.
            %
            % SUBJECT(ID, LABEL, NOTES, ATLASES, 'PROPERTYRULE1, 'VALUE1, ...)
            % creates a subject with subject ID, LABEL NOTES and ATLASES.
            % Subject will be initialized with the settings passed in the
            % VARARGIN.
            % 
            % See also Group, Cohort, SubjectMRI, SubjectfMRI, SubjectDTI.
            
            assert(iscell(atlases) && all(cellfun(@(atlas) isa(atlas, 'BrainAtlas'), atlases)), ...
                [BRAPH2.STR ':' class(sub) ':' BRAPH2.WRONG_INPUT], ...
                'The input atlases must be a cell array of BrainAtlas.')
            sub.atlases = atlases;
            
            sub.setID(id)
            sub.setLabel(label)
            sub.setNotes(notes)
            
            sub.initialize_datadict(atlases, varargin{:})
            
            data_codes = sub.getDataCodes();            
            for i = 1:1:numel(data_codes)
                data_code = data_codes{i};
                value = get_from_varargin(sub.getData(data_code).getValue(), data_code, varargin{:});
                sub.getData(data_code).setValue(value);
            end
        end
    end
    methods  % Basic functions
        function str = tostring(subject)
            % TOSTRING string with information about the subject
            %
            % STR = TOSTRING(SUBJECT) returns string with the subject class and id.
            %
            % See also disp.
            
            str = [Subject.getClass(subject) ' ' tostring(subject.getID())];
        end
        function disp(subject)
            % DISP displays information about the subject
            %
            % DISP(SUBJECT) displays information about the subject.
            % It provides information about subject class, id and data
            % codes.
            %
            % See also tostring.
            
            disp(['<a href="matlab:help ' Subject.getClass(subject) '">' Subject.getClass(subject) '</a>' ...
                ' ID:' tostring(subject.getID())])
            data_codes = subject.getDataCodes();
            for i = 1:1:subject.getDataNumber()
                data_code = data_codes{i};
                d = subject.getData(data_code);
                disp([data_code ' = ' d.tostring()])
            end
        end
    end
    methods (Abstract, Access=protected)  % Abstract utility functions
        initialize_datadict(sub, varargin)  % initializes the datadict
        update_brainatlases(sub, atlases)  % updates brainatlases also in datadict
    end
	methods  % Set functions
        function setID(sub, id)
            % SETID sets the id of the subject
            %
            % SETID(SUBJECT, ID) sets the id of the subject.
            %
            % See also getID, setLabel, setNotes, setBrainAtlases.
            
            assert(ischar(id), ...
                [BRAPH2.STR ':' class(sub) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')

            sub.id = id;
        end
        function setLabel(sub, label)
            % SETLABEL sets the label of the subject
            %
            % SETLABEL(SUBJECT, LABEL) sets the label of the subject.
            %
            % See also setID, setNotes, setBrainAtlases, getLabel.

            assert(ischar(label), ...
                [BRAPH2.STR ':' class(sub) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')
            
            sub.label = label;
        end        
        function setNotes(sub, notes)
            % SETNOTES sets the notes of the subject
            %
            % SETNOTES(SUBJECT, NOTES) sets the notes of the subject.
            %
            % See also setID, setLabel, setBrainAtlases, getNotes.

            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(sub) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')
            
            sub.notes = notes;
        end        
        function setBrainAtlases(sub, atlases)
            % SETBRAINATLASES sets the atlases of the subject
            %
            % SETBRAINATLASES(SUBJECT, ATLASES) sets the array ATLASES
            % with brain atlases. 
            %
            % See also setID, setLabel, setNotes, getBrainAtlases.
            
            sub.update_brainatlases(atlases);
        end  
        function setData(sub, varargin)
            % SETDATA sets the data to and already existing value
            %
            % SETDATA(SUB, AGE, VALUE, DATATYPE, VALUE) sets the VALUE of
            % DATATYPE type to and already initialized value. It may
            % containg AGE VALUE. 
            %
            % See also setID, getData.
            
            data_codes = sub.getDataCodes();
            data_list = sub.getDataList();
            age_data_object = data_list(data_codes{2});
            data_object = data_list(data_codes{1});
            
            atlas = sub.atlases{1}; %#ok<NASGU>
            
            old_data = sub.getData(data_codes{1}).getValue();
            
            age = get_from_varargin(0, 'age', varargin{:}); %#ok<NASGU>
            data = get_from_varargin(zeros(size(old_data)), data_codes{1}, varargin{:}); %#ok<NASGU>
            sub.datadict(data_codes{2}) = eval([age_data_object '(atlas, age)']);
            sub.datadict(data_codes{1}) = eval([data_object '(atlas, data)']);            
            
        end
    end
    methods  % Get functions
        function id = getID(sub)
            % GETID returns the id of the subject.
            %
            % ID = GETID(SUBJECT) returns the id of the subject.
            %
            % See also setID, getLabel, getNotes, getBrainAtlases, getData.
            
            id = sub.id;
        end
        function label = getLabel(sub)
            % GETLABEL returns the label of the subject.
            %
            % LABEL = GETLABEL(SUBJECT) returns the label of the subject.
            %
            % See also getID, getNotes, getBrainAtlases, getData, setLabel.
            
            label = sub.label;
        end
        function notes = getNotes(sub)
            % GETNOTES returns the notes of the subject.
            %
            % NOTES = GETNOTES(SUBJECT) returns the notes of the subject.
            %
            % See also getID, getLabel, getBrainAtlases, getData, setNotes.

            notes = sub.notes;
        end
        function atlases = getBrainAtlases(sub)
            % GETBRAINATLASES returns the brain atlases from the ATLASES.
            %
            % ATLASES = GETBRAINATLASES(SUB) returns the brain atlases from 
            % the ATLASES.
            %
            % See also getID, getLabel, getNotes, getDATA, setBrainAtlases.
            
            atlases = sub.atlases;
        end
        function d = getData(sub, data_code)
            % GETDATA returns the data from the DATADICT
            %
            % D = GETDATA(SUB, DATACODE) returns the data from the DATADICT
            %
            % See also getID, getLabel, getNotes, getBrainAtlases.
            
            d = sub.datadict(data_code);
        end
    end
    methods  % Plot functions
        function h = getDataPanel(sub, ui_parent)
            % GETDATAPANEL returns a panel handle with data ui content
            %
            % H = GETDATAPANEL(SUB, PARENT) creates a uipanel handle and
            % sets it to PARENT, then it creates uicontrols for each data
            % type the datadict has. It populates the controls dynamically
            % with the corresponding data.
            %
            % See also getMenuAtlasPanel.
            
            data_codes = sub.getDataCodes();
            data_list = sub.getDataList(); 
            atlas = sub.atlases{1};
            
            sub.h_panel = uipanel('Parent', ui_parent);
            set(sub.h_panel, 'Units', 'normalized')
            set(sub.h_panel, 'Position', [0 0 1 1])          

            % create data tables
            height = 1/length(data_list);
            width = 1;
            x = 0;
            for i = 1:1:length(data_list)
                y = 1 - i * height;

                inner_panel = uipanel('Parent', sub.h_panel);                
                set(inner_panel, 'Position', [x y width height])
                set(inner_panel, 'Title', data_codes{i})
                
                inner_obj = sub.getData(data_codes{i});
                
                tbl = inner_obj.getDataPanel(inner_panel);                
            end
             if nargout > 0
                h = sub.h_panel;
            end   
        end        
    end
    methods (Static)  % Inspection functions
        function subject_list = getList()
            % GETLIST returns the list of available subjects
            %
            % SUBJECT_LIST = GETLIST() returns the list of subjects
            % (cell array) that are subclasses of Subject.
            %
            % See also getClass, getName, getDescription.
            
            subject_list = subclasses('Subject');
        end
        function subject_class = getClass(sub)
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS(SUB) returns the class of the concrete
            % instance of subject SUB.
            %
            % SUBJECT_CLASS = GETCLASS(SUBJECT_CLASS) returns the class of the
            % subject whose class is the string SUBJECT_CLASS.
            %
            % See also getList, getDescription, getName.
            
            % subject class (same as the subject object name)
            
            if isa(sub, 'Subject')
                subject_class = class(sub);
            else % g should be a string with the subject class
                subject_class = sub;
            end
        end
        function name = getName(sub)
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME(SUB) returns the name (string) of the concrete instance
            % of subject SUB.
            %
            % NAME = GETNAME(SUBJECT_CLASS) returns the name (string) of the
            % subject whose class is the string SUBJECT_CLASS.
            %
            % See also getList, getClass, getDescription.
            
            % subject name
            
            name = eval([Subject.getClass(sub) '.getName()']);
        end
        function description = getDescription(sub)
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION(SUB) returns the description
            % (string) of the concrete instance of subject SUB
            %
            % DESCRIPTION = GETDESCRIPTION(SUBJECT_CLASS) returns the
            % description (string) of the subject whose class is SUBJECT_CLASS.
            %
            % See also getList, getName, getClass, getBrainAtlasNumber.
            
            % subject description
            
            description = eval([Subject.getClass(sub) '.getDescription()']);
        end
        function atlas_number = getBrainAtlasNumber(sub)
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % N = GETBRAINATLASNUMBER(SUB) returns the number of
            % brain atlases to the concrete subject SUB.
            %
            % N = GETBRAINATLASNUMBER(SUBJECT_CLASS) returns the number
            % of brain atlases to the subject whose class is SUBJECT_CLASS.
            %
            % See also getList, getDescription, getName, getClass.
            
            % number of differetn brain atlases
            
            atlas_number = eval([Subject.getClass(sub) '.getBrainAtlasNumber()']);
        end
        function datalist = getDataList(sub)            
            % GETDATALIST returns the list of data
            %
            % CELL ARRAY = GETDATALIST(SUB) returns a cell array of
            % subject data.
            %
            % CELL ARRAY = GETDATALIST(SUBJECT_CLASS) returns a 
            % cell array of subject data to the subject whose class is
            % SUBJECT_CLASS.
            %
            % See also getList, getDataNumber, getDataCodes, getDataClasses
            
            % list of subject data keys
            
            datalist = eval([Subject.getClass(sub) '.getDataList()']);
        end
        function data_number = getDataNumber(sub)
            % GETDATANUMBER returns the number of data
            %
            % N = GETDATANUMBER(SUB) returns the number of data of the
            % subclass SUB
            %
            % N = GETDATANUMBER(SUBJECT_CLASS) returns the number
            % of data to the subject whose class is SUBJECT_CLASS.
            %
            % See also getDataList, getBrainAtlasNumber, getDataCodes
            
            datalist = Subject.getDataList(sub);
            data_number = length(datalist);
        end
        function data_codes = getDataCodes(sub)
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject data keys.
            %
            % CELL ARRAY = GETDATACODES(SUBJECT_CLASS) returns a 
            % cell array of subject data keys to the subject whose class is
            % SUBJECT_CLASS.
            %
            % See also getList, getDataNumber, getDataList, getDataClasses
            
            datalist = Subject.getDataList(sub);
            data_codes = keys(datalist);
        end
        function data_classes = getDataClasses(sub)
            % GETDATACLASSES returns the list of data classes
            %
            % CELL ARRAY = GETDATACLASSES(SUB) returns a cell array of
            % subject data classes.
            %
            % CELL ARRAY = GETDATACLASSES(SUBJECT_CLASS) returns a 
            % cell array of subject data classes to the subject whose class is
            % SUBJECT_CLASS.
            %
            % See also getList, getDataCodes, getDataList, getDataClass
            
            datalist = Subject.getDataList(sub);
            data_classes = values(datalist);
        end
        function data_class = getDataClass(sub, data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE.
            %
            % See also getList, getDataClasses, getDataList, getDataClasses
            
            datalist = Subject.getDataList(sub);
            data_class = datalist(data_code);
        end
        function sub = getSubject(subject_class, varargin)
            % GETSUBJECT returns a subject 
            %
            % SUB = GETSUBJECT(SUBJECT_CLASS, VARARGIN) returns an instance
            % of the class of the subject SUBJECT_CLASS with arguments
            % VARARGIN. It initializes the new instance of the subject
            % class.
            %
            % See also getList, getDataClass, getDataCodes, getDataNumber
            
            sub = eval([subject_class '(varargin{:})']);
        end
    end
    methods (Access=protected)  % Deep copy
        function sub_copy = copyElement(sub)
            % COPYELEMENT(SUB) copies elements of subject
            %
            % SUB_COPY = COPYELEMENT(SUB) copies elements of the subject SUB.
            % Makes a deep copy of the structure of subject. But it does
            % not make a deep copy of the brain atlases in the data
            % objects.
            %
            % See also Cohort, Group, Graph.
            
            % IMPORTANT! It does NOT make a deep copy of the BrainAtlas
            % atlas in the data objects
            
            % Make a shallow copy
            sub_copy = copyElement@matlab.mixin.Copyable(sub);
            
            % Make a deep copy of datadict
            sub_copy.datadict = containers.Map;
            data_codes = keys(sub.datadict);
            for i = 1:1:length(data_codes)
                data_code = data_codes{i};
                d = sub.getData(data_code);
                sub_copy.datadict(data_code) = d.copy();
            end
        end
    end
    methods (Static)  % GUI functions
        function sub_atlas_menu = getMenuAtlasPanel(sub, atlas, ui_menu_parent) 
            % GETMENUATLASPANEL ui menu item to open cohort
            %
            % H = GETMENUATLASPANEL(SUBJECT, ATLAS, UI_MENU_PARENT) creates
            % a ui menu item to open a new GUI Cohrort for SUBJECT (which
            % can be either a subject class or a subject object), connects
            % it to UI_MENU_PARENT, and returns an handle to the ui menu
            % item.
            %
            % See also getDataPanel.

            sub_atlas_menu = uimenu(ui_menu_parent);
            set(sub_atlas_menu, 'Label', [Subject.getName(sub) ' Cohort'])
            set(sub_atlas_menu, 'Callback', {@subject_menu_atlas})
            
            function subject_menu_atlas(~, ~)
                GUICohort(atlas.copy(), Subject.getClass(sub));
            end
        end
    end
    methods (Abstract, Static)  % Save/load functions
        cohort = load_from_xls(tmp, varargin)  % tmp = cohort/atlases
        save_to_xls(cohort, varargin)
        cohort = load_from_txt(tmp, varargin)  % tmp = cohort/atlases
        save_to_txt(cohort, varargin)
        cohort = load_from_json(tmp, varargin)  % tmp = cohort/atlases
        save_to_json(cohort, varargin)
    end
end