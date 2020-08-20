classdef RandomComparisonST_BUT < RandomComparisonST_WU
    % RandomComparisonST_BUT A random comparison of structural data with BU graphs at fixed threshold
    % RandomComparisonST_BUT is a subclass of RandomComparisonST_WU.
    %
    % RandomComparisonST_BUT store a comparison between a group and a randomly
    % generated group. The data from the groups it compares haves a
    % threshold. Structural data can be for example MRI or PET data.
    %
    % RandomComparisonST_BUT constructor methods:
    %  RandomComparisonST_BUT       - Constructor
    %
    % RandomComparisonST_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % RandomComparisonST_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisST_BUT, MeasurementST_BUT, ComparisonST_BUT.
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonST_BUT(id, label, notes, atlas, measure_code, group, varargin)
            % RandomComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'threshold', THRESHOLD)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed THRESHOLD.
            %
            % RandomComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default THRESHOLD.
            %
            % See also MeasurementST_BUT, ComparisonST_BUT, AnalysisST_BUT.
            
            rc = rc@RandomComparisonST_WU(id, label, notes, atlas, measure_code, group, varargin{:});
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
            % GETCLASS returns the class of structural random comparison BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonST_BUT'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonST_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural random comparison BUT
            %
            % NAME = GETNAME() returns the name, RandomComparison ST BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison ST BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural random comparison BUT
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonST_BUT.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'ST random comparison with structural data using binary ' ...
                'graphs calculated at a fixed threshold. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisST_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUT';
        end
    end
    methods (Static)  % Plot ComparisonGUI Child Panel
        function handle = getChildPanel(analysis, uiparent) %#ok<INUSL>
            set(uiparent, 'Visible', 'on')
            
            ui_threshold_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_threshold_min_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_min_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_threshold_max_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_max_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_verbose_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_verbose_popup = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'popup');
            ui_interruptible_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_interruptible_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_randomization_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_randomization_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_attempts_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_attempts_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_weights_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_weights_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            function init_child_panel()
                set(ui_threshold_text, 'String', 'Threshold')
                set(ui_threshold_text, 'Position', [.01 .8 .2 .08])
                set(ui_threshold_text, 'Fontweight', 'bold')
                
                set(ui_threshold_edit, 'String', 0.1)
                set(ui_threshold_edit, 'Position', [.21 .8 .2 .08])
                set(ui_threshold_edit, 'Callback', {@cb_randomcomparison_threshold})
                
                set(ui_threshold_min_text, 'String', 'Min')
                set(ui_threshold_min_text, 'Position', [.01 .9 .2 .08])
                set(ui_threshold_min_text, 'Fontweight', 'bold')
                
                set(ui_threshold_min_edit, 'String', -1)
                set(ui_threshold_min_edit, 'Position', [.21 .9 .2 .08])
                set(ui_threshold_min_edit, 'Callback', {@cb_randomcomparison_min})
                
                set(ui_threshold_max_text, 'String', 'Max')
                set(ui_threshold_max_text, 'Position', [.01 .7 .2 .08])
                set(ui_threshold_max_text, 'Fontweight', 'bold')
                
                set(ui_threshold_max_edit, 'String', 1)
                set(ui_threshold_max_edit, 'Position', [.21 .7 .2 .08])
                set(ui_threshold_max_edit, 'Callback', {@cb_randomcomparison_max})
                
                set(ui_verbose_text, 'String', 'Verbose')
                set(ui_verbose_text, 'Position', [.41 .76 .25 .08])
                set(ui_verbose_text, 'Fontweight', 'bold')
                
                set(ui_verbose_popup, 'String', {'false' 'true'})
                set(ui_verbose_popup, 'Position', [.71 .76 .25 .08])
                set(ui_verbose_popup, 'Callback', {@cb_randomcomparison_verbose})
                
                set(ui_interruptible_text, 'String', 'Interruptible')
                set(ui_interruptible_text, 'Position', [.41 .9 .25 .08])
                set(ui_interruptible_text, 'Fontweight', 'bold')
                
                set(ui_interruptible_edit, 'String', 0.001)
                set(ui_interruptible_edit, 'Position', [.71 .9 .25 .08])
                set(ui_interruptible_edit, 'Callback', {@cb_randomcomparison_interruptible})
                
                set(ui_randomization_text, 'String', 'Randomization Number')
                set(ui_randomization_text, 'Position', [.41 .56 .25 .14])
                set(ui_randomization_text, 'Fontweight', 'bold')
                
                set(ui_randomization_edit, 'String', 1000)
                set(ui_randomization_edit, 'Position', [.71 .6 .25 .08])
                set(ui_randomization_edit, 'Callback', {@cb_randomcomparison_permutation})
                
                set(ui_attempts_text, 'String', 'Attempts per Edge')
                set(ui_attempts_text, 'Position', [.41 .4 .25 .14])
                set(ui_attempts_text, 'Fontweight', 'bold')
                
                set(ui_attempts_edit, 'String', 5)
                set(ui_attempts_edit, 'Position', [.71 .45 .25 .08])
                set(ui_attempts_edit, 'Callback', {@cb_randomcomparison_attempts})
                
                set(ui_weights_text, 'String', 'Number of Weights')
                set(ui_weights_text, 'Position', [.41 .26 .25 .14])
                set(ui_weights_text, 'Fontweight', 'bold')
                
                set(ui_weights_edit, 'String', 1)
                set(ui_weights_edit, 'Position', [.71 .3 .25 .08])
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
            function cb_randomcomparison_verbose(~, ~)
                setappdata(uiparent, 'verbose', get(ui_verbose_popup, 'Value')-1)
            end
            function cb_randomcomparison_interruptible(~, ~)
                setappdata(uiparent, 'interruptible', str2double(get(ui_interruptible_edit, 'String')))
            end
            function cb_randomcomparison_permutation(~, ~)
                setappdata(uiparent, 'permutation', str2double(get(ui_randomization_edit, 'String')))
            end
            function cb_randomcomparison_attempts(~, ~)
                setappdata(uiparent, 'attempts', str2double(get(ui_attempts_edit, 'String')))
            end
            function cb_randomcomparison_weights(~, ~)
                setappdata(uiparent, 'weights', str2double(get(ui_weights_edit, 'String')))
            end
            handle.variables = [];
            handle.step = ui_threshold_edit;
            handle.min = ui_threshold_min_edit;
            handle.max = ui_threshold_max_edit;
            handle.verbose = ui_verbose_popup;
            handle.interruptible = ui_interruptible_edit;
            handle.randomization = ui_randomization_edit;
            setappdata(uiparent, 'threshold', ...
                str2double(get(ui_threshold_min_edit, 'String')) : ...
                str2double(get(ui_threshold_edit, 'String')) : ...
                str2double(get(ui_threshold_max_edit, 'String')))
            setappdata(uiparent, 'verbose', get(ui_verbose_popup, 'Value')-1)
            setappdata(uiparent, 'interruptible', str2double(get(ui_interruptible_edit, 'String')))
            setappdata(uiparent, 'randomization', str2double(get(ui_randomization_edit, 'String')))
            setappdata(uiparent, 'attempts', str2double(get(ui_attempts_edit, 'String')))
            setappdata(uiparent, 'weights', str2double(get(ui_weights_edit, 'String')))
        end
    end
end