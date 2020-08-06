classdef RandomComparisonFNC_BUT < RandomComparisonFNC_WU
    % RandomComparisonFNC_BUT A random comparison of functional data with BU graphs at fixed threshold
    % RandomComparisonFNC_BUT is a subclass of RandomComparisonFNC_WU.
    %
    % RandomComparisonFNC_BUT store a comparison between a group and a randomly
    % generated group. The data from the groups it compares haves a
    % threshold. Functional data can be for example fMRI data.
    %
    % RandomComparisonFNC_BUT constructor methods:
    %  RandomComparisonFNC_BUT       - Constructor
    %
    % RandomComparisonFNC_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % RandomComparisonFNC_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisFNC_BUT, MeasurementFNC_BUT, ComparisonFNC_BUT.
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonFNC_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % RandomComparisonFNC_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold', THRESHOLD)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed THRESHOLD.
            %
            % RandomComparisonFNC_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default THRESHOLD.
            %
            % See also MeasurementFNC_BUT, ComparisonFNC_BUT, AnalysisFNC_BUT.
            
            rc = rc@RandomComparisonFNC_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            rc.setThreshold(threshold)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold(rc, threshold)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(RC, THRESHOLD) sets the measure value of
            % the group.
            %
            % See also getThreshold.

            rc.threshold = threshold;
        end
    end
    methods  % Get functions
        function threshold = getThreshold(rc)
            % GETTHRESHOLD returns the threshold of the data values
            %
            % THRESHOLD = GETTHRESHOLD(RC) returns the threshold of the data values.
            %
            % See also getMeasureValue, setThreshold.
            
            threshold = rc.threshold;
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_class = getClass() %#ok<*INUSD>
            % GETCLASS returns the class of functional random comparison BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonFNC_BUT'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonFNC_BUT';
        end
        function name = getName()
            % GETNAME returns the name of functional random comparison BUT
            %
            % NAME = GETNAME() returns the name, RandomComparison FNC BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison FNC BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional random comparison BUT
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonFNC_BUT.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'FNC random comparison with functional data using binary ' ...
                'graphs calculated at a fixed threshold. ' ...
                'For example, it can use fMRI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisFNC_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisFNC_BUT';
        end
    end
end