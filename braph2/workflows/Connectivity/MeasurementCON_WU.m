classdef MeasurementCON_WU < Measurement
    % single group of dti subjects
    properties
        values  % array with the values of the measure for each subject
        average_value  % average value of the group
    end
    methods  % Constructor
        function m =  MeasurementCON_WU(id, label, notes, atlas, measure_code, group, varargin)        
            % TODO: Add assert that the measure_code is in the measure list. The code
            % below can be useful but must be modified.
            %             graph_type = AnalysisCON.getGraphType();
            %             measure_list = Graph.getCompatibleMeasureList(graph_type);
            %             available_settings = {
            %                 'MeasurementCON_WU.MeasureCode', BRAPH2.STRING, measure_list{1}, measure_list;
            %                 };

            m = m@Measurement(id, label, notes, atlas, measure_code, group, varargin{:});
        end
    end
    methods  % Get functions
        function value = getMeasureValues(m)
            value = m.values;
        end
        function average_value = getGroupAverageValue(m)
            average_value = m.average_value;
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            measure_code = m.getMeasureCode();
            
            if Measure.is_global(measure_code)  % global measure
                m.values = get_from_varargin( ...
                    repmat({0}, 1, m.getGroup().subjectnumber()), ...
                    'MeasurementCON.values', ...
                    varargin{:});
                assert(iscell(m.getMeasureValues()) & ...
                    isequal(size(m.getMeasureValues()), [1, m.getGroup().subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), m.getMeasureValues())), ...
                    [BRAPH2.STR ':MeasurementCON_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementCON_WU')
                m.average_value = get_from_varargin( ...
                    0, ...
                    'MeasurementCON.average_value', ...
                    varargin{:});
                assert(isequal(size(m.getGroupAverageValue()), [1, 1]), ...  
                    [BRAPH2.STR ':MeasurementCON_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementCON_WU') 
           
            elseif Measure.is_nodal(measure_code)  % nodal measure
                m.values = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, m.getGroup().subjectnumber()), ...
                    'MeasurementCON.values', ...
                    varargin{:});
                assert(iscell(m.getMeasureValues()) & ...
                    isequal(size(m.getMeasureValues()), [1, m.getGroup().subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), m.getMeasureValues())), ...
                    [BRAPH2.STR ':MeasurementCON_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementCON_WU') 
                
                m.average_value = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'MeasurementCON.average_value', ...
                    varargin{:});
                assert(isequal(size(m.getGroupAverageValue()), [atlas.getBrainRegions().length(), 1]), ...
                    [BRAPH2.STR ':MeasurementCON_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementCON_WU') 
            
            elseif Measure.is_binodal(measure_code)  % binodal measure
                m.values = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, m.getGroup().subjectnumber()), ...
                    'MeasurementCON.values', ...
                    varargin{:});
                assert(iscell(m.getMeasureValues()) & ...
                    isequal(size(m.getMeasureValues()), [1, m.getGroup().subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), m.getMeasureValues())), ...
                    [BRAPH2.STR ':MeasurementCON_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementCON_WU')
                
                m.average_value = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'MeasurementCON.average_value', ...
                    varargin{:});
                assert(isequal(size(m.getGroupAverageValue()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                    [BRAPH2.STR ':MeasurementCON_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementCON_WU')
            end
        end
    end
    methods (Static)
        function class = getClass(m) %#ok<*INUSD>
            class = 'MeasurementCON_WU';
        end
        function name = getName(m)
            name = 'Measurement Connectivity WU';
        end
        function description = getDescription(m)
            description = 'Connectivity measurement.';
        end
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass(m)
            % measurement analysis class
            analysis_class = 'AnalysisCON_WU';
        end
        function subject_class = getSubjectClass(m)
            % measurement subject class
            subject_class = 'SubjectCON';
        end
        function available_settings = getAvailableSettings()
            available_settings = {};
        end
        function m = getMeasurement(measurement_class, id, label, notes, atlas, measure_code, group, varargin)
            m = eval([measurement_class '(id, label, notes, atlas, measure_code, group, varargin{:})']);
        end
    end
end