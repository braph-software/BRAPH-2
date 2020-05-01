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
        function value = getMeasureValue(m)
            value = m.value;
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            m.measure_code = get_from_varargin('Degree', ...
                'MeasurementMRI.measure_code', ...
                varargin{:});
            
m.value = get_data_from_varargin( ...
    'MeasurementMRI.value', ...
    m.getMeasureCode(), ...
    m.getGroup().subjectnumber(), ...
    atlas.getBrainRegions().length(), ...
    varargin{:});
        end
    end
    methods (Static)
        function class = getClass(m) %#ok<*INUSD>
            class = 'MeasurementMRI';
        end
        function name = getName(m)
            name = 'Measurement MRI';
        end
        function description = getDescription(m)
            % measurement description missing
            description = '';
        end
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass(m)
            % measurement analysis class
            analysis_class = 'AnalysisMRI';
        end
        function subject_class = getSubjectClass(m)
            % measurement subject class
            subject_class = 'SubjectMRI';
        end        
        function m = getMeasurement(measurement_class, id, atlas, group, varargin)
            m = eval([measurement_class '(id, atlas, group, varargin{:})']);
        end
    end
end