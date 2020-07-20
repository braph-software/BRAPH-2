classdef MeasurementST_WU < Measurement
    % single group of ST subjects
    properties
        value  % value of the measure for the group
    end
    methods  % Constructor
        function m =  MeasurementST_WU(id, label, notes, atlas, measure_code, group, varargin)

% TODO: Add assert that the measure_code is in the measure list. The code
% below can be useful but must be modified.
%             graph_type = AnalysisST_WU.getGraphType();
%             measure_list = Graph.getCompatibleMeasureList(graph_type);
%             available_settings = {
%                 'MeasurementST_WU.MeasureCode', BRAPH2.STRING, measure_list{1}, measure_list;
%                 };

            m = m@Measurement(id, label, notes, atlas, measure_code, group, varargin{:});
        end
    end
    methods  % Basic function
        function disp(m)
            % DISP overrides Measurement disp
            %
            % DISP(M) overrides Measurement disp and displays additional
            % information about the value of the MeasurementST_WU.
            % 
            % See also Measurement
            
            m.disp@Measurement()
            disp(['value (' tostring(size(m.value{1}, 1)) 'x' tostring(size(m.value{1}, 2)) ') = {' tostring(m.value{1}) '}' ])
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
                    'MeasurementST_WU.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), m.getMeasureValue())), ...
                    [BRAPH2.STR ':MeasurementST_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementST_WU')
            elseif Measure.is_nodal(measure_code)  % nodal measure
                m.value = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'MeasurementST_WU.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), m.getMeasureValue())), ...
                    [BRAPH2.STR ':MeasurementST_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementST_WU')
            elseif Measure.is_binodal(measure_code)  % binodal measure
                m.value = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'MeasurementST_WU.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), m.getMeasureValue())), ...
                    [BRAPH2.STR ':MeasurementST_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementST_WU')
            end
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            class = 'MeasurementST_WU';
        end
        function name = getName()
            name = 'Measurement ST WU';
        end
        function description = getDescription()
            description = 'ST measurement with weighted graphs.';
        end
        function atlas_number = getBrainAtlasNumber()
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass()
            analysis_class = 'AnalysisST_WU';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectST';
        end        
        function available_settings = getAvailableSettings()
            available_settings = {};
        end
        function m = getMeasurement(measurement_class, id, label, notes, atlas, measure_code, group, varargin) %#ok<INUSD>
            m = eval([measurement_class '(id, label, notes, atlas, measure_code, group, varargin{:})']);
        end
    end
end 