classdef MeasurementfMRI < Measurement
    % single group of mri subjects
    methods
        function m =  MeasurementfMRI(id, atlas, group, varargin)
            
            m = m@Measurement(id, atlas, group, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)
            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
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
        function sub = getMeasurement(measurementClass, id, varargin)
            sub = eval([measurementClass '(id, varargin{:})']);
        end      
    end
end