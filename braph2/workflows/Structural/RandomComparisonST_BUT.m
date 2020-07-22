classdef RandomComparisonST_BUT < RandomComparisonST_WU
    % RandomComparisonST_BUT A random comparison of structural data with weighted undirected graphs
    % RandomComparisonST_BUT is a subclass of Comparison, it implements the
    % initialization of data methods.
    %
    % RandomComparisonST_BUT implements the initialization of the data which the
    % class will save. It checks if the data being saved has correct
    % dimensions. Structural data can be for example MRI or PET data.
    %
    % RandomComparisonST_BUT constructor methods:
    %  RandomComparisonST_BUT              - Constructor
    %
    % RnomComparisonST_BUT set methods:
    %  setThreshold                 - sets the threshold
    %
    % RnomComparisonST_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % RandomComparisonST_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %  getRandcomComparison         - returns a new random comparison
    %
    % See also Comparison, AnalysisST_BUT, MeasurementST_BUT, ComparisonST_BUT.
    
    properties
        threshold  % threshold of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonST_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % RandomComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and a random group. It initializes the
            % RandomComparisonST_BUT with default settings.
            %
            % RandomComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and a random group. It initializes the
            % RandomComparisonST_BUT with VALUE settings.
            %
            % See also MeasurementST_BUT, ComparisonST_BUT, AnalysisST_BUT.
            
            rc = rc@RandomComparisonST_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            rc.setThreshold(threshold)
        end
    end
    methods  % Set functions
        function setThreshold(rc, t)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(RC, T) sets the measure value of
            % the group.
            %
            % See also getThreshold.
            
            % maybe check its less than 1?
            
            rc.threshold = t;
        end
    end
    methods  % Get functions
        function t = getThreshold(rc)
            % GETTHRESHOLD returns the threshold of the data values
            %
            % T = GETTHRESHOLD(RC) returns the threshold of the data values.
            %
            % See also getMeasureValue, setThreshold.
            
            t = rc.threshold;
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_class = getClass() %#ok<*INUSD>
            % GETCLASS returns the class of structural random comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonST_WU'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonST_WU';
        end
        function name = getName()
            % GETNAME returns the name of structural random comparison
            %
            % NAME = GETNAME() returns the name, RandomComparison ST WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison ST WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural random comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonST_WU.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = 'ST random comparison with weighted graphs.';
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'RandomComparisonST_WU'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_WU';
        end
        function sub = getRandomComparison(random_comparison_class, id, label, notes, atlas, measure_code, group, varargin)
            % GETRANDOMCOMPARISON returns a new comparison
            %
            % SUB = GETRANDOMCOMPARISON(RANDOMCOMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % returns a new RandomComparisonST_WU object with RANDOMCOMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            %
            % SUB = GETRANDOMCOMPARISON(RANDOMCOMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % returns a new RandomComparisonST_WU object with RANDOMCOMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with VALUE settings.
            %
            % See also getClass, getName, getDescription.
            
            sub = eval([random_comparison_class '(id, label, notes, atlas, measure_code, group, varargin{:})']);
        end
    end
end