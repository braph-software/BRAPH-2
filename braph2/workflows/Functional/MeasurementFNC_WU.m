classdef MeasurementFNC_WU < Measurement
    % MeasurementFNC_WU A measurement of functional data with weighted undirected graphs
    % MeasurementFNC_WU is a subclass of Measurement, it implements the
    % initialization of data methods.
    %
    % MeasurementFNC_WU implements Measurement initialization of the data
    % function class will save. It checks if the data being saved has correct
    % dimensions. Functional data can be for example MRI or PET data.
    %
    % MeasurementFNC_WU constructor methods:
    %  MeasurementFNC_WU            - Constructor
    %
    % MeasurementFNC_WU basic methods:
    %  disp                         - displays the comparison
    %
    % MeasurementFNC_WU get methods:
    %  getValue                     - returns the value of the measurement
    %
    % MeasurementFNC_WU initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % MeasurementFNC_WU descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getBrainAtlasNumber          - returns the number of brain atlases
    %  getAnalysisClass             - returns the class of the analysis
    %  getSubjectClass              - returns the class of the subject
    %  getAvailbleSettings          - returns the available settings
    %  getMeasurement               - returns a new measurement
    %
    % MeasurementFNC_WU plot methods (Static):
    %  getMeasurementSettingsPanel  - returns a UIPanel
    %
    % See also Comparison, AnalysisFNC_WU, ComparisonFNC_WU, RandomComparisonFNC_WU.
    
    % single group of fmri subjects
    properties
        values  % array with the values of the measure for each subject
        average_value  % average value of the group
    end
    methods  % Constructor
        function m =  MeasurementFNC_WU(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTFNC_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP. It initializes the MEASUREMENTFNC_WU
            % with default settings.
            %
            % See also ComparisonFNC_WU, RandomComparisonFNC_WU, AnalysisFNC_WU.
            
            graph_type = AnalysisFNC_WU.getGraphType();
            measure_list = Graph.getCompatibleMeasureList(graph_type);
            assert(ismember(measure_code, measure_list), ...
                [BRAPH2.STR ':MeasurementFNC_WU:' BRAPH2.BUG_FUNC], ...
                'MeasurementFNC_WU measure_code is not compatible with the permited Measures.');
            
            m = m@Measurement(id, label, notes, atlas, measure_code, group, varargin{:});
        end
    end
    methods  % Get functions
        function value = getMeasureValues(m)
            % GETGROUPVALUE returns the measure value of the group
            %
            % VALUE = GETMEASUREVALUE(M) returns the measure value of
            % the group.
            %
            % See also getClass, getName, getDescription.
            
            value = m.values;
        end
        function average_value = getGroupAverageValue(m)
            % GETGROUPAVERAGEVALUE returns the measure average value of the group
            %
            % AVERAGE_VALUE = GETGROUPAVERAGEVALUE(M) returns the measure
            % average value of the group.
            %
            % See also getClass, getName, getDescription.
            
            average_value = m.average_value;
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)
            % INITIALIZE_DATA initialize and check the data for the measurement
            %
            % INITIALIZE_DATA(M) initialize and check the data for the
            % measurement. It initializes with default settings.
            %
            % INITIALIZE_DATA(M, 'MeasurementST.Value', VALUE) initialize and
            % check the data for the measurement. It saves the measurement
            % VALUE.
            %
            % See also AnalysisFNC_WU.
            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            measure_code = m.getMeasureCode();
            
            if Measure.is_global(measure_code)  % global measure
                m.values = get_from_varargin( ...
                    repmat({0}, 1, m.getGroup().subjectnumber()), ...
                    'MeasurementFNC.values', ...
                    varargin{:});
                assert(iscell(m.getMeasureValues()) & ...
                    isequal(size(m.getMeasureValues()), [1, m.getGroup().subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), m.getMeasureValues())), ...
                    [BRAPH2.STR ':MeasurementFNC:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementFNC')
                m.average_value = get_from_varargin( ...
                    0, ...
                    'MeasurementFNC.average_value', ...
                    varargin{:});
                assert(isequal(size(m.getGroupAverageValue()), [1, 1]), ...
                    [BRAPH2.STR ':MeasurementFNC:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementFNC')
                
            elseif Measure.is_nodal(measure_code)  % nodal measure
                m.values = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, m.getGroup().subjectnumber()), ...
                    'MeasurementFNC.values', ...
                    varargin{:});
                assert(iscell(m.getMeasureValues()) & ...
                    isequal(size(m.getMeasureValues()), [1, m.getGroup().subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), m.getMeasureValues())), ...
                    [BRAPH2.STR ':MeasurementFNC:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementFNC')
                
                m.average_value = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'MeasurementFNC.average_value', ...
                    varargin{:});
                assert(isequal(size(m.getGroupAverageValue()), [atlas.getBrainRegions().length(), 1]), ...
                    [BRAPH2.STR ':MeasurementFNC:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementFNC')
                
            elseif Measure.is_binodal(measure_code)  % binodal measure
                m.values = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, m.getGroup().subjectnumber()), ...
                    'MeasurementFNC.values', ...
                    varargin{:});
                assert(iscell(m.getMeasureValues()) & ...
                    isequal(size(m.getMeasureValues()), [1, m.getGroup().subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), m.getMeasureValues())), ...
                    [BRAPH2.STR ':MeasurementFNC:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementFNC')
                
                m.average_value = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'MeasurementFNC.average_value', ...
                    varargin{:});
                assert(isequal(size(m.getGroupAverageValue()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                    [BRAPH2.STR ':MeasurementFNC:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementFNC')
            end
        end
    end
    methods (Static)
        function class = getClass(m) %#ok<*INUSD>
            % GETCLASS returns the class of functional measurement
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % measurement. In this case 'MeasurementFNC_WU'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementFNC_WU';
        end
        function name = getName(m)
            % GETNAME returns the name of functional measurement
            %
            % NAME = GETNAME() returns the name, Measurement FNC WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement Functional WU';
        end
        function description = getDescription(m)
            % GETDESCRIPTION returns the description of functional measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementFNC_WU.
            %
            % See also getList, getClass, getName
            
            description = 'Functional measurement.';
        end
        function atlas_number = getBrainAtlasNumber(m)
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % ATLAS_NUMBER = GETBRAINATLASNUMBER() returns the number of
            % brain atlases.
            %
            % See also getList, getClass, getName.
            
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass(m)
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'MeasurementFNC_WU'.
            %
            % See also getList, getClass, getName.
            
            % measurement analysis class
            analysis_class = 'AnalysisFNC_WU';
        end
        function subject_class = getSubjectClass(m)
            % GETSUBJETCLASS returns the class of functional measurement subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of MeasurementFNC_WU subject, 'SubjectFNC'.
            %
            % See also getList, getClass, getName, getDescription.
            
            % measurement subject class
            subject_class = 'SubjectFNC';
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of functional measurement
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS() returns the
            % available settings of MeasurementFNC_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {};
        end
        function m = getMeasurement(measurement_class, id, label, notes, atlas, measure_code, group, varargin)
            % GETMEASUREMENT returns a new measurement
            %
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % returns a new MeasurementFNC_WU object with MEASUREMENT_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            %
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % returns a new MeasurementFNC_WU object with MEASUREMENT_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with VALUE settings.
            %
            % See also getClass, getName, getDescription.
            
            m = eval([measurement_class '(id, label, notes, atlas, measure_code, group, varargin{:})']);
        end
    end
    methods (Static)  % Plot methods
        function handle = getMeasurementSettingsPanel(analysis, uiparent) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. For WU in empty.
            %
            % See also MeasurementST_WU.
            
            set(uiparent, 'Visible', 'off')
            handle.variables = [];
        end
    end
end