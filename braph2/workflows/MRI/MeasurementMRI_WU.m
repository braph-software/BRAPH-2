classdef MeasurementMRI_WU < Measurement
    % single group of mri subjects
    properties
        value  % value of the measure for the group
    end
    methods  % Constructor
        function m =  MeasurementMRI_WU(id, label, notes, atlas, measure_code, group, varargin)

% TODO: Add assert that the measure_code is in the measure list. The code
% below can be useful but must be modified.
%             graph_type = AnalysisMRI_WU.getGraphType();
%             measure_list = Graph.getCompatibleMeasureList(graph_type);
%             available_settings = {
%                 'MeasurementMRI_WU.MeasureCode', BRAPH2.STRING, measure_list{1}, measure_list;
%                 };

            m = m@Measurement(id, label, notes, atlas, measure_code, group, varargin{:});
        end
    end
    methods  % Get functions
        function value = getMeasureValue(m)
            value = m.value;
        end
    end
    methods (Access=protected)  % Initialize data
        function initialize_data(m, varargin)
            atlases = m.getBrainAtlases();
            atlas = atlases{1};

            measure_code = m.getMeasureCode();

            if Measure.is_global(measure_code)  % global measure
                m.value = get_from_varargin( ...
                    {0}, ...  % 1 measure per group
                    'MeasurementMRI_WU.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), m.getMeasureValue())), ...
                    [BRAPH2.STR ':MeasurementMRI_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementMRI_WU')
            elseif Measure.is_nodal(measure_code)  % nodal measure
                m.value = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'MeasurementMRI_WU.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), m.getMeasureValue())), ...
                    [BRAPH2.STR ':MeasurementMRI_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementMRI_WU')
            elseif Measure.is_binodal(measure_code)  % binodal measure
                m.value = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'MeasurementMRI_WU.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), m.getMeasureValue())), ...
                    [BRAPH2.STR ':MeasurementMRI_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementMRI_WU')
            end
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            class = 'MeasurementMRI_WU';
        end
        function name = getName()
            name = 'Measurement MRI WU';
        end
        function description = getDescription()
            description = 'MRI measurement with weighted graphs.';
        end
        function atlas_number = getBrainAtlasNumber()
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass()
            analysis_class = 'AnalysisMRI_WU';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectMRI';
        end        
        function available_settings = getAvailableSettings()
            available_settings = {};
        end
        function m = getMeasurement(measurement_class, id, label, notes, atlas, measure_code, group, varargin) %#ok<INUSD>
            m = eval([measurement_class '(id, label, notes, atlas, measure_code, group, varargin{:})']);
        end
    end
end 