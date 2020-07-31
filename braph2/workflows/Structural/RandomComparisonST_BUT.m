classdef RandomComparisonST_BUT < RandomComparisonST_WU
    % RandomComparisonST_BUT A random comparison of structural data with BU graphs at fixed threshold
    % RandomComparisonST_BUT is a subclass of RandomComparisonST_WU.
    %
    % RandomComparisonST_BUT store a comparison between a group and a randomly
    % generated group. The data from the groups it compares haves a
    % threshold. Structural data can be for example MRI or PET data.
    %
    % RandomComparisonST_BUT constructor methods:
    %  RandomComparisonST_BUT       - Constructor
    %
    % RandomComparisonST_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % RandomComparisonST_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisST_BUT, MeasurementST_BUT, ComparisonST_BUT.
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonST_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % RandomComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold', THRESHOLD)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed THRESHOLD.
            %
            % RandomComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default THRESHOLD.
            %
            % See also MeasurementST_BUT, ComparisonST_BUT, AnalysisST_BUT.
            
            rc = rc@RandomComparisonST_WU(id, label, notes, atlas, measure_code, group, varargin{:});
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
            % GETCLASS returns the class of structural random comparison BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonST_BUT'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonST_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural random comparison BUT
            %
            % NAME = GETNAME() returns the name, RandomComparison ST BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison ST BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural random comparison BUT
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonST_BUT.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'ST random comparison with structural data using binary ' ...
                'graphs calculated at a fixed threshold. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisST_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUT';
        end
    end
end