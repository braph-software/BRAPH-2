classdef MeasurementMRI < Measurement
    % single group of mri subjects
    properties
        measure_code  % class of measure
        value  % value of the measure for the group
    end
    methods
        function m =  MeasurementMRI(id, atlas, group, varargin)
            
            m = m@Measurement(id, atlas, group, varargin{:});
        end
        function measure_code = getMeasureCode(m)
            measure_code = m.measure_code;
        end
        function value = getMeasureValues(m)
            value = m.value;
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            m.measure_code = get_from_varargin('', 'MeasurementMRI.measure_code', varargin{:});
                    
            if Measure.is_global(m.getMeasureCode())
                value = get_from_varargin( ...
                    repmat( ...
                        {0}, ...
                        1, ...
                        m.getGroup().subjectnumber()), ...
                    'MeasurementMRI.value', ...
                    varargin{:}); %#ok<*PROPLC>
            elseif Measure.is_nodal(m.getMeasureCode())
                value = get_from_varargin( ...
                    repmat( ...
                        {zeros(atlas.getBrainRegions().length(), 1)}, ...
                        1, ...
                        m.getGroup().subjectnumber()), ...
                    'MeasurementMRI.value', ...
                    varargin{:});
            elseif Measure.is_global(m.getMeasureCode())
                value = get_from_varargin(...
                    repmat(...
                        {zeros(atlas.getBrainRegions().length())}, ...
                        1, ...
                        m.getGroup().subjectnumber()), ...
                    'MeasurementMRI.value', ...
                    varargin{:});
            end
            
            m.value = value;
        end
    end
    methods (Static)
        function class = getClass(m) %#ok<*INUSD>
            class = 'MeasurementMRI';
        end
        function name = getName(m)
            name = 'Measurement MRI';
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