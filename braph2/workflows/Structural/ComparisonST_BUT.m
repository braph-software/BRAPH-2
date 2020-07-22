classdef ComparisonST_BUT < ComparisonST_WU
    % ComparisonST_WU A comparison of structural data with weighted undirected graphs
    % ComparisonST_WU is a subclass of Comparison, it implements the
    % initialization of data methods.
    %
    % ComparisonST_WU implements the initialization of the data which the
    % class will save. It checks if the data being saved has correct
    % dimensions. Structural data can be for example MRI or PET data.
    %
    % ComparisonST_WU constructor methods:
    %  ComparisonST_WU              - Constructor
    %
    % ComparisonST_WU basic methods:
    %  disp                         - displays the comparison
    % 
    % ComparisonST_WU get methods:
    %  getGroupValues               - returns the groups measurement value
    %  getGroupValue                - returns the group measurement value
    %  getDifference                - returns the difference between values
    %  getAllDifferences            - returns all the differecens between values
    %  getP1                        - returns the p-values single tail
    %  getP2                        - returns the p-values double tail
    %  getConfidenceIntervalMin     - returns the min value of the confidence interval
    %  getConfidenceIntervalMax     - returns the max value of the confidence interval
    %
    % ComparisonST_WU initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % ComparisonST_WU descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getBrainAtlasNumber          - returns the number of brain atlases
    %  getAnalysisClass             - returns the class of the analysis
    %  getSubjectClass              - returns the class of the subject
    %  getAvailbleSettings          - returns the available settings
    %  getComparison                - returns a new comparison
    %
    % See also Comparison, AnalysisST_WU, MeasurementST_WU, RandomComparisonST_WU. 
    
    properties
        threshold  % threshold of the values
    end
    methods  % Constructor
        function c =  ComparisonST_BUT(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % COMPARISONST_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and GROUP_2. It initializes the
            % COMPARISONST_WU with default settings.
            %
            % COMPARISONST_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and GROUP_2. It initializes the
            % COMPARISONST_WU with VALUE settings.
            %
            % See also MeasurementST_WU, RandomComparisonST_WU, AnalysisST_WU.
            
            c = c@ComparisonST_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            c.setThreshold(threshold)
        end
    end
    methods  % Set functions
        function setThreshold(c, t)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(C, T) sets the measure value of
            % the group.
            %
            % See also getThreshold.
            
            % maybe check its less than 1?
            
            c.threshold = t;
        end
    end
    methods  % Get functions
        function t = getThreshold(c)
            % GETTHRESHOLD returns the threshold of the data values
            %
            % T = GETTHRESHOLD(C) returns the threshold of the data values.
            %
            % See also getMeasureValue, setThreshold.
            
            t = c.threshold;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % comparison. In this case 'ComparisonST_WU'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonST_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonST_WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Structural BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural comparison 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonST_WU.
            %
            % See also getList, getClass, getName.
            
            description = 'Structural comparison using .';
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisST_WU'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUT';
        end
        function sub = getComparison(comparison_class, id, label, notes, atlas, measure_code, group_1, group_2, varargin)  %#ok<INUSD>
            % GETCOMPARISON returns a new comparison
            %
            % SUB = GETCOMPARISON(COMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % returns a new ComparisonST_WU object with COMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            % 
            % SUB = GETCOMPARISON(COMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % returns a new ComparisonST_WU object with COMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with VALUE settings.
            %
            % See also getClass, getName, getDescription.
            
            sub = eval([comparison_class '(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:})']);
        end
    end
end