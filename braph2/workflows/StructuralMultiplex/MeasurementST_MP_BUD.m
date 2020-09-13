classdef MeasurementST_MP_BUD < MeasurementST_MP_WU
    % MeasurementST_MP_BUD A measurement of structural multiplex data with BU graphs at fixed density
    % MeasurementST_MP_BUD is a subclass of MeasurementST_MP_WU.
    %
    % MeasurementST_MP_BUD stores a measurement of structural multiplex data with 
    % BU graphs at fixed density, for this it inherits the MeasurementST_MP_WU
    % initialization of data. Structural multiplex data can be for example MRI or/and PET data.
    %
    % MeasurementST_MP_BUD constructor methods:
    %  MeasurementST_MP_BUD         - Constructor
    %
    % MeasurementST_MP_BUD get methods:
    %  getDensity1                  - returns the density of the first layer
    %  getDensity2                  - returns the density of the second layer
    %
    % MeasurementST_MP_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getAnalysisClass             - returns the class of the analysis    
    %
    % MeasurementST_MP_BUD plot methods (Static):
    %  getMeasurementSettingsPanel  - returns a UIPanel
    %
    % See also Measurement, AnalysisST_MP_BUD, ComparisonST_MP_BUD, RandomComparisonST_MP_BUD.
    
    properties (Access = protected)
        density1  % density of the values of the first layer
        density2  % density of the values of the second layer   
    end
    methods  % Constructor
        function m =  MeasurementST_MP_BUD(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTST_MP_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'density',  DENSITY)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP, this data will have a fixed DENSITY1
            % for the first layer and a fixed DENSITY2 for the second layer.
            %
            % MEASUREMENTST_MP_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP, this data will have a fixed default
            % DENSITY1 for the first layer and a fixed default DENSITY2 for 
            % the second layer.
            %
            % See also ComparisonST_MP_BUD, RandomComparisonST_MP_BUD, AnalysisST_MP_BUD.
            
            m = m@MeasurementST_MP_WU(id, label, notes, atlas, measure_code, group, varargin{:}); 
            density1 = get_from_varargin(0, 'density1', varargin{:});
            density2 = get_from_varargin(0, 'density2', varargin{:});
            m.setDensity1(density1)
            m.setDensity2(density2)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity1(m, density1)
            % SETDENSITY1 sets the fixed density of the values of the first layer
            %
            % SETDENSITY1(M, DENSITY) sets the fixed density of the values
            % of the first layer.
            %
            % See also getDensity1, setDensity2.
            
            m.density1 = density1;
        end
        function setDensity2(m, density2)
            % SETDENSITY2 sets the fixed density of the values of the second layer
            %
            % SETDENSITY2(M, DENSITY) sets the fixed density of the values
            % of the second layer.
            %
            % See also getDensity2, setDensity1.
            
            m.density2 = density2;
        end
    end
    methods  % Get functions
        function density1 = getDensity1(m)
            % GETDENSITY1 returns the fixed density of the data values of the first layer
            %
            % DENSITY1 = GETDENSITY1(M) returns the fixed density of the
            % data values of the first layer.
            %
            % See also getMeasureValue, setDensity1, getDensity2.
            
            density1 = m.density1;
        end
        function density2 = getDensity2(m)
            % GETDENSITY2 returns the fixed density of the data values of the second layer
            %
            % DENSITY2 = GETDENSITY2(M) returns the fixed density of the
            % data values of the second layer.
            %
            % See also getMeasureValue, setDensity2, getDensity1.
            
            density2 = m.density2;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural multiplex measurement BUD
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % measurement. In this case 'MeasurementST_MP_BUD'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementST_MP_BUD';
        end
        function name = getName()
            % GETNAME returns the name of structural multiplex measurement BUT
            %
            % NAME = GETNAME() returns the name, Measurement ST MP BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement ST MP BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural multiplex measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementST_MP_BUD.
            %
            % See also getList, getClass, getName
            
            description = [ ...
                'ST MP measurement with structural multiplex data using binary ' ...
                'graphs calculated at a fixed density. ' ...
                'For example, it can use MRI or/and PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the measurement is part of, 'AnalysisST_MP_BUD'.
            %
            % See also getClass, getName, getDescription.
            
            analysis_class = 'AnalysisST_MP_BUD';
        end
    end
    methods (Static)  % Plot MeasurementGUI Child Panel
        function handle = getMeasurementSettingsPanel(analysis, uiparent) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. With density settings options.
            %
            % See also MeasurementST_MP_BUD.

            handle.variables = {'density1', 'density2'};
            handle.step = [];
            handle.min = [];
            handle.max = [];         
        end
    end
end