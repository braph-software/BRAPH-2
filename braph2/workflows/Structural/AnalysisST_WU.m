classdef AnalysisST_WU < Analysis
    % AnalysisST_WU An analysis of structural data with weighted undirected graphs
    % AnalsysisST_WU is a subclass of Analysis and implements the methods
    % needed for structural analysis.
    %
    % AnalysisST_WU implements the abstract analysis calculting methods
    % to obtain a structural measurement, a random comparison or a
    % comparison. AnalysisST_WU also implements the ID methods to get
    % the correct signature of the analysis.
    % Structural data can be for example MRI or PET data.
    %
    % AnalysisST_WU constructor methods:
    %  AnalysisST_WU                - Constructor
    %
    % AnalysisST_WU ID methods:
    %  getMeasurementID             - returns the measurement ID
    %  getRandomComparisonID        - returns the random comparison ID
    %  getComparisonID              - returns the comparison ID
    %
    % AnalysisST_WU graph methods (Access = protected)
    %  get_weighted_correlation_matrix - returns the correlated matrix
    %  get_graph_for_subjects       - returns the graph with the correlated matrix
    %
    % AnalysisST_WU calcultion methods (Access = protected):
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisST_WU descriptive methods (Static):
    %  getClass                     - returns the class of the analysis
    %  getName                      - returns the name of the analysis
    %  getDescription               - returns the description of the analysis
    %  getGraphType                 - returns the availble type of graph
    %  getSubjectClass              - returns the class of the subject
    %  getMeasurementClass          - returns the class of the measurement
    %  getRandomComparisonClass     - returns the class of the random comparison
    %  getComparisonClass           - returns the class of the comparison
    %  getAvailbleSettings          - returns the available settings
    %
    % AnalysisST_WU Plot panel methods
    %  getGraphPanel                - creates a uipanel
    %  getGlobalPanel               - creates a global uipanel for GUIAnalysis
    %  getNodalPanel                - creates a nodal uipanel for GUIAnalysis
    %  getGlobalMeasurePlot         - returns a global measurement plot
    %  getGlobalComparisonPlot      - returns a global comparison plot
    %  getGlobalRandomComparisonPlot - returns a global randomcomparison plot
    %  getNodalMeasurePlot          - returns a nodal mesure plot
    %  getNodalComparisonPlot       - returns a nodal comprison plot
    %  getNodalRandomComparisonPlot - returns a nodal randomcomparison plot
    %  getBinodalMeasurePlot      - returns a binodal mesure plot
    %  getBinodalComparisonPlot   - returns a binodal comprison plot
    %  getBinodalRandomComparisonPlot - returns a binodal randomcomparison plot
    %
    % See also Analysis, MeasurementST_WU, RandomComparisonST_WU, ComparisonST_WU
    
    methods  % Constructor
        function analysis = AnalysisST_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % ANALYSISST_WU(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a structural analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISST_WU with default settings.
            %
            % ANALYSISST_WU(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a structural analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISST_WU with specified settings VALUES.
            %
            % See also MeasurementST_WU, RandomComparisonST_WU, ComparisonST_WU.
            
            analysis = analysis@Analysis(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods  % ID functions
        function measurement_id = getMeasurementID(analysis, measure_code, group, varargin)
            % GETMEASUREMENTID returns a measurement ID
            %
            % MEASUREMENT_ID = GETMEASUREMENTID(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % creates a measurement ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and all PROPERTIES and VALUES.
            %
            % See also getRandomComparisonID, getComparisonID.
            
            measurement_id = [ ...
                tostring(analysis.getMeasurementClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group)) ...
                ];
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
            % GETRANDOMCOMPARISONID returns a random comparison ID
            %
            % RANDOMCOMPARISON_ID = GETRANDOMCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and all PROPERTIES and VALUES.
            %
            % See also getMeasurementID, getComparisonID.
            
            randomcomparison_id = [ ...
                tostring(analysis.getRandomComparisonClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group)) ...
                ];
        end
        function comparison_id = getComparisonID(analysis, measure_code, group_1, group_2, varargin)
            % GETCOMPARISONID returns a comparison ID
            %
            % COMPARISON_ID = GETCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, GROUP_1 and GROUP_2, and all PROPERTIES and VALUES.
            %
            % See also getMeasurementID, getRandomComparisonID.
            
            comparison_id = [ ...
                tostring(analysis.getComparisonClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group_1)) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group_2)) ...
                ];
        end
    end
    methods (Access = protected)  % graph methods
        function A = get_weighted_correlation_matrix(analysis, subjects, varargin)
            % GET_WEIGHTED_CORRELATION_MATRIX creates a correlated matrix
            %
            % A = GET_WEIGHTED_CORRELATION_MATRIX(ANALYSIS, SUBJECTS)
            % creates a correlated matrix using the SUBJECTS data. Applies
            % the ANALYSIS settings to correlate.
            %
            % See also get_graph_for_subjects.
            
            atlases = analysis.cohort.getBrainAtlases();
            atlas = atlases{1};
            
            subject_number = numel(subjects);
            
            data = zeros(subject_number, atlas.getBrainRegions().length());
            for i = 1:1:subject_number
                subject = subjects{i};
                data(i, :) = subject.getData('ST').getValue();  % st data
            end
            
            correlation_rule = analysis.getSettings('AnalysisST.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisST.NegativeWeightRule');
            
            A = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
        end
        function g = get_graph_for_subjects(analysis, subjects, varargin)
            % GET_GRAPH_FOR_SUBJECTS returns the graph created with the correlation matrix
            %
            % G = GET_GRAPH_FOR_SUBJECTS(ANALYSIS, SUBJECTS) creates a
            % graph with the correlation matrix made of the data of
            % subjects.
            %
            % G = GET_GRAPH_FOR_SUBJECTS(ANALYSIS, SUBJECTS, PROPERTY, VALUE) creates a
            % graph with the correlation matrix made of the data of
            % subjects.
            % Admissible PROPERTIES are:
            %   AnalysisST.CorrelationRule     - determines which type of
            %                                    correlation function will be used
            %   AnalysisST.NegativeWeightRule  - determines which the type of
            %                                    filter will be applied to the matrix
            %
            % See also calculate_measurement.
            
            A = analysis.get_weighted_correlation_matrix(subjects, varargin{:});
            
            graph_type = AnalysisST_WU.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
    end
    methods (Access = protected)  % Calculation functions
        function measurement = calculate_measurement(analysis, measure_code, group, varargin)
            % CALCULATE_MEASUREMENT returns a measurement
            %
            % MEASUREMENT = CALCULTE_MEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subject. It will return a measurement with the
            % calculated measure. The function will utilize default
            % settings.
            %
            % MEASUREMENT = CALCULTE_MEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subject. It will return a measurement with the
            % calculated measure. The function will utilize VALUE settings.
            %
            % See also calculate_random_comparison, calculate_comparison.
            
            subjects = group.getSubjects();
            
            g = analysis.get_graph_for_subjects(subjects, varargin{:});
            
            measure = Measure.getMeasure(measure_code, g, varargin{:});
            measurement_value = measure.getValue();
            measurement_parameter_values = measure.getParameterValues();
            
            measurement = Measurement.getMeasurement(analysis.getMeasurementClass(), ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'MeasurementST.Value', measurement_value, ...
                'MeasurementST.ParameterValues', measurement_parameter_values, ...
                varargin{:} ...
                );
        end
        function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            % CALCULATE_RANDOM_COMPARISON returns a random comparison
            %
            % RANDOMCOMPARISON = CALCULATE_RANDOM_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subject and random data. It will compare the measures
            % obtained and will return a random comparison. The function
            % will utilize default settings.
            %
            % RANDOMCOMPARISON = CALCULATE_RANDOM_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subject and random data. It will compare the measures
            % obtained and will return a random comparison. The function
            % will utilize VALUE settings.
            % Available POPERTIES are:
            %  Verbose             - true to display info about the
            %                        randomization cycle, false by default
            %  Interruptible       - true if randomization cycle can be
            %                        interreput, false by default
            %  RandomizationNUmber - number of randomizations
            %  AttemptsPerEdge     - number of swap attempts
            %  NumberOfWeigths     - number of weigths sorted at the same time during randomization
            %
            % See also calculate_measurement, calculate_comparison.
            
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            
            M = get_from_varargin(1e+3, 'RandomizationNumber', varargin{:});
            attempts_per_edge = get_from_varargin(5, 'AttemptsPerEdge', varargin{:});
            number_of_weights = get_from_varargin(1, 'NumberOfWeights', varargin{:});
            
            % Measurements for the group
            measurement_group = analysis.getMeasurement(measure_code, group, varargin{:});
            value_group = measurement_group.getMeasureValue();
            parameter_value_group = measurement_group.getMeasureParameterValues();
            
            g = analysis.get_graph_for_subjects(group.getSubjects(), varargin{:});
            
            % Randomization
            all_randomizations = cell(1, M);
            all_differences = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                g_random = g.randomize('AttemptsPerEdge', attempts_per_edge, 'NumberOfWeights', number_of_weights);
                measure_random = g_random.getMeasure(measure_code);
                value_randomization = measure_random.getValue();
                
                all_randomizations(1, i) = measure_random.getValue();
                all_differences(1, i) = {value_group{1} - value_randomization{1}};
                
                if interruptible
                    pause(interruptible)
                end
            end
            
            % TODO rewrite following code more elegantly
            value_random = all_randomizations{1};
            for i = 2:1:M
                value_random = value_random + all_randomizations{i};
            end
            value_random = {value_random / M};
            
            difference = {value_group{1} - value_random{1}};
            
            % Statistical analysis
            p1 = pvalue1(difference, all_differences);  % singe tail,
            p2 = pvalue2(difference, all_differences);  % double tail
            
            % TODO: update with new version of quantiles once available (if needed)
            % ci_lower = quantiles(difference_all_permutations, 40, {2, 40});
            qtl = quantiles(all_differences, 40);
            ci_lower = {cellfun(@(x) x(2), qtl)};
            ci_upper = {cellfun(@(x) x(40), qtl)};
            
            randomcomparison = RandomComparison.getRandomComparison(analysis.getRandomComparisonClass(), ...
                analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
                '', ...  % random comparison label
                '', ...  % random comparison notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group, ...
                'RandomComparisonST.RandomizationNumber', M, ...
                'RandomComparisonST.AttemptsPerEdge', attempts_per_edge, ...
                'RandomComparisonST.NumberOfWeights', number_of_weights, ...
                'RandomComparisonST.value_group', value_group, ...
                'RandomComparisonST.value_random', value_random, ...
                'RandomComparisonST.difference', difference, ...
                'RandomComparisonST.all_differences', all_differences, ...
                'RandomComparisonST.p1', p1, ...
                'RandomComparisonST.p2', p2, ....
                'RandomComparisonST.confidence_min', ci_lower, ...
                'RandomComparisonST.confidence_max', ci_upper, ...
                'RandomComparisonST.ParameterValues', parameter_value_group, ...
                varargin{:} ...
                );
        end
        function comparison = calculate_comparison(analysis, measure_code, group_1, group_2, varargin)
            % CALCULATE_COMPARISON returns a comparison
            %
            % COMPARISON = CALCULATE_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP_1 subject and GROUP_2 data. It will compare the measures
            % obtained and will return a comparison. The function
            % will utilize default settings.
            %
            % COMPARISON = CALCULATE_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP_1 subject and GROUP_2 data. It will compare the measures
            % obtained and will return a comparison. The function
            % will utilize VALUE settings.
            % Available POPERTIES are:
            %  Verbose             - true to display info about the
            %                        randomization cycle, false by default
            %  Interruptible       - true if randomization cycle can be
            %                        interreput, false by default
            %  Longitudinal        - checks if the permutation is longitudinal
            %
            % See also calculate_random_comparison, calculate_measurement.
            
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            
            is_longitudinal = analysis.getSettings('AnalysisST.Longitudinal');
            M = get_from_varargin(1e+3, 'PermutationNumber', varargin{:});
            
            % Measurements for groups 1 and 2, and their difference
            measurement_1 = analysis.getMeasurement(measure_code, group_1, varargin{:});
            value_1 = measurement_1.getMeasureValue();
            
            measurement_2 = analysis.getMeasurement(measure_code, group_2, varargin{:});
            value_2 = measurement_2.getMeasureValue();
            
            difference_mean = cellfun(@(x, y) y - x, value_2, value_1, 'UniformOutput', false);
            
            subjects_1 = group_1.getSubjects();
            subjects_2 = group_2.getSubjects();
            
            % Permutations
            all_permutations_1 = cell(1, M);
            all_permutations_2 = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                [permutation_subjects_1, permutation_subjects_2] = permutation(subjects_1, subjects_2, is_longitudinal);
                
                graph_permutated_1 = analysis.get_graph_for_subjects(permutation_subjects_1, varargin{:});
                measure_permutated_1 = Measure.getMeasure(measure_code, graph_permutated_1, varargin{:});
                measure_permutated_value_1 = measure_permutated_1.getValue();
                
                graph_permutated_2 = analysis.get_graph_for_subjects(permutation_subjects_2, varargin{:});
                measure_permutated_2 = Measure.getMeasure(measure_code, graph_permutated_2, varargin{:});
                measure_permutated_value_2 = measure_permutated_2.getValue();
                
                all_permutations_1(1, i) = measure_permutated_value_1;
                all_permutations_2(1, i) = measure_permutated_value_2;
                
                if interruptible
                    pause(interruptible)
                end
            end
            
            difference_all_permutations = cellfun(@(x, y) y - x, all_permutations_1, all_permutations_2, 'UniformOutput', false);
            
            % Statistical analysis
            p1 = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
            p2 = pvalue2(difference_mean, difference_all_permutations);  % double tail
            
            % TODO: update with new version of quantiles once available (if needed)
            % ci_lower = quantiles(difference_all_permutations, 40, {2, 40});
            qtl = quantiles(difference_all_permutations, 40);
            ci_lower = {cellfun(@(x) x(2), qtl)};
            ci_upper = {cellfun(@(x) x(40), qtl)};
            
            comparison = Comparison.getComparison(analysis.getComparisonClass(), ...
                analysis.getComparisonID(measure_code, group_1, group_2, varargin{:}), ...
                '', ...  % comparison label
                '', ...  % comparison notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group_1, ...
                group_2, ...
                'ComparisonST.PermutationNumber', M, ...
                'ComparisonST.value_1', value_1, ...
                'ComparisonST.value_2', value_2, ...
                'ComparisonST.difference', difference_mean, ...
                'ComparisonST.all_differences', difference_all_permutations, ...
                'ComparisonST.p1', p1, ...
                'ComparisonST.p2', p2, ...
                'ComparisonST.confidence_min', ci_lower, ...
                'ComparisonST.confidence_max', ci_upper, ...
                varargin{:} ...
                );
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of structural analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisST_WU.
            %
            % See also getList, getName, getDescription.
            
            analysis_class = 'AnalysisST_WU';
        end
        function name = getName()
            % GETNAME returns the name of structural analysis
            %
            % NAME = GETNAME() returns the name of ANALYSIS.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Structural WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisST_WU.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis based on structural data using weighted graphs, ' ...
                'e.g. cortical thickness for each brain region. ' ...
                'It provides a single graph for each subject group. ' ...
                'Structural data can be for example MRI or PET data.' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the compatible type of graph
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns the compatible type of
            % graph 'GraphWU'.
            %
            % See also getSubjectClass.
            
            graph_type = 'GraphWU';
        end
        function subject_class = getSubjectClass()
            % GETSUBJETCLASS returns the class of structural analysis subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of AnalysisST_WU subject, 'SubjectST'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectST';
        end
        function measurement_class = getMeasurementClass()
            % GETMEASUREMENTCLASS returns the class of structural analysis measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS() returns the
            % class of AnalysisST_WU measurement, 'MeasurementST_WU'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementST_WU';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of structural analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisST_WU randomcomparison,
            % 'RandomComparisonST_WU'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonST_WU';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of structural analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisST_WU comparison, 'ComparisonST_WU'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonST_WU';
        end
        function available_settings = getAvailableSettings(m) %#ok<INUSD>
            % GETAVAILABLESETTINGS returns the available settings of structural analysis
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(M) returns the
            % available settings of AnalysisST_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {
                {'AnalysisST.CorrelationRule', BRAPH2.STRING, 'pearson', Correlation.CORRELATION_RULE_LIST}, ...
                {'AnalysisST.NegativeWeightRule', BRAPH2.STRING, 'zero', Correlation.NEGATIVE_WEIGHT_RULE_LIST}, ...
                {'AnalysisST.Longitudinal', BRAPH2.LOGICAL, false, {false, true}} ...
                };
        end
    end
    methods  % Plot panel functions
        function graph_panel = getGraphPanel(analysis, varargin)
            % GETGRAPHPANEL creates a matrix uipanel
            %
            % GRAPH_PANEL = GETGRAPHPANEL(ANALYSIS, PROPERTY, RULE, ...)
            % creates a uipanel with group selection uicontrol, weighted
            % plot uicontrol, density uicontorol, and threshold uicontrol.
            %
            % See also getClass, getSubjectClass, getGraphType.
            
            ui_parent = get_from_varargin([], 'UIParent', varargin{:});
            ui_parent_axes = get_from_varargin([], 'UIParentAxes', varargin{:});
            
            % get groups labels
            groups = analysis.getCohort().getGroups().getValues();
            if ~isempty(groups)
                groups_labels = analysis.getCohort().getGroups().getKeys();
            else
                groups_labels = 'No groups';
            end
            
            selected_group = 1;
            matrix_plot = [];
            
            cla(ui_parent_axes)
            axes(ui_parent_axes)
            
            %  create the options     ****************
            % groups popup
            ui_matrix_groups_popup = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'popup');
            set(ui_matrix_groups_popup, 'Position', [.70 .88 .28 .05])
            set(ui_matrix_groups_popup, 'TooltipString', 'Select Group')
            set(ui_matrix_groups_popup, 'String', groups_labels)
            set(ui_matrix_groups_popup, 'Callback', {@cb_group_popup})
            
            % weighted
            ui_matrix_weighted_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_weighted_checkbox, 'Position', [.70 .82 .28 .05])
            set(ui_matrix_weighted_checkbox, 'String', 'weighted correlation matrix')
            set(ui_matrix_weighted_checkbox, 'Value', true)
            set(ui_matrix_weighted_checkbox, 'TooltipString', 'Select weighted matrix')
            set(ui_matrix_weighted_checkbox, 'FontWeight', 'bold')
            set(ui_matrix_weighted_checkbox, 'Callback', {@cb_matrix_weighted_checkbox})
            
            % density
            ui_matrix_density_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_density_checkbox, 'Position', [.70 .70 .28 .05])
            set(ui_matrix_density_checkbox, 'String', 'binary correlation matrix (set density)')
            set(ui_matrix_density_checkbox, 'Value', false)
            set(ui_matrix_density_checkbox, 'TooltipString', 'Select binary correlation matrix with a set density')
            set(ui_matrix_density_checkbox, 'Callback', {@cb_matrix_density_checkbox})
            
            ui_matrix_density_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
            set(ui_matrix_density_edit, 'Position', [.70 .675 .05 .025])
            set(ui_matrix_density_edit, 'String', '50.00');
            set(ui_matrix_density_edit, 'TooltipString', 'Set density.');
            set(ui_matrix_density_edit, 'FontWeight', 'bold')
            set(ui_matrix_density_edit, 'Enable', 'off')
            set(ui_matrix_density_edit, 'Callback', {@cb_matrix_density_edit});
            
            ui_matrix_density_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
            set(ui_matrix_density_slider, 'Position', [.75 .675 .23 .025])
            set(ui_matrix_density_slider, 'Min', 0, 'Max', 100, 'Value', 50)
            set(ui_matrix_density_slider, 'TooltipString', 'Set density.')
            set(ui_matrix_density_slider, 'Enable', 'off')
            set(ui_matrix_density_slider, 'Callback', {@cb_matrix_density_slider})
            
            % threshold
            ui_matrix_threshold_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_threshold_checkbox, 'Position', [.70 .60 .28 .05])
            set(ui_matrix_threshold_checkbox, 'String', 'binary correlation matrix (set threshold)')
            set(ui_matrix_threshold_checkbox, 'Value', false)
            set(ui_matrix_threshold_checkbox, 'TooltipString', 'Select binary correlation matrix with a set threshold')
            set(ui_matrix_threshold_checkbox, 'Callback', {@cb_matrix_threshold_checkbox})
            
            ui_matrix_threshold_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
            set(ui_matrix_threshold_edit, 'Position', [.70 .575 .05 .025])
            set(ui_matrix_threshold_edit, 'String', '0.50');
            set(ui_matrix_threshold_edit, 'TooltipString', 'Set threshold.');
            set(ui_matrix_threshold_edit, 'FontWeight', 'bold')
            set(ui_matrix_threshold_edit, 'Enable', 'off')
            set(ui_matrix_threshold_edit, 'Callback', {@cb_matrix_threshold_edit});
            
            ui_matrix_threshold_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
            set(ui_matrix_threshold_slider, 'Position', [.75 .575 .23 .025])
            set(ui_matrix_threshold_slider, 'Min', -1, 'Max', 1, 'Value', .50)
            set(ui_matrix_threshold_slider, 'TooltipString', 'Set threshold.')
            set(ui_matrix_threshold_slider, 'Enable', 'off')
            set(ui_matrix_threshold_slider, 'Callback', {@cb_matrix_threshold_slider})
            
            % histogram
            ui_matrix_histogram_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_histogram_checkbox, 'Position', [.70 .76 .28 .05])
            set(ui_matrix_histogram_checkbox, 'String', 'histogram')
            set(ui_matrix_histogram_checkbox, 'Value', false)
            set(ui_matrix_histogram_checkbox, 'TooltipString', 'Select histogram of correlation coefficients')
            set(ui_matrix_histogram_checkbox, 'Callback', {@cb_matrix_histogram_checkbox})
            
            function cb_group_popup(~, ~)
                selected_group = get(ui_matrix_groups_popup, 'value');
                update_matrix();
            end
            function cb_matrix_weighted_checkbox(~, ~)
                set(ui_matrix_weighted_checkbox, 'Value', true)
                set(ui_matrix_weighted_checkbox, 'FontWeight', 'bold')
                
                set(ui_matrix_histogram_checkbox, 'Value', false)
                set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_density_checkbox, 'Value', false)
                set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_density_edit, 'Enable', 'off')
                set(ui_matrix_density_slider, 'Enable', 'off')
                
                set(ui_matrix_threshold_checkbox, 'Value', false)
                set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_threshold_edit, 'Enable', 'off')
                set(ui_matrix_threshold_slider, 'Enable', 'off')
                
                update_matrix()
            end
            function cb_matrix_density_checkbox(~, ~)
                set(ui_matrix_weighted_checkbox, 'Value', false)
                set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_histogram_checkbox, 'Value', false)
                set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_density_checkbox, 'Value', true)
                set(ui_matrix_density_checkbox, 'FontWeight', 'bold')
                set(ui_matrix_density_edit, 'Enable', 'on')
                set(ui_matrix_density_slider, 'Enable', 'on')
                
                set(ui_matrix_threshold_checkbox, 'Value', false)
                set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_threshold_edit, 'Enable', 'off')
                set(ui_matrix_threshold_slider, 'Enable', 'off')
                
                update_matrix()
            end
            function cb_matrix_threshold_checkbox(~, ~)
                set(ui_matrix_weighted_checkbox, 'Value', false)
                set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_histogram_checkbox, 'Value', false)
                set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_density_checkbox, 'Value', false)
                set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_density_edit, 'Enable', 'off')
                set(ui_matrix_density_slider, 'Enable', 'off')
                
                set(ui_matrix_threshold_checkbox, 'Value', true)
                set(ui_matrix_threshold_checkbox, 'FontWeight', 'bold')
                set(ui_matrix_threshold_edit, 'Enable', 'on')
                set(ui_matrix_threshold_slider, 'Enable', 'on')
                
                update_matrix()
            end
            function cb_matrix_histogram_checkbox(~, ~)
                set(ui_matrix_weighted_checkbox, 'Value', false)
                set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_histogram_checkbox, 'Value', true)
                set(ui_matrix_histogram_checkbox, 'FontWeight', 'bold')
                
                set(ui_matrix_density_checkbox, 'Value', false)
                set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_density_edit, 'Enable', 'off')
                set(ui_matrix_density_slider, 'Enable', 'off')
                
                set(ui_matrix_threshold_checkbox, 'Value', false)
                set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_threshold_edit, 'Enable', 'off')
                set(ui_matrix_threshold_slider, 'Enable', 'off')
                
                update_matrix()
            end
            function cb_matrix_density_edit(~, ~)
                update_matrix();
            end
            function cb_matrix_density_slider(src, ~)
                set(ui_matrix_density_edit, 'String', get(src, 'Value'))
                update_matrix();
            end
            function cb_matrix_threshold_edit(~, ~)
                update_matrix();
            end
            function cb_matrix_threshold_slider(src, ~)
                set(ui_matrix_threshold_edit, 'String', get(src, 'Value'))
                update_matrix();
            end
            function update_matrix()
                % i need to ask graph to return the plot 'Graph.PlotType'
                if  get(ui_matrix_histogram_checkbox, 'Value') % histogram
                    graph_type_value = 'histogram';
                elseif get(ui_matrix_threshold_checkbox, 'Value')  % threshold
                    graph_type_value = 'binary';
                    graph_rule = 'threshold';
                    graph_rule_value = str2double(get(ui_matrix_threshold_edit, 'String'));
                elseif get(ui_matrix_density_checkbox, 'Value')  % density
                    graph_type_value = 'binary';
                    graph_rule = 'density';
                    graph_rule_value = str2double(get(ui_matrix_density_edit, 'String'));
                else  % weighted correlation
                    graph_type_value = 'correlation';
                    graph_rule = 'nothing';
                    graph_rule_value = 0;
                end
                
                if ~isempty(groups)
                    cla(ui_parent_axes)
                    axes(ui_parent_axes)
                    % get A
                    group = analysis.getCohort().getGroups().getValue(selected_group);
                    subjects = group.getSubjects();
                    A = analysis.get_weighted_correlation_matrix(subjects, varargin{:});
                    
                    if get(ui_matrix_histogram_checkbox, 'Value')
                        matrix_plot = Graph.hist(A, varargin{:});
                    else
                        % get atlas labels
                        atlases = analysis.getCohort().getBrainAtlases();
                        atlas = atlases{1};
                        br_labels = atlas.getBrainRegions().getKeys();
                        matrix_plot = GraphWU.plot(A, ...
                            graph_rule, graph_rule_value, ...
                            'Graph.PlotType', graph_type_value, ...
                            'xlabels', br_labels, ...
                            'ylabels', br_labels, ...
                            varargin{:});
                    end
                end
            end
            
            update_matrix()
            
            if nargout > 0
                graph_panel = matrix_plot;
            end
        end
        function global_panel = getGlobalPanel(analysis, varargin)
            % GETGLOBALPANEL creates the global uipanel for GUIAnalysis
            %
            % GLOBAL_PANEL = GETGLOBALPANEL(ANALYSIS, PROPERTY, VALUE, ...)
            % creates a uipanel that contains information about global
            % measures in Measurement, RandomComparison and Comparison.
            %
            % See also getGraphPanel, getMainPanelMeasurePlot.
            
            uiparent = get_from_varargin([], 'UIParent', varargin{:});
            
            % declare constans
            SELECTALL_MEAS_CMD = GUI.SELECTALL_CMD;
            SELECTALL_MEAS_TP = 'Select all measures';
            
            CLEARSELECTION_MEAS_CMD = GUI.CLEARSELECTION_CMD;
            CLEARSELECTION_MEAS_TP = 'Clear measure selection';
            
            REMOVE_MEAS_CMD = GUI.REMOVE_CMD;
            REMOVE_MEAS_TP = 'Remove selected measures';
            
            % get global measures list
            mlist = Graph.getCompatibleMeasureList(analysis.getGraphType());
            for mi = 1:1:length(mlist)
                if Measure.is_global(mlist{mi})
                    g_list{mi} = mlist{mi}; %#ok<AGROW>
                end
            end
            global_list = g_list(~cellfun(@isempty, g_list));
            
            % declare variables
            selected_brainmeasures = [];
            
            % declare the uicontrols
            ui_mainpanel = uipanel('Parent', uiparent, 'Units', 'normalized', 'Position', [0 0 1 1]);
            ui_global_tbl = uitable(ui_mainpanel);
            ui_button_brainmeasures_selectall = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_button_brainmeasures_clearselection = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_button_brainmeasures_remove = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_checkbox_brainmeasures_meas = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_checkbox_brainmeasures_comp = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_checkbox_brainmeasures_rand = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_listbox_brainmeasures_comp_groups = uicontrol(ui_mainpanel, 'Style', 'listbox');
            ui_popup_globalmeasures_group1 = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_popup_globalmeasures_group2 = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_plot_measure_panel = uipanel('Parent', ui_mainpanel);
            ui_plot_measure_axes = get_from_varargin([], 'UIAxesGlobal', varargin{:});
            ui_plot_hide_checkbox = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_selectedmeasure_popup = uicontrol(ui_mainpanel, 'Style', 'popup');
            init_global_panel()
            function init_global_panel()
                GUI.setUnits(ui_mainpanel)
                
                set(ui_global_tbl, 'BackgroundColor', GUI.TABBKGCOLOR)
                if isequal(analysis.getMeasurementClass(), 'MeasurementST_WU')
                    set(ui_global_tbl, 'Position', [.02 .19 .96 .79])
                    GUI.setUnits(ui_plot_measure_panel)
                    GUI.setBackgroundColor(ui_plot_measure_panel)
                    
                    set(ui_plot_measure_panel, 'Position', [.0 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Parent', ui_plot_measure_panel)
                    set(ui_plot_measure_axes, 'Position', [.00 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Visible', 'off')
                else
                    set(ui_global_tbl, 'Position', [.02 .19 .4 .79])
                    GUI.setUnits(ui_plot_measure_panel)
                    GUI.setBackgroundColor(ui_plot_measure_panel)
                    set(ui_plot_measure_panel, 'Position', [.42 .00 .58 .98])
                    
                    set(ui_plot_measure_axes, 'Parent', ui_plot_measure_panel)
                    set(ui_plot_measure_axes, 'Position', [.1 .2 .8 .79])
                end
                set(ui_global_tbl, 'CellEditCallback', {@cb_global_table_edit})
                
                set(ui_global_tbl, 'Units', 'normalized')
                set(ui_button_brainmeasures_selectall, 'Position', [.19 .14 .10 .03])
                set(ui_button_brainmeasures_selectall, 'String', SELECTALL_MEAS_CMD)
                set(ui_button_brainmeasures_selectall, 'TooltipString', SELECTALL_MEAS_TP)
                set(ui_button_brainmeasures_selectall, 'Callback', {@cb_global_selectall})
                
                set(ui_button_brainmeasures_clearselection, 'Position', [.19 .10 .10 .03])
                set(ui_button_brainmeasures_clearselection, 'String', CLEARSELECTION_MEAS_CMD)
                set(ui_button_brainmeasures_clearselection, 'TooltipString', CLEARSELECTION_MEAS_TP)
                set(ui_button_brainmeasures_clearselection, 'Callback', {@cb_global_clearselection})
                
                set(ui_button_brainmeasures_remove, 'Position', [.19 .06 .10 .03])
                set(ui_button_brainmeasures_remove, 'String', REMOVE_MEAS_CMD)
                set(ui_button_brainmeasures_remove, 'TooltipString', REMOVE_MEAS_TP)
                set(ui_button_brainmeasures_remove, 'Callback', {@cb_global_remove})
                
                set(ui_checkbox_brainmeasures_meas, 'Position', [.3 .14 .10 .03])
                set(ui_checkbox_brainmeasures_meas, 'String', 'measure')
                set(ui_checkbox_brainmeasures_meas, 'Value', true)
                set(ui_checkbox_brainmeasures_meas, 'TooltipString', 'Select measure')
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_meas, 'Callback', {@cb_global_meas})
                
                set(ui_checkbox_brainmeasures_comp, 'Position',[.3 .10 .10 .03])
                set(ui_checkbox_brainmeasures_comp, 'String', 'comparison')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'TooltipString', 'Select comparison')
                set(ui_checkbox_brainmeasures_comp, 'Callback', {@cb_global_comp})
                
                set(ui_checkbox_brainmeasures_rand, 'Position', [.3 .06 .15 .03])
                set(ui_checkbox_brainmeasures_rand, 'String', 'random comparison')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'TooltipString', 'Select random comparison')
                set(ui_checkbox_brainmeasures_rand, 'Callback', {@cb_global_rand})
                
                set(ui_popup_globalmeasures_group1, 'Position', [.02 .11 .15 .05])
                set(ui_popup_globalmeasures_group1, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_globalmeasures_group1, 'Callback', {@cb_global_table})
                set(ui_popup_globalmeasures_group1, 'Enable', 'off')
                set(ui_popup_globalmeasures_group1, 'Visible', 'off')
                
                set(ui_popup_globalmeasures_group2, 'Position', [.02 .06 .15 .05])
                set(ui_popup_globalmeasures_group2, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_globalmeasures_group2, 'Callback', {@cb_global_table})
                set(ui_popup_globalmeasures_group2, 'Enable', 'off')
                set(ui_popup_globalmeasures_group2, 'Visible', 'off')
                
                set(ui_listbox_brainmeasures_comp_groups, 'Position',[.02 .07 .15 .1])
                set(ui_listbox_brainmeasures_comp_groups, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_listbox_brainmeasures_comp_groups, 'TooltipString', 'Select group 1');
                set(ui_listbox_brainmeasures_comp_groups, 'Callback', {@cb_global_table})
                
                set(ui_plot_hide_checkbox, 'Position', [.3 .02 .10 .03])
                set(ui_plot_hide_checkbox, 'String', 'Show Plot')
                set(ui_plot_hide_checkbox, 'Value', true)
                set(ui_plot_hide_checkbox, 'TooltipString', 'Show/Hide Plot')
                set(ui_plot_hide_checkbox, 'Callback', {@cb_show_plot})
                
                set(ui_selectedmeasure_popup, 'Position', [.02 .01 .15 .05])
                set(ui_selectedmeasure_popup, 'String', global_list)
                set(ui_selectedmeasure_popup, 'Callback', {@cb_global_table})
                
            end
            function update_global_table()
                data = {}; %#ok<NASGU>
                RowName = [];
                
                selected_index = get(ui_listbox_brainmeasures_comp_groups, 'Value');
                group = analysis.getCohort().getGroups().getValue(selected_index);
                
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    for j = 1:1:analysis.getMeasurements().length()
                        measurement = analysis.getMeasurements().getValue(j);
                        if isa(group, 'cell') && ismember(measurement.getMeasureCode(), global_list)
                            for k =1:1:length(group)
                                g = group{k};
                                if isequal(measurement.getGroup(), g) && isequal(selected_measure, measurement.getMeasureCode())
                                    global_measurements{j} = measurement; %#ok<AGROW>
                                end
                            end
                        else
                            if ismember(measurement.getMeasureCode(), global_list) && isequal(measurement.getGroup(), group) && isequal(selected_measure, measurement.getMeasureCode())
                                global_measurements{j} = measurement;
                            end
                        end
                    end
                    
                    if exist('global_measurements', 'var')
                        global_measurements =  global_measurements(~cellfun(@isempty, global_measurements));
                        set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group', ' value ', ' name ', ' label ', ' notes '})
                        set(ui_global_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'char', 'char', 'char'})
                        set(ui_global_tbl, 'ColumnEditable', [true false false false false false false])
                        
                        data = cell(length(global_measurements), 7);
                        for i = 1:1:length(global_measurements)
                            measurement = global_measurements{i};
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            global_value = measurement.getMeasureValue();
                            data{i, 2} = measurement.getMeasureCode();
                            data{i, 3} = measurement.getGroup().getID();
                            data{i, 4} = global_value{1};
                            data{i, 5} = measurement.getID();
                            data{i, 6} = measurement.getLabel();
                            data{i, 7} = measurement.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_global_tbl, 'Data', data)
                        set(ui_global_tbl, 'RowName', RowName)
                    else
                        set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group', ' value ', ' name ', ' label ', ' notes '})
                        set(ui_global_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'char', 'char', 'char'})
                        set(ui_global_tbl, 'ColumnEditable', [true false false false false false false])
                        set(ui_global_tbl, 'Data', [])
                        set(ui_global_tbl, 'RowName', [])
                    end
                    
                elseif get(ui_checkbox_brainmeasures_comp, 'Value')
                    group1_index = get( ui_popup_globalmeasures_group1, 'Value');
                    group1 = analysis.getCohort().getGroups().getValue(group1_index);
                    group2_index = get( ui_popup_globalmeasures_group2, 'Value');
                    group2 = analysis.getCohort().getGroups().getValue(group2_index);
                    for j = 1:1:analysis.getComparisons().length()
                        comparison = analysis.getComparisons().getValue(j);
                        [a, b] = comparison.getGroups();                        
                        if ismember(comparison.getMeasureCode(), global_list) ...
                                && ((isequal(a, group1) && isequal (b, group2)) || (isequal(a, group2) && isequal (b, group1))) ...
                                && isequal(selected_measure, comparison.getMeasureCode())
                            global_comparison{j} = comparison; %#ok<AGROW>
                        end                        
                    end
                    
                    if exist('global_comparison', 'var')
                        global_comparison =  global_comparison(~cellfun(@isempty, global_comparison));
                        set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes '})
                        set(ui_global_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_global_tbl, 'ColumnEditable', [true false false false false false false false false])
                        
                        data = cell(length(global_comparison), 7);
                        for i = 1:1:length(global_comparison)
                            comparison = global_comparison{i};
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            [val_1, val_2]  = comparison.getGroupValues();
                            [group_1, group_2] = comparison.getGroups();
                            data{i, 2} = comparison.getMeasureCode();
                            data{i, 3} = group_1.getID();
                            data{i, 4} = group_2.getID();
                            data{i, 5} = val_1{1};
                            data{i, 6} = val_2{1};
                            data{i, 7} = comparison.getID();
                            data{i, 8} = comparison.getLabel();
                            data{i, 9} = comparison.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_global_tbl, 'Data', data)
                        set(ui_global_tbl, 'RowName', RowName)
                    else
                        set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes '})
                        set(ui_global_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_global_tbl, 'ColumnEditable', [true false false false false false false false false])
                        set(ui_global_tbl, 'Data', [])
                        set(ui_global_tbl, 'RowName', [])
                    end
                    
                elseif get(ui_checkbox_brainmeasures_rand, 'Value')
                    for j = 1:1:analysis.getRandomComparisons().length()
                        randomcomparison = analysis.getRandomComparisons().getValue(j);
                        if isa(group, 'cell') && ismember(randomcomparison.getMeasureCode(), global_list)
                            for k =1:1:length(group)
                                g = group{k};
                                if isequal(randomcomparison.getGroup(), g) && isequal(selected_measure, randomcomparison.getMeasureCode())
                                    global_randomcomparison{j} = randomcomparison; %#ok<AGROW>
                                end
                            end
                        else
                            if ismember(randomcomparison.getMeasureCode(), global_list) && isequal(randomcomparison.getGroup(), group) && isequal(selected_measure, randomcomparison.getMeasureCode())
                                global_randomcomparison{j} = randomcomparison;
                            end
                        end
                    end
                    
                    if exist('global_randomcomparison', 'var')
                        global_randomcomparison =  global_randomcomparison(~cellfun(@isempty, global_randomcomparison));
                        set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes '})
                        set(ui_global_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_global_tbl, 'ColumnEditable', [true false false false false false false false])
                        
                        data = cell(length(global_randomcomparison), 7);
                        for i = 1:1:length(global_randomcomparison)
                            randomcomparison = global_randomcomparison{i};
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            group_val =  randomcomparison.getGroupValue();
                            random_val = randomcomparison.getRandomValue();
                            data{i, 2} = randomcomparison.getMeasureCode();
                            data{i, 3} = randomcomparison.getGroup().getID();
                            data{i, 4} = group_val{1};
                            data{i, 5} = random_val{1};
                            data{i, 6} = randomcomparison.getID();
                            data{i, 7} = randomcomparison.getLabel();
                            data{i, 8} = randomcomparison.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_global_tbl, 'Data', data)
                        set(ui_global_tbl, 'RowName', RowName)
                    else
                        set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes '})
                        set(ui_global_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_global_tbl, 'ColumnEditable', [true false false false false false false false])
                        set(ui_global_tbl, 'Data', [])
                        set(ui_global_tbl, 'RowName', [])
                    end
                end
            end
            function update_popup_or_listbox()
                if get(ui_checkbox_brainmeasures_comp, 'Value')
                    set(ui_popup_globalmeasures_group1, 'Enable', 'on')
                    set(ui_popup_globalmeasures_group1, 'Visible', 'on')
                    
                    set(ui_popup_globalmeasures_group2, 'Enable', 'on')
                    set(ui_popup_globalmeasures_group2, 'Visible', 'on')
                    
                    set(ui_listbox_brainmeasures_comp_groups, 'Enable', 'off')
                    set(ui_listbox_brainmeasures_comp_groups, 'Visible', 'off')
                else
                    set(ui_listbox_brainmeasures_comp_groups, 'Enable', 'on')
                    set(ui_listbox_brainmeasures_comp_groups, 'Visible', 'on')
                    
                    set(ui_popup_globalmeasures_group1, 'Enable', 'off')
                    set(ui_popup_globalmeasures_group1, 'Visible', 'off')
                    
                    set(ui_popup_globalmeasures_group2, 'Enable', 'off')
                    set(ui_popup_globalmeasures_group2, 'Visible', 'off')
                end
            end
            function init_plot_measure_panel()
                cla(ui_plot_measure_axes)
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    analysis.getGlobalMeasurePlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_listbox_brainmeasures_comp_groups, 'Value')));
                elseif get(ui_checkbox_brainmeasures_comp, 'Value')
                    analysis.getGlobalComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_globalmeasures_group1, 'Value')), ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_globalmeasures_group2, 'Value')));
                elseif get(ui_checkbox_brainmeasures_rand, 'Value')
                    analysis.getGlobalRandomComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_listbox_brainmeasures_comp_groups, 'Value')));
                end
            end
            function cb_show_plot(~, ~)
                if isequal(get(ui_plot_hide_checkbox, 'Value'), 0)
                    set(ui_global_tbl, 'Position', [.02 .19 .96 .79])
                    
                    set(ui_plot_measure_panel, 'Position', [.0 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Position', [.00 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Visible', 'off')
                else
                    set(ui_global_tbl, 'Position', [.02 .19 .4 .79])
                    set(ui_plot_measure_panel, 'Position', [.42 .00 .58 .98])
                    
                    set(ui_plot_measure_axes, 'Position', [.1 .2 .8 .79])
                    set(ui_plot_measure_axes, 'Visible', 'on')
                end
            end
            function cb_global_table(~, ~)
                update_global_table()
                init_plot_measure_panel()
            end
            function cb_global_table_edit(~, event)  % (src,event)
                g = event.Indices(1);
                col = event.Indices(2);
                newdata = event.NewData;
                switch col
                    case 1
                        if newdata == 1
                            if ~ismember(g, selected_brainmeasures)
                                selected_brainmeasures = [selected_brainmeasures g];
                            end
                        else
                            selected_brainmeasures = selected_brainmeasures(selected_brainmeasures ~= g);
                        end
                end
                
                update_global_table();
            end
            function cb_global_meas(~, ~)  % (src,event)
                set(ui_checkbox_brainmeasures_meas, 'Value', true)
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'FontWeight', 'normal')
                set(ui_listbox_brainmeasures_comp_groups, 'Enable', 'on')
                
                update_global_table()
                update_popup_or_listbox()
                init_plot_measure_panel()
            end
            function cb_global_comp(~, ~)  % (src,event)
                set(ui_checkbox_brainmeasures_meas, 'Value', false)
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_comp, 'Value', true)
                set(ui_checkbox_brainmeasures_comp, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'FontWeight', 'normal')
                set(ui_listbox_brainmeasures_comp_groups, 'Enable', 'on')
                
                update_global_table()
                update_popup_or_listbox()
                init_plot_measure_panel()
            end
            function cb_global_rand(~, ~)  % (src,event)
                set(ui_checkbox_brainmeasures_meas, 'Value', false)
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_rand, 'Value', true)
                set(ui_checkbox_brainmeasures_rand, 'FontWeight', 'bold')
                set(ui_listbox_brainmeasures_comp_groups, 'Enable', 'on')
                
                update_global_table()
                update_popup_or_listbox()
                init_plot_measure_panel()
            end
            function cb_global_selectall(~, ~)  % (src,event)
                for j = 1:1:analysis.getMeasurements().length()
                    measurement = analysis.getMeasurements().getValue(j);
                    if ismember(measurement.getMeasureCode(), global_list)
                        global_measurements{j} = measurement;                             %#ok<AGROW>
                    end
                end
                
                for r = 1:1:length(global_measurements)
                    selected_brainmeasures = sort(unique([selected_brainmeasures(:); r]));
                end
                
                update_global_table()
            end
            function cb_global_clearselection(~,~)  % (src,event)
                selected_brainmeasures  = [];
                update_global_table()
            end
            function cb_global_remove(~, ~)
                for i = 1:1:length(selected_brainmeasures)
                    k = selected_brainmeasures(i);
                    analysis.getMeasurements().remove(k);
                end
                update_global_table()
            end
            
            update_global_table()
            init_plot_measure_panel()
            
            if nargout > 0
                global_panel = ui_mainpanel;
            end
        end
        function nodal_panel = getNodalPanel(analysis, varargin)
            % GETNODALPANEL creates the nodal uipanel for GUIAnalysis
            %
            % NODAL_PANEL = GETNODALPANEL(ANALYSIS, PROPERTY, VALUE, ...)
            % creates a uipanel that contains information about nodal
            % measures in Measurement, RandomComparison and Comparison.
            %
            % See also getGraphPanel, getMainPanelMeasurePlot, getGlobalPanel
            
            uiparent = get_from_varargin([], 'UIParent', varargin{:});
            
            % declare constans
            SELECTALL_MEAS_CMD = GUI.SELECTALL_CMD;
            SELECTALL_MEAS_TP = 'Select all measures';
            
            CLEARSELECTION_MEAS_CMD = GUI.CLEARSELECTION_CMD;
            CLEARSELECTION_MEAS_TP = 'Clear measure selection';
            
            REMOVE_MEAS_CMD = GUI.REMOVE_CMD;
            REMOVE_MEAS_TP = 'Remove selected measures';
            
            % get global measures list
            mlist = Graph.getCompatibleMeasureList(analysis.getGraphType());
            for mi = 1:1:length(mlist)
                if Measure.is_nodal(mlist{mi})
                    n_list{mi} = mlist{mi}; %#ok<AGROW>
                end
            end
            nodal_list = n_list(~cellfun(@isempty, n_list));
            
            % get brain regions list
            atlases = analysis.getCohort().getBrainAtlases();
            atlas = atlases{1};  % change when multiatlases
            br_list = atlas.getBrainRegions().getKeys();
            
            % declare variables
            selected_brainmeasures = [];
            
            % declare the uicontrols
            ui_mainpanel = uipanel('Parent', uiparent, 'Units', 'normalized', 'Position', [0 0 1 1]);
            ui_nodal_tbl = uitable(ui_mainpanel);
            ui_button_brainmeasures_selectall = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_button_brainmeasures_clearselection = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_button_brainmeasures_remove = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_checkbox_brainmeasures_meas = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_checkbox_brainmeasures_comp = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_checkbox_brainmeasures_rand = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_popup_nodalmeasures_group1 = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_popup_nodalmeasures_group2 = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_selectedmeasure_popup = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_selectedbr_popup = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_plot_measure_panel = uipanel('Parent', ui_mainpanel);
            ui_plot_measure_axes = get_from_varargin([], 'UIAxesNodal', varargin{:});
            ui_plot_hide_checkbox = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            init_nodal_panel()
            function init_nodal_panel()
                GUI.setUnits(ui_mainpanel)
                
                set(ui_nodal_tbl, 'BackgroundColor', GUI.TABBKGCOLOR)
                if isequal(analysis.getMeasurementClass(), 'MeasurementST_WU')
                    set(ui_nodal_tbl, 'Position', [.02 .21 .96 .77])
                    GUI.setUnits(ui_plot_measure_panel)
                    GUI.setBackgroundColor(ui_plot_measure_panel)
                    
                    set(ui_plot_measure_panel, 'Position', [.0 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Parent', ui_plot_measure_panel)
                    set(ui_plot_measure_axes, 'Position', [.00 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Visible', 'off')
                else
                    set(ui_nodal_tbl, 'Position', [.02 .21 .4 .77])
                    GUI.setUnits(ui_plot_measure_panel)
                    GUI.setBackgroundColor(ui_plot_measure_panel)
                    set(ui_plot_measure_panel, 'Position', [.42 .00 .58 .98])
                    
                    set(ui_plot_measure_axes, 'Parent', ui_plot_measure_panel)
                    set(ui_plot_measure_axes, 'Position', [.1 .2 .8 .79])
                end
                set(ui_nodal_tbl, 'CellEditCallback', {@cb_nodal_table_edit})
                
                set(ui_nodal_tbl, 'Units', 'normalized')
                set(ui_button_brainmeasures_selectall, 'Position', [.19 .16 .10 .04])
                set(ui_button_brainmeasures_selectall, 'String', SELECTALL_MEAS_CMD)
                set(ui_button_brainmeasures_selectall, 'TooltipString', SELECTALL_MEAS_TP)
                set(ui_button_brainmeasures_selectall, 'Callback', {@cb_nodal_selectall})
                
                set(ui_button_brainmeasures_clearselection, 'Position', [.19 .11 .10 .04])
                set(ui_button_brainmeasures_clearselection, 'String', CLEARSELECTION_MEAS_CMD)
                set(ui_button_brainmeasures_clearselection, 'TooltipString', CLEARSELECTION_MEAS_TP)
                set(ui_button_brainmeasures_clearselection, 'Callback', {@cb_nodal_clearselection})
                
                set(ui_button_brainmeasures_remove, 'Position', [.19 .06 .10 .04])
                set(ui_button_brainmeasures_remove, 'String', REMOVE_MEAS_CMD)
                set(ui_button_brainmeasures_remove, 'TooltipString', REMOVE_MEAS_TP)
                set(ui_button_brainmeasures_remove, 'Callback', {@cb_nodal_remove})
                
                set(ui_checkbox_brainmeasures_meas, 'Position', [.3 .16 .10 .04])
                set(ui_checkbox_brainmeasures_meas, 'String', 'measure')
                set(ui_checkbox_brainmeasures_meas, 'Value', true)
                set(ui_checkbox_brainmeasures_meas, 'TooltipString', 'Select measure')
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_meas, 'Callback', {@cb_nodal_meas})
                
                set(ui_checkbox_brainmeasures_comp, 'Position',[.3 .11 .10 .04])
                set(ui_checkbox_brainmeasures_comp, 'String', 'comparison')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'TooltipString', 'Select comparison')
                set(ui_checkbox_brainmeasures_comp, 'Callback', {@cb_nodal_comp})
                
                set(ui_checkbox_brainmeasures_rand, 'Position', [.3 .06 .15 .04])
                set(ui_checkbox_brainmeasures_rand, 'String', 'random comparison')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'TooltipString', 'Select random comparison')
                set(ui_checkbox_brainmeasures_rand, 'Callback', {@cb_nodal_rand})
                
                set(ui_plot_hide_checkbox, 'Position', [.3 .01 .10 .04])
                set(ui_plot_hide_checkbox, 'String', 'Show Plot')
                set(ui_plot_hide_checkbox, 'Value', true)
                set(ui_plot_hide_checkbox, 'TooltipString', 'Show/Hide Plot')
                set(ui_plot_hide_checkbox, 'Callback', {@cb_show_plot})
                
                set(ui_popup_nodalmeasures_group1, 'Position', [.02 .16 .15 .04])
                set(ui_popup_nodalmeasures_group1, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_nodalmeasures_group1, 'Callback', {@cb_nodal_table})
                
                set(ui_popup_nodalmeasures_group2, 'Position', [.02 .11 .15 .04])
                set(ui_popup_nodalmeasures_group2, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_nodalmeasures_group2, 'Callback', {@cb_nodal_table})
                set(ui_popup_nodalmeasures_group2, 'Enable', 'off')
                set(ui_popup_nodalmeasures_group2, 'Visible', 'off')
                
                set(ui_selectedmeasure_popup, 'Position', [.02 .06 .15 .04])
                set(ui_selectedmeasure_popup, 'String', nodal_list)
                set(ui_selectedmeasure_popup, 'Callback', {@cb_nodal_table})
                
                set(ui_selectedbr_popup, 'Position', [.02 .01 .15 .04])
                set(ui_selectedbr_popup, 'String', br_list)
                set(ui_selectedbr_popup, 'Callback', {@cb_nodal_table})
                
            end
            function update_nodal_table()
                data = {}; %#ok<NASGU>
                RowName = [];
                
                selected_index_1 = get(ui_popup_nodalmeasures_group1, 'Value');
                group_1 = analysis.getCohort().getGroups().getValue(selected_index_1);
                
                selected_index_2 = get(ui_popup_nodalmeasures_group1, 'Value');
                group_2 = analysis.getCohort().getGroups().getValue(selected_index_2);
                
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                
                selected_br = get(ui_selectedbr_popup, 'Value');
                
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    for j = 1:1:analysis.getMeasurements().length()
                        measurement = analysis.getMeasurements().getValue(j);
                        if ismember(measurement.getMeasureCode(), nodal_list) && isequal(measurement.getGroup(), group_1) && isequal(selected_measure, measurement.getMeasureCode())
                            nodal_measurements{j} = measurement; %#ok<AGROW>
                        end
                    end
                    
                    if exist('nodal_measurements', 'var')
                        nodal_measurements =  nodal_measurements(~cellfun(@isempty, nodal_measurements));
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group', ' value ', ' name ', ' label ', ' notes '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false])
                        
                        data = cell(length(nodal_measurements), 7);
                        for i = 1:1:length(nodal_measurements)
                            measurement = nodal_measurements{i};
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            nodal_values_cell = measurement.getMeasureValue();
                            nodal_values = nodal_values_cell{1};
                            selected_nodal_value = nodal_values(selected_br);
                            data{i, 2} = measurement.getMeasureCode();
                            data{i, 3} = measurement.getGroup().getID();
                            data{i, 4} = selected_nodal_value;
                            data{i, 5} = measurement.getID();
                            data{i, 6} = measurement.getLabel();
                            data{i, 7} = measurement.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_nodal_tbl, 'Data', data)
                        set(ui_nodal_tbl, 'RowName', RowName)
                    else
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group', ' value ', ' name ', ' label ', ' notes '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false])
                        set(ui_nodal_tbl, 'Data', [])
                        set(ui_nodal_tbl, 'RowName', [])
                    end
                    
                elseif get(ui_checkbox_brainmeasures_comp, 'Value')
                    for j = 1:1:analysis.getComparisons().length()
                        comparison = analysis.getComparisons().getValue(j);
                        [a, b] = comparison.getGroups();
                        if ismember(comparison.getMeasureCode(), nodal_list) && ((isequal(a, group1) && isequal (b, group2)) || (isequal(a, group2) && isequal (b, group1))) && isequal(selected_measure, comparison.getMeasureCode())
                            nodal_comparison{j} = comparison; %#ok<AGROW>
                        end
                    end
                    
                    if exist('nodal_comparison', 'var')
                        nodal_comparison =  nodal_comparison(~cellfun(@isempty, nodal_comparison));
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false false false])
                        
                        data = cell(length(nodal_comparison), 7);
                        for i = 1:1:length(nodal_comparison)
                            comparison = nodal_comparison{i};
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            [val_1, val_2]  = comparison.getGroupValues();
                            [group_1, group_2] = comparison.getGroups();
                            nodal_values_1 = val_1{1};
                            nodal_values_2 = val_2{1};
                            data{i, 2} = comparison.getMeasureCode();
                            data{i, 3} = group_1.getID();
                            data{i, 4} = group_2.getID();
                            data{i, 5} = nodal_values_1(selected_br);
                            data{i, 6} = nodal_values_2(selected_br);
                            data{i, 7} = comparison.getID();
                            data{i, 8} = comparison.getLabel();
                            data{i, 9} = comparison.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_nodal_tbl, 'Data', data)
                        set(ui_nodal_tbl, 'RowName', RowName)
                    else
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false false false])
                        set(ui_nodal_tbl, 'Data', [])
                        set(ui_nodal_tbl, 'RowName', [])
                    end
                    
                elseif get(ui_checkbox_brainmeasures_rand, 'Value')
                    for j = 1:1:analysis.getRandomComparisons().length()
                        randomcomparison = analysis.getRandomComparisons().getValue(j);
                        if ismember(randomcomparison.getMeasureCode(), nodal_list) && isequal(randomcomparison.getGroup(), group_1) && isequal(selected_measure, randomcomparison.getMeasureCode())
                            nodal_randomcomparison{j} = randomcomparison; %#ok<AGROW>
                        end
                    end
                    
                    if exist('nodal_randomcomparison', 'var')
                        nodal_randomcomparison =  nodal_randomcomparison(~cellfun(@isempty, nodal_randomcomparison));
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false false])
                        
                        data = cell(length(nodal_randomcomparison), 7);
                        for i = 1:1:length(nodal_randomcomparison)
                            randomcomparison = nodal_randomcomparison{i};
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            group_val =  randomcomparison.getGroupValue();
                            random_val = randomcomparison.getRandomValue();
                            group_val_nodal = group_val{1};
                            random_val_nodal = random_val{1};
                            data{i, 2} = randomcomparison.getMeasureCode();
                            data{i, 3} = randomcomparison.getGroup().getID();
                            data{i, 4} = group_val_nodal(selected_br);
                            data{i, 5} = random_val_nodal(selected_br);
                            data{i, 6} = randomcomparison.getID();
                            data{i, 7} = randomcomparison.getLabel();
                            data{i, 8} = randomcomparison.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_nodal_tbl, 'Data', data)
                        set(ui_nodal_tbl, 'RowName', RowName)
                    else
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false false])
                        set(ui_nodal_tbl, 'Data', [])
                        set(ui_nodal_tbl, 'RowName', [])
                    end
                end
            end
            function update_group_popups()
                if get(ui_checkbox_brainmeasures_comp, 'Value')
                    set(ui_popup_nodalmeasures_group1, 'Enable', 'on')
                    set(ui_popup_nodalmeasures_group1, 'Visible', 'on')
                    
                    set(ui_popup_nodalmeasures_group2, 'Enable', 'on')
                    set(ui_popup_nodalmeasures_group2, 'Visible', 'on')
                else
                    set(ui_popup_nodalmeasures_group1, 'Enable', 'on')
                    set(ui_popup_nodalmeasures_group1, 'Visible', 'on')
                    
                    set(ui_popup_nodalmeasures_group2, 'Enable', 'off')
                    set(ui_popup_nodalmeasures_group2, 'Visible', 'off')
                end
            end
            function init_plot_nodal_panel()
                cla(ui_plot_measure_axes)
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    analysis.getNodalMeasurePlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_nodalmeasures_group1, 'Value')), ...
                        get(ui_selectedbr_popup, 'Value'));
                elseif get(ui_checkbox_brainmeasures_comp, 'Value')
                    analysis.getNodalComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_nodalmeasures_group1, 'Value')), ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_nodalmeasures_group2, 'Value')), ...
                        get(ui_selectedbr_popup, 'Value'));
                elseif get(ui_checkbox_brainmeasures_rand, 'Value')
                    analysis.getNodalRandomComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_nodalmeasures_group1, 'Value')), ...
                        get(ui_selectedbr_popup, 'Value'));
                end
            end
            function cb_show_plot(~, ~)
                if isequal(get(ui_plot_hide_checkbox, 'Value'), 0)
                    set(ui_nodal_tbl, 'Position', [.02 .21 .96 .77])
                    
                    set(ui_plot_measure_panel, 'Position', [.0 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Position', [.00 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Visible', 'off')
                else
                    set(ui_nodal_tbl, 'Position', [.02 .21 .4 .77])
                    set(ui_plot_measure_panel, 'Position', [.42 .00 .58 .98])
                    
                    set(ui_plot_measure_axes, 'Position', [.1 .2 .8 .79])
                    set(ui_plot_measure_axes, 'Visible', 'on')
                end
            end
            function cb_nodal_table(~, ~)
                update_nodal_table()
                init_plot_nodal_panel()
            end
            function cb_nodal_table_edit(~, event)  % (src,event)
                g = event.Indices(1);
                col = event.Indices(2);
                newdata = event.NewData;
                switch col
                    case 1
                        if newdata == 1
                            if ~ismember(g, selected_brainmeasures)
                                selected_brainmeasures = [selected_brainmeasures g];
                            end
                        else
                            selected_brainmeasures = selected_brainmeasures(selected_brainmeasures ~= g);
                        end
                end
                
                update_global_table();
            end
            function cb_nodal_meas(~, ~)  % (src,event)
                set(ui_checkbox_brainmeasures_meas, 'Value', true)
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'FontWeight', 'normal')
                
                update_nodal_table()
                update_group_popups()
                init_plot_nodal_panel()
            end
            function cb_nodal_comp(~, ~)  % (src,event)
                set(ui_checkbox_brainmeasures_meas, 'Value', false)
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_comp, 'Value', true)
                set(ui_checkbox_brainmeasures_comp, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'FontWeight', 'normal')
                
                update_nodal_table()
                update_group_popups()
                init_plot_nodal_panel()
            end
            function cb_nodal_rand(~, ~)  % (src,event)
                set(ui_checkbox_brainmeasures_meas, 'Value', false)
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_rand, 'Value', true)
                set(ui_checkbox_brainmeasures_rand, 'FontWeight', 'bold')
                
                update_nodal_table()
                update_group_popups()
                init_plot_nodal_panel()
            end
            function cb_nodal_selectall(~, ~)  % (src,event)
                for j = 1:1:analysis.getMeasurements().length()
                    measurement = analysis.getMeasurements().getValue(j);
                    if ismember(measurement.getMeasureCode(), nodal_list)
                        nodal_measurements{j} = measurement;                             %#ok<AGROW>
                    end
                end
                
                for r = 1:1:length(nodal_measurements)
                    selected_brainmeasures = sort(unique([selected_brainmeasures(:); r]));
                end
                
                update_nodal_table()
            end
            function cb_nodal_clearselection(~,~)  % (src,event)
                selected_brainmeasures  = [];
                update_nodal_table()
            end
            function cb_nodal_remove(~, ~)
                for i = 1:1:length(selected_brainmeasures)
                    k = selected_brainmeasures(i);
                    analysis.getMeasurements().remove(k);
                end
                update_nodal_table()
            end
            
            update_nodal_table()
            init_plot_nodal_panel()
            
            if nargout > 0
                nodal_panel = ui_mainpanel;
            end
        end
        function binodal_panel = getBinodalPanel(analysis, varargin)
            % GETBINODALPANEL creates the binodal uipanel for GUIAnalysis
            %
            % BINODAL_PANEL = GETBINODALPANEL(ANALYSIS, PROPERTY, VALUE, ...)
            % creates a uipanel that contains information about binodal
            % measures in Measurement, RandomComparison and Comparison.
            %
            % See also getGraphPanel, getMainPanelMeasurePlot, getGlobalPanel
            
            uiparent = get_from_varargin([], 'UIParent', varargin{:});
            
            % declare constans
            SELECTALL_MEAS_CMD = GUI.SELECTALL_CMD;
            SELECTALL_MEAS_TP = 'Select all measures';
            
            CLEARSELECTION_MEAS_CMD = GUI.CLEARSELECTION_CMD;
            CLEARSELECTION_MEAS_TP = 'Clear measure selection';
            
            REMOVE_MEAS_CMD = GUI.REMOVE_CMD;
            REMOVE_MEAS_TP = 'Remove selected measures';
            
            % get global measures list
            mlist = Graph.getCompatibleMeasureList(analysis.getGraphType());
            for mi = 1:1:length(mlist)
                if Measure.is_binodal(mlist{mi})
                    n_list{mi} = mlist{mi}; %#ok<AGROW>
                end
            end
            binodal_list = n_list(~cellfun(@isempty, n_list));
            
            % get brain regions list
            atlases = analysis.getCohort().getBrainAtlases();
            atlas = atlases{1};  % change when multiatlases
            br_list = atlas.getBrainRegions().getKeys();
            
            % declare variables
            selected_brainmeasures = [];
            
            % declare the uicontrols
            ui_mainpanel = uipanel('Parent', uiparent, 'Units', 'normalized', 'Position', [0 0 1 1]);
            ui_binodal_tbl = uitable(ui_mainpanel);
            ui_button_brainmeasures_selectall = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_button_brainmeasures_clearselection = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_button_brainmeasures_remove = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_checkbox_brainmeasures_meas = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_checkbox_brainmeasures_comp = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_checkbox_brainmeasures_rand = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_popup_binodalmeasures_group1 = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_popup_binodalmeasures_group2 = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_selectedmeasure_popup = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_selectedbr1_popup = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_selectedbr2_popup = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_plot_measure_panel = uipanel('Parent', ui_mainpanel);
            ui_plot_measure_axes = get_from_varargin([], 'UIAxesBinodal', varargin{:});
            ui_plot_hide_checkbox = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            init_binodal_panel()
            function init_binodal_panel()
                GUI.setUnits(ui_mainpanel)
                
                set(ui_binodal_tbl, 'BackgroundColor', GUI.TABBKGCOLOR)
                if isequal(analysis.getMeasurementClass(), 'MeasurementST_WU')
                    set(ui_binodal_tbl, 'Position', [.02 .21 .96 .77])
                    GUI.setUnits(ui_plot_measure_panel)
                    GUI.setBackgroundColor(ui_plot_measure_panel)
                    
                    set(ui_plot_measure_panel, 'Position', [.0 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Parent', ui_plot_measure_panel)
                    set(ui_plot_measure_axes, 'Position', [.00 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Visible', 'off')
                else
                    set(ui_binodal_tbl, 'Position', [.02 .21 .4 .77])
                    GUI.setUnits(ui_plot_measure_panel)
                    GUI.setBackgroundColor(ui_plot_measure_panel)
                    set(ui_plot_measure_panel, 'Position', [.42 .00 .58 .98])
                    
                    set(ui_plot_measure_axes, 'Parent', ui_plot_measure_panel)
                    set(ui_plot_measure_axes, 'Position', [.1 .2 .8 .79])
                end
                set(ui_binodal_tbl, 'CellEditCallback', {@cb_binodal_table_edit})
                
                set(ui_binodal_tbl, 'Units', 'normalized')
                set(ui_button_brainmeasures_selectall, 'Position', [.19 .16 .10 .04])
                set(ui_button_brainmeasures_selectall, 'String', SELECTALL_MEAS_CMD)
                set(ui_button_brainmeasures_selectall, 'TooltipString', SELECTALL_MEAS_TP)
                set(ui_button_brainmeasures_selectall, 'Callback', {@cb_binodal_selectall})
                
                set(ui_button_brainmeasures_clearselection, 'Position', [.19 .11 .10 .04])
                set(ui_button_brainmeasures_clearselection, 'String', CLEARSELECTION_MEAS_CMD)
                set(ui_button_brainmeasures_clearselection, 'TooltipString', CLEARSELECTION_MEAS_TP)
                set(ui_button_brainmeasures_clearselection, 'Callback', {@cb_binodal_clearselection})
                
                set(ui_button_brainmeasures_remove, 'Position', [.19 .06 .10 .04])
                set(ui_button_brainmeasures_remove, 'String', REMOVE_MEAS_CMD)
                set(ui_button_brainmeasures_remove, 'TooltipString', REMOVE_MEAS_TP)
                set(ui_button_brainmeasures_remove, 'Callback', {@cb_binodal_remove})
                
                set(ui_checkbox_brainmeasures_meas, 'Position', [.3 .16 .10 .04])
                set(ui_checkbox_brainmeasures_meas, 'String', 'measure')
                set(ui_checkbox_brainmeasures_meas, 'Value', true)
                set(ui_checkbox_brainmeasures_meas, 'TooltipString', 'Select measure')
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_meas, 'Callback', {@cb_binodal_meas})
                
                set(ui_checkbox_brainmeasures_comp, 'Position',[.3 .11 .10 .04])
                set(ui_checkbox_brainmeasures_comp, 'String', 'comparison')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'TooltipString', 'Select comparison')
                set(ui_checkbox_brainmeasures_comp, 'Callback', {@cb_binodal_comp})
                
                set(ui_checkbox_brainmeasures_rand, 'Position', [.3 .06 .15 .04])
                set(ui_checkbox_brainmeasures_rand, 'String', 'random comparison')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'TooltipString', 'Select random comparison')
                set(ui_checkbox_brainmeasures_rand, 'Callback', {@cb_binodal_rand})
                
                set(ui_plot_hide_checkbox, 'Position', [.3 .01 .10 .04])
                set(ui_plot_hide_checkbox, 'String', 'Show Plot')
                set(ui_plot_hide_checkbox, 'Value', true)
                set(ui_plot_hide_checkbox, 'TooltipString', 'Show/Hide Plot')
                set(ui_plot_hide_checkbox, 'Callback', {@cb_show_plot})
                
                set(ui_popup_binodalmeasures_group1, 'Position', [.02 .16 .15 .04])
                set(ui_popup_binodalmeasures_group1, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_binodalmeasures_group1, 'Callback', {@cb_binodal_table})
                
                set(ui_popup_binodalmeasures_group2, 'Position', [.02 .11 .15 .04])
                set(ui_popup_binodalmeasures_group2, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_binodalmeasures_group2, 'Callback', {@cb_binodal_table})
                set(ui_popup_binodalmeasures_group2, 'Enable', 'off')
                set(ui_popup_binodalmeasures_group2, 'Visible', 'off')
                
                set(ui_selectedmeasure_popup, 'Position', [.02 .06 .15 .04])
                set(ui_selectedmeasure_popup, 'String', binodal_list)
                set(ui_selectedmeasure_popup, 'Callback', {@cb_binodal_table})
                
                set(ui_selectedbr1_popup, 'Position', [.02 .01 .07 .04])
                set(ui_selectedbr1_popup, 'String', br_list)
                set(ui_selectedbr1_popup, 'Callback', {@cb_binodal_table})
                
                set(ui_selectedbr2_popup, 'Position', [.1 .01 .07 .04])
                set(ui_selectedbr2_popup, 'String', br_list)
                set(ui_selectedbr2_popup, 'Callback', {@cb_binodal_table})
                
            end
            function update_binodal_table()
                data = {}; %#ok<NASGU>
                RowName = [];
                
                selected_index_1 = get(ui_popup_binodalmeasures_group1, 'Value');
                group_1 = analysis.getCohort().getGroups().getValue(selected_index_1);
                
                selected_index_2 = get(ui_popup_binodalmeasures_group1, 'Value');
                group_2 = analysis.getCohort().getGroups().getValue(selected_index_2);
                
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                
                selected_br1 = get(ui_selectedbr1_popup, 'Value');
                selected_br2 = get(ui_selectedbr2_popup, 'Value');
                
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    for j = 1:1:analysis.getMeasurements().length()
                        measurement = analysis.getMeasurements().getValue(j);
                        if ismember(measurement.getMeasureCode(), binodal_list) && isequal(measurement.getGroup(), group_1) && isequal(selected_measure, measurement.getMeasureCode())
                            binodal_measurements{j} = measurement; %#ok<AGROW>
                        end
                    end
                    
                    if exist('binodal_measurements', 'var')
                        binodal_measurements =  binodal_measurements(~cellfun(@isempty, binodal_measurements));
                        set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group', ' value ', ' name ', ' label ', ' notes '})
                        set(ui_binodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'char', 'char', 'char'})
                        set(ui_binodal_tbl, 'ColumnEditable', [true false false false false false false])
                        
                        data = cell(length(binodal_measurements), 7);
                        for i = 1:1:length(binodal_measurements)
                            measurement = binodal_measurements{i};
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            binodal_values_cell = measurement.getMeasureValue();
                            binodal_values = binodal_values_cell{1};
                            selected_binodal_value = binodal_values(selected_br1, selected_br2);
                            data{i, 2} = measurement.getMeasureCode();
                            data{i, 3} = measurement.getGroup().getID();
                            data{i, 4} = selected_binodal_value;
                            data{i, 5} = measurement.getID();
                            data{i, 6} = measurement.getLabel();
                            data{i, 7} = measurement.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_binodal_tbl, 'Data', data)
                        set(ui_binodal_tbl, 'RowName', RowName)
                    else
                        set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group', ' value ', ' name ', ' label ', ' notes '})
                        set(ui_binodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'char', 'char', 'char'})
                        set(ui_binodal_tbl, 'ColumnEditable', [true false false false false false false])
                        set(ui_binodal_tbl, 'Data', [])
                        set(ui_binodal_tbl, 'RowName', [])
                    end
                    
                elseif get(ui_checkbox_brainmeasures_comp, 'Value')
                    for j = 1:1:analysis.getComparisons().length()
                        comparison = analysis.getComparisons().getValue(j);
                        [a, b] = comparison.getGroups();
                        if ismember(comparison.getMeasureCode(), binodal_list) && ((isequal(a, group1) && isequal (b, group2)) || (isequal(a, group2) && isequal (b, group1))) && isequal(selected_measure, comparison.getMeasureCode())
                            binodal_comparison{j} = comparison; %#ok<AGROW>
                        end
                    end
                    
                    if exist('binodal_comparison', 'var')
                        binodal_comparison =  binodal_comparison(~cellfun(@isempty, binodal_comparison));
                        set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes '})
                        set(ui_binodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_binodal_tbl, 'ColumnEditable', [true false false false false false false false false])
                        
                        data = cell(length(binodal_comparison), 7);
                        for i = 1:1:length(binodal_comparison)
                            comparison = binodal_comparison{i};
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            [val_1, val_2]  = comparison.getGroupValues();
                            [group_1, group_2] = comparison.getGroups();
                            binodal_values_1 = val_1{1};
                            binodal_values_2 = val_2{1};
                            data{i, 2} = comparison.getMeasureCode();
                            data{i, 3} = group_1.getID();
                            data{i, 4} = group_2.getID();
                            data{i, 5} = binodal_values_1(selected_br1, selected_br2);
                            data{i, 6} = binodal_values_2(selected_br1, selected_br2);
                            data{i, 7} = comparison.getID();
                            data{i, 8} = comparison.getLabel();
                            data{i, 9} = comparison.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_binodal_tbl, 'Data', data)
                        set(ui_binodal_tbl, 'RowName', RowName)
                    else
                        set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes '})
                        set(ui_binodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_binodal_tbl, 'ColumnEditable', [true false false false false false false false false])
                        set(ui_binodal_tbl, 'Data', [])
                        set(ui_binodal_tbl, 'RowName', [])
                    end
                    
                elseif get(ui_checkbox_brainmeasures_rand, 'Value')
                    for j = 1:1:analysis.getRandomComparisons().length()
                        randomcomparison = analysis.getRandomComparisons().getValue(j);
                        if ismember(randomcomparison.getMeasureCode(), binodal_list) && isequal(randomcomparison.getGroup(), group_1) && isequal(selected_measure, randomcomparison.getMeasureCode())
                            binodal_randomcomparison{j} = randomcomparison; %#ok<AGROW>
                        end
                    end
                    
                    if exist('binodal_randomcomparison', 'var')
                        binodal_randomcomparison =  binodal_randomcomparison(~cellfun(@isempty, binodal_randomcomparison));
                        set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes '})
                        set(ui_binodal_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_binodal_tbl, 'ColumnEditable', [true false false false false false false false])
                        
                        data = cell(length(binodal_randomcomparison), 7);
                        for i = 1:1:length(binodal_randomcomparison)
                            randomcomparison = binodal_randomcomparison{i};
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            group_val =  randomcomparison.getGroupValue();
                            random_val = randomcomparison.getRandomValue();
                            group_val_binodal = group_val{1};
                            random_val_binodal = random_val{1};
                            data{i, 2} = randomcomparison.getMeasureCode();
                            data{i, 3} = randomcomparison.getGroup().getID();
                            data{i, 4} = group_val_binodal(selected_br1, selected_br2);
                            data{i, 5} = random_val_binodal(selected_br1, selected_br2);
                            data{i, 6} = randomcomparison.getID();
                            data{i, 7} = randomcomparison.getLabel();
                            data{i, 8} = randomcomparison.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_binodal_tbl, 'Data', data)
                        set(ui_binodal_tbl, 'RowName', RowName)
                    else
                        set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes '})
                        set(ui_binodal_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char'})
                        set(ui_binodal_tbl, 'ColumnEditable', [true false false false false false false false])
                        set(ui_binodal_tbl, 'Data', [])
                        set(ui_binodal_tbl, 'RowName', [])
                    end
                end
            end
            function update_group_popups()
                if get(ui_checkbox_brainmeasures_comp, 'Value')
                    set(ui_popup_binodalmeasures_group1, 'Enable', 'on')
                    set(ui_popup_binodalmeasures_group1, 'Visible', 'on')
                    
                    set(ui_popup_binodalmeasures_group2, 'Enable', 'on')
                    set(ui_popup_binodalmeasures_group2, 'Visible', 'on')
                else
                    set(ui_popup_binodalmeasures_group1, 'Enable', 'on')
                    set(ui_popup_binodalmeasures_group1, 'Visible', 'on')
                    
                    set(ui_popup_binodalmeasures_group2, 'Enable', 'off')
                    set(ui_popup_binodalmeasures_group2, 'Visible', 'off')
                end
            end
            function init_plot_binodal_panel()
                cla(ui_plot_measure_axes)
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    analysis.getBinodalMeasurePlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_binodalmeasures_group1, 'Value')), ...
                        get(ui_selectedbr1_popup, 'Value'), get(ui_selectedbr2_popup, 'Value'));
                elseif get(ui_checkbox_brainmeasures_comp, 'Value')
                    analysis.getBinodalComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_binodalmeasures_group1, 'Value')), ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_binodalmeasures_group2, 'Value')), ...
                        get(ui_selectedbr1_popup, 'Value'), get(ui_selectedbr2_popup, 'Value'));
                elseif get(ui_checkbox_brainmeasures_rand, 'Value')
                    analysis.getBinodalRandomComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_binodalmeasures_group1, 'Value')), ...
                        get(ui_selectedbr1_popup, 'Value'), get(ui_selectedbr2_popup, 'Value'));
                end
            end
            function cb_show_plot(~, ~)
                if isequal(get(ui_plot_hide_checkbox, 'Value'), 0)
                    set(ui_binodal_tbl, 'Position', [.02 .21 .96 .77])
                    
                    set(ui_plot_measure_panel, 'Position', [.0 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Position', [.00 .00 .0 .0])
                    set(ui_plot_measure_axes, 'Visible', 'off')
                else
                    set(ui_binodal_tbl, 'Position', [.02 .21 .4 .77])
                    set(ui_plot_measure_panel, 'Position', [.42 .00 .58 .98])
                    
                    set(ui_plot_measure_axes, 'Position', [.1 .2 .8 .79])
                    set(ui_plot_measure_axes, 'Visible', 'on')
                end
            end
            function cb_binodal_table(~, ~)
                update_binodal_table()
                init_plot_binodal_panel()
            end
            function cb_binodal_table_edit(~, event)  % (src,event)
                g = event.Indices(1);
                col = event.Indices(2);
                newdata = event.NewData;
                switch col
                    case 1
                        if newdata == 1
                            if ~ismember(g, selected_brainmeasures)
                                selected_brainmeasures = [selected_brainmeasures g];
                            end
                        else
                            selected_brainmeasures = selected_brainmeasures(selected_brainmeasures ~= g);
                        end
                end
                
                update_global_table();
            end
            function cb_binodal_meas(~, ~)  % (src,event)
                set(ui_checkbox_brainmeasures_meas, 'Value', true)
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'FontWeight', 'normal')
                
                update_binodal_table()
                update_group_popups()
                init_plot_binodal_panel()
            end
            function cb_binodal_comp(~, ~)  % (src,event)
                set(ui_checkbox_brainmeasures_meas, 'Value', false)
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_comp, 'Value', true)
                set(ui_checkbox_brainmeasures_comp, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'FontWeight', 'normal')
                
                update_binodal_table()
                update_group_popups()
                init_plot_binodal_panel()
            end
            function cb_binodal_rand(~, ~)  % (src,event)
                set(ui_checkbox_brainmeasures_meas, 'Value', false)
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'FontWeight', 'normal')
                set(ui_checkbox_brainmeasures_rand, 'Value', true)
                set(ui_checkbox_brainmeasures_rand, 'FontWeight', 'bold')
                
                update_binodal_table()
                update_group_popups()
                init_plot_binodal_panel()
            end
            function cb_binodal_selectall(~, ~)  % (src,event)
                for j = 1:1:analysis.getMeasurements().length()
                    measurement = analysis.getMeasurements().getValue(j);
                    if ismember(measurement.getMeasureCode(), binodal_list)
                        binodal_measurements{j} = measurement;                             %#ok<AGROW>
                    end
                end
                
                for r = 1:1:length(binodal_measurements)
                    selected_brainmeasures = sort(unique([selected_brainmeasures(:); r]));
                end
                
                update_binodal_table()
            end
            function cb_binodal_clearselection(~,~)  % (src,event)
                selected_brainmeasures  = [];
                update_binodal_table()
            end
            function cb_binodal_remove(~, ~)
                for i = 1:1:length(selected_brainmeasures)
                    k = selected_brainmeasures(i);
                    analysis.getMeasurements().remove(k);
                end
                update_binodal_table()
            end
            
            update_binodal_table()
            init_plot_binodal_panel()
            
            if nargout > 0
                binodal_panel = ui_mainpanel;
            end
        end
        function p = getGlobalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, varargin) %#ok<INUSD>
            % GETGLOBALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getGlobalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group_1, group_2, varargin) %#ok<INUSD>
            % GETGLOBALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getGlobalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group, varargin) %#ok<INUSD>
            % GETGLOBALRANDOMCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALRANDOMCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getNodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region, varargin) %#ok<INUSD>
            % GETNODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, BRAINREGION, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getNodalPanel.
            
            p = [];
        end
        function p = getNodalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group_1, group_2, brain_region, varargin) %#ok<INUSD>
            % GETNODALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAIN_REGION, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getNodalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region, varargin) %#ok<INUSD>
            % GETNODALRANDOMCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALRANDOMCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2,  BRAINREGION, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getBinodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region_1, brain_region_2, varargin) %#ok<INUSD>
            % GETBINODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETBINODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP,  BRAINREGION1,  BRAINREGION2, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getBinodalPanel.
            
            p = [];
        end
        function p = getBinodalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group_1, group_2, brain_region_1, brain_region_2, varargin) %#ok<INUSD>
            % GETNODALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAINREGION1,  BRAINREGION2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the binodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getBinodalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region_1, brain_region_2, varargin) %#ok<INUSD>
            % GETNODALRANDOMCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALRANDOMCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAINREGION1,  BRAINREGION2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the binodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getBrainView(analysis, varargin)
            uiparent = get_from_varargin([], 'UIParent', varargin{:});
            bg = get_from_varargin([], 'BrainGraph', varargin{:});
            
            ui_brainview_panel = uipanel('Parent', uiparent, 'Units', 'normalized', 'Position', [0 0 1 1]);
            ui_brainview_axes = get_from_varargin([], 'UIAxesBrain', varargin{:});
            ui_brainview_edges_panel_button = uicontrol(ui_brainview_panel);
            ui_brainview_analysis_dictionaries_button = uicontrol(ui_brainview_panel);
            init_brainview()
            function init_brainview()
                GUI.setUnits(ui_brainview_panel)
                GUI.setBackgroundColor(ui_brainview_panel)
                
                set(ui_brainview_axes, 'Parent', ui_brainview_panel)
                set(ui_brainview_axes, 'Position', [.12 .2 0.78 .78])
                
                set(ui_brainview_edges_panel_button, 'Units', 'normalized')
                set(ui_brainview_edges_panel_button, 'Position', [.22 .02 .2 .08])
                set(ui_brainview_edges_panel_button, 'String', 'Brain Graph Options')
                set(ui_brainview_edges_panel_button, 'Callback', {@cb_bv_bg_panel})
                
                set(ui_brainview_analysis_dictionaries_button, 'Units', 'normalized')
                set(ui_brainview_analysis_dictionaries_button, 'Position', [.52 .02 .2 .08])
                set(ui_brainview_analysis_dictionaries_button, 'String', 'Measurement Options')
                set(ui_brainview_analysis_dictionaries_button, 'Tooltip', 'Manage the Measurement, Comparison and Randomcomparison.')
                set(ui_brainview_analysis_dictionaries_button, 'Callback', {@cb_bv_meas_panel})
            end
            function update_brain_graph()
                
                bg.set_axes(ui_brainview_axes);
                axes(ui_brainview_axes)
                bg.axis_equal()
                bg.hold_on();
                bg.view(PlotBrainSurf.VIEW_3D)
                bg.brain();
                bg.br_syms();
            end
            function cb_bv_bg_panel(~, ~)
                bgp =  analysis.getBrainGraphPanel(ui_brainview_axes, bg); %#ok<NASGU>
            end
            function cb_bv_meas_panel(~, ~)
               analysis.getMCRPanel(ui_brainview_axes, bg);
            end
            
            update_brain_graph()
            
            if nargout > 0
                p = ui_brainview_panel;
            end
        end
        function brain_graph_panel = getBrainGraphPanel(analysis, brain_axes, brain_graph)
            
            NAME_GRAPH =  'Brain Graph Panel';
            fig_graph = GUI.init_figure(NAME_GRAPH, .2, .5, 'west');
            
            % variables
            ga = analysis;
            bg = brain_graph;
            br_axes = brain_axes; %#ok<NASGU>
            
            ui_text_graph_group = uicontrol(fig_graph, 'Style', 'text');
            ui_popup_graph_group = uicontrol(fig_graph, 'Style', 'popup', 'String', {''});
            ui_checkbox_graph_density = uicontrol(fig_graph, 'Style', 'checkbox');
            ui_text_graph_density = uicontrol(fig_graph, 'Style', 'text');
            ui_edit_graph_bs = uicontrol(fig_graph, 'Style', 'edit');
            ui_slider_graph_bs = uicontrol(fig_graph, 'Style', 'slider');
            ui_checkbox_graph_threshold = uicontrol(fig_graph, 'Style', 'checkbox');
            ui_text_graph_threshold = uicontrol(fig_graph, 'Style', 'text');
            ui_edit_graph_bt = uicontrol(fig_graph, 'Style', 'edit');
            ui_slider_graph_bt = uicontrol(fig_graph, 'Style', 'slider');
            ui_checkbox_graph_weighted = uicontrol(fig_graph, 'Style', 'checkbox');
            ui_checkbox_graph_linecolor = uicontrol(fig_graph, 'Style',  'checkbox');
            ui_popup_graph_initcolor = uicontrol(fig_graph, 'Style', 'popup', 'String', {''});
            ui_popup_graph_fincolor = uicontrol(fig_graph, 'Style', 'popup', 'String', {''});
            ui_checkbox_graph_lineweight = uicontrol(fig_graph, 'Style',  'checkbox');
            ui_edit_graph_lineweight = uicontrol(fig_graph, 'Style', 'edit');
            ui_button_graph_show = uicontrol(fig_graph, 'Style', 'pushbutton');
            ui_button_graph_hide = uicontrol(fig_graph, 'Style', 'pushbutton');
            ui_button_graph_color = uicontrol(fig_graph, 'Style', 'pushbutton');
            ui_button_graph_edge_settings = uicontrol(fig_graph, 'Style', 'pushbutton');
            ui_text_graph_thickness = uicontrol(fig_graph, 'Style', 'text');
            ui_edit_graph_thickness = uicontrol(fig_graph, 'Style', 'edit');
            
            init_graph()
            update_popups_grouplists()
            update_graph()
            
            %% Make the GUI visible.
            set(fig_graph, 'Visible', 'on');
            
            function init_graph()
                
                set(ui_text_graph_group, 'Units', 'normalized')
                set(ui_text_graph_group, 'Position', [.05 .86 .20 .10])
                set(ui_text_graph_group, 'String', 'Group  ')
                set(ui_text_graph_group, 'HorizontalAlignment', 'left')
                set(ui_text_graph_group, 'FontWeight', 'bold')
                set(ui_text_graph_group, 'FontSize', 10)
                
                set(ui_popup_graph_group, 'Units', 'normalized')
                set(ui_popup_graph_group, 'Position', [.33 .87 .40 .10])
                set(ui_popup_graph_group, 'TooltipString', 'Select group');
                set(ui_popup_graph_group, 'Callback', {@cb_popup_group})
                
                set(ui_checkbox_graph_density, 'Units', 'normalized')
                set(ui_checkbox_graph_density, 'Position', [.05 .780 .40 .146])
                set(ui_checkbox_graph_density, 'String', 'Fix density')
                set(ui_checkbox_graph_density, 'TooltipString', 'Select density')
                set(ui_checkbox_graph_density, 'FontWeight', 'bold')
                set(ui_checkbox_graph_density, 'Callback', {@cb_checkbox_density})
                
                set(ui_text_graph_density, 'Units', 'normalized')
                set(ui_text_graph_density, 'Position', [.05 .705 .20 .10])
                set(ui_text_graph_density, 'String', 'Density  ')
                set(ui_text_graph_density, 'HorizontalAlignment', 'left')
                set(ui_text_graph_density, 'FontWeight', 'bold')
                set(ui_text_graph_density, 'FontSize', 10)
                
                set(ui_edit_graph_bs, 'Units', 'normalized')
                set(ui_edit_graph_bs, 'Position', [.760 .760 .20 .05])
                set(ui_edit_graph_bs, 'String', '50.00');
                set(ui_edit_graph_bs, 'TooltipString', 'Set density.');
                set(ui_edit_graph_bs, 'FontWeight', 'bold')
                set(ui_edit_graph_bs, 'Callback', {@cb_graph_edit_bs});
                
                set(ui_slider_graph_bs, 'Units', 'normalized')
                set(ui_slider_graph_bs, 'Position', [.33 .760 .40 .05])
                set(ui_slider_graph_bs, 'Min', 0, 'Max', 100, 'Value', 50)
                set(ui_slider_graph_bs, 'TooltipString', 'Set density.')
                set(ui_slider_graph_bs, 'Callback', {@cb_graph_slider_bs})
                
                set(ui_checkbox_graph_threshold, 'Units', 'normalized')
                set(ui_checkbox_graph_threshold, 'Position', [.05 .60 .40 .15])
                set(ui_checkbox_graph_threshold, 'String', 'Fix threshold')
                set(ui_checkbox_graph_threshold, 'TooltipString', 'Select density')
                set(ui_checkbox_graph_threshold, 'FontWeight', 'bold')
                set(ui_checkbox_graph_threshold, 'Callback', {@cb_checkbox_threshold})
                
                set(ui_text_graph_threshold, 'Units', 'normalized')
                set(ui_text_graph_threshold, 'Enable', 'off')
                set(ui_text_graph_threshold, 'Position', [.05 .515 .25 .10])
                set(ui_text_graph_threshold, 'String', 'Threshold  ')
                set(ui_text_graph_threshold, 'HorizontalAlignment', 'left')
                set(ui_text_graph_threshold, 'FontWeight', 'bold')
                set(ui_text_graph_threshold, 'FontSize', 10)
                
                set(ui_edit_graph_bt, 'Units', 'normalized')
                set(ui_edit_graph_bt, 'Enable', 'off')
                set(ui_edit_graph_bt, 'Position', [.760 .570 .20 .05])
                set(ui_edit_graph_bt, 'String', '0');
                set(ui_edit_graph_bt, 'TooltipString', 'Set threshold.');
                set(ui_edit_graph_bt, 'FontWeight', 'bold')
                set(ui_edit_graph_bt, 'Callback', {@cb_graph_edit_bt});
                
                set(ui_slider_graph_bt, 'Units', 'normalized')
                set(ui_slider_graph_bt, 'Enable', 'off')
                set(ui_slider_graph_bt, 'Position', [.33 .570 .40 .05])
                set(ui_slider_graph_bt, 'Min', -1, 'Max', 1, 'Value', 0)
                set(ui_slider_graph_bt, 'TooltipString', 'Set threshold.')
                set(ui_slider_graph_bt, 'Callback', {@cb_graph_slider_bt})
                
                set(ui_checkbox_graph_weighted, 'Units', 'normalized')
                set(ui_checkbox_graph_weighted, 'Position', [.05 .40 .40 .15])
                set(ui_checkbox_graph_weighted, 'String', 'Weighted graph')
                set(ui_checkbox_graph_weighted, 'TooltipString', 'Select density')
                set(ui_checkbox_graph_weighted, 'FontWeight', 'bold')
                set(ui_checkbox_graph_weighted, 'Callback', {@cb_checkbox_weighted})
                
                set(ui_checkbox_graph_linecolor, 'Units', 'normalized')
                set(ui_checkbox_graph_linecolor, 'Enable', 'off')
                set(ui_checkbox_graph_linecolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_graph_linecolor, 'Position', [.10 .340 .23 .10])
                set(ui_checkbox_graph_linecolor, 'String', ' Color ')
                set(ui_checkbox_graph_linecolor, 'Value', false)
                set(ui_checkbox_graph_linecolor, 'FontWeight', 'bold')
                set(ui_checkbox_graph_linecolor, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_graph_linecolor, 'Callback', {@cb_checkbox_linecolor})
                
                set(ui_popup_graph_initcolor, 'Units', 'normalized')
                set(ui_popup_graph_initcolor, 'Enable', 'off')
                set(ui_popup_graph_initcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_graph_initcolor, 'Enable', 'off')
                set(ui_popup_graph_initcolor, 'Position', [.355 .315 .155 .10])
                set(ui_popup_graph_initcolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_graph_initcolor, 'Value', 3)
                set(ui_popup_graph_initcolor, 'TooltipString', 'Select symbol');
                set(ui_popup_graph_initcolor, 'Callback', {@cb_popup_initcolor})
                
                set(ui_popup_graph_fincolor, 'Units', 'normalized')
                set(ui_popup_graph_fincolor, 'Enable', 'off')
                set(ui_popup_graph_fincolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_graph_fincolor, 'Enable', 'off')
                set(ui_popup_graph_fincolor, 'Position', [.575 .315 .155 .10])
                set(ui_popup_graph_fincolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_graph_fincolor, 'Value', 1)
                set(ui_popup_graph_fincolor, 'TooltipString', 'Select symbol');
                set(ui_popup_graph_fincolor, 'Callback', {@cb_popup_fincolor})
                
                set(ui_checkbox_graph_lineweight, 'Units', 'normalized')
                set(ui_checkbox_graph_lineweight, 'Enable', 'off')
                set(ui_checkbox_graph_lineweight, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_graph_lineweight, 'Position', [.10 .270 .28 .10])
                set(ui_checkbox_graph_lineweight, 'String', ' Thickness ')
                set(ui_checkbox_graph_lineweight, 'Value', false)
                set(ui_checkbox_graph_lineweight, 'FontWeight', 'bold')
                set(ui_checkbox_graph_lineweight, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_graph_lineweight, 'Callback', {@cb_checkbox_lineweight})
                
                set(ui_edit_graph_lineweight, 'Units', 'normalized')
                set(ui_edit_graph_lineweight, 'Enable', 'off')
                set(ui_edit_graph_lineweight, 'Position', [.35 .29 .38 .05])
                set(ui_edit_graph_lineweight, 'String', '1');
                set(ui_edit_graph_lineweight, 'TooltipString', 'Set line weight.');
                set(ui_edit_graph_lineweight, 'FontWeight', 'bold')
                set(ui_edit_graph_lineweight, 'Callback', {@cb_edit_lineweight});
                
                set(ui_button_graph_show, 'Units', 'normalized')
                set(ui_button_graph_show, 'Position', [.1 .20 .4 .06])
                set(ui_button_graph_show, 'String', ' Show ')
                set(ui_button_graph_show, 'HorizontalAlignment', 'center')
                set(ui_button_graph_show, 'FontWeight', 'bold')
                set(ui_button_graph_show, 'FontSize', 10)
                set(ui_button_graph_show, 'Callback', {@cb_graph_show})
                
                set(ui_button_graph_hide, 'Units', 'normalized')
                set(ui_button_graph_hide, 'Position', [.1 .13 .4 .06])
                set(ui_button_graph_hide, 'String', ' Hide ')
                set(ui_button_graph_hide, 'HorizontalAlignment', 'center')
                set(ui_button_graph_hide, 'FontWeight', 'bold')
                set(ui_button_graph_hide, 'FontSize', 10)
                set(ui_button_graph_hide, 'Callback', {@cb_graph_hide})
                
                set(ui_button_graph_color, 'Units', 'normalized')
                set(ui_button_graph_color, 'Position', [.52 .2 .4 .06])
                set(ui_button_graph_color, 'String', ' Color ')
                set(ui_button_graph_color, 'HorizontalAlignment', 'center')
                set(ui_button_graph_color, 'FontWeight', 'bold')
                set(ui_button_graph_color, 'FontSize', 10)
                set(ui_button_graph_color, 'Callback', {@cb_graph_color})
                
                set(ui_button_graph_edge_settings, 'Units', 'normalized')
                set(ui_button_graph_edge_settings, 'Position', [.52 .13 .4 .06])
                set(ui_button_graph_edge_settings, 'String', 'Edge Settings')
                set(ui_button_graph_edge_settings, 'HorizontalAlignment', 'center')
                set(ui_button_graph_edge_settings, 'FontWeight', 'bold')
                set(ui_button_graph_edge_settings, 'FontSize', 10)
                set(ui_button_graph_edge_settings, 'Callback', {@cb_graph_links_settings})
                
                set(ui_text_graph_thickness, 'Units', 'normalized')
                set(ui_text_graph_thickness, 'Position', [.05 .0 .30 .10])
                set(ui_text_graph_thickness, 'String', 'Set thickness  ')
                set(ui_text_graph_thickness, 'HorizontalAlignment', 'left')
                set(ui_text_graph_thickness, 'FontWeight', 'bold')
                set(ui_text_graph_thickness, 'FontSize', 10)
                
                set(ui_edit_graph_thickness, 'Units', 'normalized')
                set(ui_edit_graph_thickness, 'Position', [.405 .06 .20 .05])
                set(ui_edit_graph_thickness, 'String', '1');
                set(ui_edit_graph_thickness, 'TooltipString', 'Set density.');
                set(ui_edit_graph_thickness, 'FontWeight', 'bold')
                set(ui_edit_graph_thickness, 'Callback', {@cb_graph_thickness});
                
                if isequal(class(analysis), 'AnalysisST_BUT')
                    change_to_threshold()
                elseif isequal(class(analysis), 'AnalysisST_BUD')
                    change_to_density()
                else
                    change_to_weighted()
                end
            end
            function change_to_density()
                set(ui_checkbox_graph_density, 'Value', true)
                set(ui_slider_graph_bs, 'Enable', 'on')
                set(ui_text_graph_density, 'Enable', 'on')
                set(ui_edit_graph_bs, 'Enable', 'on')
                set(ui_edit_graph_thickness, 'enable', 'on')
                
                set(ui_checkbox_graph_threshold, 'Value', false)
                set(ui_slider_graph_bt, 'Enable', 'off')
                set(ui_text_graph_threshold, 'Enable', 'off')
                set(ui_edit_graph_bt, 'Enable', 'off')
                
                set(ui_checkbox_graph_weighted, 'Value', false)
                set(ui_checkbox_graph_linecolor, 'Enable', 'off')
                set(ui_checkbox_graph_linecolor, 'Value', false)
                set(ui_popup_graph_initcolor, 'Enable', 'off')
                set(ui_popup_graph_fincolor, 'Enable', 'off')
                set(ui_checkbox_graph_lineweight, 'Enable', 'off')
                set(ui_checkbox_graph_lineweight, 'Value', false)
                set(ui_edit_graph_lineweight, 'Enable', 'off')
                
                update_graph()
            end
            function change_to_threshold()
                set(ui_checkbox_graph_threshold, 'Value', true)
                set(ui_slider_graph_bt, 'Enable', 'on')
                set(ui_text_graph_threshold, 'Enable', 'on')
                set(ui_edit_graph_bt, 'Enable', 'on')
                set(ui_edit_graph_thickness, 'enable', 'on')
                
                set(ui_checkbox_graph_density, 'Value', false)
                set(ui_slider_graph_bs, 'Enable', 'off')
                set(ui_text_graph_density, 'Enable', 'off')
                set(ui_edit_graph_bs, 'Enable', 'off')
                
                set(ui_checkbox_graph_weighted, 'Value', false)
                set(ui_checkbox_graph_linecolor, 'Enable', 'off')
                set(ui_checkbox_graph_linecolor, 'Value', false)
                set(ui_popup_graph_initcolor, 'Enable', 'off')
                set(ui_popup_graph_fincolor, 'Enable', 'off')
                set(ui_checkbox_graph_lineweight, 'Enable', 'off')
                set(ui_checkbox_graph_lineweight, 'Value', false)
                set(ui_edit_graph_lineweight, 'Enable', 'off')
                
                update_graph()
            end
            function  change_to_weighted()
                set(ui_checkbox_graph_weighted, 'Value', true)
                set(ui_checkbox_graph_linecolor, 'Enable', 'on')
                set(ui_checkbox_graph_lineweight, 'Enable', 'on')
                set(ui_edit_graph_thickness, 'enable', 'off')
                
                set(ui_checkbox_graph_threshold, 'Value', false)
                set(ui_text_graph_threshold, 'Enable', 'off')
                set(ui_slider_graph_bt, 'Enable', 'off')
                set(ui_edit_graph_bt, 'Enable', 'off')
                
                set(ui_checkbox_graph_density, 'Value', false)
                set(ui_slider_graph_bs, 'Enable', 'off')
                set(ui_text_graph_density, 'Enable', 'off')
                set(ui_edit_graph_bs, 'Enable', 'off')
            end
            function cb_checkbox_density(~, ~)  % (src, event)
                if get(ui_checkbox_graph_density, 'Value')
                    change_to_density()
                else
                    set(ui_checkbox_graph_density, 'Value', true)
                end
            end
            function cb_checkbox_threshold(~, ~)  % (src, event)
                if get(ui_checkbox_graph_threshold, 'Value')
                    change_to_threshold()
                else
                    set(ui_checkbox_graph_threshold, 'Value', true)
                end
            end
            function cb_checkbox_weighted(~, ~)  % (src, event)
                if get(ui_checkbox_graph_weighted, 'Value')
                    change_to_weighted()
                else
                    set(ui_checkbox_graph_weighted, 'Enable', 'on')
                end
            end
            function cb_checkbox_linecolor(~, ~)  % (src, event)
                if get(ui_checkbox_graph_linecolor, 'Value')
                    set(ui_popup_graph_initcolor, 'Enable', 'on')
                    set(ui_popup_graph_fincolor, 'Enable', 'on')
                    update_graph()
                else
                    set(ui_popup_graph_initcolor, 'Enable', 'off')
                    set(ui_popup_graph_fincolor, 'Enable', 'off')
                    
                    group_index = get(ui_popup_graph_group, 'Value');
                    group = ga.getCohort().getValue(group_index);
                    [~, subjects] = group.getGroupSubjects();
                    subject = subjects{1};
                    atlas = subject.getBrainAtlases();
                    for indices = 1:1:numel(atlas)
                        [row, column] = ind2sub(size(atlas),  indices);
                        bg.link_edges(row, column, 'Color', [0 0 0])
                    end
                end
            end
            function cb_checkbox_lineweight(~, ~)  % (src, event)
                if get(ui_checkbox_graph_lineweight, 'Value')
                    set(ui_edit_graph_lineweight, 'Enable', 'on')
                    update_graph()
                else
                    set(ui_edit_graph_lineweight, 'Enable', 'off')
                    
                    weight = str2double(get(ui_edit_graph_lineweight, 'String'));
                    group_index = get(ui_popup_graph_group, 'Value');
                    group = ga.getCohort().getValue(group_index);
                    [~, subjects] = group.getGroupSubjects();
                    subject = subjects{1};
                    atlas = subject.getBrainAtlases();
                    for indices = 1:1:numel(atlas)
                        [row, column] = ind2sub(size(atlas),  indices);
                        bg.link_edges(row, column, 'LineWidth', weight)
                    end
                end
            end
            function cb_graph_edit_bs(~, ~)  % (src, event)
                density = real(str2double(get(ui_edit_graph_bs, 'String')));
                if isnan(density) || density <= 0 || density > 100
                    set(ui_edit_graph_bs, 'String', '50');
                    set(ui_slider_graph_bs, 'Value', str2double(get(ui_edit_graph_bs, 'String')));
                else
                    set(ui_slider_graph_bs, 'Value', density);
                end
                update_graph()
            end
            function cb_graph_slider_bs(src, ~)  % (src, event)
                set(ui_edit_graph_bs, 'String', get(src, 'Value'))
                update_graph()
            end
            function cb_graph_edit_bt(~, ~)  % (src, event)
                threshold = real(str2double(get(ui_edit_graph_bt, 'String')));
                if isnan(threshold) || threshold < -1 || threshold > 1
                    set(ui_edit_graph_bt, 'String', '0');
                    set(ui_slider_graph_bt, 'Value', str2double(get(ui_edit_graph_bt, 'String')));
                else
                    set(ui_slider_graph_bt, 'Value', threshold);
                end
                update_graph()
            end
            function cb_graph_slider_bt(src, ~)  % (src, event)
                set(ui_edit_graph_bt, 'String', get(src, 'Value'))
                update_graph()
            end
            function cb_edit_lineweight(~, ~)  % (src, event)
                weigth = real(str2double(get(ui_edit_graph_bs, 'String')));
                if isnan(weigth) || weigth <= 0
                    set(ui_edit_graph_lineweight, 'String', '5');
                end
                update_graph()
            end
            function cb_popup_initcolor(~, ~)  % (src, event)
                update_graph()
            end
            function cb_popup_fincolor(~, ~)  % (src, event)
                update_graph()
            end
            function cb_popup_group(~, ~)  % (src, event)
                update_graph()
            end
            function cb_graph_show(~, ~)  % (src, event)
                update_graph()
            end
            function cb_graph_hide(~, ~)  % (src, event)
                bg.link_edges_off([], [])
            end
            function cb_graph_color(~, ~)  % (src, event)
                color = uisetcolor();
                atlases = ga.getCohort().getBrainAtlases();
                atlas = atlases{1};
                if length(color)==3
                    for i = 1:1:atlas.getBrainRegions().length()
                        for j = 1:1:atlas.getBrainRegions().length()
                            bg.link_edge(i, j, 'Color', color)
                        end
                    end
                end
            end
            function cb_graph_thickness(~, ~)  % (src, event)
                thickness = real(str2double(get(ui_edit_graph_thickness, 'String')));
                if isnan(thickness) || thickness <= 0
                    set(ui_edit_graph_thickness, 'String', '1');
                end
                update_graph()
            end
            function update_graph()
                group_index = get(ui_popup_graph_group, 'Value');
                if get(ui_checkbox_graph_weighted, 'Value')
                    
                    if get(ui_checkbox_graph_linecolor, 'Value')
                        val1 = get(ui_popup_graph_initcolor, 'Value');
                        val2 = get(ui_popup_graph_fincolor, 'Value');
                        
                        bg.link_edges('Color', [val1 val2]);
                    end
                    
                    if get(ui_checkbox_graph_lineweight, 'Value')
                        
                        weight = str2double(get(ui_edit_graph_lineweight, 'String'));
                        for indices = 1:1:length(reshA)
                            bg.link_edges( 'LineWidth', weight)
                        end
                    end
                else
                    if get(ui_checkbox_graph_density, 'Value')
                        value = str2double(get(ui_edit_graph_bs, 'String'));
                        rule = 'density';
                    end
                    if get(ui_checkbox_graph_threshold, 'Value')
                        value = str2double(get(ui_edit_graph_bt, 'String'));
                        rule = 'threshold';
                    end
                    
                    group = analysis.getCohort().getGroups().getValue(group_index);
                    subjects = group.getSubjects();
                    if isequal(analysis.getGraphType, 'GraphWU')
                        graph = analysis.get_weighted_correlation_matrix(subjects);
                    else
                        graph = analysis.get_graph_for_subjects(subjects, rule, value);
                    end
                    A = graph.getA();
                    thickness = str2double(get(ui_edit_graph_thickness, 'String'));
                    bg.link_edges_off([], [])
                    for i = 1:1:size(A, 1)
                        for j = 1:1:size(A, 2)
                            if A(i, j) == 0
                                continue;
                            end
                            bg.link_edge(i, j, 'LineWidth', thickness)
                            bg.link_edge_on(i, j)
                        end
                    end
                end
            end
            function cb_graph_links_settings(~, ~)  % (src, event)
                bg.link_edges_settings([], []);
            end
            function update_popups_grouplists()
                if ga.getCohort().getGroups().length() > 0
                    % updates group lists of popups
                    GroupList = {};
                    for g = 1:1:ga.getCohort().getGroups().length()
                        GroupList{g} = ga.getCohort().getGroups().getKey(g); %#ok<AGROW>
                    end
                else
                    GroupList = {''};
                end
                set(ui_popup_graph_group, 'String', GroupList)
            end
            
            if nargout > 0
                brain_graph_panel = fig_graph;
            end
        end
        function getMCRPanel(analysis, brain_axes, bg)
            % sets position of figure
            APPNAME = 'Analysis Property Panel';
            FigPosition = [.10 .30 .35 .50];
            FigColor = GUI.BKGCOLOR;
            
            % create a figure     
            f = GUI.init_figure(APPNAME, .45, .6, 'west');
%             fig_group = figure('Visible', 'off');            
            
            set(f, 'Units', 'normalized')
            set(f, 'Position', FigPosition)
            set(f, 'Color', FigColor)
            set(f, 'Name', [APPNAME ' : Group settings - ' BRAPH2.VERSION])
            set(f, 'MenuBar', 'none')
            set(f, 'Toolbar', 'none')
            set(f, 'NumberTitle', 'off')
            set(f, 'DockControls', 'off')
           
            measure_data = [];
            fdr_lim = [];
            ga = analysis;
            
            % get all measures
            mlist = Graph.getCompatibleMeasureList(analysis.getGraphType());  % list of nodal measures            
            
            %% initialization
            % groups, actions and measures            
            ui_action_measures_checkbox = uicontrol(f, 'Style', 'checkbox');
            ui_action_comparison_checkbox = uicontrol(f, 'Style', 'checkbox');
            ui_action_random_checkbox = uicontrol(f, 'Style', 'checkbox');
            ui_text_group1 = uicontrol(f, 'Style', 'text');
            ui_text_group2 = uicontrol(f, 'Style', 'text');
            ui_text_view_action = uicontrol(f, 'Style', 'text');
            ui_popup_grouplists1 = uicontrol(f, 'Style', 'popup', 'String', {''});           
            ui_popup_grouplists2 = uicontrol(f, 'Style', 'popup', 'String', {''});         
            ui_list_gr = uicontrol(f, 'Style',  'listbox');
            
            % rescaling panel
            ui_panel_meas_scaling = uipanel(f);
            ui_text_meas_offset = uicontrol(ui_panel_meas_scaling, 'Style', 'text');
            ui_edit_meas_offset = uicontrol(ui_panel_meas_scaling, 'Style', 'edit');
            ui_text_meas_rescaling = uicontrol(ui_panel_meas_scaling, 'Style', 'text');
            ui_edit_meas_rescaling = uicontrol(ui_panel_meas_scaling, 'Style', 'edit');
            ui_checkbox_meas_fdr1 = uicontrol(ui_panel_meas_scaling, 'Style',  'checkbox');
            ui_edit_meas_fdr1 = uicontrol(ui_panel_meas_scaling, 'Style', 'edit');
            ui_checkbox_meas_fdr2 = uicontrol(ui_panel_meas_scaling, 'Style',  'checkbox');
            ui_edit_meas_fdr2 = uicontrol(ui_panel_meas_scaling, 'Style', 'edit');
            ui_button_meas_automatic = uicontrol(ui_panel_meas_scaling, 'Style', 'pushbutton');
            
            % mesure figure options            
            ui_checkbox_meas_symbolsize = uicontrol(f, 'Style',  'checkbox');
            ui_edit_meas_symbolsize = uicontrol(f, 'Style', 'edit');
            ui_checkbox_meas_symbolcolor = uicontrol(f, 'Style',  'checkbox');
            ui_popup_meas_initcolor = uicontrol(f, 'Style', 'popup', 'String', {''});
            ui_popup_meas_fincolor = uicontrol(f, 'Style', 'popup', 'String', {''});
            ui_checkbox_meas_sphereradius = uicontrol(f, 'Style',  'checkbox');
            ui_edit_meas_sphereradius = uicontrol(f, 'Style', 'edit');
            ui_checkbox_meas_spherecolor = uicontrol(f, 'Style',  'checkbox');
            ui_popup_meas_sphinitcolor = uicontrol(f, 'Style', 'popup', 'String', {''});
            ui_popup_meas_sphfincolor = uicontrol(f, 'Style', 'popup', 'String', {''});
            ui_checkbox_meas_spheretransparency = uicontrol(f, 'Style',  'checkbox');
            ui_slider_meas_spheretransparency = uicontrol(f, 'Style', 'slider');
            ui_checkbox_meas_labelsize = uicontrol(f, 'Style',  'checkbox');
            ui_edit_meas_labelsize = uicontrol(f, 'Style', 'edit');
            ui_checkbox_meas_labelcolor = uicontrol(f, 'Style',  'checkbox');
            ui_popup_meas_labelinitcolor = uicontrol(f, 'Style', 'popup', 'String', {''});
            ui_popup_meas_labelfincolor = uicontrol(f, 'Style', 'popup', 'String', {''});
            
            init_measures_panel()     
            update_figure_panel()
            update_popup_grouplist()
            update_measure_data();
            
            set(f, 'Visible', 'on')
            
            %% Callback functions
            function init_measures_panel()
                % actions ****************************************
                set(ui_action_measures_checkbox, 'Units', 'normalized')
                set(ui_action_measures_checkbox, 'Position', [.02 .95 .28 .03])
                set(ui_action_measures_checkbox, 'Value', true)
                set(ui_action_measures_checkbox, 'String', 'Measurement')
                set(ui_action_measures_checkbox, 'Callback', {@cb_action_measurement})
                
                set(ui_action_comparison_checkbox, 'Units', 'normalized')
                set(ui_action_comparison_checkbox, 'Position', [.32 .95 .28 .03])
                set(ui_action_comparison_checkbox, 'Value', false)
                set(ui_action_comparison_checkbox, 'String', 'Comparison')
                set(ui_action_comparison_checkbox, 'Callback', {@cb_action_comparison})
                
                set(ui_action_random_checkbox, 'Units', 'normalized')
                set(ui_action_random_checkbox, 'Position', [.62 .95 .28 .03])
                set(ui_action_random_checkbox, 'Value', false)
                set(ui_action_random_checkbox, 'String', 'Random Comparison')
                set(ui_action_random_checkbox, 'Callback', {@cb_action_random})
                
                % text ***************************************
                set(ui_text_group1, 'Units', 'normalized')
                set(ui_text_group1, 'Position', [.02 .9125 .25 .035])
                set(ui_text_group1, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_text_group1, 'String', 'group 1')
                set(ui_text_group1, 'HorizontalAlignment', 'left')
                set(ui_text_group1, 'FontWeight', 'bold')
                
                set(ui_text_group2, 'Units', 'normalized')
                set(ui_text_group2, 'Position', [.02 .795 .25 .035])
                set(ui_text_group2, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_text_group2, 'String', 'group 2')
                set(ui_text_group2, 'HorizontalAlignment', 'left')
                set(ui_text_group2, 'FontWeight', 'bold')
                
                set(ui_text_view_action, 'Units', 'normalized')
                set(ui_text_view_action, 'Position', [0.4525 .9125 .40 .035])
                set(ui_text_view_action, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_text_view_action, 'HorizontalAlignment', 'center')
                set(ui_text_view_action, 'FontWeight', 'bold')
  
                % groups *******************************************
                set(ui_popup_grouplists1, 'Units', 'normalized')
                set(ui_popup_grouplists1, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_grouplists1, 'Position', [.02 .86 .30 .04])
                set(ui_popup_grouplists1, 'Value', 1)
                set(ui_popup_grouplists1, 'TooltipString', 'Select group1');
                set(ui_popup_grouplists1, 'Callback', {@cb_popup_grouplist})
                
                set(ui_popup_grouplists2, 'Units', 'normalized')
                set(ui_popup_grouplists2, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_grouplists2, 'Position', [.02 .7575 .30 .04])
                set(ui_popup_grouplists2, 'Value', 1)
                set(ui_popup_grouplists2, 'TooltipString', 'Select group2');
                set(ui_popup_grouplists2, 'Callback', {@cb_popup_grouplist})                
              
                % measure list ***************************************
                set(ui_list_gr, 'Units', 'normalized')
                set(ui_list_gr, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_list_gr, 'String', cellfun(@(x) Measure.getName(x), mlist, 'UniformOutput', false))
                set(ui_list_gr, 'Value', 1)
                set(ui_list_gr, 'Max', -1, 'Min', 0)
                set(ui_list_gr, 'BackgroundColor', [1 1 1])
                set(ui_list_gr, 'Position', [.02 .02 .30 .68])
                set(ui_list_gr, 'TooltipString', 'Select brain regions');
                set(ui_list_gr, 'Callback', {@cb_list_gr});
                
                % panels ******************************************
                set(ui_panel_meas_scaling, 'Position', [.35 .65 .605 .2550])
                
                set(ui_text_meas_offset, 'Units', 'normalized')
                set(ui_text_meas_offset, 'Position', [.02 .75 .15 .15])
                set(ui_text_meas_offset, 'String', 'offset')
                set(ui_text_meas_offset, 'HorizontalAlignment', 'center')
                set(ui_text_meas_offset, 'FontWeight', 'bold')
                
                set(ui_edit_meas_offset, 'Units', 'normalized')
                set(ui_edit_meas_offset, 'String', '0')
                set(ui_edit_meas_offset, 'Enable', 'on')
                set(ui_edit_meas_offset, 'Position', [.2 .75 .25 .15])
                set(ui_edit_meas_offset, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_offset, 'FontWeight', 'bold')
                set(ui_edit_meas_offset, 'Callback', {@cb_edit_meas_offset})
                
                set(ui_text_meas_rescaling, 'Units', 'normalized')
                set(ui_text_meas_rescaling, 'Position', [.02 .45 .15 .15])
                set(ui_text_meas_rescaling, 'String', 'rescale')
                set(ui_text_meas_rescaling, 'HorizontalAlignment', 'center')
                set(ui_text_meas_rescaling, 'FontWeight', 'bold')
                
                set(ui_edit_meas_rescaling, 'Units', 'normalized')
                set(ui_edit_meas_rescaling, 'String', '10')
                set(ui_edit_meas_rescaling, 'Enable', 'on')
                set(ui_edit_meas_rescaling, 'Position', [.2 .45 .25 .15])
                set(ui_edit_meas_rescaling, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_rescaling, 'FontWeight', 'bold')
                set(ui_edit_meas_rescaling, 'Callback', {@cb_edit_meas_rescaling})
                
                set(ui_button_meas_automatic, 'Units', 'normalized')
                set(ui_button_meas_automatic, 'Position', [.3 .02 .4 .2])
                set(ui_button_meas_automatic, 'String', 'Automatic rescaling')
                set(ui_button_meas_automatic, 'HorizontalAlignment', 'center')
                set(ui_button_meas_automatic, 'Callback', {@cb_meas_automatic})
                
                set(ui_checkbox_meas_fdr1, 'Units', 'normalized')
                set(ui_checkbox_meas_fdr1, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_fdr1, 'Position', [.47 .75 .25 .15])
                set(ui_checkbox_meas_fdr1, 'String', 'fdr (1-tailed)')
                set(ui_checkbox_meas_fdr1, 'Value', false)
                set(ui_checkbox_meas_fdr1, 'FontWeight', 'bold')
                set(ui_checkbox_meas_fdr1, 'TooltipString', 'apply 1-tailed false discovery rate limit')
                set(ui_checkbox_meas_fdr1, 'Callback', {@cb_checkbox_meas_fdr1})
                
                set(ui_edit_meas_fdr1, 'Units', 'normalized')
                set(ui_edit_meas_fdr1, 'String', '0.05')
                set(ui_edit_meas_fdr1, 'Position', [.74 0.75 .2 .15])
                set(ui_edit_meas_fdr1, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_fdr1, 'FontWeight', 'bold')
                set(ui_edit_meas_fdr1, 'Callback', {@cb_edit_meas_fdr1})
                
                set(ui_checkbox_meas_fdr2, 'Units', 'normalized')
                set(ui_checkbox_meas_fdr2, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_fdr2, 'Position', [.47 .45 .25 .15])
                set(ui_checkbox_meas_fdr2, 'String', 'fdr (2-tailed)')
                set(ui_checkbox_meas_fdr2, 'Value', false)
                set(ui_checkbox_meas_fdr2, 'FontWeight', 'bold')
                set(ui_checkbox_meas_fdr2, 'TooltipString', 'apply false discovery rate limit')
                set(ui_checkbox_meas_fdr2, 'Callback', {@cb_checkbox_meas_fdr2})
                
                set(ui_edit_meas_fdr2, 'Units', 'normalized')
                set(ui_edit_meas_fdr2, 'String', '0.05')
                set(ui_edit_meas_fdr2, 'Position', [.74 0.45 .2 .15])
                set(ui_edit_meas_fdr2, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_fdr2, 'FontWeight', 'bold')
                set(ui_edit_meas_fdr2, 'Callback', {@cb_edit_meas_fdr2})
                
                % measure figure *******************************
                set(ui_checkbox_meas_symbolsize, 'Units', 'normalized')
                set(ui_checkbox_meas_symbolsize, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_symbolsize, 'Position', [.35 .6 .30 .04])
                set(ui_checkbox_meas_symbolsize, 'String', ' Symbol Size ')
                set(ui_checkbox_meas_symbolsize, 'Value', false)
                set(ui_checkbox_meas_symbolsize, 'FontWeight', 'bold')
                set(ui_checkbox_meas_symbolsize, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_symbolsize, 'Callback', {@cb_checkbox_meas_symbolsize})
                
                set(ui_edit_meas_symbolsize, 'Units', 'normalized')
                set(ui_edit_meas_symbolsize, 'String', PlotBrainGraph.INIT_SYM_SIZE)
                set(ui_edit_meas_symbolsize, 'Enable', 'off')
                set(ui_edit_meas_symbolsize, 'Position', [.7050 .6 .25 .04])
                set(ui_edit_meas_symbolsize, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_symbolsize, 'FontWeight', 'bold')
                set(ui_edit_meas_symbolsize, 'Callback', {@cb_edit_meas_symbolsize})
                
                set(ui_checkbox_meas_symbolcolor, 'Units', 'normalized')
                set(ui_checkbox_meas_symbolcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_symbolcolor, 'Position', [.35 .515 .23 .04])
                set(ui_checkbox_meas_symbolcolor, 'String', ' Symbol Color ')
                set(ui_checkbox_meas_symbolcolor, 'Value', false)
                set(ui_checkbox_meas_symbolcolor, 'FontWeight', 'bold')
                set(ui_checkbox_meas_symbolcolor, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_symbolcolor, 'Callback', {@cb_checkbox_meas_symbolcolor})
                
                set(ui_popup_meas_initcolor, 'Units', 'normalized')
                set(ui_popup_meas_initcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_initcolor, 'Enable', 'off')
                set(ui_popup_meas_initcolor, 'Position', [.7050 .52 .11 .04])
                set(ui_popup_meas_initcolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_initcolor, 'Value', 3)
                set(ui_popup_meas_initcolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_initcolor, 'Callback', {@cb_meas_initcolor})
                
                set(ui_popup_meas_fincolor, 'Units', 'normalized')
                set(ui_popup_meas_fincolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_fincolor, 'Enable', 'off')
                set(ui_popup_meas_fincolor, 'Position', [0.8450 .52 .11 .04])
                set(ui_popup_meas_fincolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_fincolor, 'Value', 1)
                set(ui_popup_meas_fincolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_fincolor, 'Callback', {@cb_meas_fincolor})
                
                set(ui_checkbox_meas_sphereradius, 'Units', 'normalized')
                set(ui_checkbox_meas_sphereradius, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_sphereradius, 'Position', [.35 0.415 .30 .04])
                set(ui_checkbox_meas_sphereradius, 'String', ' Sphere Radius ')
                set(ui_checkbox_meas_sphereradius, 'Value', false)
                set(ui_checkbox_meas_sphereradius, 'FontWeight', 'bold')
                set(ui_checkbox_meas_sphereradius, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_sphereradius, 'Callback', {@cb_checkbox_meas_sphereradius})
                
                set(ui_edit_meas_sphereradius, 'Units', 'normalized')
                set(ui_edit_meas_sphereradius, 'String', PlotBrainGraph.INIT_SPH_R)
                set(ui_edit_meas_sphereradius, 'Enable', 'off')
                set(ui_edit_meas_sphereradius, 'Position', [.7050 0.42 .25 .04])
                set(ui_edit_meas_sphereradius, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_sphereradius, 'FontWeight', 'bold')
                set(ui_edit_meas_sphereradius, 'Callback', {@cb_edit_meas_sphereradius})
                
                set(ui_checkbox_meas_spherecolor, 'Units', 'normalized')
                set(ui_checkbox_meas_spherecolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_spherecolor, 'Position', [.35 0.315 .45 .04])
                set(ui_checkbox_meas_spherecolor, 'String', ' Sphere Color ')
                set(ui_checkbox_meas_spherecolor, 'Value', false)
                set(ui_checkbox_meas_spherecolor, 'FontWeight', 'bold')
                set(ui_checkbox_meas_spherecolor, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_spherecolor, 'Callback', {@cb_checkbox_meas_spherecolor})
                
                set(ui_popup_meas_sphinitcolor, 'Units', 'normalized')
                set(ui_popup_meas_sphinitcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_sphinitcolor, 'Enable', 'off')
                set(ui_popup_meas_sphinitcolor, 'Position', [.7050 .32 .11 .04])
                set(ui_popup_meas_sphinitcolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_sphinitcolor, 'Value', 1)
                set(ui_popup_meas_sphinitcolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_sphinitcolor, 'Callback', {@cb_meas_sphinitcolor})
                
                set(ui_popup_meas_sphfincolor, 'Units', 'normalized')
                set(ui_popup_meas_sphfincolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_sphfincolor, 'Enable', 'off')
                set(ui_popup_meas_sphfincolor, 'Position', [0.8450 .32 .11 .04])
                set(ui_popup_meas_sphfincolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_sphfincolor, 'Value', 3)
                set(ui_popup_meas_sphfincolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_sphfincolor, 'Callback', {@cb_meas_sphfincolor})
                
                set(ui_checkbox_meas_spheretransparency, 'Units', 'normalized')
                set(ui_checkbox_meas_spheretransparency, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_spheretransparency, 'Position', [.35 0.215 .32 .04])
                set(ui_checkbox_meas_spheretransparency, 'String', ' Sphere Transparency ')
                set(ui_checkbox_meas_spheretransparency, 'Value', false)
                set(ui_checkbox_meas_spheretransparency, 'FontWeight', 'bold')
                set(ui_checkbox_meas_spheretransparency, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_spheretransparency, 'Callback', {@cb_checkbox_meas_spheretransparency})
                
                set(ui_slider_meas_spheretransparency, 'Units', 'normalized')
                set(ui_slider_meas_spheretransparency, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_slider_meas_spheretransparency, 'Min', 0, 'Max', 1, 'Value', PlotBrainGraph.INIT_SPH_FACE_ALPHA);
                set(ui_slider_meas_spheretransparency, 'Enable', 'off')
                set(ui_slider_meas_spheretransparency, 'Position', [.7050 0.22 .25 .04])
                set(ui_slider_meas_spheretransparency, 'TooltipString', 'Brain region transparency (applied both to faces and edges)')
                set(ui_slider_meas_spheretransparency, 'Callback', {@cb_slider_meas_spheretransparency})
                
                set(ui_checkbox_meas_labelsize, 'Units', 'normalized')
                set(ui_checkbox_meas_labelsize, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_labelsize, 'Position', [.35 .115 .32 .04])
                set(ui_checkbox_meas_labelsize, 'String', ' Label Size ')
                set(ui_checkbox_meas_labelsize, 'Value', false)
                set(ui_checkbox_meas_labelsize, 'FontWeight', 'bold')
                set(ui_checkbox_meas_labelsize, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_labelsize, 'Callback', {@cb_checkbox_meas_labelsize})
                
                set(ui_edit_meas_labelsize, 'Units', 'normalized')
                set(ui_edit_meas_labelsize, 'String', PlotBrainGraph.INIT_LAB_FONT_SIZE)
                set(ui_edit_meas_labelsize, 'Enable', 'off')
                set(ui_edit_meas_labelsize, 'Position', [.7050 .12 .25 .04])
                set(ui_edit_meas_labelsize, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_labelsize, 'FontWeight', 'bold')
                set(ui_edit_meas_labelsize, 'Callback', {@cb_edit_meas_labelsize})
                
                set(ui_checkbox_meas_labelcolor, 'Units', 'normalized')
                set(ui_checkbox_meas_labelcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_labelcolor, 'Position', [.35 0.0150 .32 .04])
                set(ui_checkbox_meas_labelcolor, 'String', ' Label Color ')
                set(ui_checkbox_meas_labelcolor, 'Value', false)
                set(ui_checkbox_meas_labelcolor, 'FontWeight', 'bold')
                set(ui_checkbox_meas_labelcolor, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_labelcolor, 'Callback', {@cb_checkbox_meas_labelcolor})
                
                set(ui_popup_meas_labelinitcolor, 'Units', 'normalized')
                set(ui_popup_meas_labelinitcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_labelinitcolor, 'Enable', 'off')
                set(ui_popup_meas_labelinitcolor, 'Position', [.7050 .02 .11 .04])
                set(ui_popup_meas_labelinitcolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_labelinitcolor, 'Value', 1)
                set(ui_popup_meas_labelinitcolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_labelinitcolor, 'Callback', {@cb_meas_labelinitcolor})
                
                set(ui_popup_meas_labelfincolor, 'Units', 'normalized')
                set(ui_popup_meas_labelfincolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_labelfincolor, 'Enable', 'off')
                set(ui_popup_meas_labelfincolor, 'Position', [0.8450 .02 .11 .04])
                set(ui_popup_meas_labelfincolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_labelfincolor, 'Value', 3)
                set(ui_popup_meas_labelfincolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_labelfincolor, 'Callback', {@cb_meas_labelfincolor})
            end
            function cb_action_measurement(~, ~)
                value = true;
                set(ui_action_measures_checkbox, 'Value', value) 
                set(ui_action_comparison_checkbox, 'Value', ~value)
                set(ui_action_random_checkbox, 'Value', ~value)
                update_figure_panel()
            end
            function cb_action_comparison(~, ~)
                value = true;
                set(ui_action_measures_checkbox, 'Value', ~value) 
                set(ui_action_comparison_checkbox, 'Value', value)
                set(ui_action_random_checkbox, 'Value', ~value)                
                update_figure_panel()
            end
            function cb_action_random(~, ~)
                value = true;
                set(ui_action_measures_checkbox, 'Value', ~value) 
                set(ui_action_comparison_checkbox, 'Value', ~value)
                set(ui_action_random_checkbox, 'Value', value)                
                update_figure_panel()
            end
            function update_figure_panel()
                if get(ui_action_comparison_checkbox, 'Value')
                    % generals
                    set(ui_popup_grouplists2, 'Enable', 'on')
                    set(ui_text_group2, 'Enable', 'on')
                    set(ui_text_view_action, 'String', 'View difference')
                    % mesure panel
                    set(ui_checkbox_meas_fdr1, 'Enable', 'on')
                    set(ui_checkbox_meas_fdr2, 'Enable', 'on')
                    set(ui_edit_meas_fdr1, 'Enable', 'off')
                    set(ui_edit_meas_fdr2, 'Enable', 'off')
                elseif get(ui_action_random_checkbox, 'Value')
                    set(ui_popup_grouplists2, 'Enable', 'off')
                    set(ui_text_group2, 'Enable', 'off')
                    set(ui_text_view_action, 'String', 'View measure')
                    
                    set(ui_checkbox_meas_fdr1, 'Enable', 'off')
                    set(ui_checkbox_meas_fdr2, 'Enable', 'off')
                    set(ui_edit_meas_fdr1, 'Enable', 'off')
                    set(ui_edit_meas_fdr2, 'Enable', 'off')
                else
                    set(ui_popup_grouplists2, 'Enable', 'off')
                    set(ui_text_group2, 'Enable', 'off')
                    set(ui_text_view_action, 'String', 'View measure')
                    
                    set(ui_checkbox_meas_fdr1, 'Enable', 'off')
                    set(ui_checkbox_meas_fdr2, 'Enable', 'off')
                    set(ui_edit_meas_fdr1, 'Enable', 'off')
                    set(ui_edit_meas_fdr2, 'Enable', 'off')
                end
            end
            function update_popup_grouplist()
                if ga.getCohort().getGroups().length() > 0
                    % updates group lists of popups
                    GroupList = ga.getCohort().getGroups().getKeys();
%                     for g = 1:1:ga.getCohort().getGroups().length()
%                         GroupList{g} = ga.getCohort().getGroups().getValue(g);
%                     end
                else
                    GroupList = {''};
                end
                set(ui_popup_grouplists1, 'String', GroupList)
                set(ui_popup_grouplists2, 'String', GroupList)
            end
            function cb_list_gr(~, ~)
                update_measure_data()
                update_brain_meas_plot()
            end
            function cb_popup_grouplist(~, ~)  % (src, event)
                update_measure_data()
                update_brain_meas_plot()
            end
            function cb_edit_meas_offset(~, ~)  %  (src, event)
                offset = real(str2double(get(ui_edit_meas_offset, 'String')));
                if isempty(offset)
                    set(ui_edit_meas_offset, 'String', '100')
                else
                    set(ui_edit_meas_offset, 'String', num2str(offset))
                end
                update_brain_meas_plot()
            end
            function cb_edit_meas_rescaling(~, ~)  %  (src, event)
                rescaling = real(str2double(get(ui_edit_meas_rescaling, 'String')));
                if isempty(rescaling) || isnan(rescaling) || rescaling < 10^(-4) || rescaling > (10^+4)
                    set(ui_edit_meas_rescaling, 'String', '10')
                else
                    set(ui_edit_meas_rescaling, 'String', num2str(rescaling))
                end
                update_brain_meas_plot()
            end
            function cb_checkbox_meas_fdr1(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_fdr1, 'Value')
                    set(ui_edit_meas_fdr1, 'Enable', 'on')
                    set(ui_edit_meas_fdr2, 'Enable', 'off')
                    set(ui_checkbox_meas_fdr2, 'Enable', 'off')
                    
                    update_measure_data()
                    update_brain_meas_plot()
                else
                    set(ui_edit_meas_fdr1, 'Enable', 'off')
                    set(ui_checkbox_meas_fdr2, 'Enable', 'on')
                    
                    update_measure_data()
                    update_brain_meas_plot()
                end
            end
            function cb_edit_meas_fdr1(~, ~)  %  (src, event)
                lim = real(str2double(get(ui_edit_meas_fdr1, 'String')));
                if isempty(lim) || lim <= 0 || lim > 1
                    set(ui_edit_meas_fdr1, 'String', '0.05')
                else
                    set(ui_edit_meas_fdr1, 'String', num2str(lim))
                end
                update_measure_data()
                update_brain_meas_plot()
            end
            function cb_checkbox_meas_fdr2(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_fdr2, 'Value')
                    set(ui_edit_meas_fdr2, 'Enable', 'on')
                    set(ui_edit_meas_fdr1, 'Enable', 'off')
                    set(ui_checkbox_meas_fdr1, 'Enable', 'off')
                    
                    update_measure_data()
                    update_brain_meas_plot()
                else
                    set(ui_edit_meas_fdr2, 'Enable', 'off')
                    set(ui_checkbox_meas_fdr1, 'Enable', 'on')
                    
                    update_measure_data()
                    update_brain_meas_plot()
                end
            end
            function cb_edit_meas_fdr2(~, ~)  %  (src, event)
                lim = real(str2double(get(ui_edit_meas_fdr2, 'String')));
                if isempty(lim) || lim <= 0 || lim > 1
                    set(ui_edit_meas_fdr2, 'String', '0.05')
                else
                    set(ui_edit_meas_fdr2, 'String', num2str(lim))
                end
                update_measure_data()
                update_brain_meas_plot()
            end
            function cb_meas_automatic(~, ~)  %  (src, event)
                if ~isempty(measure_data)
                    offset = min(measure_data);
                    if isnan(offset) || offset == 0 || ~isreal(offset)
                        set(ui_edit_meas_offset, 'String', '0');
                    else
                        set(ui_edit_meas_offset, 'String', num2str(offset))
                    end
                    
                    rescaling = max(measure_data) - offset;
                    if rescaling == 0 || isnan(rescaling) || ~isreal(rescaling)
                        set(ui_edit_meas_rescaling, 'String', '1');
                    else
                        set(ui_edit_meas_rescaling, 'String', num2str(rescaling))
                    end
                    
                    update_brain_meas_plot()
                end
            end
            function cb_checkbox_meas_symbolsize(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_symbolsize, 'Value')
                    set(ui_edit_meas_symbolsize, 'Enable', 'on')
                    
                    update_brain_meas_plot()
                else
                    size = str2double(get(ui_edit_meas_symbolsize, 'String'));
                    size = 1 + size;
                    bg.br_syms([], 'Size', size);
                    
                    set(ui_edit_meas_symbolsize, 'Enable', 'off')
                    update_brain_meas_plot()
                end
            end
            function cb_edit_meas_symbolsize(~, ~)  %  (src, event)
                size = real(str2double(get(ui_edit_meas_symbolsize, 'String')));
                if isempty(size) || size<=0
                    set(ui_edit_meas_symbolsize, 'String', '1')
                    size = 5;
                end
                update_brain_meas_plot()
            end
            function cb_checkbox_meas_symbolcolor(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_symbolcolor, 'Value')
                    set(ui_popup_meas_initcolor, 'Enable', 'on')
                    set(ui_popup_meas_fincolor, 'Enable', 'on')
                    
                    update_brain_meas_plot()
                else
                    val = get(ui_popup_meas_initcolor, 'Value');
                    str = get(ui_popup_meas_initcolor, 'String');
                    bg.br_syms([], 'Color', str{val});
                    
                    set(ui_popup_meas_initcolor, 'Enable', 'off')
                    set(ui_popup_meas_fincolor, 'Enable', 'off')
                    
                    update_brain_meas_plot()
                end
            end
            function cb_meas_initcolor(~, ~)  %  (src, event)
                update_brain_meas_plot()
            end
            function cb_meas_fincolor(~, ~)  %  (src, event)
                update_brain_meas_plot()
            end
            function cb_checkbox_meas_sphereradius(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_sphereradius, 'Value')
                    set(ui_edit_meas_sphereradius, 'Enable', 'on')
                    
                    update_brain_meas_plot()
                else
                    R = str2double(get(ui_edit_meas_sphereradius, 'String'));
                    R = R + 1;
                    bg.br_sphs([], 'R', R);
                    
                    set(ui_edit_meas_sphereradius, 'Enable', 'off')
                    update_brain_meas_plot()
                end
            end
            function cb_edit_meas_sphereradius(~, ~)  %  (src, event)
                R = real(str2double(get(ui_edit_meas_sphereradius, 'String')));
                if isempty(R) || R<=0
                    set(ui_edit_meas_sphereradius, 'String', '1')
                    R = 3;
                end
                update_brain_meas_plot()
            end
            function cb_checkbox_meas_spherecolor(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_spherecolor, 'Value')
                    set(ui_popup_meas_sphinitcolor, 'Enable', 'on')
                    set(ui_popup_meas_sphfincolor, 'Enable', 'on')
                    update_brain_meas_plot()
                else
                    val = get(ui_popup_meas_sphinitcolor, 'Value');
                    str = get(ui_popup_meas_sphinitcolor, 'String');
                    bg.br_sphs([], 'Color', str{val});
                    
                    set(ui_popup_meas_sphinitcolor, 'Enable', 'off')
                    set(ui_popup_meas_sphfincolor, 'Enable', 'off')
                    update_brain_meas_plot()
                end
            end
            function cb_meas_sphinitcolor(~, ~)  %  (src, event)
                update_brain_meas_plot()
            end
            function cb_meas_sphfincolor(~, ~)  %  (src, event)
                update_brain_meas_plot()
            end
            function cb_checkbox_meas_spheretransparency(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_spheretransparency, 'Value')
                    set(ui_slider_meas_spheretransparency, 'Enable', 'on')
                    
                    update_brain_meas_plot()
                else
                    alpha = get(ui_slider_meas_spheretransparency, 'Value');
                    bg.br_sphs([], 'Alpha', alpha);
                    
                    set(ui_slider_meas_spheretransparency, 'Enable', 'off')
                    update_brain_meas_plot()
                end
            end
            function cb_slider_meas_spheretransparency(~, ~)  %  (src, event)
                update_brain_meas_plot();
            end
            function cb_checkbox_meas_labelsize(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_labelsize, 'Value')
                    set(ui_edit_meas_labelsize, 'Enable', 'on')
                    
                    update_brain_meas_plot()
                else
                    size = str2double(get(ui_edit_meas_labelsize, 'String'));
                    size = size + 1;
                    bg.br_labs([], 'FontSize', size);
                    
                    set(ui_edit_meas_labelsize, 'Enable', 'off')
                    update_brain_meas_plot()
                end
            end
            function cb_edit_meas_labelsize(~, ~)  %  (src, event)
                size = real(str2double(get(ui_edit_meas_labelsize, 'String')));
                if isempty(size) || size<=0
                    set(ui_edit_meas_labelsize, 'String', '1')
                    size = 5;
                end
                update_brain_meas_plot()
            end
            function cb_checkbox_meas_labelcolor(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_labelcolor, 'Value')
                    set(ui_popup_meas_labelinitcolor, 'Enable', 'on')
                    set(ui_popup_meas_labelfincolor, 'Enable', 'on')
                    
                    update_brain_meas_plot()
                else
                    val = get(ui_popup_meas_labelinitcolor, 'Value');
                    str = get(ui_popup_meas_labelinitcolor, 'String');
                    bg.br_labs([], 'Color', str{val});
                    
                    set(ui_popup_meas_labelinitcolor, 'Enable', 'off')
                    set(ui_popup_meas_labelfincolor, 'Enable', 'off')
                    update_brain_meas_plot()
                end
            end
            function cb_meas_labelinitcolor(~, ~)  %  (src, event)
                update_brain_meas_plot()
            end
            function cb_meas_labelfincolor(~, ~)  %  (src, event)
                update_brain_meas_plot()
            end
            function update_measure_data()
                i = get(ui_list_gr, 'Value');
                group1_index = get(ui_popup_grouplists1, 'Value');
                group1 = ga.getCohort().getGroups().getValue(group1_index);
                measure = mlist{i};
                selected_case = [];
                if get(ui_action_comparison_checkbox, 'Value')
                    % i want to look in comprison
                    group2_index = get(ui_popup_grouplists2, 'Value');
                    group2 = ga.getCohort().getGroups().getValue(group2_index);
                    comparisons_idict = ga.getComparisons();
                    
                    for i = 1:1:comparisons_idict.lenth()
                        comparison = comparisons_idict.getValue(i);
                        [a, b] = comparison.getGroups();
                        if isequal(comparison.getMeasureCode(), measure) && ((isequal(a, group1) && isequal (b, group2)) || (isequal(a, group2) && isequal (b, group1)))
                            selected_case = comparison;
                        end
                    end
                    
                elseif get(ui_action_random_checkbox, 'Value')
                    % i want to look in rcomprison
                    randoms_idict = ga.getRandomComparisons();
                    for i = 1:1:randoms_idict.lenth()
                        r_comparison = randoms_idict.getValue(i);
                        g = r_comparison.getGroup();
                        if isequal(r_comparison.getMeasureCode(), measure) && isequal(g, group1) 
                            selected_case = r_comparison;
                        end
                    end
                else
                    % i want to look in measurements
                    randoms_idict = ga.getRandomComparisons();
                    for i = 1:1:randoms_idict.lenth()
                        r_comparison = randoms_idict.getValue(i);
                        g = r_comparison.getGroup();
                        if isequal(r_comparison.getMeasureCode(), measure) && isequal(g, group1)
                            selected_case = r_comparison;
                        end
                    end
                end
                
%                 if isempty(i) || length(i) > 1
%                     i = 1;
%                 end
%                 [measures, mi] = ga.getComparisons(mlist(get(ui_list_gr, 'Value')), get(ui_popup_grouplists1, 'Value'), get(ui_popup_grouplists2, 'Value'));
%                 if isempty(measures)
%                     errordlg('The measure does not exist')
%                 else
%                     meas = measures{1};
%                     measure_data = abs(meas.diff());
%                     
%                     fdr_lim = ones(1, length(ga.getBrainAtlas));
%                     p1 = measures{1}.getProp(MRIComparisonWU.PVALUE1);
%                     p2 = measures{1}.getProp(MRIComparisonWU.PVALUE2);
%                     for i = 1:1:length(ga.getBrainAtlas)
%                         if get(ui_checkbox_meas_fdr1, 'Value')
%                             if p1(i)>fdr(p1, str2double(get(ui_edit_meas_fdr1, 'String')))
%                                 fdr_lim(i) = 0;
%                             end
%                         elseif get(ui_checkbox_meas_fdr2, 'Value')
%                             if p2(i)>fdr(p2, str2double(get(ui_edit_meas_fdr2, 'String')))
%                                 fdr_lim(i) = 0;
%                             end
%                         end
%                     end
%                 end
                
                
            end
           
            function update_brain_meas_plot()
                
                if get(ui_checkbox_meas_symbolsize, 'Value')
                    
                    size = str2double(get(ui_edit_meas_symbolsize, 'String'));
                    offset = str2double(get(ui_edit_meas_offset, 'String'));
                    rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                    
                    size = (1 + ((measure_data - offset)./rescaling)*size).*fdr_lim;
                    size(isnan(size)) = 0.1;
                    size(size<=0) = 0.1;
                    bg.br_syms([], 'Size', size);
                end
                
                if get(ui_checkbox_meas_symbolcolor, 'Value')
                    
                    offset = str2double(get(ui_edit_meas_offset, 'String'));
                    rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                    
                    colorValue = (measure_data - offset)./rescaling;
                    %colorValue = (measure_data - min(measure_data))./(max(measure_data)-min(measure_data));
                    colorValue(isnan(colorValue)) = 0;
                    colorValue(colorValue<0) = 0;
                    colorValue(colorValue>1) = 1;
                    
                    C = zeros(length(colorValue), 3);
                    
                    val1 = get(ui_popup_meas_initcolor, 'Value');
                    val2 = get(ui_popup_meas_fincolor, 'Value');
                    C(:, val1) = colorValue;
                    C(:, val2) = 1 - colorValue;
                    
                    bg.br_syms([], 'Color', C);
                end
                
                if get(ui_checkbox_meas_sphereradius, 'Value')
                    
                    R = str2double(get(ui_edit_meas_sphereradius, 'String'));
                    offset = str2double(get(ui_edit_meas_offset, 'String'));
                    rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                    
                    R = (1 + ((measure_data - offset)./rescaling)*R).*fdr_lim;
                    R(isnan(R)) = 0.1;
                    R(R<=0) = 0.1;
                    bg.br_sphs([], 'R', R);
                end
                
                if get(ui_checkbox_meas_spherecolor, 'Value')
                    
                    offset = str2double(get(ui_edit_meas_offset, 'String'));
                    rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                    
                    colorValue = (measure_data - offset)./rescaling;
                    %colorValue = (measure_data - min(measure_data))./(max(measure_data)-min(measure_data));
                    colorValue(isnan(colorValue)) = 0;
                    colorValue(colorValue<0) = 0;
                    colorValue(colorValue>1) = 1;
                    
                    C = zeros(length(colorValue), 3);
                    
                    val1 = get(ui_popup_meas_sphinitcolor, 'Value');
                    val2 = get(ui_popup_meas_sphfincolor, 'Value');
                    C(:, val1) = colorValue;
                    C(:, val2) = 1 - colorValue;
                    bg.br_sphs([], 'Color', C);
                end
                
                if get(ui_checkbox_meas_spheretransparency, 'Value')
                    
                    alpha = get(ui_slider_meas_spheretransparency, 'Value');
                    offset = str2double(get(ui_edit_meas_offset, 'String'));
                    rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                    
                    alpha_vec = (((measure_data - offset)./rescaling).*alpha).*fdr_lim;
                    alpha_vec(isnan(alpha_vec)) = 0;
                    alpha_vec(alpha_vec<0) = 0;
                    alpha_vec(alpha_vec>1) = 1;
                    bg.br_sphs([], 'Alpha', alpha_vec);
                end
                
                if get(ui_checkbox_meas_labelsize, 'Value')
                    
                    size = str2double(get(ui_edit_meas_labelsize, 'String'));
                    offset = str2double(get(ui_edit_meas_offset, 'String'));
                    rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                    
                    size = (1 + ((measure_data - offset)./rescaling)*size).*fdr_lim;
                    size(isnan(size)) = 0.1;
                    size(size<=0) = 0.1;
                    bg.br_labs([], 'FontSize', size);
                end
                
                if get(ui_checkbox_meas_labelcolor, 'Value')
                    
                    offset = str2double(get(ui_edit_meas_offset, 'String'));
                    rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                    
                    colorValue = (measure_data - offset)./rescaling;
                    %colorValue = (measure_data - min(measure_data))./(max(measure_data)-min(measure_data));
                    colorValue(isnan(colorValue)) = 0;
                    colorValue(colorValue<0) = 0;
                    colorValue(colorValue>1) = 1;
                    
                    C = zeros(length(colorValue), 3);
                    
                    val1 = get(ui_popup_meas_labelinitcolor, 'Value');
                    val2 = get(ui_popup_meas_labelfincolor, 'Value');
                    C(:, val1) = colorValue;
                    C(:, val2) = 1 - colorValue;
                    bg.br_labs([], 'Color', C);
                end
                
            end
        end
    end
end