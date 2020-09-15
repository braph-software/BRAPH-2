classdef ComparisonST_MP_BUT < ComparisonST_MP_WU
    % ComparisonST_MP_BUT A comparison of structural multiplex data with BU graphs at fixed threshold
    % ComparisonST_MP_BUT is a subclass of ComparisonST_MP_WU.
    %
    % ComparisonST_MP_BUT stores a comparison between two groups.
    % The data from the groups it compares have a fixed threshold for each layer.
    % Structural multiplex data can be for example MRI or/and PET data.
    %
    % ComparisonST_MP_BUT constructor methods:
    %  ComparisonST_MP_BUT          - Constructor
    %
    % ComparisonST_MP_BUT get methods:
    %  getThreshold1                - returns the threshold of the first layer
    %  getThreshold2                - returns the threshold of the second layer
    %
    % ComparisonST_MP_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % ComparisonST_MP_BUT plot methods (Static):
    %  getComparisonSettingsPanel   - returns a UIPanel
    % 
    % See also Comparison, AnalysisST_MP_BUT, MeasurementST_MP_BUT, RandomComparisonST_MP_BUT.
    
    properties (Access = protected)
        threshold1  % threshold of the values of the first layer
        threshold2  % threshold of the values of the second layer
    end
    methods  % Constructor
        function c =  ComparisonST_MP_BUT(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % COMPARISONST_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'threshold1', THRESHOLD1, 'threshold2', THRESHOLD2)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed THRESHOLD1 for the first layer and a fixed THRESHOLD2
            % for the second layer.
            %
            % COMPARISONST_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default THRESHOLD1 for the first layer and a fixed 
            % default THRESHOLD2 for the second layer.
            %
            % See also MeasurementST_MP_BUT, RandomComparisonST_MP_BUT, AnalysisST_MP_BUT.
            
            c = c@ComparisonST_MP_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            threshold1 = get_from_varargin(0, 'threshold1', varargin{:});
            threshold2 = get_from_varargin(0, 'threshold2', varargin{:});
            c.setThreshold1(threshold1)
            c.setThreshold2(threshold2)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold1(c, threshold1)
            % SETTHRESHOLD1 sets the threshold of the values of the first layer
            %
            % SETTHRESHOLD1(C, THRESHOLD1) sets the threshold of the values
            % of the first layer.
            %
            % See also getThreshold1, setThreshold2.
            
            c.threshold1 = threshold1;
        end
        function setThreshold2(c, threshold2)
            % SETTHRESHOLD2 sets the threshold of the values of the second layer
            %
            % SETTHRESHOLD2(C, THRESHOLD2) sets the threshold of the values
            % of the second layer.
            %
            % See also getThreshold2, setThreshold1.
            
            c.threshold2 = threshold2;
        end
    end
    methods  % Get functions
        function threshold1 = getThreshold1(c)
            % GETTHRESHOLD1 returns the threshold of the data values of the first layer
            %
            % T = GETTHRESHOLD1(C) returns the threshold of the data values
            % of the first layer.
            %
            % See also getMeasureValue, setThreshold1, getThreshold2.
            
            threshold1 = c.threshold1;
        end
        function threshold2 = getThreshold2(c)
            % GETTHRESHOLD2 returns the threshold of the data values of the second layer
            %
            % T = GETTHRESHOLD2(C) returns the threshold of the data values
            % of the second layer.
            %
            % See also getMeasureValue, setThreshold2, getThreshold1.
            
            threshold2 = c.threshold2;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural multiplex comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % comparison. In this case 'ComparisonST_MP_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonST_MP_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural multiplex comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonST_MP_BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Structural Multiplex BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonST_MP_BUT.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'ST MP comparison with structural multiplex data using binary graphs ' ...
                'calculated at a fixed threshold. ' ...
                'For example, it can use MRI or/and PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisST_MP_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_MP_BUT';
        end
    end
    methods (Static)  % Plot MeasurementGUI Child Panel
        function handle = getComparisonSettingsPanel(analysis, uiparent) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible,
            % Permutation and Threshold.
            %
            % See also ComparisonST_BUT.
                                 
            handle.variables = {'threshold1', 'threshold2'};
            handle.step = [];
            handle.min = [];
            handle.max = [];
            handle.permutation = [];
        end
    end
end