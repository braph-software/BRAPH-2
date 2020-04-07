classdef SubjectfMRI < Subject
    % SubjectfMRI < Subject: A subject of type fMRI.
    % SubjectfMRI represents a subject of type fMRI.
    %
    % SubjectfMRI methods (Access=protected)
    %   SubjectfMRI             - Constructor.
    %
    % SubjectfMRI methods (Access=protected)
    %   initialize_datadict     - initializes the data dictionary DATADICT.
    %   update_brainatlases     - updates the brain atlases in DATADICT.
    %
    % SubjectfMRI methods (Static)
    %   getClass                - returns the class of SubjectfMRI.
    %   getName                 - returns the name of  SubjectfMRI.
    %   getDescription          - returns the description of SubjectfMRI.
    %   getBrainAtlasNumber     - returns the number of elements of Atlases
    %   getDataList             - returns the type of data of SubjectfMRI
    %   getDataNumber           - returns the number of elements of DATADICT
    %   getDataCodes            - returns the key codes of the data for SubjectfMRI
    %   getDataClasses          - returns the class of the type of all data of SubjectfMRI.
    %   getDataClass            - returns the class of the type of a data of SubjectfMRI.
    %   getSubject              - returns a new instantiation of SubjectfMRI
    %
    % See also Group, Cohort, SubjectMRI, SubjectDTI, Subject.
    methods
        function sub = SubjectfMRI(atlas, varargin)
            % SUBJECTFMRI(ATLAS) creates a subject of type fMRI. 
            % ATLAS is the brain atlas that subject fMRI will use (it can be
            % either a BrainAtlas or a cell array with a single BrainAtlas).
            % 
            % SUBJECTFMRI(ATLASES, 'SubjectID', ID) creates a subject with
            % subject id ID.
            %
            % SUBJECTFMRI(ATLASES, 'age', AGE, 'fMRI', FMRI) creates a subject
            % with age AGE and fMRI timeseries FMRI.
            %
            % See also See also Group, Cohort, SubjectMRI, SubjectDTI, Subject.

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
            % INITIALIZE_DATADICT(SUB, 'age', AGE, 'fMRI', FMRI) initializes the data
            % ditionary with data type and data code of subject fMRI.
            %
            % See also update_brainatlases().

            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas);
            sub.datadict('fMRI') = DataFunctional(atlas);
        end
        function update_brainatlases(sub, atlases)
            % UPDATE_BRAINATLASES updates the atlases of the subject fMRI
            % 
            % UPDATE_BRAINATLASES(SUB, ATLASES) updates the atlases of the
            % subject fMRI using the new values ATLASES. ATLASES must be a
            % cell array with a single BrainAtlas.
            % 
            % See also initialize_datadict().

            sub.atlases = atlases;
            atlas = atlases{1};

            d1 = sub.datadict('age');
            d1.setBrainAtlas(atlas)
            
            d2 = sub.datadict('fMRI');
            d2.setBrainAtlas(atlas);
        end
    end
    methods (Static)
        function subject_class = getClass()
            % GETCLASS returns the class of the subject
            %
            % SUBJECT_CLASS = GETCLASS() returns the class SubjectfMRI.
            %
            % See also getList(), getDescription(), getName()
            
                subject_class = 'SubjectfMRI';
        end
        function name = getName()
            % GETNAME returns the name of the subject
            %
            % NAME = GETNAME() returns the name: Subject Functional MRI.
            %
            % See also getList(), getClass().
            
            name = 'Subject Functional MRI';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the subject
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of SubjectfMRI.
            %
            % See also getList(), getName(), getClass().
            
            description = [ ...
                'Subject with functional MRI data, ' ...
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
            % subject data. For Subject fMRI, the data list is: 
            %   age             -    DataScalar.
            %   fMRI            -    DataFunctional.
            %
            % See also getList()
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('fMRI') = 'DataFunctional';            
        end
        function data_number = getDataNumber()
            % GETDATANUMBER returns the number of data.
            %
            % N = GETDATANUMBER() returns the number of data.        
            %
            % See also getDataList(), getBrainAtlasNumber().
            
            data_number = Subject.getDataNumber('SubjectfMRI');
        end
        function data_codes = getDataCodes()
            % GETDATACODES returns the list of data keys
            %
            % CELL ARRAY = GETDATACODES(SUB) returns a cell array of
            % subject fmri data keys.          
            %
            % See also getList()
            
            data_codes = Subject.getDataCodes('SubjectfMRI');
        end
        function data_classes = getDataClasses()
            % GETDATACLASSES returns the list of data classes
            %
            % CELL ARRAY = GETDATACLASSES(SUB) returns a cell array of
            % subject fmri data classes.
            %
            % CELL ARRAY = GETDATACLASSES(SUBJECT_CLASS) returns a 
            % cell array of subject fmri data classes to the subject whose class is
            % SUBJECT_CLASS.
            %
            % See also getList(), getDataCodes(), getDataClass().
            
            data_classes = Subject.getDataClasses('SubjectfMRI');
        end
        function data_class = getDataClass(data_code)
            % GETDATACLASS returns the class of a data.
            %
            % DATA_CLASS = GETDATACLASS(SUB, DATACODE) returns the class of
            % data with code DATACODE  
            %
            % See also getList(), getDataClasses().
            
            data_class = Subject.getDataNumber('SubjectfMRI', data_code);
        end
    end
end