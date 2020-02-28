classdef SubjectDTI < Subject
    methods
        function sub = SubjectDTI(atlas, varargin)

            sub = sub@Subject('BrainAtlas', atlas, varargin{:});
        end
    end
    methods (Access=protected)
        function datadict = initialize_datadict(sub, varargin) %#ok<INUSL>

            atlas = get_from_varargin([], 'BrainAtlas', varargin{:});
            
            datadict = containers.Map;
            datadict('age') = DataScalar(atlas);
            datadict('DTI') = DataConnectivity(atlas);
        end
    end
    methods (Static)
        function subject_class = getClass()
                subject_class = 'SubjectDTI';
        end
        function name = getName()
            name = 'Subject DTI';
        end
        function description = getDescription()
            description = [ ...
                'Subject with DTI connectivity matrix' ...
                'such as activation timeseries for each brain region' ...
                ];
        end
        function atlas_number = getBrainAtlasNumber()
            atlas_number = 1;
        end
        function datalist = getDataList()
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('DTI') = 'DataConnectivity';            
        end
        function data_number = getDataNumber()
            data_number = Subject.getDataNumber('SubjectDTI');
        end
        function data_codes = getDataCodes()
            data_codes = Subject.getDataCodes('SubjectDTI');
        end
        function data_classes = getDataClasses()
            data_classes = Subject.getDataClasses('SubjectDTI');
        end
        function data_class = getDataClass(data_code)
            data_class = Subject.getDataNumber('SubjectDTI', data_code);
        end
    end
end