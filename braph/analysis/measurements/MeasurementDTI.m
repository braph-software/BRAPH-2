classdef MeasurementDTI < Measurement
    % single group of dti subjects
    methods
        function m =  MeasurementDTI(id, atlas, group, varargin)
            
            m = m@Measurement(id, atlas, group, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_datadict(m, varargin)
            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};

            value_scalar = get_from_varargin(0,'MeasurementDTIAge', varargin{:});
            value_dti = get_from_varargin(zeros(atlas.getBrainRegions().length(), atlas.getBrainRegions().length()), 'MeasurementDTIValue', varargin{:});

            m.data_dict = containers.Map;
            m.data_dict('type') = DataScalar(atlas, value_scalar);  % this must be an array 
            m.data_dict('value') = DataConnectivity(atlas, [value_dti{:}]);
        end
    end
    methods (Static)
        function class = getClass(m) %#ok<*INUSD>
            class = 'MeasurementDTI';
        end
        function name = getName(m)
            name = 'Measurement DTI';
        end
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  1;
        end
        function group_number = getGroupNumber(m)
            group_number = 1;
        end
        function description = getDescription(m)
            % measurement description missing
            description = '';
        end
        function datalist = getDataList(m)
            % list of measurments data keys
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('type') = 'DataScalar';
            datalist('value') = 'DataConnectivity'; 
        end
        function sub = getMeasurement(measurementClass, id, varargin)
            sub = eval([measurementClass '(id, varargin{:})']);
        end
        function data_codes = getDataCodes(m)
            data_codes = Measurement.getDataCodes('MeasurementDTI');
        end
        function data_number = getDataNumber(m)
            data_number = Measurement.getDataNumber('MeasurementDTI');
        end
        function data_classes = getDataClasses(m)
            data_classes = Measurement.getDataClasses('MeasurementDTI');
        end
        function data_class = getDataClass(m, data_code) %#ok<INUSL>
            data_class = Measuremente.getDataNumber(...
                'MeasurementDTI', data_code);
        end
    end
end