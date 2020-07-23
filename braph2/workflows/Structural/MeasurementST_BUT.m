classdef MeasurementST_BUT< MeasurementST_WU
    % MeasurementST_BUT A measurement of structural data of fixed threshold binary undirected graphs
    % MeasurementST_BUT is a subclass of MeasurementST_WU, it implements the
    % initialization of data methods.
    %
    % MeasurementST_BUT implements the initialization of the data of fixed 
    % threshold binary undirected graphswhich the class will save.
    % It checks if the data being saved has correct dimensions. 
    % Structural data can be for example MRI or PET data.
    %
    % MeasurementST_BUT constructor methods:
    %  MeasurementST_BUT            - Constructor
    %
    % MeasurementST_BUT set methods:
    %  setThreshold                 - sets the threshold
    % 
    % MeasurementST_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % MeasurementST_BUT initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % MeasurementST_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getAnalysisClass             - returns the class of the analysis
    %  getMeasurement               - returns a new measurement
    %
    % See also Comparison, AnalysisST_BUT, ComparisonST_BUT, RandomComparisonST_BUT. 
   
    properties
        threshold  % threshold of the values
    end
    methods  % Constructor
        function m =  MeasurementST_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data of fixed threshold binary undirected graphs
            % from GROUP. It initializes the MeasurementST_BUT 
            % with default settings.
            %
            % MeasurementST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data of fixed threshold binary undirected graphs
            % from GROUP. It initializes the MeasurementST_BUT 
            % with VALUE settings.
            %
            % See also ComparisonST_BUT, RandomComparisonST_BUT, AnalysisST_BUT.
            
            m = m@MeasurementST_WU(id, label, notes, atlas, measure_code, group, varargin{:});

            threshold = get_from_varargin(0, 'threshold', varargin{:});
            m.setThreshold(threshold)
        end
    end
    methods (Access=protected) % Set functions
        function setThreshold(m, threshold)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(M, T) sets the measure value of 
            % the group.
            % 
            % See also getThreshold.
            
            m.threshold = threshold;
        end
    end
    methods  % Get functions
        function threshold = getThreshold(m)
            % GETTHRESHOLD returns the threshold of the data values
            %
            % T = GETTHRESHOLD(M) returns the threshold of the data values.
            %
            % See also getMeasureValue, setThreshold.
            
            threshold = m.threshold;
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
            % NAME = GETNAME() returns the name, Measurement ST BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement ST BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementST_BUT.
            %
            % See also getList, getClass, getName
            
            description = [ ...
                'ST measurement with structural data using binary graphs ' ...
                'calculated at a fixed threshold. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'MeasurementST_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUT';
        end     
    end
end 