classdef MeasurementST_MP_BUT < MeasurementST_MP_WU
    % MeasurementST_MP_BUT A measurement of structural multiplex data with BU graphs at fixed threshold
    % MeasurementST_MP_BUT is a subclass of MeasurementST_MP_WU.
    %
    % MeasurementST_MP_BUT stores a measurement of structural multiplex data with BU
    % graphs at fixed threshold for each layer, for this it implements MeasurementST_MP_WU
    % initialization of data. Structural multiplex data can be for example MRI or/and PET data.
    %
    % MeasurementST_MP_BUT constructor methods:
    %  MeasurementST_MP_BUT         - Constructor
    %
    % MeasurementST_MP_BUT get methods:
    %  getThreshold1                - returns the threshold of the first layer
    %  getThreshold2                - returns the threshold of the second layer
    %
    % MeasurementST_MP_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getAnalysisClass             - returns the class of the analysis
    %
    % MeasurementST_MP_BUT plot methods (Static):
    %  getMeasurementSettingsPanel  - returns a UIPanel
    %
    % See also Measurement, AnalysisST_MP_BUT, ComparisonST_MP_BUT, RandomComparisonST_MP_BUT.
    
    properties (Access = protected)
        threshold1  % threshold of the values of the first layer
        threshold2  % threshold of the values of the second layer
    end
    methods  % Constructor
        function m =  MeasurementST_MP_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTST_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold1', THRESHOLD1, 'threshold2', THRESHOLD2)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP, this data will have a fixed THRESHOLD1 
            % for the first layer and a fixed THRESHOLD2 for the second layer.
            %
            % MEASUREMENTST_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP, this data will have a fixed default THRESHOLD1
            % for the first layer and a fixed default THRESHOLD2 for the second layer.
            %
            % See also ComparisonST_MP_BUT, RandomComparisonST_MP_BUT, AnalysisST_MP_BUT.
            
            m = m@MeasurementST_MP_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            threshold1 = get_from_varargin(0, 'threshold1', varargin{:});
            threshold2 = get_from_varargin(0, 'threshold2', varargin{:});
            m.setThreshold1(threshold1)
            m.setThreshold2(threshold2)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold1(m, threshold1)
            % SETTHRESHOLD1 sets the threshold of the values of the first layer
            %
            % SETTHRESHOLD1(M, THRESHOLD1) sets the threshold of the values
            % of the first layer.
            %
            % See also getThreshold1, setThreshold2.
            
            m.threshold1 = threshold1;
        end
        function setThreshold2(m, threshold2)
            % SETTHRESHOLD2 sets the threshold of the values of the second layer
            %
            % SETTHRESHOLD2(M, THRESHOLD2) sets the threshold of the values
            % of the second layer.
            %
            % See also getThreshold2, setThreshold1.
            
            m.threshold2 = threshold2;
        end
    end
    methods  % Get functions
        function threshold1 = getThreshold1(m)
            % GETTHRESHOLD1 returns the threshold of the data values of the first layer
            %
            % T = GETTHRESHOLD1(M) returns the threshold of the data values
            % of the first layer.
            %
            % See also getMeasureValue, setThreshold1, getThreshold2.
            
            threshold1 = m.threshold1;
        end
        function threshold2 = getThreshold2(m)
            % GETTHRESHOLD2 returns the threshold of the data values of the second layer
            %
            % T = GETTHRESHOLD2(M) returns the threshold of the data values
            % of the second layer.
            %
            % See also getMeasureValue, setThreshold2, getThreshold1.
            
            threshold2 = m.threshold2;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural multiplex measurement BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % measurement. In this case 'MeasurementST_MP_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementST_MP_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural multiplex measurement BUT
            %
            % NAME = GETNAME() returns the name, Measurement ST MP BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement ST MP BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural multiplex measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementST_MP_BUT.
            %
            % See also getList, getClass, getName
            
            description = [ ...
                'ST MP measurement with structural multiplex data using binary graphs ' ...
                'calculated at a fixed threshold. ' ...
                'For example, it can use MRI or/and PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the measurement is part of, 'AnalysisST_MP_BUT'.
            %
            % See also getClass, getName, getDescription.
            
            analysis_class = 'AnalysisST_MP_BUT';
        end
    end
    methods (Static)  % Plot functions
        function handle = getMeasurementSettingsPanel(analysis, uiparent) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. With threshold settings options.
            %
            % See also MeasurementST_BUT.
            
            handle.variables = {'threshold1', 'threshold2'};
            handle.step = [];
            handle.min = [];
            handle.max = [];
        end
    end
end