classdef MeasurementCON_BUT < MeasurementCON_WU
    % MeasurementCON_BUT A measurement of connectivity data with BU graphs at fixed threshold
    % MeasurementCON_BUT is a subclass of MeasurementCON_WU.
    %
    % MeasurementCON_BUT store a measurement of connectivity data with BU
    % graphs at fixes threshold, for this it implements MeasurementCON_WU
    % initialization of data. Structural data can be for example MRI or PET data.
    %
    % MeasurementCON_BUT constructor methods:
    %  MeasurementCON_BUT            - Constructor
    %
    % MeasurementCON_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % MeasurementCON_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getAnalysisClass             - returns the class of the analysis

    %
    % See also Comparison, AnalysisCON_BUT, ComparisonCON_BUT, RandomComparisonCON_BUT. 
   
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function m =  MeasurementCON_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTCON_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold',  THRESHOLD)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP, this data will have a fixed THRESHOLD. 
            %
            % MeasurementCON_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP, this data will have a fixed default threshold.
            %
            % See also ComparisonCON_BUT, RandomComparisonCON_BUT, AnalysisCON_BUT.
            
            m = m@MeasurementCON_WU(id, label, notes, atlas, measure_code, group, varargin{:});

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
            % GETCLASS returns the class of connectivity measurement BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % measurement. In this case 'MeasurementCON_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementCON_BUT';
        end
        function name = getName()
            % GETNAME returns the name of connectivity measurement BUT
            %
            % NAME = GETNAME() returns the name, Measurement CON BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement CON BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementCON_BUT.
            %
            % See also getList, getClass, getName
            
            description = [ ...
                'CON measurement with connectivity data using binary graphs ' ...
                'calculated at a fixed threshold. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the measurement is part of, 'AnalysisCON_BUT'.
            %
            % See also getClass, getName, getDescription.
            
            analysis_class = 'AnalysisCON_BUT';
        end     
    end
end 