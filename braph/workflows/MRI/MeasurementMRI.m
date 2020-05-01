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
            
            if Measure.is_global(m.getMeasureCode())  % global measure
                m.value = get_from_varargin( ...
                    repmat({0}, 1, 1), ...  % 1 measure per group
                    'MeasurementMRI.value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) & ...
                    isequal(size(m.getMeasureValue()), [1, 1]) & ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), m.getMeasureValue())), ...
                    ['BRAPH:MeasurementMRI:WrongData'], ...
                    ['Data not compatible with MeasurementMRI.']) %#ok<*NBRAK>
            elseif Measure.is_nodal(m.getMeasureCode())  % nodal measure
                m.value = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, 1), ...
                    'MeasurementMRI.value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) & ...
                    isequal(size(m.getMeasureValue()), [1, 1]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), m.getMeasureValue())), ...
                    ['BRAPH:MeasurementMRI:WrongData'], ...
                    ['Data not compatible with MeasurementMRI.']) %#ok<*NBRAK>      
            elseif Measure.is_binodal(m.getMeasureCode())  % binodal measure
                m.value = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, 1), ...
                    'MeasurementMRI.value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) & ...
                    isequal(size(m.getMeasureValue()), [1, 1]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), m.getMeasureValue())), ...
                    ['BRAPH:MeasurementMRI:WrongData'], ...
                    ['Data not compatible with MeasurementMRI.']) %#ok<*NBRAK>   
            end
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