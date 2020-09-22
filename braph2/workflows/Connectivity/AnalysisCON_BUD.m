classdef AnalysisCON_BUD < AnalysisCON_WU
    % AnalysisCON_BUD An analysis of connectivity data of fixed density binary undirected graphs
    % AnalysisCON_BUD is a subclass of AnalysisCON_WU and implements the methods
    % needed for connectivity analysis.
    %
    % AnalysisCON_BUD implements AnalysisCON_WU calculating methods
    % to obtain a connectivity data of fixed density binary undirected graphs
    % measurement, a random comprison or a comparison. AnalysisCON_BUD
    % overrides the ID methods of its superclass.
    % Connectivity data can be for example MRI or PET data.
    %
    % AnalysisCON_BUD constructor methods:
    %  AnalysisCON_BUD              - Constructor
    %
    % AnalysisCON_BUD calcultion methods (Access = protected):
    %  get_graph_for_subjects       - returns the graph of the correlated matrix
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisCON_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the analysis
    %  getName                      - returns the name of the analysis
    %  getDescription               - returns the description of the analysis
    %  getMeasurementClass          - returns the class of the measurement
    %  getRandomComparisonClass     - returns the class of the random comparison
    %  getComparisonClass           - returns the class of the comparison
    %  getAvailbleSettings          - returns the available settings
    %
    % AnalysisCON_BUD Plot UIPanels
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
        function analysis = AnalysisCON_BUD(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % AnalysisCON_BUD(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a connectivity analysis of fixed density with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It 
            % initializes the ANALYSISST_WU with default settings.
            %
            % AnalysisCON_BUD(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a connectivity analysis of fixed density with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It
            % initializes the ANALYSISST_WU with specified settings VALUES.
            %
            % See also MeasurementST_WU, RandomComparisonST_WU, ComparisonST_WU.
                 
            analysis = analysis@AnalysisCON_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin{:});
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
            
            measurement_id = getMeasurementID@AnalysisCON_WU(analysis, measure_code, group, varargin{:});
            
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
         
            randomcomparison_id = getRandomComparisonID@AnalysisCON_WU(analysis, measure_code, group, varargin{:});
            
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
            
            comparison_id = getComparisonID@AnalysisCON_WU(analysis, measure_code, group_1, group_2, varargin{:});
            
            density = get_from_varargin(0, 'density', varargin{:});
            comparison_id = [comparison_id ' density=' num2str(density)];
        end
    end
    methods (Access = protected)
        function g = get_graph_for_subjects(analysis, subjects, varargin)
            % GET_GRAPH_FOR_SUBJECTS returns the graph created with the correlation matrix
            %
            % G = GET_GRAPH_FOR_SUBJECTS(ANALYSIS, SUBJECTS, PROPERY, VALUE, ...) creates a
            % graph with the correlation matrix made of the data of
            % subjects. It will binarize the matrix depending on the
            % PROPERTY and VALUE.
            %
            % See also calculate_measurement.
            
            atlases = analysis.cohort.getBrainAtlases();
            atlas = atlases{1};
            
            subject_number = numel(subjects);
            
            data = zeros(subject_number, atlas.getBrainRegions().length());
            for i = 1:1:subject_number
                subject = subjects{i};
                data(i, :) = subject.getData('CON').getValue();  % st data
            end
            
            correlation_rule = analysis.getSettings('AnalysisCON.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisCON.NegativeWeightRule');
            A = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
            
            density = get_from_varargin(0, 'density', varargin{:});
            A = binarize(A, 'density', density, varargin{:});
            
            graph_type = AnalysisCON_WU.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of connectivity analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisCON_BUD.
            %
            % See also getList, getName, getDescription.
            
            analysis_class = 'AnalysisCON_BUD';
        end
        function name = getName()
            % GETNAME returns the name of connectivity analysis
            %
            % NAME = GETNAME() returns the name of the analysis.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Connectivity BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisCON_BUD.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis based on connectivity data of fixed density using ' ...
                'weighted graphs e.g. cortical thickness for each brain region. ' ...
                'It provides a single graph for each subject group. ' ...
                'Connectivity data can be for example MRI or PET data.' ...
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
            % GETMEASUREMENTCLASS returns the class of connectivity analysis measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS() returns the
            % class of AnalysisCON_BUD measurement, 'MeasurementCON_BUD'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementCON_BUD';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of connectivity analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisCON_BUD randomcomparison,
            % 'RandomComparisonCON_BUD'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonCON_BUD';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of connectivity analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisCON_BUD comparison, 'ComparisonCON_BUD'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonCON_BUD';
        end
    end
    methods  % plot methods
        function p = getGlobalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, subject, varargin) %#ok<INUSL>
            % GETGLOBALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectMeasurements(measure_code, group, '.getDensity()');
             if subject == 1
                Y = analysis.selectMeasurements(measure_code, group, '.getGroupAverageValue()');
            else 
                measurements = analysis.selectMeasurements(measure_code, group, '.getMeasureValues()');
                Y = cellfun(@(x) x(subject-1), measurements);
            end
            
            if ~isempty(X) && ~isempty(Y)
                x_ = cell2mat(X);
                y_ = cell2mat(Y);
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
            ylabel(ui_parent_axes, [measure_code ' Group Average'])
            
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
            ylabel(ui_parent_axes, [measure_code ' Difference'])
            
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
            ylabel(ui_parent_axes, [measure_code ' Difference'])
            
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
        function p = getNodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_regions, subject, varargin) %#ok<INUSL>
            % GETNODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectMeasurements(measure_code, group, '.getDensity()');
            if subject == 1
                Y = analysis.selectMeasurements(measure_code, group, '.getGroupAverageValue()');
            else
                measurements = analysis.selectMeasurements(measure_code, group, '.getMeasureValues()');
                Y = cellfun(@(x) x(subject-1), measurements);
            end
            for i = 1:1:length(Y)
                y_unique_cell = Y{i};
                y_nodal_values = y_unique_cell;
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
            ylabel(ui_parent_axes, [measure_code ' Group Average'])
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
            ylabel(ui_parent_axes, [measure_code ' Difference'])
            
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
            ylabel(ui_parent_axes, [measure_code ' Difference'])
            
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
        function p = getBinodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region_1, brain_region_2, subject, varargin)  %#ok<INUSL>
            % GETBINODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETBINODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP,  BRAINREGION1,  BRAINREGION2, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getBinodalPanel.
            
            X = analysis.selectMeasurements(measure_code, group, '.getDensity()');
            if subject == 1
                Y = analysis.selectMeasurements(measure_code, group, '.getGroupAverageValue()');
            else
                measurements = analysis.selectMeasurements(measure_code, group, '.getMeasureValues()');
                Y = cellfun(@(x) x(subject-1), measurements);
            end
            for i = 1:1:length(Y)
                y_unique_cell = Y{i};
                y_nodal_values = y_unique_cell;
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
            ylabel(ui_parent_axes, [measure_code ' Group Average'])
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
            ylabel(ui_parent_axes, [measure_code ' Difference'])
            
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
            ylabel(ui_parent_axes, [measure_code ' Difference'])
            
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