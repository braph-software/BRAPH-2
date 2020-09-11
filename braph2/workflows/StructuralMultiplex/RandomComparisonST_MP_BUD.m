classdef RandomComparisonST_MP_BUD < RandomComparisonST_MP_WU
    % RandomComparisonST_MP_BUD A random comparison of structural multiplex data with BU graphs at fixed density
    % RandomComparisonST_MP_BUD is a subclass of RandomComparisonST_MP_WU.
    %
    % RandomComparisonST_MP_BUD stores a comparison between a group and a randomly
    % generated group. The data from the groups it compares have a fixed density
    % for each layer. Structural data can be for example MRI or/and PET data.
    %
    % RandomComparisonST_MP_BUD constructor methods:
    %  RandomComparisonST_MP_BUD    - Constructor
    %
    % RandomComparisonST_MP_BUD get methods:
    %  getDensity1                  - returns the density of the first layer
    %  getDensity2                  - returns the density of the second layer
    %
    % RandomComparisonST_MP_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % RandomComparisonST_MP_BUD plot methods (Static):
    %  getRandomComparisonSettingsPanel - returns a UIPanel
    %
    % See also RandomComparison, AnalysisST_MP_BUD, MeasurementST_MP_BUD, ComparisonST_MP_BUD.
    
    properties (Access = protected)
        density1  % density of the values of the first layer
        density2  % density of the values of the second layer   
    end
    methods  % Constructor
        function rc =  RandomComparisonST_MP_BUD(id, label, notes, atlas, measure_code, group, varargin)
            % RANDOMCOMPARISONST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'density', DENSITY)
            % creates a random comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed DENSITY1 for the first layer and a fixed DENSITY2  
            % for the second layer.
            %
            % RANDOMCOMPARISONST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a random comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default DENSITY1 for the first layer and a fixed 
            % default DENSITY2 for the second layer.
            %
            % See also MeasurementST_MP_BUD, ComparisonST_MP_BUD, AnalysisST_MP_BUD.
            
            rc = rc@RandomComparisonST_MP_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            density1 = get_from_varargin(0, 'density1', varargin{:});
            density2 = get_from_varargin(0, 'density2', varargin{:});
            rc.setDensity1(density1)
            rc.setDensity2(density2)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity1(rc, density1)
            % SETDENSITY1 sets the fixed density of the values of the first layer
            %
            % SETDENSITY1(RC, DENSITY) sets the fixed density of the values
            % of the first layer.
            %
            % See also getDensity1, setDensity2.
            
            rc.density1 = density1;
        end
        function setDensity2(rc, density2)
            % SETDENSITY2 sets the fixed density of the values of the second layer
            %
            % SETDENSITY2(RC, DENSITY) sets the fixed density of the values
            % of the second layer.
            %
            % See also getDensity2, setDensity1.
            
            rc.density2 = density2;
        end
    end
    methods  % Get functions
        function density1 = getDensity1(rc)
            % GETDENSITY1 returns the fixed density of the data values of the first layer
            %
            % DENSITY1 = GETDENSITY1(RC) returns the fixed density of the
            % data values of the first layer.
            %
            % See also getMeasureValue, setDensity1, getDensity2.
            
            density1 = rc.density1;
        end
        function density2 = getDensity2(rc)
            % GETDENSITY2 returns the fixed density of the data values of the second layer
            %
            % DENSITY2 = GETDENSITY2(RC) returns the fixed density of the
            % data values of the second layer.
            %
            % See also getMeasureValue, setDensity2, getDensity1.
            
            density2 = rc.density2;
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_class = getClass() %#ok<*INUSD>
            % GETCLASS returns the class of structural multiplex random comparison BUD
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonST_MP_BUD'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonST_MP_BUD';
        end
        function name = getName()
            % GETNAME returns the name of structural random multiplex comparison BUD
            %
            % NAME = GETNAME() returns the name, RandomComparison ST MP BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison ST MP BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural multiplex random comparison BUD
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonST_MP_BUD.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'ST random comparison with structural multiplex data using binary ' ...
                'graphs calculated at a fixed density. ' ...
                'For example, it can use MRI or/and PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisST_MP_BUD'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_MP_BUD';
        end
    end
    methods (Static)  % Plot ComparisonGUI Child Panel
        function handle = getRandomComparisonSettingsPanel(analysis, uiparent) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible,
            % Randomization and Density.
            %
            % See also RandomComparisonST_BUD.

            handle.variables = {'density1', 'density2'};
            handle.step = [];
            handle.min = [];
            handle.max = [];
            handle.randomization = [];
        end
    end
end