classdef RandomComparisonST_MP_BUT < RandomComparisonST_MP_WU
    % RandomComparisonST_MP_BUT A random comparison of structural multiplex data with BU graphs at fixed threshold
    % RandomComparisonST_MP_BUT is a subclass of RandomComparisonST_MP_WU.
    %
    % RandomComparisonST_MP_BUT store a comparison between a group and a randomly
    % generated group. The data from the groups it compares have a fixed threshold 
    % for each layer. Structural multiplex data can be for example MRI or/and PET data.
    %
    % RandomComparisonST_MP_BUT constructor methods:
    %  RandomComparisonST_MP_BUT    - Constructor
    %
    % RandomComparisonST_MP_BUT get methods:
    %  getThreshold1                - returns the threshold of the first layer
    %  getThreshold2                - returns the threshold of the second layer
    %
    % RandomComparisonST_MP_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % RandomComparisonST_MP_BUT plot methods (Static):
    %  getRandomComparisonSettingsPanel - returns a UIPanel
    % 
    % See also RandomComparison, AnalysisST_MP_BUT, MeasurementST_MP_BUT, ComparisonST_MP_BUT.
    
    properties (Access = protected)
        threshold1  % threshold of the values of the first layer
        threshold2  % threshold of the values of the second layer
    end
    methods  % Constructor
        function rc =  RandomComparisonST_MP_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % RANDOMCOMPARISONST_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold1', THRESHOLD1, 'threshold2', THRESHOLD2)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % a fixed THRESHOLD1 for the first layer and a fixed THRESHOLD2
            % for the second layer.
            %
            % RANDOMCOMPARISONST_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default THRESHOLD1 for the first layer and a fixed 
            % default THRESHOLD2 for the second layer.
            %
            % See also MeasurementST_MP_BUT, ComparisonST_MP_BUT, AnalysisST_MP_BUT.
            
            rc = rc@RandomComparisonST_MP_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            threshold1 = get_from_varargin(0, 'threshold1', varargin{:});
            threshold2 = get_from_varargin(0, 'threshold2', varargin{:});
            rc.setThreshold1(threshold1)
            rc.setThreshold2(threshold2)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold1(rc, threshold1)
            % SETTHRESHOLD1 sets the threshold of the values of the first layer
            %
            % SETTHRESHOLD1(RC, THRESHOLD1) sets the threshold of the values
            % of the first layer.
            %
            % See also getThreshold1, setThreshold2.
            
            rc.threshold1 = threshold1;
        end
        function setThreshold2(rc, threshold2)
            % SETTHRESHOLD2 sets the threshold of the values of the second layer
            %
            % SETTHRESHOLD2(RC, THRESHOLD2) sets the threshold of the values
            % of the second layer.
            %
            % See also getThreshold2, setThreshold1.
            
            rc.threshold2 = threshold2;
        end
    end
    methods  % Get functions
        function threshold1 = getThreshold1(rc)
            % GETTHRESHOLD1 returns the threshold of the data values of the first layer
            %
            % T = GETTHRESHOLD1(RC) returns the threshold of the data values
            % of the first layer.
            %
            % See also getMeasureValue, setThreshold1, getThreshold2.
            
            threshold1 = rc.threshold1;
        end
        function threshold2 = getThreshold2(rc)
            % GETTHRESHOLD2 returns the threshold of the data values of the second layer
            %
            % T = GETTHRESHOLD2(RC) returns the threshold of the data values
            % of the second layer.
            %
            % See also getMeasureValue, setThreshold2, getThreshold1.
            
            threshold2 = rc.threshold2;
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_class = getClass() %#ok<*INUSD>
            % GETCLASS returns the class of structural multiplex random comparison BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonST_MP_BUT'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonST_MP_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural multiplex random comparison BUT
            %
            % NAME = GETNAME() returns the name, RandomComparison ST MP BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison ST MP BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural multiplex random comparison BUT
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonST_MP_BUT.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'ST MP random comparison with structural multiplex data using binary ' ...
                'graphs calculated at a fixed threshold. ' ...
                'For example, it can use MRI or/and PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisST_MP_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_MP_BUT';
        end
    end
    methods (Static)  % Plot ComparisonGUI Child Panel
        function handle = getRandomComparisonSettingsPanel(analysis, uiparent) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible,
            % Randomization and Threshold.
            %
            % See also RandomComparisonST_BUT.

            handle.variables = {'threshold1', 'threshold2'};
            handle.step = [];
            handle.min = [];
            handle.max = [];
            handle.randomization = [];
        end
    end
end