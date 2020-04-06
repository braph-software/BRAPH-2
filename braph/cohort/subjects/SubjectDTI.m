classdef SubjectDTI < Subject
    % SubjectDTI < Subject: A subject of type DTI.
    % SubjectDTI represents a subject of type DTI.
    %
    % SubjectDTI methods (Access=protected)
    %   SubjectDTI                 - Constructor.
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
            % SUBJECTDTI(ATLASES, VARARGIN) creates a subject of type dti with the 
            % properties VARARGIN. ATLASES is the brain atlases that subject dti will use.
            % VARARGIN contains information about the subject dti id and the
            % data codes utilized in the DATADICT. This method passes
            % varargin to its super constructor Subject. 
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
            % INITIALIZE_DATADICT(SUB, VARARGIN) initializes the data
            % ditionary with data type and data code of subject dti.
            %
            % See also update_brainatlases().

            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas);
            sub.datadict('DTI') = DataConnectivity(atlas);
        end
        function update_brainatlases(sub, atlases)
            % UPDATE_BRAINATLASES updates the atlases of the subject dti
            % 
            % UPDATE_BRAINATLASES(SUB, ATLASES) updates the atlases of the
            % subject dti using the new values ATLASES.
            % 
            % See also initialize_datadict()

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
            %   Age             -    DataScalar.
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
            % See also getList(), ().
            
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
end