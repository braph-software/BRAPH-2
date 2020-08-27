classdef MeasurementST_WU < Measurement
    % MeasurementST_WU A measurement of structural data with weighted undirected graphs
    % MeasurementST_WU is a subclass of Measurement, it implements the
    % initialization of data methods.
    %
    % MeasurementST_WU implements Measurement initialization of the data 
    % function class will save. It checks if the data being saved has correct
    % dimensions. Structural data can be for example MRI or PET data.
    %
    % MeasurementST_WU constructor methods:
    %  MeasurementST_WU             - Constructor
    %
    % MeasurementST_WU basic methods:
    %  disp                         - displays the comparison
    % 
    % MeasurementST_WU get methods:
    %  getValue                     - returns the value of the measurement
    %
    % MeasurementST_WU initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % MeasurementST_WU descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getBrainAtlasNumber          - returns the number of brain atlases
    %  getAnalysisClass             - returns the class of the analysis
    %  getSubjectClass              - returns the class of the subject
    %  getAvailbleSettings          - returns the available settings
    %  getMeasurement               - returns a new measurement
    %
    % See also Comparison, AnalysisST_WU, ComparisonST_WU, RandomComparisonST_WU. 
   
    properties
        value  % value of the measure for the group
    end
    methods  % Constructor
        function m =  MeasurementST_WU(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTST_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP. It initializes the MEASUREMENTST_WU 
            % with default settings.
            %
            % See also ComparisonST_WU, RandomComparisonST_WU, AnalysisST_WU.
            
            graph_type = AnalysisST_WU.getGraphType();
            measure_list = Graph.getCompatibleMeasureList(graph_type);            
            assert(ismember(measure_code, measure_list), ...
                [BRAPH2.STR ':MeasurementST_WU:' BRAPH2.BUG_FUNC], ...
                'MeasurementST_WU measure_code is not compatible with the permited Measures.');

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
            % GETGROUPVALUE returns the measure value of the group
            %
            % VALUE = GETMEASUREVALUE(M) returns the measure value of 
            % the group.
            % 
            % See also getClass, getName, getDescription.
            
            value = m.value;
        end
    end
    methods (Access=protected)  % Initialize data
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
            % See also AnalysisST_WU.
            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};

            measure_code = m.getMeasureCode();
            
            if Measure.is_global(measure_code)  % global measure
                m.value = get_from_varargin( ...
                    {0}, ...  % 1 measure per group
                    'MeasurementST.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x, 1), 1), m.getMeasureValue())) &&...
                    all(cellfun(@(x) isequal(size(x, 2), 1), m.getMeasureValue())), ...
                    [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(m)])
            elseif Measure.is_nodal(measure_code)  % nodal measure
                m.value = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'MeasurementST.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x, 1), atlas.getBrainRegions().length()), m.getMeasureValue())) && ...
                    all(cellfun(@(x) isequal(size(x, 2), 1), m.getMeasureValue())), ...
                    [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(m)])
            elseif Measure.is_binodal(measure_code)  % binodal measure
                m.value = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'MeasurementST.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) && ...
                    isequal(size(m.getMeasureValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x, 1), atlas.getBrainRegions().length()), m.getMeasureValue())) && ...
                    all(cellfun(@(x) isequal(size(x, 2), atlas.getBrainRegions().length()), m.getMeasureValue())), ...
                    [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(m)])
            end
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural measurement
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % measurement. In this case 'MeasurementST_WU'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementST_WU';
        end
        function name = getName()
            % GETNAME returns the name of structural measurement
            %
            % NAME = GETNAME() returns the name, Measurement ST WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement ST WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementST_WU.
            %
            % See also getList, getClass, getName
            
            description = [ ...
                'ST measurement with weighted graphs. ' ...
                'For example, it can use MRI or PET data.' ...
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
            % analysis the random comparison is part of, 'MeasurementST_WU'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_WU';
        end
        function subject_class = getSubjectClass()
            % GETSUBJETCLASS returns the class of structural measurement subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of MeasurementST_WU subject, 'SubjectST'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectST';
        end        
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of structural measurement
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS() returns the 
            % available settings of MeasurementST_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {};
        end
        function m = getMeasurement(measurement_class, id, label, notes, atlas, measure_code, group, varargin) %#ok<INUSD>
            % GETMEASUREMENT returns a new measurement
            %
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % returns a new MeasurementST_WU object with MEASUREMENT_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            % 
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % returns a new MeasurementST_WU object with MEASUREMENT_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with VALUE settings.
            %
            % See also getClass, getName, getDescription.
            
            m = eval([measurement_class '(id, label, notes, atlas, measure_code, group, varargin{:})']);
        end
    end
end 