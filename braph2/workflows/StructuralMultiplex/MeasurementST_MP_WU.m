classdef MeasurementST_MP_WU < Measurement
    % MeasurementST_MP_WU A measurement of structural multiplex data with weighted undirected graphs    
    % MeasurementST_MP_WU is a subclass of Measurement, it implements the
    % initialization of data methods.
    %
    % MeasurementST_MP_WU implements Measurement initialization of the data
    % function class will save. It checks if the data being saved has correct
    % dimensions. Structural multiplex data can be for example MRI or/and PET data.
    %
    % MeasurementST_MP_WU constructor methods:
    %  MeasurementST_MP_WU          - Constructor
    %
    % MeasurementST_MP_WU basic methods:
    %  disp                         - displays the measurement
    %
    % MeasurementST_MP_WU get methods:
    %  getValue                     - returns the value of the measurement
    %  getMeasureParameterValues    - returns the values of the measure's parameter
    %
    % MeasurementST_MP_WU initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % MeasurementST_MP_WU descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getBrainAtlasNumber          - returns the number of brain atlases
    %  getAnalysisClass             - returns the class of the analysis
    %  getSubjectClass              - returns the class of the subject
    %  getAvailbleSettings          - returns the available settings
    %  getMeasurement               - returns a new measurement
    %
    % MeasurementST_MP_WU plot methods (Static):
    %  getMeasurementSettingsPanel  - returns a UIPanel
    %
    % See also Measurement, AnalysisST_MP_WU, ComparisonST_MP_WU, RandomComparisonST_MP_WU.
    
    properties
        value  % value of the measure for the group
        parameter_values  % parameter values of the measure
    end
    methods  % Constructor
        function m =  MeasurementST_MP_WU(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTST_MP_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP. It initializes the MEASUREMENTST_MP_WU
            % with default settings.
            %
            % See also ComparisonST_MP_WU, RandomComparisonST_MP_WU, AnalysisST_MP_WU.
            
            graph_type = AnalysisST_MP_WU.getGraphType();
            measure_list = Graph.getCompatibleMeasureList(graph_type);
            assert(ismember(measure_code, measure_list), ...
                [BRAPH2.STR ':MeasurementST_MP_WU:' BRAPH2.BUG_FUNC], ...
                'MeasurementST_MP_WU measure_code is not compatible with the permited Measures.');

            m = m@Measurement(id, label, notes, atlas, measure_code, group, varargin{:});
        end
    end
    methods  % Basic function
        function disp(m)
            % DISP overrides Measurement disp
            %
            % DISP(M) overrides Measurement disp and displays additional
            % information about the value of the MeasurementST_MP_WU.
            %
            % See also Measurement
            
            m.disp@Measurement()
            disp(['value (' tostring(size(m.value{1}, 1)) 'x' tostring(size(m.value{1}, 2)) ') = {' tostring(m.value{1}) '}' ])
        end
    end
    methods  % Get functions
        function value = getMeasureValue(m)
            % GETMEASUREVALUE returns the measure value of the group
            %
            % VALUE = GETMEASUREVALUE(M) returns the measure value of
            % the group.
            %
            % See also getClass, getName, getDescription.
            
            value = m.value;
        end
        function parameter_values = getMeasureParameterValues(m)
            % GETMEASUREPARAMETERVALUES returns the values of the measure's parameter
            %
            % PARAMETER_VALUES = GETMEASUREPARAMETERVALUES(M) returns the values 
            % of the measure's parameter.
            % 
            % See also getClass, getName, getDescription.
            
            parameter_values = m.parameter_values;
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)
            % INITIALIZE_DATA initialize and check the data for the measurement
            %
            % INITIALIZE_DATA(M) initialize and check the data for the
            % measurement. It initializes with default settings.
            %
            % INITIALIZE_DATA(M, 'MeasurementST_MP.Value', VALUE) initialize and
            % check the data for the measurement. It saves the measurement
            % VALUE.
            %
            % See also AnalysisST_MP_WU.     

            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            measure_code = m.getMeasureCode();
            
            m.parameter_values = get_from_varargin( ...
                    [], ...  % 1 dimension minimum
                    'MeasurementST_MP.ParameterValues', ...
                    varargin{:});
            parameter_values_length = max(1, length(m.parameter_values));
            
            if Measure.is_superglobal(measure_code)  % superglobal measure
                rows = 1;
                columns = 1;
            elseif Measure.is_unilayer(measure_code)  % unilayer measure
                rows = 2;
                columns = 1;
            elseif Measure.is_bilayer(measure_code)  % bilayer measure
                rows = 2;
                columns = 2;
            end
            
            if Measure.is_global(measure_code)  % global measure
                m.value = get_from_varargin( ...
                    repmat({zeros(1, 1, parameter_values_length)}, rows, columns), ...  % 1 measure per group
                    'MeasurementST_MP.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [rows, columns]) && ...
                    all(cellfun(@(x) isequal(size(x, 1), 1), m.getMeasureValue())) && ...
                    all(cellfun(@(x) isequal(size(x, 2), 1), m.getMeasureValue())) && ...
                    all(cellfun(@(x) isequal(size(x, 3), parameter_values_length), m.getMeasureValue())), ...
                    [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(m)])
            elseif Measure.is_nodal(measure_code)  % nodal measure
                m.value = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1, parameter_values_length)}, rows, columns), ...
                    'MeasurementST_MP.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [rows, columns]) && ...
                    all(cellfun(@(x) isequal(size(x, 1), atlas.getBrainRegions().length()), m.getMeasureValue())) && ...
                    all(cellfun(@(x) isequal(size(x, 2), 1), m.getMeasureValue())) && ...
                    all(cellfun(@(x) isequal(size(x, 3), parameter_values_length), m.getMeasureValue())), ...
                    [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(m)])                
            elseif Measure.is_binodal(measure_code)  % binodal measure
                m.value = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), atlas.getBrainRegions().length(), parameter_values_length)}, rows, columns), ...
                    'MeasurementST_MP.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [rows, columns]) && ...
                    all(cellfun(@(x) isequal(size(x, 1), atlas.getBrainRegions().length()), m.getMeasureValue())) && ...
                    all(cellfun(@(x) isequal(size(x, 2), atlas.getBrainRegions().length()), m.getMeasureValue())) && ...
                    all(cellfun(@(x) isequal(size(x, 3), parameter_values_length), m.getMeasureValue())), ...
                    [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(m)])
            end
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural multiplex measurement
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % measurement. In this case 'MeasurementST_MP_WU'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementST_MP_WU';
        end
        function name = getName()
            % GETNAME returns the name of structural multiplex measurement
            %
            % NAME = GETNAME() returns the name, Measurement ST MP WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement ST MP WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural multiplex measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementST_MP_WU.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Structural multiplex measurement with weighted graphs. ' ...
                'For example, it can use MRI and/or PET data.' ...
                ];
        end
        function atlas_number = getBrainAtlasNumber()
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % ATLAS_NUMBER = GETBRAINATLASNUMBER() returns the number of
            % brain atlases.
            %
            % See also getList, getClass, getName.
            
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'MeasurementST_MP_WU'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_MP_WU';
        end
        function subject_class = getSubjectClass()
            % GETSUBJETCLASS returns the class of structural multiplex measurement subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of MeasurementST_MP_WU subject, 'SubjectST_MP'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectST_MP';
        end        
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of structural multiplex measurement
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS() returns the
            % available settings of MeasurementST_MP_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {};
        end
        function m = getMeasurement(measurement_class, id, label, notes, atlas, measure_code, group, varargin) %#ok<INUSD>
            % GETMEASUREMENT returns a new measurement
            %
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % returns a new MeasurementST_MP_WU object with MEASUREMENT_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            %
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % returns a new MeasurementST_MP_WU object with MEASUREMENT_CLASS,
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
            % See also MeasurementST_MP_WU.
            
            set(uiparent, 'Visible', 'off')
            handle.variables = [];
        end
    end
end