classdef MeasurementCON_WU < Measurement
    % MeasurementCON_WU A measurement of connectivity data with weighted undirected graphs
    % MeasurementCON_WU is a subclass of Measurement, it implements the
    % initialization of data methods.
    %
    % MeasurementCON_WU implements Measurement initialization of the data 
    % function class will save. It checks if the data being saved has correct
    % dimensions. Connectivity data can be for example MRI or PET data.
    %
    % MeasurementCON_WU constructor methods:
    %  MeasurementCON_WU              - Constructor
    %
    % MeasurementCON_WU basic methods:
    %  disp                         - displays the comparison
    % 
    % MeasurementCON_WU get methods:
    %  getValue                     - returns the value of the measurement
    %
    % MeasurementCON_WU initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % MeasurementCON_WU descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getBrainAtlasNumber          - returns the number of brain atlases
    %  getAnalysisClass             - returns the class of the analysis
    %  getSubjectClass              - returns the class of the subject
    %  getAvailbleSettings          - returns the available settings
    %  getMeasurement               - returns a new measurement
    %
    % MeasurementCON_WU plot methods (Static):
    %  getMeasurementSettingsPanel  - returns a UIPanel
    %
    % See also Comparison, AnalysisCON_WU, ComparisonCON_WU, RandomComparisonCON_WU. 
    
    % single group of dti subjects
    properties
        values  % array with the values of the measure for each subject
        average_value  % average value of the group
    end
    methods  % Constructor
        function m =  MeasurementCON_WU(id, label, notes, atlas, measure_code, group, varargin)        
            % MEASUREMENTCON_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP. It initializes the MEASUREMENTCON_WU 
            % with default settings.
            %
            % See also ComparisonCON_WU, RandomComparisonCON_WU, AnalysisCON_WU.
            
            graph_type = AnalysisCON_WU.getGraphType();
            measure_list = Graph.getCompatibleMeasureList(graph_type);            
            assert(ismember(measure_code, measure_list), ...
                [BRAPH2.STR ':MeasurementCON_WU:' BRAPH2.BUG_FUNC], ...
                'MeasurementCON_WU measure_code is not compatible with the permited Measures.');

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
            % See also AnalysisCON_WU.
            
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
            % GETCLASS returns the class of connectivity measurement
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % measurement. In this case 'MeasurementCON_WU'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementCON_WU';
        end
        function name = getName(m)
             % GETNAME returns the name of connectivity measurement
            %
            % NAME = GETNAME() returns the name, Measurement CON WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement Connectivity WU';
        end
        function description = getDescription(m)
            % GETDESCRIPTION returns the description of connectivity measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementCON_WU.
            %
            % See also getList, getClass, getName
            
            description = 'Connectivity measurement.';
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
            % analysis the random comparison is part of, 'MeasurementCON_WU'.
            %
            % See also getList, getClass, getName.
            
            % measurement analysis class
            analysis_class = 'AnalysisCON_WU';
        end
        function subject_class = getSubjectClass(m)
            % GETSUBJETCLASS returns the class of connectivity measurement subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of MeasurementCON_WU subject, 'SubjectCON'.
            %
            % See also getList, getClass, getName, getDescription.
            
            % measurement subject class
            subject_class = 'SubjectCON';
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of connectivity measurement
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS() returns the 
            % available settings of MeasurementCON_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {};
        end
        function m = getMeasurement(measurement_class, id, label, notes, atlas, measure_code, group, varargin)
            % GETMEASUREMENT returns a new measurement
            %
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % returns a new MeasurementCON_WU object with MEASUREMENT_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            % 
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % returns a new MeasurementCON_WU object with MEASUREMENT_CLASS,
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