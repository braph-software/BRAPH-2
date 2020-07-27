classdef RandomComparisonCON_BUT < RandomComparisonCON_WU
    % RandomComparisonCON_BUT A random comparison of connectivity data with BU graphs at fixed threshold
    % RandomComparisonCON_BUT is a subclass of RandomComparisonST_WU.
    %
    % RandomComparisonCON_BUT store a comparison between a group and a randomly
    % generated group. The data from the groups it compares have a
    % threshold. Connectivity data can be for example DTI data.
    %
    % RandomComparisonCON_BUT constructor methods:
    %  RandomComparisonCON_BUT       - Constructor
    %
    % RandomComparisonCON_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % RandomComparisonCON_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisCON_BUT, MeasurementCON_BUT, ComparisonCON_BUT.
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonCON_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % RandomComparisonCON_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold', THRESHOLD)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed THRESHOLD.
            %
            % RandomComparisonCON_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default THRESHOLD.
            %
            % See also MeasurementCON_BUT, ComparisonCON_BUT, AnalysisCON_BUT.
            
            rc = rc@RandomComparisonCON_WU(id, label, notes, atlas, measure_code, group, varargin{:});
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
            % GETCLASS returns the class of connectivity random comparison BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonCON_BUT'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonCON_BUT';
        end
        function name = getName()
            % GETNAME returns the name of connectivity random comparison BUT
            %
            % NAME = GETNAME() returns the name, RandomComparison CON BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison CON BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity random comparison BUT
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonCON_BUT.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'CON random comparison with connectivity data using binary ' ...
                'graphs calculated at a fixed threshold. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisCON_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisCON_BUT';
        end
    end
end