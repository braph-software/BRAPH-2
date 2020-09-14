classdef ComparisonFNC_BUT < ComparisonFNC_WU
    % ComparisonFNC_BUT A comparison of functional data with BU graphs at fixed threshold
    % ComparisonFNC_BUT is a subclass of Comparison.
    %
    % ComparisonFNC_BUT store a comparison between two groups.
    % The data from the groups it compares have a threshold.
    % Functional data can be for example fMRI data.
    %
    % ComparisonFNC_BUT constructor methods:
    %  ComparisonFNC_BUT            - Constructor
    %
    % ComparisonFNC_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % ComparisonFNC_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisFNC_BUT, MeasurementFNC_BUT, RandomComparisonFNC_BUT. 
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function c =  ComparisonFNC_BUT(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % ComparisonFNC_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'threshold', THRESHOLD) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed THRESHOLD.
            %
            % ComparisonFNC_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default THRESHOLD.
            %
            % See also MeasurementFNC_BUT, RandomComparisonFNC_BUT, AnalysisFNC_BUT.
            
            c = c@ComparisonFNC_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
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
            % GETCLASS returns the class of functional comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % comparison. In this case 'ComparisonFNC_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonFNC_BUT';
        end
        function name = getName()
            % GETNAME returns the name of functional comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonFNC_BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Functional BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional comparison 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonFNC_BUT.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'FNC comparison with functional data using binary graphs ' ...
                'calculated at a fixed threshold. ' ...
                'For example, it can use fMRI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisFNC_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisFNC_BUT';
        end
    end
end