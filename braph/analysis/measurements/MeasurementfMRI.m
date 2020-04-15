classdef MeasurementfMRI < Measurement
    % single group of mri subjects
    methods
        function m =  MeasurementfMRI(id, atlas, group, varargin)
            
            m = m@Measurement(id, atlas, group, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_datadict(m, varargin)
            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            m.data_dict = containers.Map;
            m.data_dict('type') = DataScalar(atlas);
            m.data_dict('value') = DataFunctional(atlas);
        end
    end
    methods (Static)
        function class = getClass(m) %#ok<*INUSD>
            class = 'MeasurementfMRI';
        end
        function name = getName(m)
            name = 'Measurement fMRI';
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
            datalist('value') = 'DataFunctional'; 
        end
        function sub = getMeasurement(measurementClass, id, varargin)
            sub = eval([measurementClass '(id, varargin{:})']);
        end
        function data_codes = getDataCodes(m)
            data_codes = Measurement.getDataCodes('MeasurementfMRI');
        end
        function data_number = getDataNumber(m)
            data_number = Measurement.getDataNumber('MeasurementfMRI');
        end
        function data_classes = getDataClasses(m)
            data_classes = Measurement.getDataClasses('MeasurementfMRI');
        end
        function data_class = getDataClass(m, data_code) %#ok<INUSL>
            data_class = Measuremente.getDataNumber(...
                'MeasurementfMRI', data_code);
        end
    end
end