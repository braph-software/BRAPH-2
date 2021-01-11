classdef AnalysisST_MP_BUT < AnalysisST_MP_WU
    % AnalysisST_MP_BUT An analysis of structural multiplex data of fixed threshold binary undirected graphs
    % AnalysisST_MP_BUT is a subclass of AnalysisST_MP_WU and implements the methods
    % needed for structural multiplex analysis.
    %
    % AnalysisST_MP_BUT implements AnalysisST_MP_WU calculating methods
    % to obtain a structural multiplex data of fixed threshold binary undirected 
    % graphs measurement, a random comparison or a comparison. AnalysisST_MP_BUT
    % overrides the ID methods of its superclass.
    % Structural multiplex data can be for example MRI or/and PET data.
    %
    % AnalysisST_MP_BUT constructor methods:
    %  AnalysisST_MP_BUT            - Constructor
    %
    % AnalysisST_MP_BUT graph methods (Access = protected)
    %  get_graph_for_subjects       - returns the graph of the correlated matrix
    %
    % AnalysisST_MP_BUT calcultion methods (Access = protected):
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisST_MP_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the analysis
    %  getName                      - returns the name of the analysis
    %  getDescription               - returns the description of the analysis
    %  getMeasurementClass          - returns the class of the measurement
    %  getRandomComparisonClass     - returns the class of the random comparison
    %  getComparisonClass           - returns the class of the comparison
    %  getAvailbleSettings          - returns the available settings
    %
    % AnalysisST_MP_BUT Plot UIPanels
    %  getGlobalMeasurePlot         - returns a global measurement plot
    %  getGlobalComparisonPlot      - returns a global comparison plot
    %  getGlobalRandomComparisonPlot - returns a global randomcomparison plot
    %
    % See also Analysis, MeasurementST_MP_BUT, RandomComparisonST_MP_BUT, ComparisonST_MP_BUT
    
    methods
        function analysis = AnalysisST_MP_BUT(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % ANALYSISST_MP_BUT(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a structural multiplex analysis of fixed threshold with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It
            % initializes the ANALYSISST_MP_WU with default settings.
            %
            % ANALYSISST_MP_BUT(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a structural multiplex analysis of fixed threshold with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It
            % initializes the ANALYSISST_MP_WU with specified settings VALUES.
            %
            % See also MeasurementST_MP_BUT, RandomComparisonST_MP_BUT, ComparisonST_MP_BUT.
            
            analysis = analysis@AnalysisST_MP_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods  % ID functions
        function measurement_id = getMeasurementID(analysis, measure_code, group, varargin)
            % GETMEASUREMENTID returns a measurement ID
            %
            % MEASUREMENT_ID = GETMEASUREMENTID(ANALYSIS, MEASURE_CODE, GROUP, 'threshold', THRESHOLD)
            % creates a measurement ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and the THRESHOLD.
            %
            % See also getRandomComparisonID, getComparisonID.
            
            measurement_id = getMeasurementID@AnalysisST_MP_WU(analysis, measure_code, group, varargin{:});
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            measurement_id = [measurement_id ' threshold=' num2str(threshold)];
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
            % GETRANDOMCOMPARISONID returns a random comparison ID
            %
            % RANDOMCOMPARISON_ID = GETRANDOMCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP, 'threshold', THRESHOLD)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and the THRESHOLD.
            %
            % See also getMeasurementID, getComparisonID.
            
            randomcomparison_id = getRandomComparisonID@AnalysisST_MP_WU(analysis, measure_code, group, varargin{:});
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            randomcomparison_id = [randomcomparison_id ' threshold=' num2str(threshold)];
        end
        function comparison_id = getComparisonID(analysis, measure_code, group_1, group_2, varargin)
            % GETCOMPARISONID returns a comparison ID
            %
            % COMPARISON_ID = GETCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, 'threshold', THRESHOLD)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, GROUP_1 and GROUP_2, and the THRESHOLD.
            %
            % See also getMeasurementID, getRandomComparisonID.
            
            comparison_id = getComparisonID@AnalysisST_MP_WU(analysis, measure_code, group_1, group_2, varargin{:});
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            comparison_id = [comparison_id ' threshold=' num2str(threshold)];
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
            
            A = analysis.get_weighted_correlation_matrix(subjects, varargin{:});
            subject = subjects{1};
            layers = subject.getNumberOfLayers(); 
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            
            for i=1:1:layers
                L = A{i, i};
                new_L = binarize(L, 'threshold', threshold, varargin{:});
                A(i, i) = {new_L};
            end
            
            graph_type = AnalysisST_MP_WU.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of structural multiplex analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisST_MP_BUT.
            %
            % See also getList, getName, getDescription.
            
            analysis_class = 'AnalysisST_MP_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural multiplex analysis
            %
            % NAME = GETNAME() returns the name of the analysis.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Structural Multiplex BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural multiplex analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisST_MP_BUT.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis based on structural multiplex data of fixed threshold using ' ...
                'weighted graphs e.g. cortical thickness for each brain region. ' ...
                'It provides a single graph for each subject group. ' ...
                'Structural multiplex data can be for example MRI or/and PET data.' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the compatible type of graph
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns the compatible type of
            % graph 'MultiplexGraphBU'.
            %
            % See also getSubjectClass.
            
            graph_type = 'MultiplexGraphBU';
        end
        function measurement_class = getMeasurementClass()
            % GETMEASUREMENTCLASS returns the class of structural multiplex analysis measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS() returns the
            % class of AnalysisST_MP_BUT measurement, 'MeasurementST_MP_BUT'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementST_MP_BUT';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of structural multiplex analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisST_MP_BUT randomcomparison,
            % 'RandomComparisonST_MP_BUT'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonST_MP_BUT';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of structural multiplex analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisST_MP_BUT comparison, 'ComparisonST_MP_BUT'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonST_MP_BUT';
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

            X = analysis.selectMeasurements(measure_code, group, '.getThreshold()');   
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
            
            xlabel(ui_parent_axes, 'Threshold')
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

            X = analysis.selectComparisons(measure_code, group_1, group_2, '.getThreshold()');
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
            xlabel(ui_parent_axes, 'Threshold')
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
            
            X = analysis.selectRandomComparisons(measure_code, group, '.getThreshold()');
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
            xlabel(ui_parent_axes, 'Threshold')
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
        function p = getNodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region, varargin) %#ok<INUSL>
            % GETNODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %            
            % See also getGraphPanel, getGlobalPanel.

            X = analysis.selectMeasurements(measure_code, group, '.getThreshold()');
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
            
            xlabel(ui_parent_axes, 'Threshold')
            ylabel(ui_parent_axes, [measure_code ' Measure Value'])
        end
        function p = getNodalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group_1, group_2, brain_region, varargin) 
            % GETNODALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAIN_REGION, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectComparisons(measure_code, group_1, group_2, '.getThreshold()');
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
            xlabel(ui_parent_axes, 'Threshold')
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
            
            X = analysis.selectRandomComparisons(measure_code, group, '.getThreshold()');
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
            xlabel(ui_parent_axes, 'Threshold')
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
        function p = getBinodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region_1, brain_region_2, varargin)  %#ok<INUSL>
            % GETBINODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETBINODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP,  BRAINREGION1,  BRAINREGION2, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getBinodalPanel.          

            X = analysis.selectMeasurements(measure_code, group, '.getThreshold()');
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
            
            xlabel(ui_parent_axes, 'Threshold')
            ylabel(ui_parent_axes, [measure_code ' Measure Value'])
        end
        function p = getBinodalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group_1, group_2, brain_region_1, brain_region_2, varargin)
            % GETNODALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAINREGION1,  BRAINREGION2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the binodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            X = analysis.selectComparisons(measure_code, group_1, group_2, '.getThreshold()');
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
            xlabel(ui_parent_axes, 'Threshold')
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
            
            X = analysis.selectRandomComparisons(measure_code, group, '.getThreshold()');
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
            xlabel(ui_parent_axes, 'Threshold')
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
                    
                    y_confidence = analysis.selectRandomComparisons(measure_code, group, '.getConfidenceIntervalMax()');
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