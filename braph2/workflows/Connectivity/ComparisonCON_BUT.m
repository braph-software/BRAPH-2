classdef ComparisonCON_BUT < ComparisonCON_WU
    % ComparisonCON_BUT A comparison of connectivity data with BU graphs at fixed threshold
    % ComparisonCON_BUT is a subclass of Comparison.
    %
    % ComparisonCON_BUT store a comparison between two groups.
    % The data from the groups it compares have a threshold.
    % Connectivity data can be for example MRI or PET data.
    %
    % ComparisonCON_BUT constructor methods:
    %  ComparisonCON_BUT              - Constructor
    %
    % ComparisonCON_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % ComparisonCON_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisCON_BUT, MeasurementCON_BUT, RandomComparisonCON_BUT. 
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function c =  ComparisonCON_BUT(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % ComparisonCON_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'threshold', THRESHOLD) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed THRESHOLD.
            %
            % ComparisonCON_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default THRESHOLD.
            %
            % See also MeasurementCON_BUT, RandomComparisonCON_BUT, AnalysisCON_BUT.
            
            c = c@ComparisonCON_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
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
            % GETCLASS returns the class of connectivity comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % comparison. In this case 'ComparisonCON_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonCON_BUT';
        end
        function name = getName()
            % GETNAME returns the name of connectivity comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonCON_BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Connectivity BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity comparison 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonCON_BUT.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'CON comparison with connectivity data using binary graphs ' ...
                'calculated at a fixed threshold. ' ...
                'For example, it can use DTI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisCON_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisCON_BUT';
        end
    end
end