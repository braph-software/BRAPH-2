classdef MeasurementST_BUT< MeasurementST_WU
    % MeasurementST_BUT A measurement of structural data with weighted undirected graphs
    % MeasurementST_BUT is a subclass of MeasurementST_WU, it implements the
    % initialization of data methods.
    %
    % MeasurementST_BUT implements the initialization of the data which the
    % class will save. It checks if the data being saved has correct
    % dimensions. Structural data can be for example MRI or PET data.
    %
    % MeasurementST_BUT constructor methods:
    %  MeasurementST_BUT            - Constructor
    %
    % MeasurementST_BUT basic methods:
    %  disp                         - displays the comparison
    % 
    % MeasurementST_BUT get methods:
    %  getValue                     - returns the value of the measurement
    %
    % MeasurementST_BUT initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % MeasurementST_BUT descriptive methods (Static):
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
        threshold  % threshold of the values
    end
    methods  % Constructor
        function m =  MeasurementST_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTST_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP. It initializes the MEASUREMENTST_WU 
            % with default settings.
            %
            % MEASUREMENTST_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP. It initializes the MEASUREMENTST_WU 
            % with VALUE settings.
            %
            % See also ComparisonST_WU, RandomComparisonST_WU, AnalysisST_WU.
            
            m = m@MeasurementST_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            m.setThreshold(threshold)
        end
    end
    methods  % Set functions
        function setThreshold(m, t)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(M, T) sets the measure value of 
            % the group.
            % 
            % See also getThreshold.
            
            % maybe check its less than 1?
                        
            m.threshold = t;
        end
    end
    methods  % Get functions
        function t = getThreshold(m)
            % GETTHRESHOLD returns the threshold of the data values
            %
            % T = GETTHRESHOLD(M) returns the threshold of the data values.
            %
            % See also getMeasureValue, setThreshold.
            
            t = m.threshold;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural measurement
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % measurement. In this case 'MeasurementST_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementST_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural measurement
            %
            % NAME = GETNAME() returns the name, Measurement ST WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement ST BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementST_WU.
            %
            % See also getList, getClass, getName
            
            description = 'ST measurement with ';
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'MeasurementST_WU'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUT';
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