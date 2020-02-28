classdef SubjectMRI < Subject
    methods
        function sub = SubjectMRI(atlas)

            sub = sub@Subject('BrainAtlas', atlas);
        end
    end
    methods (Access=protected)
        function datadict = initialize_datadict(sub, varargin) %#ok<INUSL>

            atlas = get_from_varargin([], 'BrainAtlas', varargin{:});
            
            datadict = containers.Map;
            datadict('age') = DataScalar(atlas);
            datadict('MRI') = DataStructural(atlas);
        end
    end
    methods (Static)
        function subject_class = getClass()
                subject_class = 'SubjectMRI';
        end
        function name = getName()
            name = 'Subject Structural MRI';
        end
        function description = getDescription()
            description = [ ...
                'Subject with structural MRI data ' ...
                'such as cortical thickness for each brain region' ...
                ];
        end
        function atlas_number = getBrainAtlasNumber()
            atlas_number = 1;
        end
        function datalist = getDataList()
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('MRI') = 'DataStructural';            
        end
        function data_number = getDataNumber()
            data_number = Subject.getDataNumber('SubjectMRI');
        end
        function data_codes = getDataCodes()
            data_codes = Subject.getDataCodes('SubjectMRI');
        end
        function data_classes = getDataClasses()
            data_classes = Subject.getDataClasses('SubjectMRI');
        end
        function data_class = getDataClass(data_code)
            data_class = Subject.getDataNumber('SubjectMRI', data_code);
        end
    end
end