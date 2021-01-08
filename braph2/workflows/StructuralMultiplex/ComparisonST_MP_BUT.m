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
    %  getThreshold                 - returns the threshold 
    %
    % ComparisonST_MP_BUT set methods:
    %  setThreshold                 - sets the threshold 
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
        threshold  % threshold of the values 
    end
    methods  % Constructor
        function c =  ComparisonST_MP_BUT(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % COMPARISONST_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'threshold', THRESHOLD)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed THRESHOLD.
            %
            % COMPARISONST_MP_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default threshold.
            %
            % See also MeasurementST_MP_BUT, RandomComparisonST_MP_BUT, AnalysisST_MP_BUT.
            
            c = c@ComparisonST_MP_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            c.setThreshold(threshold)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold(c, threshold)
            % SETTHRESHOLD sets the threshold of the values 
            %
            % SETTHRESHOLD(C, THRESHOLD) sets the threshold of the values.
            %
            % See also getThreshold.
            
            c.threshold = threshold;
        end
    end
    methods  % Get functions
        function threshold = getThreshold(c)
            % GETTHRESHOLD returns the threshold of the data values
            %
            % T = GETTHRESHOLD(C) returns the threshold of the data values.
            %
            % See also getMeasureValue, setThreshold.
            
            threshold = c.threshold;
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
                                 
            set(uiparent, 'Visible', 'on')
            ui_threshold_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_threshold_min_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_min_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_threshold_max_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_threshold_max_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_permutation_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_permutation_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            function init_child_panel()
                set(ui_threshold_text, 'String', 'Threshold')
                set(ui_threshold_text, 'Position', [.01 .65 .47 .08])
                set(ui_threshold_text, 'Fontweight', 'bold')
                
                set(ui_threshold_edit, 'String', 0.1)
                set(ui_threshold_edit, 'Position', [.5 .67 .45 .08])
                set(ui_threshold_edit, 'Callback', {@cb_comparison_threshold})
                
                set(ui_threshold_min_text, 'String', 'Min')
                set(ui_threshold_min_text, 'Position', [.01 .75 .47 .08])
                set(ui_threshold_min_text, 'Fontweight', 'bold')
                
                set(ui_threshold_min_edit, 'String', -1)
                set(ui_threshold_min_edit, 'Position', [.5 .77 .45 .08])
                set(ui_threshold_min_edit, 'Callback', {@cb_comparison_min})
                
                set(ui_threshold_max_text, 'String', 'Max')
                set(ui_threshold_max_text, 'Position', [.01 .55 .47 .08])
                set(ui_threshold_max_text, 'Fontweight', 'bold')
                
                set(ui_threshold_max_edit, 'String', 1)
                set(ui_threshold_max_edit, 'Position', [.5 .57 .45 .08])
                set(ui_threshold_max_edit, 'Callback', {@cb_comparison_max})
                
                set(ui_permutation_text, 'String', 'Perumtation Number')
                set(ui_permutation_text, 'Position', [.01 .85 .47 .08])
                set(ui_permutation_text, 'Fontweight', 'bold')
                
                set(ui_permutation_edit, 'String', 1000)
                set(ui_permutation_edit, 'Position', [.5 .87 .45 .08])
                set(ui_permutation_edit, 'Callback', {@cb_comparison_permutation})
                
            end
            function cb_comparison_threshold(~,~)
                setappdata(uiparent, 'threshold', ...
                    str2double(get(ui_threshold_min_edit, 'String')) : ...
                    str2double(get(ui_threshold_edit, 'String')) : ...
                    str2double(get(ui_threshold_max_edit, 'String')))
            end
            function cb_comparison_min(src, ~)
                newdata = get(src, 'String');
                set(ui_threshold_min_edit, 'String', newdata);
            end
            function cb_comparison_max(src, ~)
                newdata = get(src, 'String');
                set(ui_threshold_max_edit, 'String', newdata);
            end
            function cb_comparison_permutation(~, ~)
                setappdata(uiparent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
            end
            
            handle.variables = {'threshold'};
            handle.step = ui_threshold_edit;
            handle.min = ui_threshold_min_edit;
            handle.max = ui_threshold_max_edit;
            handle.permutation = ui_permutation_edit;
            setappdata(uiparent, 'threshold', ...
                str2double(get(ui_threshold_min_edit, 'String')) : ...
                str2double(get(ui_threshold_edit, 'String')) : ...
                str2double(get(ui_threshold_max_edit, 'String')))
            setappdata(uiparent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
        end
    end
end