classdef AnalysisST_BUD < AnalysisST_WU
    % AnalysisST_BUD An analysis of structural data of fixed density binary undirected graphs
    % AnalysisST_BUD is a subclass of AnalysisST_WU and inherits the methods
    % needed for structural analysis.
    %
    % AnalysisST_BUD inhertis AnalysisST_WU calculating methods
    % to obtain a structural data of fixed density binary undirected graphs
    % measurement, a random comprison or a comparison. AnalysisST_BUD
    % overrides the ID methods of its superclass.
    % Structural data can be for example MRI or PET data.
    %
    % AnalysisST_BUD constructor methods:
    %  AnalysisST_BUD               - Constructor
    %
    % AnalysisST_BUD graph methods (Access = protected)
    %  get_graph_for_subjects       - returns the graph of the correlated matrix
    %
    % AnalysisST_BUD calculation methods (Access = protected):
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisST_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the analysis
    %  getName                      - returns the name of the analysis
    %  getDescription               - returns the description of the analysis
    %  getMeasurementClass          - returns the class of the measurement
    %  getRandomComparisonClass     - returns the class of the random comparison
    %  getComparisonClass           - returns the class of the comparison
    %  getAvailbleSettings          - returns the available settings
    %
    % AnalysisST_BUD Plot UIPanels
    %  getGlobalMeasurePlot         - returns a global measurement plot
    %  getGlobalComparisonPlot      - returns a global comparison plot
    %  getGlobalRandomComparisonPlot - returns a global randomcomparison plot
    %  getNodalMeasurePlot         - returns a global measurement plot
    %  getNodalComparisonPlot      - returns a global comparison plot
    %  getNodalRandomComparisonPlot - returns a global randomcomparison plot
    %  getBiNodalMeasurePlot         - returns a global measurement plot
    %  getBiNodalComparisonPlot      - returns a global comparison plot
    %  getBiNodalRandomComparisonPlot - returns a global randomcomparison plot
    %
    % See also Analysis, MeasurementST_BUD, RandomComparisonST_BUD, ComparisonST_BUD
    
    methods
        function analysis = AnalysisST_BUD(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % ANALYSISST_BUD(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a structural analysis of fixed density with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It
            % initializes the ANALYSISST_WU with default settings.
            %
            % ANALYSISST_BUD(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a structural analysis of fixed density with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It
            % initializes the ANALYSISST_WU with specified settings VALUES.
            %
            % See also MeasurementST_BUD, RandomComparisonST_BUD, ComparisonST_BUD.
            
            analysis = analysis@AnalysisST_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods  % ID functions
        function measurement_id = getMeasurementID(analysis, measure_code, group, varargin)
            % GETMEASUREMENTID returns a measurement ID
            %
            % MEASUREMENT_ID = GETMEASUREMENTID(ANALYSIS, MEASURE_CODE, GROUP, 'density', DENSITY)
            % creates a measurement ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and the DENSITY.
            %
            % See also getRandomComparisonID, getComparisonID.
            
            measurement_id = getMeasurementID@AnalysisST_WU(analysis, measure_code, group, varargin{:});
            
            density = get_from_varargin(0, 'density', varargin{:});
            measurement_id = [measurement_id ' density=' num2str(density)];
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
            % GETRANDOMCOMPARISONID returns a random comparison ID
            %
            % RANDOMCOMPARISON_ID = GETRANDOMCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP, 'density', DENSITY)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and the DENSITY.
            %
            % See also getMeasurementID, getComparisonID.
            
            randomcomparison_id = getRandomComparisonID@AnalysisST_WU(analysis, measure_code, group, varargin{:});
            
            density = get_from_varargin(0, 'density', varargin{:});
            randomcomparison_id = [randomcomparison_id ' density=' num2str(density)];
        end
        function comparison_id = getComparisonID(analysis, measure_code, group_1, group_2, varargin)
            % GETCOMPARISONID returns a comparison ID
            %
            % COMPARISON_ID = GETCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, 'density', DENSITY)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, GROUP_1 and GROUP_2, and the DENSITY.
            %
            % See also getMeasurementID, getRandomComparisonID.
            
            comparison_id = getComparisonID@AnalysisST_WU(analysis, measure_code, group_1, group_2, varargin{:});
            
            density = get_from_varargin(0, 'density', varargin{:});
            comparison_id = [comparison_id ' density=' num2str(density)];
        end
    end
    methods (Access = protected)  % graph methods
        function g = get_graph_for_subjects(analysis, subjects, varargin)
            % GET_GRAPH_FOR_SUBJECTS returns the graph created with the correlation matrix
            %
            % G = GET_GRAPH_FOR_SUBJECTS(ANALYSIS, SUBJECTS, PROPERY, VALUE, ...) creates a
            % graph with the correlation matrix made of the data of
            % subjects. It will binarize the matrix depending on the
            % PROPERTY and VALUE.
            %
            % See also calculate_measurement.
            
            A = analysis.get_weighted_correlation_matrix(subjects, varargin{:});
            
            density = get_from_varargin(0, 'density', varargin{:});
            A = binarize(A, 'density', density, varargin{:});
            
            graph_type = AnalysisST_WU.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of structural analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisST_BUD.
            %
            % See also getList, getName, getDescription.
            
            analysis_class = 'AnalysisST_BUD';
        end
        function name = getName()
            % GETNAME returns the name of structural analysis
            %
            % NAME = GETNAME() returns the name of the analysis.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Structural BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisST_BUD.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis based on structural data of fixed density using ' ...
                'weighted graphs e.g. cortical thickness for each brain region. ' ...
                'It provides a single graph for each subject group. ' ...
                'Structural data can be for example MRI or PET data.' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the compatible type of graph
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns the compatible type of
            % graph 'GraphBU'.
            %
            % See also getSubjectClass.
            
            graph_type = 'GraphBU';
        end
        function measurement_class = getMeasurementClass()
            % GETMEASUREMENTCLASS returns the class of structural analysis measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS() returns the
            % class of AnalysisST_BUD measurement, 'MeasurementST_BUD'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementST_BUD';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of structural analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisST_BUD randomcomparison,
            % 'RandomComparisonST_BUD'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonST_BUD';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of structural analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisST_BUD comparison, 'ComparisonST_BUD'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonST_BUD';
        end
    end
    methods  % plot methods
        function p = getGlobalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, varargin) %#ok<INUSL>
            % GETGLOBALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectMeasurements(measure_code, group, '.getDensity()');
            Y = analysis.selectMeasurements(measure_code, group, '.getMeasureValue()');
            
            if ~isempty(X) && ~isempty(Y)
                x_ = cell2mat(X);
                y_ = cell2mat([Y{:}]);
                p = plot(ui_parent_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1], ...
                    varargin{:});
            else
            end
            
            xlabel(ui_parent_axes, 'Density')
            ylabel(ui_parent_axes, measure_code)
            
        end
        function p = getGlobalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group_1, group_2, varargin)
            % GETGLOBALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectComparisons(measure_code, group_1, group_2, '.getDensity()');
            Y = analysis.selectComparisons(measure_code, group_1, group_2, '.getDifference()');
            
            if ~isempty(X) && ~isempty(Y)
                x_ = cell2mat(X);
                y_ = cell2mat([Y{:}]);
                
                p = plot(ui_parent_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1]);
            else
            end
            
            hold(ui_parent_axes, 'on')
            xlabel(ui_parent_axes, 'Density')
            ylabel(ui_parent_axes, measure_code)
            
            ui_confidence_interval_min_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            ui_confidence_interval_max_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            init_plot_panel()
            function init_plot_panel()
                set(ui_confidence_interval_min_checkbox, 'Position', [.02 .08 .25 .05]);
                set(ui_confidence_interval_min_checkbox, 'String', 'Show Confidence Interval Min');
                set(ui_confidence_interval_min_checkbox, 'Value', false);
                set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})
                
                set(ui_confidence_interval_max_checkbox, 'Position', [.02 .02 .25 .05]);
                set(ui_confidence_interval_max_checkbox, 'String', 'Show Confidence Interval Max');
                set(ui_confidence_interval_max_checkbox, 'Value', false);
                set(ui_confidence_interval_max_checkbox, 'Callback', {@cb_show_confidence_interval_max})
            end
            
            h_p_min = [];
            h_p_max = [];
            function cb_show_confidence_interval_min(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMin()');
                    x_ = cell2mat(X);
                    y_ = cell2mat([y_confidence{:}]);
                    h_p_min = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_min.Visible = true;
                else
                    h_p_min.Visible = false;
                end
            end
            function cb_show_confidence_interval_max(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMax()');
                    x_ = cell2mat(X);
                    y_ = cell2mat([y_confidence{:}]);
                    h_p_max = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_max.Visible = true;
                else
                    h_p_max.Visible = false;
                end
            end
        end
        function p = getGlobalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, varargin)
            % GETGLOBALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectRandomComparisons(measure_code, group, '.getDensity()');
            Y = analysis.selectRandomComparisons(measure_code, group, '.getDifference()');
            
            if ~isempty(X) && ~isempty(Y)
                x_ = cell2mat(X);
                y_ = cell2mat([Y{:}]);
                
                p = plot(ui_parent_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1]);
            else
            end
            
            hold(ui_parent_axes, 'on')
            xlabel(ui_parent_axes, 'Density')
            ylabel(ui_parent_axes, measure_code)
            
            ui_confidence_interval_min_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            ui_confidence_interval_max_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            init_plot_panel()
            function init_plot_panel()
                set(ui_confidence_interval_min_checkbox, 'Position', [.02 .08 .25 .05]);
                set(ui_confidence_interval_min_checkbox, 'String', 'Show Confidence Interval Min');
                set(ui_confidence_interval_min_checkbox, 'Value', false);
                set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})
                
                set(ui_confidence_interval_max_checkbox, 'Position', [.02 .02 .25 .05]);
                set(ui_confidence_interval_max_checkbox, 'String', 'Show Confidence Interval Max');
                set(ui_confidence_interval_max_checkbox, 'Value', false);
                set(ui_confidence_interval_max_checkbox, 'Callback', {@cb_show_confidence_interval_max})
            end
            
            h_p_min = [];
            h_p_max = [];
            function cb_show_confidence_interval_min(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectRandomComparisons(measure_code, group, '.getConfidenceIntervalMin()');
                    x_ = cell2mat(X);
                    y_ = cell2mat([y_confidence{:}]);
                    h_p_min = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_min.Visible = true;
                else
                    h_p_min.Visible = false;
                end
            end
            function cb_show_confidence_interval_max(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectRandomComparisons(measure_code, group, '.getConfidenceIntervalMax()');
                    x_ = cell2mat(X);
                    y_ = cell2mat([y_confidence{:}]);
                    h_p_max = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_max.Visible = true;
                else
                    h_p_max.Visible = false;
                end
            end
        end
        function p = getNodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_regions, varargin) %#ok<INUSL>
            % GETNODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectMeasurements(measure_code, group, '.getDensity()');
            Y = analysis.selectMeasurements(measure_code, group, '.getMeasureValue()');
            for i = 1:1:length(Y)
                y_unique_cell = Y{i};
                y_nodal_values = y_unique_cell{1};
                y_brain_region{i} = y_nodal_values(brain_regions); %#ok<AGROW>
            end
            
            if ~isempty(X) && ~isempty(y_brain_region)
                x_ = cell2mat(X);
                y_ = [y_brain_region{:}];
                p = plot(ui_parent_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1], ...
                    varargin{:});
            else
            end
            
            xlabel(ui_parent_axes, 'Density')
            ylabel(ui_parent_axes, measure_code)
        end
        function p = getNodalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group_1, group_2, brain_region, varargin)
            % GETNODALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAIN_REGION, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectComparisons(measure_code, group_1, group_2, '.getDensity()');
            Y = analysis.selectComparisons(measure_code, group_1, group_2, '.getDifference()');
            
            for i = 1:1:length(Y)
                y_unique_cell = Y{i};
                y_nodal_values = y_unique_cell{1};
                y_brain_region{i} = y_nodal_values(brain_region); %#ok<AGROW>
            end
            
            if ~isempty(X) && ~isempty(y_brain_region)
                x_ = cell2mat(X);
                y_ = [y_brain_region{:}];
                
                p = plot(ui_parent_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1]);
            else
            end
            
            hold(ui_parent_axes, 'on')
            xlabel(ui_parent_axes, 'Density')
            ylabel(ui_parent_axes, measure_code)
            
            ui_confidence_interval_min_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            ui_confidence_interval_max_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            init_plot_panel()
            function init_plot_panel()
                set(ui_confidence_interval_min_checkbox, 'Position', [.02 .08 .25 .05]);
                set(ui_confidence_interval_min_checkbox, 'String', 'Show Confidence Interval Min');
                set(ui_confidence_interval_min_checkbox, 'Value', false);
                set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})
                
                set(ui_confidence_interval_max_checkbox, 'Position', [.02 .02 .25 .05]);
                set(ui_confidence_interval_max_checkbox, 'String', 'Show Confidence Interval Max');
                set(ui_confidence_interval_max_checkbox, 'Value', false);
                set(ui_confidence_interval_max_checkbox, 'Callback', {@cb_show_confidence_interval_max})
            end
            
            h_p_min = [];
            h_p_max = [];
            function cb_show_confidence_interval_min(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMin()');
                    for j = 1:1:length(y_confidence)
                        min_cell = y_confidence{j};
                        min_cell_values = min_cell{1};
                        min_brs{j} = min_cell_values(brain_region); %#ok<AGROW>
                    end
                    x_ = cell2mat(X);
                    y_ = [min_brs{:}];
                    h_p_min = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_min.Visible = true;
                else
                    h_p_min.Visible = false;
                end
            end
            function cb_show_confidence_interval_max(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMax()');
                    for j = 1:1:length(y_confidence)
                        max_cell = y_confidence{j};
                        max_cell_values = max_cell{1};
                        max_brs{j} = max_cell_values(brain_region); %#ok<AGROW>
                    end
                    x_ = cell2mat(X);
                    y_ = [max_brs{:}];
                    h_p_max = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_max.Visible = true;
                else
                    h_p_max.Visible = false;
                end
            end
        end
        function p = getNodalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region, varargin)
            % GETNODALRANDOMCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALRANDOMCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAIN_REGION, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectRandomComparisons(measure_code, group, '.getDensity()');
            Y = analysis.selectRandomComparisons(measure_code, group, '.getDifference()');
            
            for i = 1:1:length(Y)
                y_unique_cell = Y{i};
                y_nodal_values = y_unique_cell{1};
                y_brain_region{i} = y_nodal_values(brain_region); %#ok<AGROW>
            end
            
            if ~isempty(X) && ~isempty(y_brain_region)
                x_ = cell2mat(X);
                y_ = [y_brain_region{:}];
                
                p = plot(ui_parent_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1]);
            else
            end
            
            hold(ui_parent_axes, 'on')
            xlabel(ui_parent_axes, 'Density')
            ylabel(ui_parent_axes, measure_code)
            
            ui_confidence_interval_min_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            ui_confidence_interval_max_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            init_plot_panel()
            function init_plot_panel()
                set(ui_confidence_interval_min_checkbox, 'Position', [.02 .08 .25 .05]);
                set(ui_confidence_interval_min_checkbox, 'String', 'Show Confidence Interval Min');
                set(ui_confidence_interval_min_checkbox, 'Value', false);
                set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})
                
                set(ui_confidence_interval_max_checkbox, 'Position', [.02 .02 .25 .05]);
                set(ui_confidence_interval_max_checkbox, 'String', 'Show Confidence Interval Max');
                set(ui_confidence_interval_max_checkbox, 'Value', false);
                set(ui_confidence_interval_max_checkbox, 'Callback', {@cb_show_confidence_interval_max})
            end
            
            h_p_min = [];
            h_p_max = [];
            function cb_show_confidence_interval_min(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectRandomComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMin()');
                    for j = 1:1:length(y_confidence)
                        min_cell = y_confidence{j};
                        min_cell_values = min_cell{1};
                        min_brs{j} = min_cell_values(brain_region); %#ok<AGROW>
                    end
                    x_ = cell2mat(X);
                    y_ = [min_brs{:}];
                    h_p_min = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_min.Visible = true;
                else
                    h_p_min.Visible = false;
                end
            end
            function cb_show_confidence_interval_max(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectRandomComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMax()');
                    for j = 1:1:length(y_confidence)
                        max_cell = y_confidence{j};
                        max_cell_values = max_cell{1};
                        max_brs{j} = max_cell_values(brain_region); %#ok<AGROW>
                    end
                    x_ = cell2mat(X);
                    y_ = [max_brs{:}];
                    h_p_max = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_max.Visible = true;
                else
                    h_p_max.Visible = false;
                end
            end
        end
        function p = getBinodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region_1, brain_region_2, varargin)  %#ok<INUSL>
            % GETBINODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETBINODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP,  BRAINREGION1,  BRAINREGION2, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getBinodalPanel.
            
            X = analysis.selectMeasurements(measure_code, group, '.getDensity()');
            Y = analysis.selectMeasurements(measure_code, group, '.getMeasureValue()');
            for i = 1:1:length(Y)
                y_unique_cell = Y{i};
                y_nodal_values = y_unique_cell{1};
                y_brain_region{i} = y_nodal_values(brain_region_1, brain_region_2); %#ok<AGROW>
            end
            
            if ~isempty(X) && ~isempty(y_brain_region)
                x_ = cell2mat(X);
                y_ = [y_brain_region{:}];
                p = plot(ui_parent_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1], ...
                    varargin{:});
            else
            end
            
            xlabel(ui_parent_axes, 'Density')
            ylabel(ui_parent_axes, measure_code)
        end
        function p = getBinodalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes,  measure_code, group_1, group_2, brain_region_1, brain_region_2, varargin)
            % GETNODALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAINREGION1,  BRAINREGION2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the binodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectComparisons(measure_code, group_1, group_2, '.getDensity()');
            Y = analysis.selectComparisons(measure_code, group_1, group_2, '.getDifference()');
            
            for i = 1:1:length(Y)
                y_unique_cell = Y{i};
                y_nodal_values = y_unique_cell{1};
                y_brain_region{i} = y_nodal_values(brain_region_1, brain_region_2); %#ok<AGROW>
            end
            
            if ~isempty(X) && ~isempty(y_brain_region)
                x_ = cell2mat(X);
                y_ = [y_brain_region{:}];
                
                p = plot(ui_parent_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1]);
            else
            end
            
            hold(ui_parent_axes, 'on')
            xlabel(ui_parent_axes, 'Density')
            ylabel(ui_parent_axes, measure_code)
            
            ui_confidence_interval_min_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            ui_confidence_interval_max_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            init_plot_panel()
            function init_plot_panel()
                set(ui_confidence_interval_min_checkbox, 'Position', [.02 .08 .25 .05]);
                set(ui_confidence_interval_min_checkbox, 'String', 'Show Confidence Interval Min');
                set(ui_confidence_interval_min_checkbox, 'Value', false);
                set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})
                
                set(ui_confidence_interval_max_checkbox, 'Position', [.02 .02 .25 .05]);
                set(ui_confidence_interval_max_checkbox, 'String', 'Show Confidence Interval Max');
                set(ui_confidence_interval_max_checkbox, 'Value', false);
                set(ui_confidence_interval_max_checkbox, 'Callback', {@cb_show_confidence_interval_max})
            end
            
            h_p_min = [];
            h_p_max = [];
            function cb_show_confidence_interval_min(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMin()');
                    for j = 1:1:length(y_confidence)
                        min_cell = y_confidence{j};
                        min_cell_values = min_cell{1};
                        min_brs{j} = min_cell_values(brain_region_1, brain_region_2); %#ok<AGROW>
                    end
                    x_ = cell2mat(X);
                    y_ = [min_brs{:}];
                    h_p_min = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_min.Visible = true;
                else
                    h_p_min.Visible = false;
                end
            end
            function cb_show_confidence_interval_max(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMax()');
                    for j = 1:1:length(y_confidence)
                        max_cell = y_confidence{j};
                        max_cell_values = max_cell{1};
                        max_brs{j} = max_cell_values(brain_region_1, brain_region_2); %#ok<AGROW>
                    end
                    x_ = cell2mat(X);
                    y_ = [max_brs{:}];
                    h_p_max = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_max.Visible = true;
                else
                    h_p_max.Visible = false;
                end
            end
        end
        function p = getBinodalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region_1, brain_region_2, varargin)
            % GETNODALRANDOMCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALRANDOMCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAINREGION1,  BRAINREGION2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the binodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectRandomComparisons(measure_code, group, '.getDensity()');
            Y = analysis.selectRandomComparisons(measure_code, group, '.getDifference()');
            
            for i = 1:1:length(Y)
                y_unique_cell = Y{i};
                y_nodal_values = y_unique_cell{1};
                y_brain_region{i} = y_nodal_values(brain_region_1, brain_region_2); %#ok<AGROW>
            end
            
            if ~isempty(X) && ~isempty(y_brain_region)
                x_ = cell2mat(X);
                y_ = [y_brain_region{:}];
                
                p = plot(ui_parent_axes, ...
                    x_, ...
                    y_, ...
                    'Marker', 'o', ...
                    'MarkerSize', 10, ...
                    'MarkerEdgeColor', [0 0 1], ...
                    'MarkerFaceColor', [.9 .4 .1], ...
                    'LineStyle', '-', ...
                    'LineWidth', 1, ...
                    'Color', [0 0 1]);
            else
            end
            
            hold(ui_parent_axes, 'on')
            xlabel(ui_parent_axes, 'Density')
            ylabel(ui_parent_axes, measure_code)
            
            ui_confidence_interval_min_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            ui_confidence_interval_max_checkbox = uicontrol(ui_parent_panel, 'Style', 'checkbox', 'Units', 'normalized');
            init_plot_panel()
            function init_plot_panel()
                set(ui_confidence_interval_min_checkbox, 'Position', [.02 .08 .25 .05]);
                set(ui_confidence_interval_min_checkbox, 'String', 'Show Confidence Interval Min');
                set(ui_confidence_interval_min_checkbox, 'Value', false);
                set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})
                
                set(ui_confidence_interval_max_checkbox, 'Position', [.02 .02 .25 .05]);
                set(ui_confidence_interval_max_checkbox, 'String', 'Show Confidence Interval Max');
                set(ui_confidence_interval_max_checkbox, 'Value', false);
                set(ui_confidence_interval_max_checkbox, 'Callback', {@cb_show_confidence_interval_max})
            end
            
            h_p_min = [];
            h_p_max = [];
            function cb_show_confidence_interval_min(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectRandomComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMin()');
                    for j = 1:1:length(y_confidence)
                        min_cell = y_confidence{j};
                        min_cell_values = min_cell{1};
                        min_brs{j} = min_cell_values(brain_region_1, brain_region_2); %#ok<AGROW>
                    end
                    x_ = cell2mat(X);
                    y_ = [min_brs{:}];
                    h_p_min = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_min.Visible = true;
                else
                    h_p_min.Visible = false;
                end
            end
            function cb_show_confidence_interval_max(src, ~)
                if src.Value == true
                    
                    y_confidence = analysis.selectRandomComparisons(measure_code, group_1, group_2, '.getConfidenceIntervalMax()');
                    for j = 1:1:length(y_confidence)
                        max_cell = y_confidence{j};
                        max_cell_values = max_cell{1};
                        max_brs{j} = max_cell_values(brain_region_1, brain_region_2); %#ok<AGROW>
                    end
                    x_ = cell2mat(X);
                    y_ = [max_brs{:}];
                    h_p_max = plot(ui_parent_axes, ...
                        x_, ...
                        y_, ...
                        'Marker', 'x', ...
                        'MarkerSize', 10, ...
                        'MarkerEdgeColor', [0 0 1], ...
                        'MarkerFaceColor', [.3 .4 .5], ...
                        'LineStyle', '-', ...
                        'LineWidth', 1, ...
                        'Color', [0 1 1]);
                    h_p_max.Visible = true;
                else
                    h_p_max.Visible = false;
                end
            end
        end
    end
end