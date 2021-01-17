classdef RandomComparisonST_BUD < RandomComparisonST_WU
    % RandomComparisonST_BUD A random comparison of structural data with BU graphs at fixed density
    % RandomComparisonST_BUD is a subclass of RandomComparisonST_WU.
    %
    % RandomComparisonST_BUD stores a comparison between a group and a randomly
    % generated group. The data from the groups it compares have a
    % density. Structural data can be for example MRI or PET data.
    %
    % RandomComparisonST_BUD constructor methods:
    %  RandomComparisonST_BUD       - Constructor
    %
    % RandomComparisonST_BUD get methods:
    %  getDensity                   - returns the density
    %
    % RandomComparisonST_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % RandomComparisonST_BUD plot methods (Static):
    %  getRandomComparisonSettingsPanel - returns a UIPanel
    %
    % See also RandomComparison, AnalysisST_BUD, MeasurementST_BUD, ComparisonST_BUD.
    
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonST_BUD(id, label, notes, atlas, measure_code, group, varargin)
            % RANDOMCOMPARISONST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'density', DENSITY)
            % creates a random comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed DENSITY.
            %
            % RANDOMCOMPARISONST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a random comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default DENSITY.
            %
            % See also MeasurementST_BUD, ComparisonST_BUD, AnalysisST_BUD.
            
            rc = rc@RandomComparisonST_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            density = get_from_varargin(0, 'density', varargin{:});
            rc.setDensity(density)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity(rc, density)
            % SETDENSITY sets the measure fixed density of values
            %
            % SETDENSITY(RC, DENSITY) sets the measure fixed density of
            % values.
            %
            % See also getDensity.
            
            rc.density = density;
        end
    end
    methods  % Get functions
        function density = getDensity(rc)
            % GETDENSITY returns the fixed density of the data values
            %
            % DENSITY = GETDENSITY(RC) returns the fixed density of the
            % data values.
            %
            % See also getMeasureValue, setDensity.
            
            density = rc.density;
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_class = getClass() %#ok<*INUSD>
            % GETCLASS returns the class of structural random comparison BUD
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonST_BUD'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonST_BUD';
        end
        function name = getName()
            % GETNAME returns the name of structural random comparison BUD
            %
            % NAME = GETNAME() returns the name, RandomComparison ST BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison ST BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural random comparison BUD
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonST_BUD.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'ST random comparison with structural data using binary ' ...
                'graphs calculated at a fixed density. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisST_BUD'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUD';
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
            
            set(uiparent, 'Visible', 'on')
            
            ui_density_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_density_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_density_min_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_density_min_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_density_max_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_density_max_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_randomization_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_randomization_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_attempts_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_attempts_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_weights_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_weights_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            function init_child_panel()
                set(ui_density_text, 'String', 'Density')
                set(ui_density_text, 'Position', [.01 .46 .47 .08])
                set(ui_density_text, 'Fontweight', 'bold')
                
                set(ui_density_edit, 'String', 1)
                set(ui_density_edit, 'Position', [.5 .47 .45 .08])
                set(ui_density_edit, 'Callback', {@cb_randomcomparison_density})
                
                set(ui_density_min_text, 'String', 'Min')
                set(ui_density_min_text, 'Position', [.01 .56 .47 .08])
                set(ui_density_min_text, 'Fontweight', 'bold')
                
                set(ui_density_min_edit, 'String', 0)
                set(ui_density_min_edit, 'Position', [.5 .57 .45 .08])
                set(ui_density_min_edit, 'Callback', {@cb_randomcomparison_min})
                
                set(ui_density_max_text, 'String', 'Max')
                set(ui_density_max_text, 'Position', [.01 .36 .47 .08])
                set(ui_density_max_text, 'Fontweight', 'bold')
                
                set(ui_density_max_edit, 'String', 100)
                set(ui_density_max_edit, 'Position', [.5 .37 .45 .08])
                set(ui_density_max_edit, 'Callback', {@cb_randomcomparison_max})
                                
                set(ui_randomization_text, 'String', 'Randomization Number')
                set(ui_randomization_text, 'Position', [.01 .86 .47 .08])
                set(ui_randomization_text, 'Fontweight', 'bold')
                
                set(ui_randomization_edit, 'String', 1000)
                set(ui_randomization_edit, 'Position', [.5 .87 .45 .08])
                set(ui_randomization_edit, 'Callback', {@cb_randomcomparison_permutation})
                
                set(ui_attempts_text, 'String', 'Attempts per Edge')
                set(ui_attempts_text, 'Position',  [.01 .76 .47 .08])
                set(ui_attempts_text, 'Fontweight', 'bold')
                
                set(ui_attempts_edit, 'String', 5)
                set(ui_attempts_edit, 'Position', [.5 .77 .45 .08])
                set(ui_attempts_edit, 'Callback', {@cb_randomcomparison_attempts})
                
                set(ui_weights_text, 'String', 'Number of Weights')
                set(ui_weights_text, 'Position',  [.01 .66 .47 .08])
                set(ui_weights_text, 'Fontweight', 'bold')
                
                set(ui_weights_edit, 'String', 1)
                set(ui_weights_edit, 'Position', [.5 .67 .45 .08])
                set(ui_weights_edit, 'Callback', {@cb_randomcomparison_weights})
            end
            function cb_randomcomparison_density(~,~)
                setappdata(uiparent, 'density', ...
                    str2double(get(ui_density_min_edit, 'String')) : ...
                    str2double(get(ui_density_edit, 'String')) : ...
                    str2double(get(ui_density_max_edit, 'String')))
            end
            function cb_randomcomparison_min(src, ~)
                newdata = get(src, 'String');
                set(ui_density_min_edit, 'String', newdata);
            end
            function cb_randomcomparison_max(src, ~)
                newdata = get(src, 'String');
                set(ui_density_max_edit, 'String', newdata);
            end
            function cb_randomcomparison_permutation(~, ~)
                setappdata(uiparent, 'randomization', str2double(get(ui_randomization_edit, 'String')))
            end
            function cb_randomcomparison_attempts(~, ~)
                setappdata(uiparent, 'attempts', str2double(get(ui_attempts_edit, 'String')))
            end
            function cb_randomcomparison_weights(~, ~)
                setappdata(uiparent, 'numberweigths', str2double(get(ui_weights_edit, 'String')))
            end
            handle.variables = {'density'};
            handle.step = ui_density_edit;
            handle.min = ui_density_min_edit;
            handle.max = ui_density_max_edit;
            handle.randomization = ui_randomization_edit;
            setappdata(uiparent, 'density', ...
                str2double(get(ui_density_min_edit, 'String')) : ...
                str2double(get(ui_density_edit, 'String')) : ...
                str2double(get(ui_density_max_edit, 'String')))
            setappdata(uiparent, 'randomization', str2double(get(ui_randomization_edit, 'String')))
            setappdata(uiparent, 'attempts', str2double(get(ui_attempts_edit, 'String')))
            setappdata(uiparent, 'numberweigths', str2double(get(ui_weights_edit, 'String')))
        end
    end
end