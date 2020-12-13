classdef ComparisonCON_BUD < ComparisonCON_WU
    % ComparisonCON_BUD A comparison of connectivity data with BU graphs at fixed density
    % ComparisonCON_BUD is a subclass of Comparison.
    %
    % ComparisonCON_BUD store a comparison between two groups.
    % The data from the groups it compares have a density.
    % Connectivity data can be for example MRI or PET data.
    %
    % ComparisonCON_BUD constructor methods:
    %  ComparisonCON_BUD              - Constructor
    %
    % ComparisonCON_BUD get methods:
    %  getThreshold                 - returns the density
    %
    % ComparisonCON_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % ComparisonCON_BUD plot methods (Static):
    %  getComparisonSettingsPanel   - returns a UIPanel
    %
    % See also Comparison, AnalysisCON_BUD, MeasurementCON_BUD, RandomComparisonCON_BUD.
    
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function c =  ComparisonCON_BUD(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % ComparisonCON_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'density', DENSITY)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed DENSITY.
            %
            % ComparisonCON_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default DENSITY.
            %
            % See also MeasurementCON_BUD, RandomComparisonCON_BUD, AnalysisCON_BUD.
            
            c = c@ComparisonCON_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            density = get_from_varargin(0, 'density', varargin{:});
            c.setDensity(density)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity(c, density)
            % SETDENSITY sets the measure value of the group
            %
            % SETDENSITY(C, DENSITY) sets the measure value of
            % the group.
            %
            % See also getDensity.
            
            c.density = density;
        end
    end
    methods  % Get functions
        function density = getDensity(c)
            % GETDENSITY returns the density of the data values
            %
            % T = GETDENSITY(C) returns the density of the data values.
            %
            % See also getMeasureValue, setDensity.
            
            density = c.density;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of connectivity comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % comparison. In this case 'ComparisonCON_BUD'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonCON_BUD';
        end
        function name = getName()
            % GETNAME returns the name of connectivity comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonCON_BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Connectivity BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonCON_BUD.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'CON comparison with connectivity data using binary graphs ' ...
                'calculated at a fixed density. ' ...
                'For example, it can use DTI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisCON_BUD'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisCON_BUD';
        end
    end
    methods (Static)  % Plot MeasurementGUI Child Panel
        function handle = getComparisonSettingsPanel(analysis, uiparent, varargin)
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible,
            % Permutation and Density.
            %
            % See also ComparisonST_BUD.
            
            statistic_type = get_from_varargin('PermutationTest', 'StatisticsType', varargin{:});
            
            set(uiparent, 'Visible', 'on')
            ui_density_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_density_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_density_min_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_density_min_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_density_max_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_density_max_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            init_Statistic_Panel()
            function init_child_panel()
                set(ui_density_text, 'String', 'Density')
                set(ui_density_text, 'Position', [.01 .55 .47 .08])
                set(ui_density_text, 'Fontweight', 'bold')
                
                set(ui_density_edit, 'String', 1)
                set(ui_density_edit, 'Position', [.5 .57 .45 .08])
                set(ui_density_edit, 'Callback', {@cb_comparison_density})
                
                set(ui_density_min_text, 'String', 'Min')
                set(ui_density_min_text, 'Position', [.01 .45 .47 .08])
                set(ui_density_min_text, 'Fontweight', 'bold')
                
                set(ui_density_min_edit, 'String', 0)
                set(ui_density_min_edit, 'Position', [.5 .47 .45 .08])
                set(ui_density_min_edit, 'Callback', {@cb_comparison_min})
                
                set(ui_density_max_text, 'String', 'Max')
                set(ui_density_max_text, 'Position', [.01 .35 .47 .08])
                set(ui_density_max_text, 'Fontweight', 'bold')
                
                set(ui_density_max_edit, 'String', 100)
                set(ui_density_max_edit, 'Position', [.5 .37 .45 .08])
                set(ui_density_max_edit, 'Callback', {@cb_comparison_max})                
            end
            function init_Statistic_Panel()
                handle = Statistics.getStatisticPanel(statistic_type, analysis, uiparent, varargin);
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
                        
            handle.variables = {'density'};
            handle.step = ui_density_edit;
            handle.min = ui_density_min_edit;
            handle.max = ui_density_max_edit;
            setappdata(uiparent, 'density', ...
                str2double(get(ui_density_min_edit, 'String')) : ...
                str2double(get(ui_density_edit, 'String')) : ...
                str2double(get(ui_density_max_edit, 'String')))
        end
    end
end