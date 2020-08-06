classdef MeasurementFNC_BUT < MeasurementFNC_WU
    % MeasurementFNC_BUT A measurement of functional data with BU graphs at fixed threshold
    % MeasurementFNC_BUT is a subclass of MeasurementFNC_WU.
    %
    % MeasurementFNC_BUT store a measurement of functional data with BU
    % graphs at fixes threshold, for this it implements MeasurementFNC_WU
    % initialization of data. Functional data can be for example fMRI data.
    %
    % MeasurementFNC_BUT constructor methods:
    %  MeasurementFNC_BUT            - Constructor
    %
    % MeasurementFNC_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % MeasurementFNC_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisFNC_BUT, ComparisonFNC_BUT, RandomComparisonFNC_BUT. 
   
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function m =  MeasurementFNC_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTFNC_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold',  THRESHOLD)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP, this data will have a fixed THRESHOLD. 
            %
            % MeasurementFNC_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP, this data will have a fixed default threshold.
            %
            % See also ComparisonFNC_BUT, RandomComparisonFNC_BUT, AnalysisFNC_BUT.
            
            m = m@MeasurementFNC_WU(id, label, notes, atlas, measure_code, group, varargin{:});

            threshold = get_from_varargin(0, 'threshold', varargin{:});
            m.setThreshold(threshold)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold(m, threshold)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(M, THRESHOLD) sets the measure value of 
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
            % THRESHOLD = GETTHRESHOLD(M) returns the threshold of the data values.
            %
            % See also getMeasureValue.
            
            threshold = m.threshold;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of functional measurement BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % measurement. In this case 'MeasurementFNC_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementFNC_BUT';
        end
        function name = getName()
            % GETNAME returns the name of functional measurement BUT
            %
            % NAME = GETNAME() returns the name, Measurement FNC BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement FNC BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementFNC_BUT.
            %
            % See also getList, getClass, getName
            
            description = [ ...
                'FNC measurement with functional data using binary graphs ' ...
                'calculated at a fixed threshold. ' ...
                'For example, it can use fMRI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the measurement is part of, 'AnalysisFNC_BUT'.
            %
            % See also getClass, getName, getDescription.
            
            analysis_class = 'AnalysisFNC_BUT';
        end     
    end
end 