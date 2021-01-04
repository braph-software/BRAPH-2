classdef ComparisonST_BUD < ComparisonST_WU
    % ComparisonST_BUD A comparison of structural data with BU graphs at fixed density
    % ComparisonST_BUD is a subclass of Comparison.
    %
    % ComparisonST_BUD stores a comparison between two groups.
    % The data from the groups it compares have a density.
    % Structural data can be for example MRI or PET data.
    %
    % ComparisonST_BUD constructor methods:
    %  ComparisonST_BUD              - Constructor
    %
    % ComparisonST_BUD get methods:
    %  getDensity                   - returns the density
    %
    % ComparisonST_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % ComparisonST_BUD plot methods (Static):
    %  getComparisonSettingsPanel   - returns a UIPanel
    % 
    % See also Comparison, AnalysisST_BUD, MeasurementST_BUD, RandomComparisonST_BUD.
    
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function c =  ComparisonST_BUD(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % COMPARISONST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'density', DENSITY)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed DENSITY.
            %
            % COMPARISONST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default DENSITY.
            %
            % See also MeasurementST_BUD, RandomComparisonST_BUD, AnalysisST_BUD.
            
            c = c@ComparisonST_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            density = get_from_varargin(0, 'density', varargin{:});
            c.setDensity(density)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity(c, density)
            % SETDENSITY sets the fixed density of the values
            %
            % SETDENSITY(C, DENSITY) sets the fixed density of the values.
            %
            % See also getDensity.
            
            c.density = density;
        end
    end
    methods  % Get functions
        function density = getDensity(c)
            % GETDENSITY returns the fixed density of the data values
            %
            % DENSITY = GETDENSITY(C) returns the fixed density of the
            % data values.
            %
            % See also getMeasureValue, setDensity.
            
            density = c.density;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % comparison. In this case 'ComparisonST_BUD'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonST_BUD';
        end
        function name = getName()
            % GETNAME returns the name of structural comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonST_BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Structural BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonST_BUD.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'ST comparison with structural data using binary graphs ' ...
                'calculated at a fixed density. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisST_BUD'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUD';
        end
    end
    methods (Static)  % Plot MeasurementGUI Child Panel
        function handle = getComparisonSettingsPanel(analysis, uiparent, varargin) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible,
            % Permutation and Density.
            %
            % See also ComparisonST_BUD.
            
            set(uiparent, 'Visible', 'on')
            ui_density_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_density_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_density_min_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_density_min_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_density_max_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_density_max_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_permutation_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_permutation_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            function init_child_panel()
                set(ui_density_text, 'String', 'Density')
                set(ui_density_text, 'Position', [.01 .65 .47 .08])
                set(ui_density_text, 'Fontweight', 'bold')
                
                set(ui_density_edit, 'String', 1)
                set(ui_density_edit, 'Position', [.5 .67 .45 .08])
                set(ui_density_edit, 'Callback', {@cb_comparison_density})
                
                set(ui_density_min_text, 'String', 'Min')
                set(ui_density_min_text, 'Position', [.01 .75 .47 .08])
                set(ui_density_min_text, 'Fontweight', 'bold')
                
                set(ui_density_min_edit, 'String', 0)
                set(ui_density_min_edit, 'Position', [.5 .77 .45 .08])
                set(ui_density_min_edit, 'Callback', {@cb_comparison_min})
                
                set(ui_density_max_text, 'String', 'Max')
                set(ui_density_max_text, 'Position', [.01 .55 .47 .08])
                set(ui_density_max_text, 'Fontweight', 'bold')
                
                set(ui_density_max_edit, 'String', 100)
                set(ui_density_max_edit, 'Position', [.5 .57 .45 .08])
                set(ui_density_max_edit, 'Callback', {@cb_comparison_max})
                
                set(ui_permutation_text, 'String', 'Perumtation Number')
                set(ui_permutation_text, 'Position', [.01 .85 .47 .08])
                set(ui_permutation_text, 'Fontweight', 'bold')
                
                set(ui_permutation_edit, 'String', 1000)
                set(ui_permutation_edit, 'Position', [.5 .87 .45 .08])
                set(ui_permutation_edit, 'Callback', {@cb_comparison_permutation})
                
            end
            function cb_comparison_density(~,~)
                setappdata(uiparent, 'density', ...
                    str2double(get(ui_density_min_edit, 'String')) : ...
                    str2double(get(ui_density_edit, 'String')) : ...
                    str2double(get(ui_density_max_edit, 'String')))
            end
            function cb_comparison_min(src, ~)
                newdata = get(src, 'String');
                set(ui_density_min_edit, 'String', newdata);
            end
            function cb_comparison_max(src, ~)
                newdata = get(src, 'String');
                set(ui_density_max_edit, 'String', newdata);
            end
            function cb_comparison_permutation(~, ~)
                setappdata(uiparent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
            end
            
            handle.variables = {'density'};
            handle.step = ui_density_edit;
            handle.min = ui_density_min_edit;
            handle.max = ui_density_max_edit; 
            handle.permutation = ui_permutation_edit;
            setappdata(uiparent, 'density', ...
                str2double(get(ui_density_min_edit, 'String')) : ...
                str2double(get(ui_density_edit, 'String')) : ...
                str2double(get(ui_density_max_edit, 'String')))
            setappdata(uiparent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
        end
    end
end