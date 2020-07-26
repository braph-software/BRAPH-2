classdef ComparisonST_BUT < ComparisonST_WU
    % ComparisonST_BUT A comparison of structural data with BU graphs at fixed threshold
    % ComparisonST_BUT is a subclass of Comparison.
    %
    % ComparisonST_BUT store a comparison between two groups.
    % The data from the groups it compares have a threshold.
    % Structural data can be for example MRI or PET data.
    %
    % ComparisonST_BUT constructor methods:
    %  ComparisonST_BUT              - Constructor
    %
    % ComparisonST_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % ComparisonST_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisST_BUT, MeasurementST_BUT, RandomComparisonST_BUT. 
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function c =  ComparisonST_BUT(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % ComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'threshold', THRESHOLD) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed THRESHOLD.
            %
            % ComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default THRESHOLD.
            %
            % See also MeasurementST_BUT, RandomComparisonST_BUT, AnalysisST_BUT.
            
            c = c@ComparisonST_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            c.setThreshold(threshold)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold(c, threshold)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(C, THRESHOLD) sets the measure value of
            % the group.
            %
            % See also getThreshold.
            
            c.threshold = threshold;
        end
    end
    methods  % Get functions
        function threshold = getThreshold(c)
            % GETTHRESHOLD returns the threshold of the data values
            %
            % T = GETTHRESHOLD(C) returns the threshold of the data values.
            %
            % See also getMeasureValue, setThreshold.
            
            threshold = c.threshold;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % comparison. In this case 'ComparisonST_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonST_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonST_BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Structural BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural comparison 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonST_BUT.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'ST comparison with structural data using binary graphs ' ...
                'calculated at a fixed threshold. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisST_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUT';
        end
    end
end