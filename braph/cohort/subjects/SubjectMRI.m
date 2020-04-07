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
            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas);
            sub.datadict('MRI') = DataStructural(atlas);
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
    end
end