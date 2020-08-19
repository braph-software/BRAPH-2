classdef ComparisonST_BUT < ComparisonST_WU
    % ComparisonST_BUT A comparison of structural data with BU graphs at fixed threshold
    % ComparisonST_BUT is a subclass of Comparison.
    %
    % ComparisonST_BUT store a comparison between two groups.
    % The data from the groups it compares have a threshold.
    % Structural data can be for example MRI or PET data.
    %
    % ComparisonST_BUT constructor methods:
    %  ComparisonST_BUT             - Constructor
    %
    % ComparisonST_BUT get methods:
    %  getThreshold                 - returns the threshold
    %
    % ComparisonST_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisST_BUT, MeasurementST_BUT, RandomComparisonST_BUT.
    
    properties (Access = protected)
        threshold  % threshold of the values
    end
    methods  % Constructor
        function c =  ComparisonST_BUT(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % ComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'threshold', THRESHOLD)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed THRESHOLD.
            %
            % ComparisonST_BUT(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default THRESHOLD.
            %
            % See also MeasurementST_BUT, RandomComparisonST_BUT, AnalysisST_BUT.
            
            c = c@ComparisonST_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            c.setThreshold(threshold)
        end
    end
    methods (Access = protected) % Set functions
        function setThreshold(c, threshold)
            % SETTHRESHOLD sets the measure value of the group
            %
            % SETTHRESHOLD(C, THRESHOLD) sets the measure value of
            % the group.
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
            % GETCLASS returns the class of structural comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % comparison. In this case 'ComparisonST_BUT'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonST_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonST_BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Structural BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonST_BUT.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'ST comparison with structural data using binary graphs ' ...
                'calculated at a fixed threshold. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisST_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUT';
        end
    end
    methods (Static)  % Plot MeasurementGUI Child Panel
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
            ui_permutation_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_permutation_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            function init_child_panel()
                set(ui_threshold_text, 'String', 'Threshold')
                set(ui_threshold_text, 'Position', [.01 .8 .2 .08])
                set(ui_threshold_text, 'Fontweight', 'bold')
                
                set(ui_threshold_edit, 'String', 0.1)
                set(ui_threshold_edit, 'Position', [.21 .8 .2 .08])
                set(ui_threshold_edit, 'Callback', {@cb_comparison_threshold})
                
                set(ui_threshold_min_text, 'String', 'Min')
                set(ui_threshold_min_text, 'Position', [.01 .9 .2 .08])
                set(ui_threshold_min_text, 'Fontweight', 'bold')
                
                set(ui_threshold_min_edit, 'String', -1)
                set(ui_threshold_min_edit, 'Position', [.21 .9 .2 .08])
                set(ui_threshold_min_edit, 'Callback', {@cb_comparison_min})
                
                set(ui_threshold_max_text, 'String', 'Max')
                set(ui_threshold_max_text, 'Position', [.01 .7 .2 .08])
                set(ui_threshold_max_text, 'Fontweight', 'bold')
                
                set(ui_threshold_max_edit, 'String', 1)
                set(ui_threshold_max_edit, 'Position', [.21 .7 .2 .08])
                set(ui_threshold_max_edit, 'Callback', {@cb_comparison_max})
                
                set(ui_verbose_text, 'String', 'Verbose')
                set(ui_verbose_text, 'Position', [.41 .8 .3 .08])
                set(ui_verbose_text, 'Fontweight', 'bold')
                
                set(ui_verbose_popup, 'String', {'false' 'true'})
                set(ui_verbose_popup, 'Position', [.71 .8 .2 .08])
                set(ui_verbose_popup, 'Callback', {@cb_comparison_verbose})
                
                set(ui_interruptible_text, 'String', 'Interruptible')
                set(ui_interruptible_text, 'Position', [.41 .9 .3 .08])
                set(ui_interruptible_text, 'Fontweight', 'bold')
                
                set(ui_interruptible_edit, 'String', 0.001)
                set(ui_interruptible_edit, 'Position', [.71 .9 .2 .08])
                set(ui_interruptible_edit, 'Callback', {@cb_comparison_interruptible})
                
                set(ui_permutation_text, 'String', 'Perumtation Number')
                set(ui_permutation_text, 'Position', [.41 .65 .3 .14])
                set(ui_permutation_text, 'Fontweight', 'bold')
                
                set(ui_permutation_edit, 'String', 1000)
                set(ui_permutation_edit, 'Position', [.71 .7 .2 .08])
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
            function cb_comparison_verbose(~, ~)
                setappdata(uiparent, 'verbose', get(ui_verbose_popup, 'String'))
            end
            function cb_comparison_interruptible(~, ~)
                setappdata(uiparent, 'interruptible', str2double(get(ui_interruptible_edit, 'String')))
            end
            function cb_comparison_permutation(~, ~)
                setappdata(uiparent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
            end
            
            handle.variables = {'threshold'};
            handle.step = ui_threshold_edit;
            handle.min = ui_threshold_min_edit;
            handle.max = ui_threshold_max_edit;
            setappdata(uiparent, 'threshold', ...
                str2double(get(ui_threshold_min_edit, 'String')) : ...
                str2double(get(ui_threshold_edit, 'String')) : ...
                str2double(get(ui_threshold_max_edit, 'String')))
            setappdata(uiparent, 'verbose', get(ui_verbose_popup, 'String'))
            setappdata(uiparent, 'interruptible', str2double(get(ui_interruptible_edit, 'String')))
            setappdata(uiparent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
        end
    end
end