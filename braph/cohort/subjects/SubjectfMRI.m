classdef SubjectfMRI < Subject
    methods
        function sub = SubjectfMRI(atlas)

            sub = sub@Subject('BrainAtlas', atlas);
        end
    end
    methods (Access=protected)
        function datadict = initialize_datadict(sub, varargin) %#ok<INUSL>

            atlas = get_from_varargin([], 'BrainAtlas', varargin{:});
            
            datadict = containers.Map;
            datadict('age') = DataScalar(atlas);
            datadict('fMRI') = DataFunctional(atlas);
        end
    end
    methods (Static)
        function subject_class = getClass()
                subject_class = 'SubjectfMRI';
        end
        function name = getName()
            name = 'Subject Functional MRI';
        end
        function description = getDescription()
            description = [ ...
                'Subject with functional MRI data ' ...
                'such as activation timeseries for each brain region' ...
                ];
        end
        function atlas_number = getBrainAtlasNumber()
            atlas_number = 1;
        end
        function datalist = getDataList()
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('fMRI') = 'DataFunctional';            
        end
        function data_number = getDataNumber()
            data_number = Subject.getDataNumber('SubjectfMRI');
        end
        function data_codes = getDataCodes()
            data_codes = Subject.getDataCodes('SubjectfMRI');
        end
        function data_classes = getDataClasses()
            data_classes = Subject.getDataClasses('SubjectfMRI');
        end
        function data_class = getDataClass(data_code)
            data_class = Subject.getDataNumber('SubjectfMRI', data_code);
        end
    end
end