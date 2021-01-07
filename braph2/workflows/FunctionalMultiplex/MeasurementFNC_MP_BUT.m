classdef MeasurementFNC_MP_BUT < MeasurementFNC_MP_WU
    % MeasurementFNC_MP_BUT A measurement of functional data with BU graphs at fixed threshold
    % MeasurementFNC_MP_BUT is a subclass of MeasurementFNC_MP_WU.
    %
    % MeasurementFNC_MP_BUT store a measurement of functional data with BU
    % graphs at fixes threshold, for this it implements MeasurementFNC_MP_WU
    % initialization of data. Functional data can be for example fMRI data.
    %
    % MeasurementFNC_MP_BUT constructor methods:
    %  MeasurementFNC_MP_BUT            - Constructor
    %
    % MeasurementFNC_MP_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % MeasurementFNC_MP_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getAnalysisClass             - returns the class of the analysis
    %
    % MeasurementFNC_MP_BUT plot methods (Static):
    %  getMeasurementSettingsPanel  - returns a UIPanel
    %
    % See also Comparison, AnalysisFNC_MP_BUT, ComparisonFNC_MP_BUT, RandomComparisonFNC_MP_BUT.
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function m =  MeasurementFNC_MP_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % MeasurementFNC_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold',  THRESHOLD)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP, this data will have a fixed THRESHOLD.
            %
            % MeasurementFNC_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP, this data will have a fixed default threshold.
            %
            % See also ComparisonFNC_MP_BUT, RandomComparisonFNC_MP_BUT, AnalysisFNC_MP_BUT.
            
            m = m@MeasurementFNC_MP_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            m.setThreshold(threshold)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold(m, threshold)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(M, THRESHOLD) sets the measure value of
            % the group.
            %
            % See also getThreshold.
            
            m.threshold = threshold;
        end
    end
    methods  % Get functions
        function threshold = getThreshold(m)
            % GETTHRESHOLD returns the threshold of the data values
            %
            % THRESHOLD = GETTHRESHOLD(M) returns the threshold of the data values.
            %
            % See also getMeasureValue.
            
            threshold = m.threshold;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of functional measurement BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % measurement. In this case 'MeasurementFNC_MP_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementFNC_MP_BUT';
        end
        function name = getName()
            % GETNAME returns the name of functional measurement BUT
            %
            % NAME = GETNAME() returns the name, Measurement FNC BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement FNC MP BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementFNC_MP_BUT.
            %
            % See also getList, getClass, getName
            
            description = 'Functional Multiplex with Threshold measurement.';
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the measurement is part of, 'AnalysisFNC_MP_BUT'.
            %
            % See also getClass, getName, getDescription.
            
            analysis_class = 'AnalysisFNC_MP_BUT';
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
            
            set(uiparent, 'Visible', 'on')
            ui_threshold_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_threshold_min_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_min_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_threshold_max_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_max_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            function init_child_panel()
                set(ui_threshold_text, 'String', 'Threshold')
                set(ui_threshold_text, 'Position', [.01 .8 .3 .08])
                set(ui_threshold_text, 'Fontweight', 'bold')
                
                set(ui_threshold_edit, 'String', 0.1)
                set(ui_threshold_edit, 'Position', [.31 .8 .3 .08])
                set(ui_threshold_edit, 'Callback', {@cb_measurement_threshold})
                
                set(ui_threshold_min_text, 'String', 'Min')
                set(ui_threshold_min_text, 'Position', [.01 .9 .3 .08])
                set(ui_threshold_min_text, 'Fontweight', 'bold')
                
                set(ui_threshold_min_edit, 'String', -1)
                set(ui_threshold_min_edit, 'Position', [.31 .9 .3 .08])
                set(ui_threshold_min_edit, 'Callback', {@cb_measurement_min})
                
                set(ui_threshold_max_text, 'String', 'Max')
                set(ui_threshold_max_text, 'Position', [.01 .7 .3 .08])
                set(ui_threshold_max_text, 'Fontweight', 'bold')
                
                set(ui_threshold_max_edit, 'String', 1)
                set(ui_threshold_max_edit, 'Position', [.31 .7 .3 .08])
                set(ui_threshold_max_edit, 'Callback', {@cb_measurement_max})
                
            end
            function cb_measurement_threshold(~, ~)
                setappdata(uiparent, 'threshold', ...
                    str2double(get(ui_threshold_min_edit, 'String')) : ...
                    str2double(get(ui_threshold_edit, 'String')) : ...
                    str2double(get(ui_threshold_max_edit, 'String')))
            end
            function cb_measurement_min(src, ~)
                newdata = get(src, 'String');
                set(ui_threshold_min_edit, 'String', newdata);
            end
            function cb_measurement_max(src, ~)
                newdata = get(src, 'String');
                set(ui_threshold_max_edit, 'String', newdata);
            end
            handle.variables = {'threshold'};
            handle.step = ui_threshold_edit;
            handle.min = ui_threshold_min_edit;
            handle.max = ui_threshold_max_edit;
            setappdata(uiparent, 'threshold', ...
                str2double(get(ui_threshold_min_edit, 'String')) : ...
                str2double(get(ui_threshold_edit, 'String')) : ...
                str2double(get(ui_threshold_max_edit, 'String')))
        end
    end
end