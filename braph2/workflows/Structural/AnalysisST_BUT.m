classdef AnalysisST_BUT < AnalysisST_WU
    % AnalysisST_BUT An analysis of structural data of fixed threshold binary undirected graphs
    % AnalysisST_BUT is a subclass of AnalysisST_WU and implements the methods
    % needed for structural analysis.
    %
    % AnalysisST_BUT implements AnalysisST_WU calculating methods
    % to obtain a structural data of fixed threshold binary undirected graphs
    % measurement, a random comprison or a comparison. AnalysisST_BUT
    % overrides the ID methods of its superclass.
    % Structural data can be for example MRI or PET data.
    %
    % AnalysisST_BUT constructor methods:
    %  AnalysisST_BUT               - Constructor
    %
    % AnalysisST_BUT graph methods (Access = protected)
    %  get_graph_for_subjects       - returns the graph of the correlated matrix
    %
    % AnalysisST_BUT calcultion methods (Access = protected):
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisST_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the analysis
    %  getName                      - returns the name of the analysis
    %  getDescription               - returns the description of the analysis
    %  getMeasurementClass          - returns the class of the measurement
    %  getRandomComparisonClass     - returns the class of the random comparison
    %  getComparisonClass           - returns the class of the comparison
    %  getAvailbleSettings          - returns the available settings
    %
    % AnalysisST_BUT Plot UIPanels
    %  getGlobalMeasurePlot         - returns a global measurement plot
    %  getGlobalComparisonPlot      - returns a global comparison plot
    %  getGlobalRandomComparisonPlot - returns a global randomcomparison plot
    %
    % See also Analysis, MeasurementST_BUT, RandomComparisonST_BUT, ComparisonST_BUT
    
    methods
        function analysis = AnalysisST_BUT(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % AnalysisST_BUT(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a structural analysis of fixed threshold with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It
            % initializes the ANALYSISST_WU with default settings.
            %
            % AnalysisST_BUT(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a structural analysis of fixed threshold with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It
            % initializes the ANALYSISST_WU with specified settings VALUES.
            %
            % See also MeasurementST_WU, RandomComparisonST_WU, ComparisonST_WU.
            
            analysis = analysis@AnalysisST_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin{:});
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
            
            measurement_id = getMeasurementID@AnalysisST_WU(analysis, measure_code, group, varargin{:});
            
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
            
            randomcomparison_id = getRandomComparisonID@AnalysisST_WU(analysis, measure_code, group, varargin{:});
            
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
            
            comparison_id = getComparisonID@AnalysisST_WU(analysis, measure_code, group_1, group_2, varargin{:});
            
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
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            A = binarize(A, 'treshold', threshold, varargin{:});
            
            graph_type = AnalysisST_WU.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of structural analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisST_BUT.
            %
            % See also getList, getName, getDescription.
            
            analysis_class = 'AnalysisST_BUT';
        end
        function name = getName()
            % GETNAME returns the name of structural analysis
            %
            % NAME = GETNAME() returns the name of the analysis.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Structural BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisST_BUT.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis based on structural data of fixed threshold using ' ...
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
            % class of AnalysisST_BUT measurement, 'MeasurementST_BUT'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementST_BUT';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of structural analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisST_BUT randomcomparison,
            % 'RandomComparisonST_BUT'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonST_BUT';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of structural analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisST_BUT comparison, 'ComparisonST_BUT'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonST_BUT';
        end
    end
    methods  % plot methods
        function p = getGlobalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, group, varargin)
            % GETGLOBALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            measurements = analysis.getMeasurements().getValues();  % array
            group = analysis.getCohort().getGroups().getValue(group);
            measurements = measurements(find(cellfun(@(x) isequal(x.getGroup(), group) , measurements))); %#ok<FNDSB>
            % i need to plot threshold vs measurement values
            y_label = [];
            X = [];
            Y = [];
            x_ = [0 0];
            y_ = [0 0]; %#ok<NASGU>
            for i = 1:1:length(measurements)
                m = measurements{i};
                X{i} = m.getThreshold();  %#ok<AGROW>
                val_cell = m.getMeasureValue();
                Y{i} = val_cell{1};   %#ok<AGROW>
                y_label = m.getMeasureCode();
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
                    'Color', [0 0 1]);
            else
            end
            
            xlabel(ui_parent_axes, 'Threshold')
            ylabel(ui_parent_axes, y_label)
            
            ui_min_text = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_min_edit = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_max_text = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_max_edit = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_step_text = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_step_edit = uicontrol(ui_parent_panel, 'Style', 'text');
            init_uicontrols()
            function init_uicontrols()
                
                set(ui_min_text, 'Units', 'normalized')
                set(ui_min_text, 'Position', [.01 .07 .15 .05])
                set(ui_min_text, 'String', 'Min')
                
                set(ui_min_edit, 'Units', 'normalized')
                set(ui_min_edit, 'Position', [.16 .07 .15 .05])
                set(ui_min_edit, 'String', x_(1))
                
                set(ui_max_text, 'Units', 'normalized')
                set(ui_max_text, 'Position', [.01 .05 .15 .05])
                set(ui_max_text, 'String', 'Max')
                
                set(ui_max_edit, 'Units', 'normalized')
                set(ui_max_edit, 'Position', [.16 .05 .15 .05])
                set(ui_max_edit, 'String', x_(end))
                
                set(ui_step_text, 'Units', 'normalized')
                set(ui_step_text, 'Position', [.01 .03 .15 .05])
                set(ui_step_text, 'String', 'Step')
                
                set(ui_step_edit, 'Units', 'normalized')
                set(ui_step_edit, 'Position', [.16 .03 .15 .05])
                set(ui_step_edit, 'String', x_(2) - x_(1))
                
            end
        end
        function p = getGlobalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group_1, group_2, varargin)
            % GETGLOBALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            comparisons = analysis.getComparisons().getValues();  % array
            group1 = analysis.getCohort().getGroups().getValue(group_1);
            group2 = analysis.getCohort().getGroups().getValue(group_2);
            comparisons_ = [];
            comparison_to_plot = [];
            for i = 1:1:length(comparisons)
                comparison = comparisons{i};
                [g1, g2] = comparison.getGroups();
                if isequal(g1, group1) && isequal(g2, group2)
                    comparisons_{i} = comparison; %#ok<AGROW>
                end
            end
            if ~isempty(comparisons_)
                comparison_to_plot = comparisons_(~cellfun(@isempty, comparisons_));
            end
            y_label = [];
            X = [];
            Y = [];
            x_ = [0 0];
            y_ = [0 0]; %#ok<NASGU>
            for i = 1:1:length(comparison_to_plot)
                c = comparison_to_plot{i};
                X{i} = c.getThreshold();  %#ok<AGROW>
                val_cell = c.getDifference();
                Y{i} = val_cell{1};   %#ok<AGROW>
                y_label = c.getMeasureCode();
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
                    'Color', [0 0 1]);
            else
            end
            
            xlabel(ui_parent_axes, 'Threshold')
            ylabel(ui_parent_axes, y_label)
            
            ui_min_text = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_min_edit = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_max_text = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_max_edit = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_step_text = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_step_edit = uicontrol(ui_parent_panel, 'Style', 'text');
            init_uicontrols()
            function init_uicontrols()
                set(ui_min_text, 'Units', 'normalized')
                set(ui_min_text, 'Position', [.01 .07 .15 .05])
                set(ui_min_text, 'String', 'Min')
                
                set(ui_min_edit, 'Units', 'normalized')
                set(ui_min_edit, 'Position', [.16 .07 .15 .05])
                set(ui_min_edit, 'String', x_(1))
                
                set(ui_max_text, 'Units', 'normalized')
                set(ui_max_text, 'Position', [.01 .05 .15 .05])
                set(ui_max_text, 'String', 'Max')
                
                set(ui_max_edit, 'Units', 'normalized')
                set(ui_max_edit, 'Position', [.16 .05 .15 .05])
                set(ui_max_edit, 'String', x_(end))
                
                set(ui_step_text, 'Units', 'normalized')
                set(ui_step_text, 'Position', [.01 .03 .15 .05])
                set(ui_step_text, 'String', 'Step')
                
                set(ui_step_edit, 'Units', 'normalized')
                set(ui_step_edit, 'Position', [.16 .03 .15 .05])
                set(ui_step_edit, 'String', x_(2) - x_(1))
                
            end
        end
        function p = getGlobalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group, varargin)
            % GETGLOBALRANDOMCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALRANDOMCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            randomcomparisons = analysis.getRandomComparisons().getValues();  % array
            group = analysis.getCohort().getGroups().getValue(group);
            random_comparison = randomcomparisons(find(cellfun(@(x) isequal(x.getGroup(), group), randomcomparisons))); %#ok<FNDSB>
            y_label = [];
            X = [];
            Y = [];
            x_ = [0 0];
            y_ = [0 0]; %#ok<NASGU>
            for i = 1:1:length(random_comparison)
                rc = random_comparison{i};
                X{i} = rc.getThreshold();  %#ok<AGROW>
                val_cell = rc.getDifference();
                Y{i} = val_cell{1};   %#ok<AGROW>
                y_label = rc.getMeasureCode();
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
                    'Color', [0 0 1]);
            else
            end
            
            xlabel(ui_parent_axes, 'Threshold')
            ylabel(ui_parent_axes, y_label)
            
            ui_min_text = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_min_edit = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_max_text = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_max_edit = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_step_text = uicontrol(ui_parent_panel, 'Style', 'text');
            ui_step_edit = uicontrol(ui_parent_panel, 'Style', 'text');
            init_uicontrols()
            function init_uicontrols()
                set(ui_min_text, 'Units', 'normalized')
                set(ui_min_text, 'Position', [.01 .07 .15 .05])
                set(ui_min_text, 'String', 'Min')
                
                set(ui_min_edit, 'Units', 'normalized')
                set(ui_min_edit, 'Position', [.16 .07 .15 .05])
                set(ui_min_edit, 'String', x_(1))
                
                set(ui_max_text, 'Units', 'normalized')
                set(ui_max_text, 'Position', [.01 .05 .15 .05])
                set(ui_max_text, 'String', 'Max')
                
                set(ui_max_edit, 'Units', 'normalized')
                set(ui_max_edit, 'Position', [.16 .05 .15 .05])
                set(ui_max_edit, 'String', x_(end))
                
                set(ui_step_text, 'Units', 'normalized')
                set(ui_step_text, 'Position', [.01 .03 .15 .05])
                set(ui_step_text, 'String', 'Step')
                
                set(ui_step_edit, 'Units', 'normalized')
                set(ui_step_edit, 'Position', [.16 .03 .15 .05])
                set(ui_step_edit, 'String', x_(2) - x_(1))
                
            end
        end
    end
end