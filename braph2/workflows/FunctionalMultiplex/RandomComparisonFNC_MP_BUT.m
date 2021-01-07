classdef RandomComparisonFNC_MP_BUT < RandomComparisonFNC_MP_WU
    % RandomComparisonFNC_MP_BUT A random comparison of functional data with BU graphs at fixed threshold
    % RandomComparisonFNC_MP_BUT is a subclass of RandomComparisonFNC_MP_WU.
    %
    % RandomComparisonFNC_MP_BUT store a comparison between a group and a randomly
    % generated group. The data from the groups it compares haves a
    % threshold. Functional data can be for example fMRI data.
    %
    % RandomComparisonFNC_MP_BUT constructor methods:
    %  RandomComparisonFNC_MP_BUT       - Constructor
    %
    % RandomComparisonFNC_MP_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % RandomComparisonFNC_MP_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % RandomComparisonFNC_MP_BUT plot methods (Static):
    %  getRandomComparisonSettingsPanel - returns a UIPanel
    %
    % See also Comparison, AnalysisFNC_BUT, MeasurementFNC_BUT, ComparisonFNC_BUT.
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonFNC_MP_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % RandomComparisonFNC_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold', THRESHOLD)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed THRESHOLD.
            %
            % RandomComparisonFNC_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default THRESHOLD.
            %
            % See also MeasurementFNC_BUT, ComparisonFNC_BUT, AnalysisFNC_BUT.
            
            rc = rc@RandomComparisonFNC_MP_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            rc.setThreshold(threshold)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold(rc, threshold)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(RC, THRESHOLD) sets the measure value of
            % the group.
            %
            % See also getThreshold.
            
            rc.threshold = threshold;
        end
    end
    methods  % Get functions
        function threshold = getThreshold(rc)
            % GETTHRESHOLD returns the threshold of the data values
            %
            % THRESHOLD = GETTHRESHOLD(RC) returns the threshold of the data values.
            %
            % See also getMeasureValue, setThreshold.
            
            threshold = rc.threshold;
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_class = getClass() %#ok<*INUSD>
            % GETCLASS returns the class of functional random comparison BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonFNC_MP_BUT'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonFNC_MP_BUT';
        end
        function name = getName()
            % GETNAME returns the name of functional random comparison BUT
            %
            % NAME = GETNAME() returns the name, RandomComparison FNC BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison FNC MP BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional random comparison BUT
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonFNC_MP_BUT.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'FNC MP random comparison with functional data using binary ' ...
                'graphs calculated at a fixed threshold. ' ...
                'For example, it can use fMRI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisFNC_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisFNC_MP_BUT';
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
            
            set(uiparent, 'Visible', 'on')
            
            ui_threshold_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_threshold_min_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_min_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_threshold_max_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_max_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_randomization_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_randomization_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_attempts_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_attempts_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_weights_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_weights_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            function init_child_panel()
                set(ui_threshold_text, 'String', 'Threshold')
                set(ui_threshold_text, 'Position', [.01 .46 .47 .08])
                set(ui_threshold_text, 'Fontweight', 'bold')
                
                set(ui_threshold_edit, 'String', 0.1)
                set(ui_threshold_edit, 'Position', [.5 .47 .45 .08])
                set(ui_threshold_edit, 'Callback', {@cb_randomcomparison_threshold})
                
                set(ui_threshold_min_text, 'String', 'Min')
                set(ui_threshold_min_text, 'Position', [.01 .56 .47 .08])
                set(ui_threshold_min_text, 'Fontweight', 'bold')
                
                set(ui_threshold_min_edit, 'String', -1)
                set(ui_threshold_min_edit, 'Position', [.5 .57 .45 .08])
                set(ui_threshold_min_edit, 'Callback', {@cb_randomcomparison_min})
                
                set(ui_threshold_max_text, 'String', 'Max')
                set(ui_threshold_max_text, 'Position', [.01 .36 .47 .08])
                set(ui_threshold_max_text, 'Fontweight', 'bold')
                
                set(ui_threshold_max_edit, 'String', 1)
                set(ui_threshold_max_edit, 'Position', [.5 .37 .45 .08])
                set(ui_threshold_max_edit, 'Callback', {@cb_randomcomparison_max})
                
                set(ui_randomization_text, 'String', 'Randomization Number')
                set(ui_randomization_text, 'Position', [.01 .86 .47 .08])
                set(ui_randomization_text, 'Fontweight', 'bold')
                
                set(ui_randomization_edit, 'String', 1000)
                set(ui_randomization_edit, 'Position', [.5 .87 .45 .08])
                set(ui_randomization_edit, 'Callback', {@cb_randomcomparison_randomization})
                
                set(ui_attempts_text, 'String', 'Attempts per Edge')
                set(ui_attempts_text, 'Position', [.01 .76 .47 .08])
                set(ui_attempts_text, 'Fontweight', 'bold')
                
                set(ui_attempts_edit, 'String', 5)
                set(ui_attempts_edit, 'Position', [.5 .77 .45 .08])
                set(ui_attempts_edit, 'Callback', {@cb_randomcomparison_attempts})
                
                set(ui_weights_text, 'String', 'Number of Weights')
                set(ui_weights_text, 'Position', [.01 .66 .47 .08])
                set(ui_weights_text, 'Fontweight', 'bold')
                
                set(ui_weights_edit, 'String', 1)
                set(ui_weights_edit, 'Position', [.5 .67 .45 .08])
                set(ui_weights_edit, 'Callback', {@cb_randomcomparison_weights})
            end
            function cb_randomcomparison_threshold(~,~)
                setappdata(uiparent, 'threshold', ...
                    str2double(get(ui_threshold_min_edit, 'String')) : ...
                    str2double(get(ui_threshold_edit, 'String')) : ...
                    str2double(get(ui_threshold_max_edit, 'String')))
            end
            function cb_randomcomparison_min(src, ~)
                newdata = get(src, 'String');
                set(ui_threshold_min_edit, 'String', newdata);
            end
            function cb_randomcomparison_max(src, ~)
                newdata = get(src, 'String');
                set(ui_threshold_max_edit, 'String', newdata);
            end
            function cb_randomcomparison_randomization(~, ~)
                setappdata(uiparent, 'randomization', str2double(get(ui_randomization_edit, 'String')))
            end
            function cb_randomcomparison_attempts(~, ~)
                setappdata(uiparent, 'attempts', str2double(get(ui_attempts_edit, 'String')))
            end
            function cb_randomcomparison_weights(~, ~)
                setappdata(uiparent, 'numberweigths', str2double(get(ui_weights_edit, 'String')))
            end
            handle.variables = {'threshold'};
            handle.step = ui_threshold_edit;
            handle.min = ui_threshold_min_edit;
            handle.max = ui_threshold_max_edit;
            handle.randomization = ui_randomization_edit;
            setappdata(uiparent, 'threshold', ...
                str2double(get(ui_threshold_min_edit, 'String')) : ...
                str2double(get(ui_threshold_edit, 'String')) : ...
                str2double(get(ui_threshold_max_edit, 'String')))
            setappdata(uiparent, 'randomization', str2double(get(ui_randomization_edit, 'String')))
            setappdata(uiparent, 'attempts', str2double(get(ui_attempts_edit, 'String')))
            setappdata(uiparent, 'numberweigths', str2double(get(ui_weights_edit, 'String')))
        end
    end
end