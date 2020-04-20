classdef MeasurementDTI < Measurement
    % single group of dti subjects
    properties
        value  % array with the values of the measures
        average_value  % average value of the group
        measure_code  % class of measure
    end
    methods
        function m =  MeasurementDTI(id, atlas, group, varargin)
            
            m = m@Measurement(id, atlas, group, varargin{:});
        end
        function average_value = getGroupAverageValue(m)
            average_value = m.average_value;
        end
        function measure_code = getMeasureCode(m)
            measure_code = m.measure_code;
        end
        function value = getMeasure(m)
            value = m.value;
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)
            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            value = get_from_varargin(zeros(atlas.getBrainRegions().length(), atlas.getBrainRegions().length()), 'MeasurementDTI.subject_values', varargin{:});
            if iscell(value)                
                m.value = [value{:}];
            else
                m.value = value;
            end
            m.average_value = get_from_varargin(0, 'MeasurementDTI.average_value', varargin{:}); %#ok<*PROPLC>
            m.measure_code = get_from_varargin('', 'measure_code', varargin{:});
            
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
        function sub = getMeasurement(measurementClass, id, varargin)
            sub = eval([measurementClass '(id, varargin{:})']);
        end
        
    end
end