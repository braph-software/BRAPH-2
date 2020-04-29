classdef MeasurementfMRI < Measurement
    properties
        measure_code  % class of measure
        values  % array with the values of the measure for each subject
        average_value  % average value of the group
    end
    methods
        function m =  MeasurementfMRI(id, atlas, group, varargin)
            
            m = m@Measurement(id, atlas, group, varargin{:});
        end
        function measure_code = getMeasureCode(m)
            measure_code = m.measure_code;
        end
        function value = getMeasureValues(m)
            value = m.values;
        end
        function average_value = getGroupAverageValue(m)
            average_value = m.average_value;
        end
        function p_value = getCorrelationPValue(m)
            p_value = m.p_value;
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            m.measure_code = get_from_varargin('', 'MeasurementfMRI.measure_code', varargin{:});
                    
            m.values = get_data_from_varargin(m.getMeasureCode(), ...
                m.getGroup().subjectnumber(), ...
                atlas.getBrainRegions().length(), ...
                'MeasurementfMRI.subject_values', ...
                varargin{:});       
            m.average_value = get_data_from_varargin(m.getMeasureCode(), ...
                1, ...
                atlas.getBrainRegions().length(), ...
                'MeasurementfMRI.average_value', ...
                varargin{:}); 
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
        function description = getDescription(m)
            % measurement description missing
            description = '';
        end       
        function sub = getMeasurement(measurementClass, id, varargin)
            sub = eval([measurementClass '(id, varargin{:})']);
        end      
    end
end