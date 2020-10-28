classdef Subject < handle & matlab.mixin.Copyable
    % Subject < handle & matlab.mixin.Copyable (Abstract): A subject 
    % Subject provides the methods necessary for all subjects.
    % Instances of ths class cannot be created.
    % Use one of the subclasses (e.g., SubjectMRI, SubjectfMRI, SubjectDTI)
    % The subclasses must be created inside the folder containing the
    % respective workflow (e.g., ./braph/workflows/MRI/,
    % ./braph/workflows/fMRI/, ./braph/workflows/DTI/).
    %
    % Subject properties (GetAccess=protected, SetAccess=protected):
    %   id                      - id of the subject.
    %   atlases                 - cell array with brain atlases.
    %   datadict                - dictionary with subject data
    %                             (key, value) = (char, subject data type)
    %
    % Subject methods (Access=protected)
    %   Subject                 - Constructor.
    %   sub_copy                - deep copy community structure.
    %
    % Subject methods:    
    %   tostring                - returns a string representing the subject.
    %   disp                    - displays the subject.
    %   setID                   - sets the ID.
    %   getID                   - returns the ID.
    %   getData                 - returns the data from DATADICT
    %   setBrainAtlases         - sets the brain atlases
    %   getBrainAtlases         - returns the brain atlases from ATLASES
    %
    % Subject methods (Abstract, Access=protected)
    %   initialize_datadict     - initializes the data dictionary DATADICT.
    %   update_brainatlases     - updates the brain atlases in DATADICT.
    %
    % Subject methods (Static)
    %   getList                 - returns a list with subclasses of Subject
    %   getClass                - returns the class of the subclass.
    %   getName                 - returns the name of the subclass.
    %   getDescription          - returns the description of the subclass.
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of the subclass
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data.
    %   getDataClasses          - returns the class of the type of all data of the subclass.
    %   getDataClass            - returns the class of the type of a data of the subclass.
    %   getSubject              - returns a new instantiation of a subclass
    %
    % See also Group, Cohort, SubjectDTI, SubjectMRI, SubjectfMRI.
    
    properties (GetAccess=protected, SetAccess=protected)
        id  % subject id
        atlases % cell array with brain atlases
        datadict  % dictionary with subject data
    end
    methods (Access=protected)
        function sub = Subject(atlases, varargin)
            % SUBJECT(ATLASES) creates a subject. 
            % ATLASES is the brain atlases that subject will use.
            % VARARGIN contains information about the subject id and the
            % data codes utilized in the DATADICT.
            % This method is only accessible by the subclasses of Subject.
            %
            % SUBJECT(ATLASES, 'SubjectID', ID) creates a subject with
            % subject id ID.
            %
            % SUBJECT(ATLASES, 'DataCode1', Data1, 'DataCode2', Data2, ...) 
            % creates a subject and initialize its data.
            % 
            % See also Group, Cohort, SubjectMRI, SubjectfMRI, SubjectDTI
            
            assert(iscell(atlases), ...
                ['BRAIN:Subject:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects']) %#ok<NBRAK>
            sub.atlases = atlases;
            
            id = get_from_varargin(now(), 'SubjectID', varargin{:});
            sub.setID(id)
            
            sub.initialize_datadict(atlases, varargin{:})
            
            data_codes = sub.getDataCodes();            
            for i = 1:1:numel(data_codes)
                data_code = data_codes{i};
                value = get_from_varargin(sub.getData(data_code).getValue(), data_code, varargin);
                sub.getData(data_code).setValue(value);
            end
        end
        function sub_copy = copyElement(sub)
            % COPYELEMENT(SUB) copies elements of subject.
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
    methods
        function str = tostring(subject)
            % TOSTRING string with information about the subject
            %
            % STR = TOSTRING(SUBJECT) returns string with the subject class and id.
            %
            % See also disp().
            
            str = [Subject.getClass(subject) ' ' tostring(subject.getID())];
        end
        function disp(subject)
            % DISP displays information about the subject
            %
            % DISP(SUBJECT) displays information about the subject.
            % It provides information about subject class, id and data
            % codes.
            %
            % See also tostring().
            
            disp(['<a href="matlab:help ' Subject.getClass(subject) '">' Subject.getClass(subject) '</a>' ...
                ' ID:' tostring(subject.getID())])
            data_codes = subject.getDataCodes();
            for i = 1:1:subject.getDataNumber()
                data_code = data_codes{i};
                d = subject.getData(data_code);
                disp([data_code ' = ' d.tostring()])
            end
        end
        function setID(sub, id)
            % SETID sets the id of the subject.
            %
            % ID = SETID(SUBJECT, ID) sets the id of the subject.
            %
            % See also getID(), getData(), setBrainAtlases().
            
            sub.id = id;
        end
        function id = getID(sub)
            % GETID returns the id of the subject.
            %
            % ID = GETID(SUBJECT) returns the id of the subject.
            %
            % See also setID(), getData(), setBrainAtlases().
            
            id = sub.id;
        end
        function d = getData(sub, data_code)
            % GETDATA returns the data from the DATADICT
            %
            % D = GETDATA(SUB, DATACODE) returns the data from the DATADICT
            %
            % See also getID(), getBrainAtlases().
            
            d = sub.datadict(data_code);
        end
        function setBrainAtlases(sub, atlases)
            % SETBRAINATLASES sets the of the subject.
            %
            % ID = SETBRAINATLASES(SUBJECT, ATLASES) sets the array ATLASES
            % with brain atlases. 
            %
            % See also getID(), getData(), getData().
            
            sub.update_brainatlases(atlases);
        end
        function atlases = getBrainAtlases(sub)
            % GETBRAINATLASES returns the brain atlases from the ATLASES.
            %
            % ATLASES = GETBRAINATLASES(SUB) returns the brain atlases from 
            % the ATLASES.
            %
            % See also getID(), getDATA().
            
            atlases = sub.atlases;
        end
    end
    methods (Abstract, Access=protected)
        initialize_datadict(sub, varargin)  % initialized the data_dict
        update_brainatlases(sub, atlases)  % updates brainatlases also in datadict
    end
    methods (Static)
        function subject_list = getList()
            % GETLIST returns the list of available subjects
            %
            % SUBJECT_LIST = GETLIST() returns the list of subjects
            % (cell array) that are subclasses of Subject.
            %
            % See also getClass(), getName()
            
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
            % See also getList(), getDescription().
            
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
            % See also getList(), getClass().
            
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
            % See also getList(), getName(), getClass().
            
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
            % See also getList(), getDescription(), getName(), getClass().
            
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
            % See also getList()
            
            % list of subject data keys
            
            datalist = eval([Subject.getClass(sub) '.getDataList()']);
        end
        function data_number = getDataNumber(sub)
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER(SUB) returns the number of data of the
            % subclass SUB
            %
            % N = GETDATANUMBER(SUBJECT_CLASS) returns the number
            % of  data to the subject whose class is SUBJECT_CLASS.
            %
            % See also getDataList(), getBrainAtlasNumber().
            
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
            % See also getList().
            
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
            % See also getList(), getDataCodes(), getDataClass()
            
            datalist = Subject.getDataList(sub);
            data_classes = values(datalist);
        end
        function data_class = getDataClass(sub, data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE  
            %
            % See also getList(), getDataClasses().
            
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
            % See also getList(), getDataClass().
            
            sub = eval([subject_class '(varargin{:})']);
        end
    end
end