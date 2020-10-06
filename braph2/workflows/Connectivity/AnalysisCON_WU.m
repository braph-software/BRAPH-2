classdef AnalysisCON_WU < Analysis
    % AnalysisCON_WU An analysis of connectivity data with weighted undirected graphs
    % AnalsysisST_WU is a subclass of Analysis and implements the methods
    % needed for connectivity analysis.
    %
    % AnalysisCON_WU implements the abstract analysis calculting methods
    % to obtain a connectivity measurement, a random comparison or a
    % comparison. AnalysisCON_WU also implements the ID methods to get
    % the correct signature of the analysis.
    % Connectivity data can be for example DTI data.
    %
    % AnalysisCON_WU constructor methods:
    %  AnalysisCON_WU               - Constructor
    %
    % AnalysisCON_WU ID methods:
    %  getMeasurementID             - returns the measurement ID
    %  getRandomComparisonID        - returns the random comparison ID
    %  getComparisonID              - returns the comparison ID
    %
    % AnalysisCON_WU calcultion methods (Access = protected):
    %  get_graph_for_group          - returns the graph of the correlated matrix
    %  get_graph_for_subject        - returns the graph of the correlated matrix
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisCON_WU descriptive methods (Static):
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
    % AnalysisCON_WU Plot panel methods
    %  getGraphPanel                - creates a uipanel
    %  getGlobalPanel               - creates a global uipanel for GUIAnalysis
    %  getNodalPanel                - creates a nodal uipanel for GUIAnalysis
    %  getGlobalMeasurePlot         - returns a global measurement plot
    %  getGlobalComparisonPlot      - returns a global comparison plot
    %  getGlobalRandomComparisonPlot - returns a global randomcomparison plot
    %  getNodalMeasurePlot          - returns a nodal measure plot
    %  getNodalComparisonPlot       - returns a nodal comparison plot
    %  getNodalRandomComparisonPlot - returns a nodal randomcomparison plot
    %  getBinodalMeasurePlot      - returns a binodal measure plot
    %  getBinodalComparisonPlot   - returns a binodal comparison plot
    %  getBinodalRandomComparisonPlot - returns a binodal randomcomparison plot
    %
    % See also Analysis, MeasurementCON_WU, RandomComparisonCON_WU, ComparisonCON_WU
    
    methods  % Constructor
        function analysis = AnalysisCON_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % ANALYSISCON_WU(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a connectivity analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISCON_WU with default settings.
            %
            % ANALYSISCON_WU(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a connectivity analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISCON_WU with specified settings VALUES.
            %
            % See also MeasurementCON_WU, RandomComparisonCON_WU, ComparisonCON_WU.
            
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
    methods (Access = protected)  % Calculation functions
        function graphs = get_graphs_for_group(analysis, group, varargin)
            % GET_GRAPH_FOR_GROUP returns the graph created with the group data
            %
            % G = GET_GRAPH_FOR_GROUP(ANALYSIS, GROUP) creates a
            % graph with the correlation matrix made of the data of
            % subjects of the group
            %
            % See also calculate_measurement.
            
            graph_type = analysis.getGraphType();
            subjects = group.getSubjects();
            graphs = cell(1, group.subjectnumber());
            
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                A = subject.getData('CON').getValue();  % CON matrix
                graphs{i} = Graph.getGraph(graph_type, A);
            end
        end
        function graph = get_graph_for_subject(analysis, subject, varargin)
            % GET_GRAPH_FOR_SUBJECT returns the graph created with the correlation matrix
            %
            % G = GET_GRAPH_FOR_SUBJECT(ANALYSIS, SUBJECT, PROPERY, VALUE, ...) creates a
            % graph with the correlation matrix made of the data of
            % subject. It will binarize the matrix depending on the
            % PROPERTY and VALUE.
            %
            % See also calculate_measurement.
            
            data = subject.getData('CON').getValue();
            graph_type = analysis.getGraphType();
            graph = Graph.getGraph(graph_type, data);
        end
        function measurement = calculate_measurement(analysis, measure_code, group, varargin) %#ok<*INUSL>
            % CALCULATE_MEASUREMENT returns a measurement
            %
            % MEASUREMENT = CALCULTE_MEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subjects. It will return a measurement with the
            % calculated measure. The function will utilize default
            % settings.
            %
            % MEASUREMENT = CALCULTE_MEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subjects. It will return a measurement with the
            % calculated measure. The function will utilize VALUE settings.
            %
            % See also calculate_random_comparison, calculate_comparison.
            
            graphs = analysis.get_graphs_for_group(group, varargin{:});
            measures = cell(1, group.subjectnumber());
            for i = 1:1:group.subjectnumber()
                measure = Measure.getMeasure(measure_code, graphs{i}, varargin{:});
                measures{i} = cell2mat(measure.getValue());
            end
            
            measure_average = mean(reshape(cell2mat(measures), [size(measures{1}, 1), size(measures{1}, 2), group.subjectnumber()]), 3);
            
            measurement = Measurement.getMeasurement(analysis.getMeasurementClass(), ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'MeasurementCON.values', measures, ...
                'MeasurementCON.average_value', measure_average, ...
                varargin{:});
        end
        function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            % CALCULATE_RANDOM_COMPARISON returns a random comparison
            %
            % RANDOMCOMPARISON = CALCULATE_RANDOM_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subjects and random data. It will compare the measures
            % obtained and will return a random comparison. The function
            % will utilize default settings.
            %
            % RANDOMCOMPARISON = CALCULATE_RANDOM_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subjects and random data. It will compare the measures
            % obtained and will return a random comparison. The function
            % will utilize VALUE settings.
            %
            % See also calculate_measurement, calculate_comparison.
            
            % rules
            attempts_per_edge = analysis.getSettings('AnalysisCON.AttemptsPerEdge');
            number_of_weights = analysis.getSettings('AnalysisCON.NumberOfWeights');
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            M = get_from_varargin(1e+3, 'RandomizationNumber', varargin{:});
            
            % Measurements for the group
            measurement_group = analysis.getMeasurement(measure_code, group, varargin{:});
            values_group = measurement_group.getMeasureValues();
            average_value_group = mean(reshape(cell2mat(values_group), [size(values_group{1}, 1), size(values_group{1}, 2), group.subjectnumber()]), 3);
            
            graphs = analysis.get_graphs_for_group(group, varargin{:});
            
            % Randomization
            all_randomizations = cell(1, M);
            all_differences = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                for j = 1:1:length(graphs)
                    g = graphs{j};
                    g_random = g.randomize('AttemptsPerEdge', attempts_per_edge, 'NumberOfWeights', number_of_weights);
                    measure_random = g_random.getMeasure(measure_code);
                    measure_random_packed = measure_random.getValue();
                    values_randomizations{j}  =  measure_random_packed{1}; %#ok<AGROW>
                end
                mean_groups = mean(reshape(cell2mat(values_group), [size(values_group{1}, 1), size(values_group{1}, 2), group.subjectnumber()]), 3);
                mean_randomizations = mean(reshape(cell2mat(values_randomizations), [size(values_randomizations{1}, 1), size(values_randomizations{1}, 2), group.subjectnumber()]), 3);
                all_randomizations{1, i} = mean_randomizations;
                all_differences{1, i} =  mean_groups - mean_randomizations;
                
                if interruptible
                    pause(interruptible)
                end
            end
            
            all_random = all_randomizations{1};
            for i = 2:1:M
                all_random = all_random + all_randomizations{i};
            end
            average_value_random = {all_random / M};
            
            value_random = values_randomizations;
            
            difference = {average_value_group - average_value_random{1}};
            
            % Statistical analysis
            p1 = pvalue1(difference, all_differences);  % singe tail,
            p2 = pvalue2(difference, all_differences);  % double tail
            
            qtl = quantiles(all_differences, 40);
            ci_lower = {cellfun(@(x) x(2), qtl)};
            ci_upper = {cellfun(@(x) x(40), qtl)};
            
            % create randomComparisonClass
            randomcomparison = RandomComparison.getRandomComparison(analysis.getRandomComparisonClass(), ...
                analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
                '', ...  % random comparison label
                '', ...  % random comparison notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group, ...
                'RandomComparisonCON.RandomizationNumber', M, ...
                'RandomComparisonCON.value_group', values_group, ...
                'RandomComparisonCON.value_random', value_random, ...
                'RandomComparisonCON.average_value_group', {average_value_group}, ...
                'RandomComparisonCON.average_value_random', average_value_random, ...
                'RandomComparisonCON.difference', difference, ...
                'RandomComparisonCON.all_differences', all_differences, ...
                'RandomComparisonCON.p1', p1, ...
                'RandomComparisonCON.p2', p2, ....
                'RandomComparisonCON.confidence_min', ci_lower, ...
                'RandomComparisonCON.confidence_max', ci_upper, ...
                varargin{:} ...
                );
        end
        function comparison = calculate_comparison(analysis, measure_code, group_1, group_2, varargin)
            % CALCULATE_COMPARISON returns a comparison
            %
            % COMPARISON = CALCULATE_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP_1 subjects and GROUP_2 data. It will compare the measures
            % obtained and will return a comparison. The function
            % will utilize default settings.
            %
            % COMPARISON = CALCULATE_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP_1 subjects and GROUP_2 data. It will compare the measures
            % obtained and will return a comparison. The function
            % will utilize VALUE settings.
            %
            % See also calculate_random_comparison, calculate_measurement.
            
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            
            is_longitudinal = analysis.getSettings('AnalysisCON.Longitudinal');
            M = get_from_varargin(1e+3, 'PermutationNumber', varargin{:});
            
            % Measurements for groups 1 and 2, and their difference
            measurements_1 = analysis.getMeasurement(measure_code, group_1, varargin{:});
            values_1 = measurements_1.getMeasureValues();
            res_1 = {mean(reshape(cell2mat(values_1), [size(values_1{1}, 1), size(values_1{1}, 2), group_1.subjectnumber()]), 3)};
            
            measurements_2 = analysis.getMeasurement(measure_code, group_2, varargin{:});
            values_2 = measurements_2.getMeasureValues();
            res_2 =  {mean(reshape(cell2mat(values_2), [size(values_2{1}, 1), size(values_2{1}, 2), group_2.subjectnumber()]), 3)};
            
            all_permutations_1 = cell(1, M);
            all_permutations_2 = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                [permutation_1, permutation_2] = permutation(values_1, values_2, is_longitudinal);
                
                mean_permutated_1 = mean(reshape(cell2mat(permutation_1), [size(permutation_1{1}, 1), size(permutation_1{1}, 2), group_1.subjectnumber()]), 3);
                mean_permutated_2 = mean(reshape(cell2mat(permutation_2), [size(permutation_2{1}, 1), size(permutation_2{1}, 2), group_2.subjectnumber()]), 3);
                
                all_permutations_1(1, i) = {mean_permutated_1};
                all_permutations_2(1, i) = {mean_permutated_2};
                
                difference_all_permutations{1, i} = mean_permutated_1 - mean_permutated_2; %#ok<AGROW>
                if interruptible
                    pause(interruptible)
                end
            end
            
            difference_mean = {res_2{1} - res_1{1}};  % difference of the mean values of the non permutated groups
            difference_all_permutations = cellfun(@(x) [x], difference_all_permutations, 'UniformOutput', false);  %#ok<NBRAK> % permutated group 1 - permutated group 2
            
            % Statistical analysis
            p1 = {pvalue1(difference_mean{1}, difference_all_permutations)};  % singe tail,
            p2 = {pvalue2(difference_mean{1}, difference_all_permutations)};  % double tail
            
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
                'ComparisonCON.PermutationNumber', M, ...
                'ComparisonCON.values_1', values_1, ...
                'ComparisonCON.average_values_1', res_1, ...
                'ComparisonCON.values_2', values_2, ...
                'ComparisonCON.average_values_2', res_2, ...
                'ComparisonCON.difference', difference_mean, ...
                'ComparisonCON.all_differences', difference_all_permutations, ...
                'ComparisonCON.p1', p1, ...
                'ComparisonCON.p2', p2, ...
                'ComparisonCON.confidence_min', ci_lower, ...
                'ComparisonCON.confidence_max', ci_upper, ...
                varargin{:});
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of connectivity analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisCON_WU.
            %
            % See also getList, getName, getDescription.
            analysis_class = 'AnalysisCON_WU';
        end
        function name = getName()
            % GETNAME returns the name of connectivity analysis
            %
            % NAME = GETNAME() returns the name of ANALYSIS.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Connectivity WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisCON_WU.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis using CON connectivity matrix, ' ...
                'e.g. activation timeseries for each brain region. ' ...
                'It provides a graph for each subject.' ...
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
            % GETSUBJETCLASS returns the class of connectivity analysis subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of AnalysisCON_WU subject, 'SubjectCON'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectCON';
        end
        function measurement_class = getMeasurementClass()
            % GETMEASUREMENTCLASS returns the class of connectivity analysis measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS() returns the
            % class of AnalysisCON_WU measurement, 'MeasurementCON_WU'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementCON_WU';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of connectivity analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisST_WU randomcomparison,
            % 'RandomComparisonCON_WU'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonCON_WU';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of connectivity analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisCON_WU comparison, 'ComparisonCON_WU'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonCON_WU';
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of connectivity analysis
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(M) returns the
            % available settings of AnalysisCON_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {
                {'AnalysisCON.Longitudinal', BRAPH2.LOGICAL, false, {false, true}}, ...
                {'AnalysisCON.AttemptsPerEdge', BRAPH2.NUMERIC, 1, {}}, ...
                {'AnalysisCON.NumberOfWeights', BRAPH2.NUMERIC, 1, {}} ...
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
            
            subject_labels = {''};
            
            selected_group = 1;
            selected_subject = 1;
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
            
            ui_matrix_subjects_popup = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'popup');
            set(ui_matrix_subjects_popup, 'Position', [.70 .80 .28 .05])
            set(ui_matrix_subjects_popup, 'TooltipString', 'Select Group')
            set(ui_matrix_subjects_popup, 'String', subject_labels)
            set(ui_matrix_subjects_popup, 'Callback', {@cb_group_subjects})
            
            % weighted
            ui_matrix_weighted_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_weighted_checkbox, 'Position', [.70 .70 .28 .05])
            set(ui_matrix_weighted_checkbox, 'String', 'weighted correlation matrix')
            set(ui_matrix_weighted_checkbox, 'Value', true)
            set(ui_matrix_weighted_checkbox, 'TooltipString', 'Select weighted matrix')
            set(ui_matrix_weighted_checkbox, 'FontWeight', 'bold')
            set(ui_matrix_weighted_checkbox, 'Callback', {@cb_matrix_weighted_checkbox})
            
            % density
            ui_matrix_density_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_density_checkbox, 'Position', [.70 .64 .28 .05])
            set(ui_matrix_density_checkbox, 'String', 'binary correlation matrix (set density)')
            set(ui_matrix_density_checkbox, 'Value', false)
            set(ui_matrix_density_checkbox, 'TooltipString', 'Select binary correlation matrix with a set density')
            set(ui_matrix_density_checkbox, 'Callback', {@cb_matrix_density_checkbox})
            
            ui_matrix_density_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
            set(ui_matrix_density_edit, 'Position', [.70 .615 .05 .025])
            set(ui_matrix_density_edit, 'String', '50.00');
            set(ui_matrix_density_edit, 'TooltipString', 'Set density.');
            set(ui_matrix_density_edit, 'FontWeight', 'bold')
            set(ui_matrix_density_edit, 'Enable', 'off')
            set(ui_matrix_density_edit, 'Callback', {@cb_matrix_density_edit});
            
            ui_matrix_density_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
            set(ui_matrix_density_slider, 'Position', [.75 .615 .23 .025])
            set(ui_matrix_density_slider, 'Min', 0, 'Max', 100, 'Value', 50)
            set(ui_matrix_density_slider, 'TooltipString', 'Set density.')
            set(ui_matrix_density_slider, 'Enable', 'off')
            set(ui_matrix_density_slider, 'Callback', {@cb_matrix_density_slider})
            
            % threshold
            ui_matrix_threshold_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_threshold_checkbox, 'Position', [.70 .54 .28 .05])
            set(ui_matrix_threshold_checkbox, 'String', 'binary correlation matrix (set threshold)')
            set(ui_matrix_threshold_checkbox, 'Value', false)
            set(ui_matrix_threshold_checkbox, 'TooltipString', 'Select binary correlation matrix with a set threshold')
            set(ui_matrix_threshold_checkbox, 'Callback', {@cb_matrix_threshold_checkbox})
            
            ui_matrix_threshold_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
            set(ui_matrix_threshold_edit, 'Position', [.70 .515 .05 .025])
            set(ui_matrix_threshold_edit, 'String', '0.50');
            set(ui_matrix_threshold_edit, 'TooltipString', 'Set threshold.');
            set(ui_matrix_threshold_edit, 'FontWeight', 'bold')
            set(ui_matrix_threshold_edit, 'Enable', 'off')
            set(ui_matrix_threshold_edit, 'Callback', {@cb_matrix_threshold_edit});
            
            ui_matrix_threshold_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
            set(ui_matrix_threshold_slider, 'Position', [.75 .515 .23 .025])
            set(ui_matrix_threshold_slider, 'Min', -1, 'Max', 1, 'Value', .50)
            set(ui_matrix_threshold_slider, 'TooltipString', 'Set threshold.')
            set(ui_matrix_threshold_slider, 'Enable', 'off')
            set(ui_matrix_threshold_slider, 'Callback', {@cb_matrix_threshold_slider})
            
            % histogram
            ui_matrix_histogram_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_histogram_checkbox, 'Position', [.70 .44 .28 .05])
            set(ui_matrix_histogram_checkbox, 'String', 'histogram')
            set(ui_matrix_histogram_checkbox, 'Value', false)
            set(ui_matrix_histogram_checkbox, 'TooltipString', 'Select histogram of correlation coefficients')
            set(ui_matrix_histogram_checkbox, 'Callback', {@cb_matrix_histogram_checkbox})
            
            function cb_group_popup(~, ~)
                selected_group = get(ui_matrix_groups_popup, 'value');
                selected_subject = 1;
                set(ui_matrix_subjects_popup, 'Value', selected_subject)
                update_subjects();
                update_matrix();
            end
            function cb_group_subjects(~, ~)
                selected_subject = get(ui_matrix_subjects_popup, 'value');
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
                    atlases = analysis.getCohort().getBrainAtlases();
                    atlas = atlases{1};
                    group = analysis.getCohort().getGroups().getValue(selected_group);
                    if selected_subject == 1
                        graphs = analysis.get_graphs_for_group(group, varargin{:});
                        g_As = cellfun(@(x) x.getA(), graphs, 'UniformOutput', false);
                        A = zeros(atlas.getBrainRegions().length());
                        
                        for i = 1:1:length(graphs)
                            A = A+g_As{i};
                        end
                        A = A/length(graphs);
                        
                        if get(ui_matrix_histogram_checkbox, 'Value')
                            matrix_plot = Graph.hist(A, varargin{:});
                        else
                            % get atlas labels
                            
                            br_labels = atlas.getBrainRegions().getKeys();
                            matrix_plot = GraphWU.plot(A, ...
                                graph_rule, graph_rule_value, ...
                                'Graph.PlotType', graph_type_value, ...
                                'xlabels', br_labels, ...
                                'ylabels', br_labels, ...
                                varargin{:});
                        end
                    else
                        [~, subjects] = analysis.getCohort().getGroupSubjects(selected_group);
                        subject = subjects{selected_subject-1};  % remove first index
                        graph = analysis.get_graph_for_subject(subject, varargin{:});
                        A = graph.getA();
                        if get(ui_matrix_histogram_checkbox, 'Value')
                            matrix_plot = Graph.hist(A, varargin{:});
                        else
                            % get atlas labels
                            
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
            end
            function update_subjects()
                [~, subjects] = analysis.getCohort().getGroupSubjects(selected_group);
                subject_labels_inner = cellfun(@(x) x.getID(), subjects, 'UniformOutput', false);
                subject_labels = ['Group Average' subject_labels_inner];
                set(ui_matrix_subjects_popup, 'String', subject_labels)
            end
            
            update_matrix()
            update_subjects()
            
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
            % See also getGraphPanel, getMainPanelMeasurePlot, getBrainView
            
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
            selected_subject_index = 1;
            sub = [];
            
            % declare the uicontrols
            ui_mainpanel = uipanel('Parent', uiparent, 'Units', 'normalized', 'Position', [0 0 1 1]);
            ui_global_tbl = uitable(ui_mainpanel);
            ui_button_brainmeasures_selectall = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_button_brainmeasures_clearselection = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_button_brainmeasures_remove = uicontrol(ui_mainpanel, 'Style', 'pushbutton');
            ui_checkbox_brainmeasures_meas = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_checkbox_brainmeasures_comp = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_checkbox_brainmeasures_rand = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_popup_globalmeasures_group1 = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_popup_globalmeasures_group2 = uicontrol(ui_mainpanel, 'Style', 'popup');
            ui_plot_measure_panel = uipanel('Parent', ui_mainpanel);
            ui_plot_measure_axes = get_from_varargin([], 'UIAxesGlobal', varargin{:});
            ui_plot_hide_checkbox = uicontrol(ui_mainpanel, 'Style', 'checkbox');
            ui_selectedmeasure_popup = uicontrol(ui_mainpanel, 'Style', 'popup');
            fdr_threshold_edit = uicontrol(ui_mainpanel, 'style', 'edit');
            ui_selected_subject = uicontrol(ui_mainpanel, 'Style', 'popup');
            init_global_panel()
            function init_global_panel()
                GUI.setUnits(ui_mainpanel)
                
                set(ui_global_tbl, 'BackgroundColor', GUI.TABBKGCOLOR)
                if isequal(analysis.getMeasurementClass(), 'MeasurementCON_WU')
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
                
                set(fdr_threshold_edit, 'Position', [.19 .02 .1 .03])
                set(fdr_threshold_edit, 'String', '0.05')
                set(fdr_threshold_edit, 'TooltipString', 'Input the desired FDR threshold parameter')
                set(fdr_threshold_edit, 'Callback', {@cb_global_fdr})
                set(fdr_threshold_edit, 'Visible', 'off')
                
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
                
                set(ui_plot_hide_checkbox, 'Position', [.3 .02 .10 .03])
                set(ui_plot_hide_checkbox, 'String', 'Show Plot')
                set(ui_plot_hide_checkbox, 'Value', true)
                set(ui_plot_hide_checkbox, 'TooltipString', 'Show/Hide Plot')
                set(ui_plot_hide_checkbox, 'Callback', {@cb_show_plot})
                
                set(ui_popup_globalmeasures_group1, 'Position', [.02 .13 .15 .04])
                set(ui_popup_globalmeasures_group1, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_globalmeasures_group1, 'Callback', {@cb_global_table})
                
                set(ui_popup_globalmeasures_group2, 'Position', [.02 .09 .15 .04])
                set(ui_popup_globalmeasures_group2, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_globalmeasures_group2, 'Callback', {@cb_global_table})
                set(ui_popup_globalmeasures_group2, 'Enable', 'off')
                set(ui_popup_globalmeasures_group2, 'Visible', 'off')
                
                set(ui_selected_subject, 'Position', [.02 .05 .15 .04])
                set(ui_selected_subject, 'String', {''})
                set(ui_selected_subject, 'Callback', {@cb_select_subject})
                
                set(ui_selectedmeasure_popup, 'Position', [.02 .01 .15 .04])
                set(ui_selectedmeasure_popup, 'String', global_list)
                set(ui_selectedmeasure_popup, 'Callback', {@cb_global_table})
                
            end
            function update_global_table()
                data = {}; %#ok<NASGU>
                RowName = [];
                
                selected_index = get(ui_popup_globalmeasures_group1, 'Value');
                group = analysis.getCohort().getGroups().getValue(selected_index);
                
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                
                subject = selected_subject_index;
                if subject > 1
                    [~, subjects] = analysis.getCohort().getGroupSubjects(selected_index);
                    sub = subjects{subject-1};
                else
                    sub = [];
                end
                
                fdr_t = get(fdr_threshold_edit, 'String');
                
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
                        if subject == 1
                            set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group ', ' group value ', ' name ', ' label ', ' notes '})
                        else
                            set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' subject ', ' subject value ', ' name ', ' label ', ' notes '})
                        end
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
                            if subject == 1
                                output_value = measurement.getGroupAverageValue();
                                output_id = measurement.getGroup().getID();
                            else
                                global_values = measurement.getMeasureValues();
                                output_value = global_values{subject-1};
                                output_id = sub.getID();
                            end
                            
                            data{i, 2} = measurement.getMeasureCode();
                            data{i, 3} = output_id;
                            data{i, 4} = output_value;
                            data{i, 5} = measurement.getID();
                            data{i, 6} = measurement.getLabel();
                            data{i, 7} = measurement.getNotes();
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_global_tbl, 'Data', data)
                        set(ui_global_tbl, 'RowName', RowName)
                    else
                        set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group', ' group value ', ' name ', ' label ', ' notes '})
                        set(ui_global_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'char', 'char', 'char'})
                        set(ui_global_tbl, 'ColumnEditable', [true false false false false false false ])
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
                        set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' group value 1 ', ' group value 2', ' name ', ' label ', ' notes ', 'fdr'})
                        set(ui_global_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char', 'char'})
                        set(ui_global_tbl, 'ColumnEditable', [true false false false false false false false false false])
                        
                        data = cell(length(global_comparison), 10);
                        for i = 1:1:length(global_comparison)
                            comparison = global_comparison{i};
                            p_values = comparison.getP1();
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            [val_1, val_2]  = comparison.getGroupAverageValues();
                            diff = comparison.getDifference();
                            [group_1, group_2] = comparison.getGroups();
                            data{i, 2} = comparison.getMeasureCode();
                            data{i, 3} = group_1.getID();
                            data{i, 4} = group_2.getID();
                            data{i, 5} = val_1{1};
                            data{i, 6} = val_2{1};
                            data{i, 7} = comparison.getID();
                            data{i, 8} = comparison.getLabel();
                            data{i, 9} = comparison.getNotes();
                            data{i, 10} = fdr([p_values{:}], str2double(fdr_t));
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
                        set(ui_global_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes ', ' fdr '})
                        set(ui_global_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char', 'char'})
                        set(ui_global_tbl, 'ColumnEditable', [true false false false false false false false])
                        
                        data = cell(length(global_randomcomparison), 9);
                        for i = 1:1:length(global_randomcomparison)
                            randomcomparison = global_randomcomparison{i};
                            p_values = randomcomparison.getP1();
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            group_val =  randomcomparison.getAverageRandomValue();
                            random_val = randomcomparison.getRandomValue();
                            data{i, 2} = randomcomparison.getMeasureCode();
                            data{i, 3} = randomcomparison.getGroup().getID();
                            data{i, 4} = group_val{1};
                            data{i, 5} = random_val{1};
                            data{i, 6} = randomcomparison.getID();
                            data{i, 7} = randomcomparison.getLabel();
                            data{i, 8} = randomcomparison.getNotes();
                            data{i, 9} = fdr([p_values{:}], str2double(fdr_t));
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
                    
                    set(ui_selected_subject, 'Enable', 'off')
                    set(ui_selected_subject, 'Visible', 'off')
                    
                    set(fdr_threshold_edit, 'Visible', 'on')
                else
                    set(ui_popup_globalmeasures_group1, 'Enable', 'on')
                    set(ui_popup_globalmeasures_group1, 'Visible', 'on')
                    
                    set(ui_popup_globalmeasures_group2, 'Enable', 'off')
                    set(ui_popup_globalmeasures_group2, 'Visible', 'off')
                    
                    set(ui_selected_subject, 'Enable', 'off')
                    set(ui_selected_subject, 'Visible', 'off')
                    
                    if get(ui_checkbox_brainmeasures_meas, 'Value')
                        set(fdr_threshold_edit, 'Visible', 'off')
                        set(ui_selected_subject, 'Enable', 'on')
                        set(ui_selected_subject, 'Visible', 'on')
                    else
                        set(fdr_threshold_edit, 'Visible', 'on')
                    end
                end
            end
            function init_plot_measure_panel()
                cla(ui_plot_measure_axes)
                deleteExtraChilds(ui_plot_measure_panel)
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    analysis.getGlobalMeasurePlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_globalmeasures_group1, 'Value')), selected_subject_index);
                elseif get(ui_checkbox_brainmeasures_comp, 'Value')
                    analysis.getGlobalComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_globalmeasures_group1, 'Value')), ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_globalmeasures_group2, 'Value')), selected_subject_index);
                elseif get(ui_checkbox_brainmeasures_rand, 'Value')
                    analysis.getGlobalRandomComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_globalmeasures_group1, 'Value')), selected_subject_index);
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
                update_subjects()
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
                selected_index = get(ui_listbox_brainmeasures_comp_groups, 'Value');
                group = analysis.getCohort().getGroups().getValue(selected_index);
                measures_array = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures_array{get(ui_selectedmeasure_popup, 'Value')};
                measures = analysis.selectMeasurements(selected_measure, group);
                
                for i = 1:1:length(selected_brainmeasures)
                    k = selected_brainmeasures(i);
                    m = measures{k};
                    analysis.getMeasurements().remove(m);
                end
                selected_brainmeasures = [];
                update_global_table()
                init_plot_measure_panel()
            end
            function cb_global_fdr(~, ~)
                update_global_table()
            end
            function deleteExtraChilds(ui_control)
                childs = findobj(ui_control, 'Style', 'checkbox');
                for i = 1:1:length(childs)
                    c = childs(i);
                    if isequal(c.Style, 'checkbox')
                        delete(c);
                    end
                end
            end
            function cb_select_subject(~, ~)
                selected_subject_index = get(ui_selected_subject, 'value');
                update_global_table();
                init_plot_measure_panel();
            end
            function update_subjects()
                selected_group = get(ui_popup_globalmeasures_group1, 'Value');
                [~, subjects] = analysis.getCohort().getGroupSubjects(selected_group);
                subject_labels_inner = cellfun(@(x) x.getID(), subjects, 'UniformOutput', false);
                subject_labels = ['All Subjects' subject_labels_inner];
                set(ui_selected_subject, 'String', subject_labels)
            end
            
            update_global_table()
            init_plot_measure_panel()
            update_subjects()
            
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
            selected_subject_index = 1;
            sub = [];
            
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
            fdr_threshold_edit = uicontrol(ui_mainpanel, 'style', 'edit');
            ui_selected_subject = uicontrol(ui_mainpanel, 'Style', 'popup');
            init_nodal_panel()
            function init_nodal_panel()
                GUI.setUnits(ui_mainpanel)
                
                set(ui_nodal_tbl, 'BackgroundColor', GUI.TABBKGCOLOR)
                if isequal(analysis.getMeasurementClass(), 'MeasurementCON_WU')
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
                
                set(fdr_threshold_edit, 'Position', [.19 .02 .1 .03])
                set(fdr_threshold_edit, 'String', '0.05')
                set(fdr_threshold_edit, 'TooltipString', 'Input the desired FDR threshold parameter')
                set(fdr_threshold_edit, 'Callback', {@cb_nodal_fdr})
                set(fdr_threshold_edit, 'Visible', 'off')
                
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
                
                set(ui_popup_nodalmeasures_group1, 'Position', [.02 .16 .15 .03])
                set(ui_popup_nodalmeasures_group1, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_nodalmeasures_group1, 'Callback', {@cb_nodal_table})
                
                set(ui_popup_nodalmeasures_group2, 'Position', [.02 .12 .15 .03])
                set(ui_popup_nodalmeasures_group2, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_nodalmeasures_group2, 'Callback', {@cb_nodal_table})
                set(ui_popup_nodalmeasures_group2, 'Enable', 'off')
                set(ui_popup_nodalmeasures_group2, 'Visible', 'off')
                
                set(ui_selected_subject, 'Position', [.02 .09 .15 .03])
                set(ui_selected_subject, 'String', {''})
                set(ui_selected_subject, 'Callback', {@cb_select_subject})
                
                set(ui_selectedmeasure_popup, 'Position', [.02 .05 .15 .03])
                set(ui_selectedmeasure_popup, 'String', nodal_list)
                set(ui_selectedmeasure_popup, 'Callback', {@cb_nodal_table})
                
                set(ui_selectedbr_popup, 'Position', [.02 .01 .15 .03])
                set(ui_selectedbr_popup, 'String', br_list)
                set(ui_selectedbr_popup, 'Callback', {@cb_nodal_table})
                
            end
            function update_nodal_table()
                data = {}; %#ok<NASGU>
                RowName = [];
                
                selected_index_1 = get(ui_popup_nodalmeasures_group1, 'Value');
                group_1 = analysis.getCohort().getGroups().getValue(selected_index_1);
                
                selected_index_2 = get(ui_popup_nodalmeasures_group2, 'Value');
                group_2 = analysis.getCohort().getGroups().getValue(selected_index_2);
                
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                
                selected_br = get(ui_selectedbr_popup, 'Value');
                
                subject = selected_subject_index;
                if subject > 1
                    [~, subjects] = analysis.getCohort().getGroupSubjects(selected_index_1);
                    sub = subjects{subject-1};
                else
                    sub = [];
                end
                
                fdr_t = get(fdr_threshold_edit, 'String');
                
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    for j = 1:1:analysis.getMeasurements().length()
                        measurement = analysis.getMeasurements().getValue(j);
                        if ismember(measurement.getMeasureCode(), nodal_list) && isequal(measurement.getGroup(), group_1) && isequal(selected_measure, measurement.getMeasureCode())
                            nodal_measurements{j} = measurement; %#ok<AGROW>
                        end
                    end
                    
                    if exist('nodal_measurements', 'var')
                        nodal_measurements =  nodal_measurements(~cellfun(@isempty, nodal_measurements));
                        if subject == 1
                            set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group ', ' group value ', ' name ', ' label ', ' notes '})
                        else
                            set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' subject ', ' subject value ', ' name ', ' label ', ' notes '})
                        end
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
                            if subject == 1
                                tmp = measurement.getGroupAverageValue();
                                output_value = tmp(selected_br);
                                output_id = measurement.getGroup().getID();
                            else
                                global_values = measurement.getMeasureValues();
                                tmp = global_values{subject-1};
                                output_value = tmp(selected_br);
                                output_id = sub.getID();
                            end
                            data{i, 2} = measurement.getMeasureCode();
                            data{i, 3} = output_id;
                            data{i, 4} = output_value;
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
                        if ismember(comparison.getMeasureCode(), nodal_list) && ((isequal(a, group_1) && isequal (b, group_2)) || (isequal(a, group_2) && isequal (b, group_1))) && isequal(selected_measure, comparison.getMeasureCode())
                            nodal_comparison{j} = comparison; %#ok<AGROW>
                        end
                    end
                    
                    if exist('nodal_comparison', 'var')
                        nodal_comparison =  nodal_comparison(~cellfun(@isempty, nodal_comparison));
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes ', ' fdr '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false false false false])
                        
                        data = cell(length(nodal_comparison), 10);
                        for i = 1:1:length(nodal_comparison)
                            comparison = nodal_comparison{i};
                            p_values = comparison.getP1();
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            [val_1, val_2]  = comparison.getGroupAverageValues();
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
                            data{i, 10} = fdr([p_values{:}]', str2double(fdr_t));
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_nodal_tbl, 'Data', data)
                        set(ui_nodal_tbl, 'RowName', RowName)
                    else
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes ', ' fdr '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false false false false])
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
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes ', ' fdr '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false false false])
                        
                        data = cell(length(nodal_randomcomparison), 9);
                        for i = 1:1:length(nodal_randomcomparison)
                            randomcomparison = nodal_randomcomparison{i};
                            p_values = randomcomparison.getP1();
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            group_val =  randomcomparison.getAverageRandomValue();
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
                            data{i, 9} = fdr([p_values{:}]', str2double(fdr_t));
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_nodal_tbl, 'Data', data)
                        set(ui_nodal_tbl, 'RowName', RowName)
                    else
                        set(ui_nodal_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes ', ' fdr '})
                        set(ui_nodal_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char', 'char'})
                        set(ui_nodal_tbl, 'ColumnEditable', [true false false false false false false false false])
                        set(ui_nodal_tbl, 'Data', [])
                        set(ui_nodal_tbl, 'RowName', [])
                    end
                end
            end
            function update_group_popups()
                if get(ui_checkbox_brainmeasures_comp, 'Value')
                    set(ui_popup_nodalmeasures_group1, 'Enable', 'on')
                    set(ui_popup_nodalmeasures_group1, 'Visible', 'on')
                    
                    set(ui_selected_subject, 'Enable', 'off')
                    set(ui_selected_subject, 'Visible', 'off')
                    
                    set(ui_popup_nodalmeasures_group2, 'Enable', 'on')
                    set(ui_popup_nodalmeasures_group2, 'Visible', 'on')
                    set(fdr_threshold_edit, 'Visible', 'on')
                else
                    set(ui_popup_nodalmeasures_group1, 'Enable', 'on')
                    set(ui_popup_nodalmeasures_group1, 'Visible', 'on')
                    
                    set(ui_popup_nodalmeasures_group2, 'Enable', 'off')
                    set(ui_popup_nodalmeasures_group2, 'Visible', 'off')
                    
                    set(ui_selected_subject, 'Enable', 'off')
                    set(ui_selected_subject, 'Visible', 'off')
                    
                    if get(ui_checkbox_brainmeasures_meas, 'Value')
                        set(fdr_threshold_edit, 'Visible', 'off')
                        set(ui_selected_subject, 'Enable', 'on')
                        set(ui_selected_subject, 'Visible', 'on')
                    else
                        set(fdr_threshold_edit, 'Visible', 'on')
                    end
                end
            end
            function init_plot_nodal_panel()
                cla(ui_plot_measure_axes)
                deleteExtraChilds(ui_plot_measure_panel)
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    analysis.getNodalMeasurePlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_nodalmeasures_group1, 'Value')), ...
                        get(ui_selectedbr_popup, 'Value'), selected_subject_index);
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
                update_subjects()
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
                
                update_nodal_table();
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
                selected_index = get(ui_popup_nodalmeasures_group1, 'Value');
                group = analysis.getCohort().getGroups().getValue(selected_index);
                measures_array = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures_array{get(ui_selectedmeasure_popup, 'Value')};
                measures = analysis.selectMeasurements(selected_measure, group);
                
                for i = 1:1:length(selected_brainmeasures)
                    k = selected_brainmeasures(i);
                    m = measures{k};
                    analysis.getMeasurements().remove(m);
                end
                selected_brainmeasures = [];
                update_nodal_table()
                init_plot_nodal_panel()
            end
            function cb_nodal_fdr(~, ~)
                update_nodal_table()
            end
            function deleteExtraChilds(ui_control)
                childs = findobj(ui_control, 'Style', 'checkbox');
                for i = 1:1:length(childs)
                    c = childs(i);
                    if isequal(c.Style, 'checkbox')
                        delete(c);
                    end
                end
            end
            function cb_select_subject(~, ~)
                selected_subject_index = get(ui_selected_subject, 'value');
                update_nodal_table();
                init_plot_nodal_panel();
            end
            function update_subjects()
                selected_group = get(ui_popup_nodalmeasures_group1, 'Value');
                [~, subjects] = analysis.getCohort().getGroupSubjects(selected_group);
                subject_labels_inner = cellfun(@(x) x.getID(), subjects, 'UniformOutput', false);
                subject_labels = ['All Subjects' subject_labels_inner];
                set(ui_selected_subject, 'String', subject_labels)
            end
            
            update_nodal_table()
            init_plot_nodal_panel()
            update_subjects()
            
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
            % See also getGraphPanel, getMainPanelMeasurePlot, getGlobalPanel, getBrainView
            
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
            selected_subject_index = 1;
            sub = [];
            
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
            fdr_threshold_edit = uicontrol(ui_mainpanel, 'style', 'edit');
            ui_selected_subject = uicontrol(ui_mainpanel, 'Style', 'popup');
            init_binodal_panel()
            function init_binodal_panel()
                GUI.setUnits(ui_mainpanel)
                
                set(ui_binodal_tbl, 'BackgroundColor', GUI.TABBKGCOLOR)
                if isequal(analysis.getMeasurementClass(), 'MeasurementCON_WU')
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
                
                set(fdr_threshold_edit, 'Position', [.19 .02 .1 .03])
                set(fdr_threshold_edit, 'String', '0.05')
                set(fdr_threshold_edit, 'TooltipString', 'Input the desired FDR threshold parameter')
                set(fdr_threshold_edit, 'Callback', {@cb_binodal_fdr})
                set(fdr_threshold_edit, 'Visible', 'off')
                
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
                
                set(ui_popup_binodalmeasures_group1, 'Position', [.02 .16 .15 .03])
                set(ui_popup_binodalmeasures_group1, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_binodalmeasures_group1, 'Callback', {@cb_binodal_table})
                
                set(ui_popup_binodalmeasures_group2, 'Position', [.02 .12 .15 .03])
                set(ui_popup_binodalmeasures_group2, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_binodalmeasures_group2, 'Callback', {@cb_binodal_table})
                set(ui_popup_binodalmeasures_group2, 'Enable', 'off')
                set(ui_popup_binodalmeasures_group2, 'Visible', 'off')
                
                set(ui_selected_subject, 'Position', [.02 .09 .15 .03])
                set(ui_selected_subject, 'String', {''})
                set(ui_selected_subject, 'Callback', {@cb_select_subject})
                
                set(ui_selectedmeasure_popup, 'Position', [.02 .05 .15 .03])
                set(ui_selectedmeasure_popup, 'String', binodal_list)
                set(ui_selectedmeasure_popup, 'Callback', {@cb_binodal_table})
                
                set(ui_selectedbr1_popup, 'Position', [.02 .01 .07 .03])
                set(ui_selectedbr1_popup, 'String', br_list)
                set(ui_selectedbr1_popup, 'Callback', {@cb_binodal_table})
                
                set(ui_selectedbr2_popup, 'Position', [.1 .01 .07 .03])
                set(ui_selectedbr2_popup, 'String', br_list)
                set(ui_selectedbr2_popup, 'Callback', {@cb_binodal_table})
                
            end
            function update_binodal_table()
                data = {}; %#ok<NASGU>
                RowName = [];
                
                selected_index_1 = get(ui_popup_binodalmeasures_group1, 'Value');
                group_1 = analysis.getCohort().getGroups().getValue(selected_index_1);
                
                selected_index_2 = get(ui_popup_binodalmeasures_group2, 'Value');
                group_2 = analysis.getCohort().getGroups().getValue(selected_index_2);
                
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                
                selected_br1 = get(ui_selectedbr1_popup, 'Value');
                selected_br2 = get(ui_selectedbr2_popup, 'Value');
                
                subject = selected_subject_index;
                if subject > 1
                    [~, subjects] = analysis.getCohort().getGroupSubjects(selected_index_1);
                    sub = subjects{subject-1};
                else
                    sub = [];
                end
                
                fdr_t = get(fdr_threshold_edit, 'String');
                
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    for j = 1:1:analysis.getMeasurements().length()
                        measurement = analysis.getMeasurements().getValue(j);
                        if ismember(measurement.getMeasureCode(), binodal_list) && isequal(measurement.getGroup(), group_1) && isequal(selected_measure, measurement.getMeasureCode())
                            binodal_measurements{j} = measurement; %#ok<AGROW>
                        end
                    end
                    
                    if exist('binodal_measurements', 'var')
                        binodal_measurements =  binodal_measurements(~cellfun(@isempty, binodal_measurements));
                        if subject == 1
                            set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group ', ' group value ', ' name ', ' label ', ' notes '})
                        else
                            set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' subject ', ' subject value ', ' name ', ' label ', ' notes '})
                        end
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
                            if subject == 1
                                tmp = measurement.getGroupAverageValue();
                                output_value = tmp(selected_br1, selected_br2);
                                output_id = measurement.getGroup().getID();
                            else
                                global_values = measurement.getMeasureValues();
                                tmp = global_values{subject-1};
                                output_value = tmp(selected_br1, selected_br2);
                                output_id = sub.getID();
                            end
                            data{i, 2} = measurement.getMeasureCode();
                            data{i, 3} = output_id;
                            data{i, 4} = output_value;
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
                        if ismember(comparison.getMeasureCode(), binodal_list) && ((isequal(a, group_1) && isequal (b, group_2)) || (isequal(a, group_2) && isequal (b, group_1))) && isequal(selected_measure, comparison.getMeasureCode())
                            binodal_comparison{j} = comparison; %#ok<AGROW>
                        end
                    end
                    
                    if exist('binodal_comparison', 'var')
                        binodal_comparison =  binodal_comparison(~cellfun(@isempty, binodal_comparison));
                        set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes ', ' fdr '})
                        set(ui_binodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char', 'char'})
                        set(ui_binodal_tbl, 'ColumnEditable', [true false false false false false false false false false])
                        
                        data = cell(length(binodal_comparison), 10);
                        for i = 1:1:length(binodal_comparison)
                            comparison = binodal_comparison{i};
                            p_values = comparison.getP1();
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            [val_1, val_2]  = comparison.getGroupAverageValues();
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
                            data{i, 10} = fdr([p_values{:}], str2double(fdr_t));
                            RowName(i) = i; %#ok<AGROW>
                        end
                        set(ui_binodal_tbl, 'Data', data)
                        set(ui_binodal_tbl, 'RowName', RowName)
                    else
                        set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group 1 ', ' group 2 ', ' value 1 ', 'value 2', ' name ', ' label ', ' notes ', ' fdr '})
                        set(ui_binodal_tbl, 'ColumnFormat', {'logical', 'char', 'char', 'char',  'numeric', 'numeric', 'char', 'char', 'char', 'char'})
                        set(ui_binodal_tbl, 'ColumnEditable', [true false false false false false false false false false])
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
                        set(ui_binodal_tbl, 'ColumnName', {'', ' measure ', ' group ', ' value group ', 'value random ', ' name ', ' label ', ' notes ', ' fdr '})
                        set(ui_binodal_tbl, 'ColumnFormat', {'logical', 'char',  'char',  'numeric', 'numeric', 'char', 'char', 'char', 'char'})
                        set(ui_binodal_tbl, 'ColumnEditable', [true false false false false false false false false])
                        
                        data = cell(length(binodal_randomcomparison), 7);
                        for i = 1:1:length(binodal_randomcomparison)
                            randomcomparison = binodal_randomcomparison{i};
                            p_values = randomcomparison.getP1();
                            if any(selected_brainmeasures == i)
                                data{i, 1} = true;
                            else
                                data{i, 1} = false;
                            end
                            group_val =  randomcomparison.getAverageRandomValue();
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
                            data{i, 9} = fdr([p_values{:}], str2double(fdr_t));
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
                    
                    set(fdr_threshold_edit, 'Visible', 'on')
                    
                    set(ui_selected_subject, 'Enable', 'off')
                    set(ui_selected_subject, 'Visible', 'off')
                else
                    set(ui_popup_binodalmeasures_group1, 'Enable', 'on')
                    set(ui_popup_binodalmeasures_group1, 'Visible', 'on')
                    
                    set(ui_popup_binodalmeasures_group2, 'Enable', 'off')
                    set(ui_popup_binodalmeasures_group2, 'Visible', 'off')
                    set(ui_selected_subject, 'Enable', 'off')
                    set(ui_selected_subject, 'Visible', 'off')
                    
                    if get(ui_checkbox_brainmeasures_meas, 'Value')
                        set(fdr_threshold_edit, 'Visible', 'off')
                        set(ui_selected_subject, 'Enable', 'on')
                        set(ui_selected_subject, 'Visible', 'on')
                    else
                        set(fdr_threshold_edit, 'Visible', 'on')
                    end
                end
            end
            function init_plot_binodal_panel()
                cla(ui_plot_measure_axes)
                deleteExtraChilds(ui_plot_measure_panel)
                measures = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures{get(ui_selectedmeasure_popup, 'Value')};
                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    analysis.getBinodalMeasurePlot(ui_plot_measure_panel, ui_plot_measure_axes, selected_measure, ...
                        analysis.getCohort().getGroups().getValue(get(ui_popup_binodalmeasures_group1, 'Value')), ...
                        get(ui_selectedbr1_popup, 'Value'), get(ui_selectedbr2_popup, 'Value'), selected_subject_index);
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
                update_subjects()
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
                
                update_binodal_table();
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
                selected_index = get(ui_popup_binodalmeasures_group1, 'Value');
                group = analysis.getCohort().getGroups().getValue(selected_index);
                measures_array = get(ui_selectedmeasure_popup, 'String');
                selected_measure = measures_array{get(ui_selectedmeasure_popup, 'Value')};
                measures = analysis.selectMeasurements(selected_measure, group);
                
                for i = 1:1:length(selected_brainmeasures)
                    k = selected_brainmeasures(i);
                    m = measures{k};
                    analysis.getMeasurements().remove(m);
                end
                selected_brainmeasures = [];
                update_binodal_table()
                init_plot_binodal_panel()
            end
            function cb_binodal_fdr(~, ~)
                update_binodal_table()
            end
            function deleteExtraChilds(ui_control)
                childs = findobj(ui_control, 'Style', 'checkbox');
                for i = 1:1:length(childs)
                    c = childs(i);
                    if isequal(c.Style, 'checkbox')
                        delete(c);
                    end
                end
            end
            function cb_select_subject(~, ~)
                selected_subject_index = get(ui_selected_subject, 'value');
                update_binodal_table();
                init_plot_binodal_panel();
            end
            function update_subjects()
                selected_group = get(ui_popup_binodalmeasures_group1, 'Value');
                [~, subjects] = analysis.getCohort().getGroupSubjects(selected_group);
                subject_labels_inner = cellfun(@(x) x.getID(), subjects, 'UniformOutput', false);
                subject_labels = ['All Subjects' subject_labels_inner];
                set(ui_selected_subject, 'String', subject_labels)
            end
            
            update_binodal_table()
            init_plot_binodal_panel()
            update_subjects()
            
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
            % GETBRAINVIEW creates a brain view panel for GUIAnalysis
            %
            % P = GETBRAINVIEW(ANALYSIS, PROPERTY, RULE, ...) creates a
            % brain view panel for GUIAnalysis.
            %
            % See also getGlobalPanel, getNodalPanel, getBinodalPanel.
            uiparent = get_from_varargin([], 'UIParent', varargin{:});
            bg = get_from_varargin([], 'BrainGraph', varargin{:});
            bgp = [];
            mrc = [];
            
            ui_brainview_panel = uipanel('Parent', uiparent, 'Units', 'normalized', 'Position', [0 0 1 1]);
            ui_brainview_axes = get_from_varargin([], 'UIAxesBrain', varargin{:});
            ui_brainview_edges_panel_button = uicontrol(ui_brainview_panel);
            ui_brainview_analysis_dictionaries_button = uicontrol(ui_brainview_panel);
            ui_brain_view_show_checkbox = uicontrol(ui_brainview_panel, 'Style', 'checkbox');
            ui_brain_view_syms_checkbox = uicontrol(ui_brainview_panel, 'Style', 'checkbox');
            ui_brain_view_labs_checkbox = uicontrol(ui_brainview_panel, 'Style', 'checkbox');
            
            init_brainview()
            function init_brainview()
                GUI.setUnits(ui_brainview_panel)
                GUI.setBackgroundColor(ui_brainview_panel)
                
                set(ui_brainview_axes, 'Parent', ui_brainview_panel)
                set(ui_brainview_axes, 'Position', [.12 .2 0.78 .78])
                
                set(ui_brain_view_show_checkbox, 'Units', 'normalized')
                set(ui_brain_view_show_checkbox, 'Position', [.02 .11 .15 .05])
                set(ui_brain_view_show_checkbox, 'String', 'Show Brain Surface')
                set(ui_brain_view_show_checkbox, 'Value', true)
                set(ui_brain_view_show_checkbox, 'Callback', {@cb_show_surf})
                
                set(ui_brain_view_syms_checkbox, 'Units', 'normalized')
                set(ui_brain_view_syms_checkbox, 'Position', [.02 .06 .15 .05])
                set(ui_brain_view_syms_checkbox, 'String', 'Show Brain Regions')
                set(ui_brain_view_syms_checkbox, 'Value', true)
                set(ui_brain_view_syms_checkbox, 'Callback', {@cb_show_brs})
                
                set(ui_brain_view_labs_checkbox, 'Units', 'normalized')
                set(ui_brain_view_labs_checkbox, 'Position', [.02 .01 .15 .05])
                set(ui_brain_view_labs_checkbox, 'String', 'Show Brain Labels')
                set(ui_brain_view_labs_checkbox, 'Value', true)
                set(ui_brain_view_labs_checkbox, 'Callback', {@cb_show_labs})
                
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
            ui_contextmenu_figure_brainsurf = uicontextmenu();
            ui_contextmenu_figure_brainsurf_settings = uimenu(ui_contextmenu_figure_brainsurf);
            ui_contextmenu_figure_syms = uicontextmenu();
            ui_contextmenu_figure_symbol_settings = uimenu(ui_contextmenu_figure_syms);
            ui_contextmenu_figure_labs = uicontextmenu();
            ui_contextmenu_figure_labels_settings = uimenu(ui_contextmenu_figure_labs);
            init_contextmenus()
            function init_contextmenus()
                set(ui_contextmenu_figure_brainsurf_settings, 'Label', 'Brain Surface Settings')
                set(ui_contextmenu_figure_brainsurf_settings, 'Callback', {@cb_figure_brainsurf})
                
                function cb_figure_brainsurf(~, ~)  % (src, event)
                    bg.brain_settings();
                end
                
                set(ui_contextmenu_figure_symbol_settings, 'Label', 'Brain Region Settings')
                set(ui_contextmenu_figure_symbol_settings, 'Callback', {@cb_figure_settingsbr})
                
                function cb_figure_settingsbr(~, ~)  % (src, event)
                    i = bg.get_sym_i(gco);
                    bg.br_syms_settings(i)
                end
                
                set(ui_contextmenu_figure_labels_settings, 'Label', 'Label Settings')
                set(ui_contextmenu_figure_labels_settings, 'Callback', {@cb_figure_settingslab})
                
                function cb_figure_settingslab(~, ~)  % (src, event)
                    i = bg.get_labs_i(gco);
                    bg.br_labs_settings(i)
                end
            end
            function create_figure()
                bg.set_axes(ui_brainview_axes);
                axes(ui_brainview_axes)
                bg.axis_equal();
                bg.hold_on();
                bg.view(PlotBrainSurf.VIEW_3D);
                bg.brain('UIContextMenu', ui_contextmenu_figure_brainsurf);
                bg.br_syms([], 'UIContextMenu', ui_contextmenu_figure_syms);
                bg.br_labs([], 'UIContextMenu', ui_contextmenu_figure_labs);
                update_brain_graph();
            end
            function update_brain_graph()
                if get(ui_brain_view_show_checkbox, 'Value')
                    bg.brain_on();
                else
                    bg.brain_off();
                end
                if get(ui_brain_view_syms_checkbox, 'Value')
                    bg.br_syms_on();
                else
                    bg.br_syms_off();
                end
                if get(ui_brain_view_labs_checkbox, 'Value')
                    bg.br_labs_on();
                else
                    bg.br_labs_off();
                end
            end
            function cb_bv_bg_panel(~, ~)
                if isempty(bgp) || ~isvalid(bgp)
                    bgp =  analysis.getBrainGraphPanel(ui_brainview_axes, bg);
                else
                    figure(bgp);
                end
            end
            function cb_bv_meas_panel(~, ~)
                if isempty(mrc) || ~isvalid(mrc)
                    mrc = analysis.getMCRPanel(ui_brainview_axes, bg);
                else
                    figure(mrc)
                end
            end
            function cb_show_surf(~, ~)
                update_brain_graph()
            end
            function cb_show_brs(~, ~)
                update_brain_graph()
            end
            function cb_show_labs(~, ~)
                update_brain_graph()
            end
            
            create_figure()
            
            if nargout > 0
                p = ui_brainview_panel;
            end
        end
        function brain_graph_panel = getBrainGraphPanel(analysis, brain_axes, brain_graph)
            % GETBRAINGRAPHPANEL creates a braingraph panel
            %
            % BRAIN_GRAPH_PANEL = GETBRAINGRAPHPANEL(ANAlYSIS, AXES, PLOTBRAINGRAPH)
            % creates a brain graph panel to manage the type of
            % PLOTBRAINGRAPH that the GUIAnalysis plots in the AXES.
            %
            % See also getBrainView,
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
            ui_link_type = uicontrol(fig_graph, 'Style', 'popup', 'String', {'line', 'arrow', 'cylinder'});
            
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
                set(ui_text_graph_thickness, 'Position', [.02 .05 .3 .05])
                set(ui_text_graph_thickness, 'String', 'Set thickness  ')
                set(ui_text_graph_thickness, 'HorizontalAlignment', 'center')
                set(ui_text_graph_thickness, 'FontWeight', 'bold')
                set(ui_text_graph_thickness, 'FontSize', 8)
                
                set(ui_edit_graph_thickness, 'Units', 'normalized')
                set(ui_edit_graph_thickness, 'Position', [.34 .06 .2 .05])
                set(ui_edit_graph_thickness, 'String', '1');
                set(ui_edit_graph_thickness, 'TooltipString', 'Set density.');
                set(ui_edit_graph_thickness, 'FontWeight', 'bold')
                set(ui_edit_graph_thickness, 'Callback', {@cb_graph_thickness});
                
                set(ui_link_type, 'Units', 'normalized')
                set(ui_link_type, 'Position', [.62 .06 .3 .05])
                set(ui_link_type, 'Callback', {@cb_link_type});
                
                if isequal(class(analysis), 'AnalysisCON_BUT')
                    change_to_threshold()
                elseif isequal(class(analysis), 'AnalysisCON_BUD')
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
            function change_to_weighted()
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
                link_style = get(ui_link_type, 'Value');
                if  link_style == 1
                    bg.link_edges_off([], [])
                elseif link_style == 2
                    bg.arrow_edges_off([],[])
                else
                    bg.cylinder_edges_off([],[])
                end
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
            function cb_link_type(~, ~)
                update_graph()
            end
            function update_graph()
                group_index = get(ui_popup_graph_group, 'Value');
                link_style = get(ui_link_type, 'Value');
                if get(ui_checkbox_graph_weighted, 'Value')
                    
                    if get(ui_checkbox_graph_linecolor, 'Value')
                        val1 = get(ui_popup_graph_initcolor, 'Value');
                        val2 = get(ui_popup_graph_fincolor, 'Value');
                        
                        if  link_style == 1
                            bg.link_edges('Color', [val1 val2]);
                        elseif link_style == 2
                            bg.arrow_edges('Color', [val1 val2]);
                        else
                            bg.cylinder_edges('Color', [val1 val2]);
                        end
                    end
                    
                    if get(ui_checkbox_graph_lineweight, 'Value')
                        
                        weight = str2double(get(ui_edit_graph_lineweight, 'String'));
                        for indices = 1:1:length(reshA)
                            if  link_style == 1
                                bg.link_edges('LineWidth', weight)
                            elseif link_style == 2
                                bg.arrow_edges('LineWidth', weight);
                            else
                                bg.cylinder_edges('LineWidth', weight);
                            end
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
                    atlases = analysis.getCohort().getBrainAtlases();
                    atlas = atlases{1};
                    
                    %                     if isequal(analysis.getGraphType, 'GraphWU')
                    graphs = analysis.get_graphs_for_group(group);
                    %                     else
                    %                         graphs = analysis.get_graphs_for_group(group, rule, value);
                    %                     end
                    g_As = cellfun(@(x) x.getA(), graphs, 'UniformOutput', false);
                    A = zeros(atlas.getBrainRegions().length());
                    
                    for i = 1:1:length(graphs)
                        A = A+g_As{i};
                    end
                    A = A/length(graphs);
                    A = binarize(A, rule, value);
                    thickness = str2double(get(ui_edit_graph_thickness, 'String'));
                    
                    bg.link_edges_off([], [])
                    bg.arrow_edges_off([],[])
                    bg.cylinder_edges_off([],[])
                    
                    for i = 1:1:size(A, 1)
                        for j = 1:1:size(A, 2)
                            if A(i, j) == 0
                                continue;
                            end
                            if  link_style == 1
                                bg.link_edge(i, j, 'LineWidth', thickness);
                                bg.link_edge_on(i, j)
                            elseif link_style == 2
                                bg.arrow_edge(i, j, 'LineWidth', thickness);
                                bg.arrow_edge_on(i, j)
                            else
                                bg.cylinder_edge(i, j, 'LineWidth', thickness);
                                bg.cylinder_edge_on(i, j)
                            end
                        end
                    end
                end
            end
            function cb_graph_links_settings(~, ~)  % (src, event)
                link_style = get(ui_link_type, 'Value');
                if link_style == 1
                    bg.link_edges_settings([], []);
                elseif link_style == 2
                    bg.arrow_edges_settings([], []);
                else
                    bg.cylinder_edges_settings([], []);
                end
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
        function h = getMCRPanel(analysis, brain_axes, bg)
            % sets position of figure
            APPNAME = 'Analysis Property Panel';
            FigPosition = [.10 .30 .35 .50];
            FigColor = GUI.BKGCOLOR;
            
            % create a figure
            f = GUI.init_figure(APPNAME, .45, .6, 'west');
            
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
            p1 = [];
            p2 = [];
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
            ui_list_threshold_or_density = uicontrol(f, 'Style', 'listbox');
            list_tittle = uicontrol(f, 'Style', 'text');
            
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
            
            % measure container panel
            ui_measure_container_panel = uipanel(f, 'Units', 'normalized');
            
            % nodal measure figure options
            ui_checkbox_meas_symbolsize = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
            ui_edit_meas_symbolsize = uicontrol(ui_measure_container_panel, 'Style', 'edit');
            ui_checkbox_meas_symbolcolor = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
            ui_popup_meas_initcolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
            ui_popup_meas_fincolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
            ui_checkbox_meas_sphereradius = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
            ui_edit_meas_sphereradius = uicontrol(ui_measure_container_panel, 'Style', 'edit');
            ui_checkbox_meas_spherecolor = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
            ui_popup_meas_sphinitcolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
            ui_popup_meas_sphfincolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
            ui_checkbox_meas_spheretransparency = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
            ui_slider_meas_spheretransparency = uicontrol(ui_measure_container_panel, 'Style', 'slider');
            ui_checkbox_meas_labelsize = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
            ui_edit_meas_labelsize = uicontrol(ui_measure_container_panel, 'Style', 'edit');
            ui_checkbox_meas_labelcolor = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
            ui_popup_meas_labelinitcolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
            ui_popup_meas_labelfincolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
            
            % binodal measure figure options
            ui_edge_value_show = uicontrol(f, 'Units', 'normalized', 'Style', 'checkbox');
            
            init_measures_panel()
            update_figure_panel()
            update_popup_grouplist()
            update_measure_data(1);
            
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
                
                set(list_tittle, 'Units', 'normalized')
                set(list_tittle, 'BackgroundColor', GUI.BKGCOLOR)
                set(list_tittle, 'HorizontalAlignment', 'center')
                set(list_tittle, 'FontWeight', 'bold')
                
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
                
                % lists ***************************************
                set(ui_list_gr, 'Units', 'normalized')
                set(ui_list_gr, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_list_gr, 'String', cellfun(@(x) Measure.getName(x), mlist, 'UniformOutput', false))
                set(ui_list_gr, 'Value', 1)
                set(ui_list_gr, 'Max', -1, 'Min', 0)
                set(ui_list_gr, 'BackgroundColor', [1 1 1])
                set(ui_list_gr, 'Position', [.02 .02 .30 .68])
                set(ui_list_gr, 'TooltipString', 'Select brain regions');
                set(ui_list_gr, 'Callback', {@cb_list_gr});
                
                set(ui_list_threshold_or_density, 'Units', 'normalized')
                set(ui_list_threshold_or_density, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_list_threshold_or_density, 'Value', 1)
                set(ui_list_threshold_or_density, 'Max', -1, 'Min', 0)
                set(ui_list_threshold_or_density, 'BackgroundColor', [1 1 1])
                set(ui_list_threshold_or_density, 'Callback', {@cb_list_t_or_d});
                
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
                set(ui_measure_container_panel, 'Position', [.35 .01 .605 .64])
                
                set(ui_checkbox_meas_symbolsize, 'Units', 'normalized')
                set(ui_checkbox_meas_symbolsize, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_symbolsize, 'Position', [.01 .9 .30 .08])
                set(ui_checkbox_meas_symbolsize, 'String', ' Symbol Size ')
                set(ui_checkbox_meas_symbolsize, 'Value', false)
                set(ui_checkbox_meas_symbolsize, 'FontWeight', 'bold')
                set(ui_checkbox_meas_symbolsize, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_symbolsize, 'Callback', {@cb_checkbox_meas_symbolsize})
                
                set(ui_edit_meas_symbolsize, 'Units', 'normalized')
                set(ui_edit_meas_symbolsize, 'String', PlotBrainGraph.INIT_SYM_SIZE)
                set(ui_edit_meas_symbolsize, 'Enable', 'off')
                set(ui_edit_meas_symbolsize, 'Position', [.31 .9 .6 .08])
                set(ui_edit_meas_symbolsize, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_symbolsize, 'FontWeight', 'bold')
                set(ui_edit_meas_symbolsize, 'Callback', {@cb_edit_meas_symbolsize})
                
                set(ui_checkbox_meas_symbolcolor, 'Units', 'normalized')
                set(ui_checkbox_meas_symbolcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_symbolcolor, 'Position', [.01 .8 .3 .08])
                set(ui_checkbox_meas_symbolcolor, 'String', ' Symbol Color ')
                set(ui_checkbox_meas_symbolcolor, 'Value', false)
                set(ui_checkbox_meas_symbolcolor, 'FontWeight', 'bold')
                set(ui_checkbox_meas_symbolcolor, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_symbolcolor, 'Callback', {@cb_checkbox_meas_symbolcolor})
                
                set(ui_popup_meas_initcolor, 'Units', 'normalized')
                set(ui_popup_meas_initcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_initcolor, 'Enable', 'off')
                set(ui_popup_meas_initcolor, 'Position', [.31 .8 .3 .08])
                set(ui_popup_meas_initcolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_initcolor, 'Value', 3)
                set(ui_popup_meas_initcolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_initcolor, 'Callback', {@cb_meas_initcolor})
                
                set(ui_popup_meas_fincolor, 'Units', 'normalized')
                set(ui_popup_meas_fincolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_fincolor, 'Enable', 'off')
                set(ui_popup_meas_fincolor, 'Position', [0.61 .8 .3 .08])
                set(ui_popup_meas_fincolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_fincolor, 'Value', 1)
                set(ui_popup_meas_fincolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_fincolor, 'Callback', {@cb_meas_fincolor})
                
                set(ui_checkbox_meas_sphereradius, 'Units', 'normalized')
                set(ui_checkbox_meas_sphereradius, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_sphereradius, 'Position', [.01 0.7 .3 .08])
                set(ui_checkbox_meas_sphereradius, 'String', ' Sphere Radius ')
                set(ui_checkbox_meas_sphereradius, 'Value', false)
                set(ui_checkbox_meas_sphereradius, 'FontWeight', 'bold')
                set(ui_checkbox_meas_sphereradius, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_sphereradius, 'Callback', {@cb_checkbox_meas_sphereradius})
                
                set(ui_edit_meas_sphereradius, 'Units', 'normalized')
                set(ui_edit_meas_sphereradius, 'String', PlotBrainGraph.INIT_SPH_R)
                set(ui_edit_meas_sphereradius, 'Enable', 'off')
                set(ui_edit_meas_sphereradius, 'Position', [.31 0.7 .6 .08])
                set(ui_edit_meas_sphereradius, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_sphereradius, 'FontWeight', 'bold')
                set(ui_edit_meas_sphereradius, 'Callback', {@cb_edit_meas_sphereradius})
                
                set(ui_checkbox_meas_spherecolor, 'Units', 'normalized')
                set(ui_checkbox_meas_spherecolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_spherecolor, 'Position', [.01 0.6 .3 .08])
                set(ui_checkbox_meas_spherecolor, 'String', ' Sphere Color ')
                set(ui_checkbox_meas_spherecolor, 'Value', false)
                set(ui_checkbox_meas_spherecolor, 'FontWeight', 'bold')
                set(ui_checkbox_meas_spherecolor, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_spherecolor, 'Callback', {@cb_checkbox_meas_spherecolor})
                
                set(ui_popup_meas_sphinitcolor, 'Units', 'normalized')
                set(ui_popup_meas_sphinitcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_sphinitcolor, 'Enable', 'off')
                set(ui_popup_meas_sphinitcolor, 'Position', [.31 .6 .3 .08])
                set(ui_popup_meas_sphinitcolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_sphinitcolor, 'Value', 1)
                set(ui_popup_meas_sphinitcolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_sphinitcolor, 'Callback', {@cb_meas_sphinitcolor})
                
                set(ui_popup_meas_sphfincolor, 'Units', 'normalized')
                set(ui_popup_meas_sphfincolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_sphfincolor, 'Enable', 'off')
                set(ui_popup_meas_sphfincolor, 'Position', [0.61 .6 .3 .08])
                set(ui_popup_meas_sphfincolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_sphfincolor, 'Value', 3)
                set(ui_popup_meas_sphfincolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_sphfincolor, 'Callback', {@cb_meas_sphfincolor})
                
                set(ui_checkbox_meas_spheretransparency, 'Units', 'normalized')
                set(ui_checkbox_meas_spheretransparency, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_spheretransparency, 'Position', [.01 0.5 .3 .08])
                set(ui_checkbox_meas_spheretransparency, 'String', ' Sphere Transparency ')
                set(ui_checkbox_meas_spheretransparency, 'Value', false)
                set(ui_checkbox_meas_spheretransparency, 'FontWeight', 'bold')
                set(ui_checkbox_meas_spheretransparency, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_spheretransparency, 'Callback', {@cb_checkbox_meas_spheretransparency})
                
                set(ui_slider_meas_spheretransparency, 'Units', 'normalized')
                set(ui_slider_meas_spheretransparency, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_slider_meas_spheretransparency, 'Min', 0, 'Max', 1, 'Value', PlotBrainGraph.INIT_SPH_FACE_ALPHA);
                set(ui_slider_meas_spheretransparency, 'Enable', 'off')
                set(ui_slider_meas_spheretransparency, 'Position', [.31 0.5 .6 .08])
                set(ui_slider_meas_spheretransparency, 'TooltipString', 'Brain region transparency (applied both to faces and edges)')
                set(ui_slider_meas_spheretransparency, 'Callback', {@cb_slider_meas_spheretransparency})
                
                set(ui_checkbox_meas_labelsize, 'Units', 'normalized')
                set(ui_checkbox_meas_labelsize, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_labelsize, 'Position', [.01 .4 .3 .08])
                set(ui_checkbox_meas_labelsize, 'String', ' Label Size ')
                set(ui_checkbox_meas_labelsize, 'Value', false)
                set(ui_checkbox_meas_labelsize, 'FontWeight', 'bold')
                set(ui_checkbox_meas_labelsize, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_labelsize, 'Callback', {@cb_checkbox_meas_labelsize})
                
                set(ui_edit_meas_labelsize, 'Units', 'normalized')
                set(ui_edit_meas_labelsize, 'String', PlotBrainGraph.INIT_LAB_FONT_SIZE)
                set(ui_edit_meas_labelsize, 'Enable', 'off')
                set(ui_edit_meas_labelsize, 'Position', [.31 .4 .6 .08])
                set(ui_edit_meas_labelsize, 'HorizontalAlignment', 'center')
                set(ui_edit_meas_labelsize, 'FontWeight', 'bold')
                set(ui_edit_meas_labelsize, 'Callback', {@cb_edit_meas_labelsize})
                
                set(ui_checkbox_meas_labelcolor, 'Units', 'normalized')
                set(ui_checkbox_meas_labelcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_checkbox_meas_labelcolor, 'Position', [.01 0.3 .3 .08])
                set(ui_checkbox_meas_labelcolor, 'String', ' Label Color ')
                set(ui_checkbox_meas_labelcolor, 'Value', false)
                set(ui_checkbox_meas_labelcolor, 'FontWeight', 'bold')
                set(ui_checkbox_meas_labelcolor, 'TooltipString', 'Shows brain regions by label')
                set(ui_checkbox_meas_labelcolor, 'Callback', {@cb_checkbox_meas_labelcolor})
                
                set(ui_popup_meas_labelinitcolor, 'Units', 'normalized')
                set(ui_popup_meas_labelinitcolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_labelinitcolor, 'Enable', 'off')
                set(ui_popup_meas_labelinitcolor, 'Position', [.31 .3 .3 .08])
                set(ui_popup_meas_labelinitcolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_labelinitcolor, 'Value', 1)
                set(ui_popup_meas_labelinitcolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_labelinitcolor, 'Callback', {@cb_meas_labelinitcolor})
                
                set(ui_popup_meas_labelfincolor, 'Units', 'normalized')
                set(ui_popup_meas_labelfincolor, 'BackgroundColor', GUI.BKGCOLOR)
                set(ui_popup_meas_labelfincolor, 'Enable', 'off')
                set(ui_popup_meas_labelfincolor, 'Position', [0.61 .3 .3 .08])
                set(ui_popup_meas_labelfincolor, 'String', {'R', 'G', 'B'})
                set(ui_popup_meas_labelfincolor, 'Value', 3)
                set(ui_popup_meas_labelfincolor, 'TooltipString', 'Select symbol');
                set(ui_popup_meas_labelfincolor, 'Callback', {@cb_meas_labelfincolor})
                
                set(ui_edge_value_show, 'Position', [0.4 0.3 0.4 0.2])
                set(ui_edge_value_show, 'String', 'Show Binodal Measures as Labels')
                set(ui_edge_value_show, 'Value', false)
                set(ui_edge_value_show, 'Callback', {@cb_binodal_measure_show})
                
                update_measure_control_panel()
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
            function cb_list_gr(~, ~)
                update_measure_data(2)
                update_brain_meas_plot()
                update_measure_control_panel()
            end
            function cb_list_t_or_d(~, ~)
                update_measure_data(2)
                update_brain_meas_plot()
            end
            function cb_popup_grouplist(~, ~)  % (src, event)
                update_measure_data(2)
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
                    
                    update_measure_data(2)
                    update_brain_meas_plot()
                else
                    set(ui_edit_meas_fdr1, 'Enable', 'off')
                    set(ui_checkbox_meas_fdr2, 'Enable', 'on')
                    
                    update_measure_data(2)
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
                update_measure_data(2)
                update_brain_meas_plot()
            end
            function cb_checkbox_meas_fdr2(~, ~)  %  (src, event)
                if get(ui_checkbox_meas_fdr2, 'Value')
                    set(ui_edit_meas_fdr2, 'Enable', 'on')
                    set(ui_edit_meas_fdr1, 'Enable', 'off')
                    set(ui_checkbox_meas_fdr1, 'Enable', 'off')
                    
                    update_measure_data(2)
                    update_brain_meas_plot()
                else
                    set(ui_edit_meas_fdr2, 'Enable', 'off')
                    set(ui_checkbox_meas_fdr1, 'Enable', 'on')
                    
                    update_measure_data(2)
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
                update_measure_data(2)
                update_brain_meas_plot()
            end
            function cb_meas_automatic(~, ~)  %  (src, event)
                if ~isempty(measure_data)
                    if iscell(measure_data)
                        measure_data_inner = [measure_data{:}];
                    else
                        measure_data_inner = measure_data;
                    end
                    offset = min(measure_data_inner(:));
                    if isnan(offset) || offset == 0 || ~isreal(offset)
                        set(ui_edit_meas_offset, 'String', '0');
                    else
                        set(ui_edit_meas_offset, 'String', num2str(offset))
                    end
                    
                    rescaling = max(measure_data_inner(:)) - offset;
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
            function update_figure_panel()
                if isequal(ga.getClass(), 'AnalysisCON_WU')
                    set(ui_list_gr, 'Position', [.02 .02 .30 .68])
                    set(ui_list_threshold_or_density, 'Position', [0 0 0 0])
                else
                    set(ui_list_gr, 'Position', [.02 .36 .3 .36])
                    set(ui_list_threshold_or_density, 'Position', [.02 .02 .3 .3])
                    set(list_tittle, 'Position', [.02 .32 .25 .04])
                    if isequal(ga.getClass(), 'AnalysisCON_BUT')
                        set(list_tittle, 'String', 'Select Threshold')
                    else  % desity
                        set(list_tittle, 'String', 'Select Density')
                    end
                end
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
            function update_list_t_d(selected_case)
                if isequal(ga.getClass(), 'AnalysisCON_BUT')
                    if get(ui_action_comparison_checkbox, 'Value')
                        [a, b] = selected_case.getGroups();
                        set(ui_list_threshold_or_density, 'String', analysis.selectComparisons(selected_case.getMeasureCode(), a, b, '.getThreshold()'))
                    elseif get(ui_action_random_checkbox, 'Value')
                        set(ui_list_threshold_or_density, 'String', analysis.selectRandomComparisons(selected_case.getMeasureCode(), selected_case.getGroup(), '.getThreshold()'))
                    else
                        set(ui_list_threshold_or_density, 'String', analysis.selectMeasurements(selected_case.getMeasureCode(), selected_case.getGroup(), '.getThreshold()'))
                    end
                elseif isequal(ga.getClass(), 'AnalysisCON_BUD')
                    if get(ui_action_comparison_checkbox, 'Value')
                        [a, b] = selected_case.getGroups();
                        set(ui_list_threshold_or_density, 'String', analysis.selectComparisons(selected_case.getMeasureCode(), a, b, '.getDensity()'))
                    elseif get(ui_action_random_checkbox, 'Value')
                        set(ui_list_threshold_or_density, 'String', analysis.selectRandomComparisons(selected_case.getMeasureCode(), selected_case.getGroup(), '.getDensity()'))
                    else
                        set(ui_list_threshold_or_density, 'String', analysis.selectMeasurements(selected_case.getMeasureCode(), selected_case.getGroup(), '.getDensity()'))
                    end
                else
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
            function update_measure_data(init_or_selection)
                if  init_or_selection == 2
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
                        
                        for i = 1:1:comparisons_idict.length()
                            comparison = comparisons_idict.getValue(i);
                            [a, b] = comparison.getGroups();
                            if isequal(comparison.getMeasureCode(), measure) && ((isequal(a, group1) && isequal (b, group2)) || (isequal(a, group2) && isequal (b, group1)))
                                selected_case = comparison;
                                update_list_t_d(selected_case)
                                break;
                            end
                        end
                        selected_action = 'Comparison';
                    elseif get(ui_action_random_checkbox, 'Value')
                        % i want to look in rcomprison
                        randoms_idict = ga.getRandomComparisons();
                        for i = 1:1:randoms_idict.length()
                            r_comparison = randoms_idict.getValue(i);
                            g = r_comparison.getGroup();
                            if isequal(r_comparison.getMeasureCode(), measure) && isequal(g, group1)
                                selected_case = r_comparison;
                                update_list_t_d(selected_case)
                                break;
                            end
                        end
                        selected_action = 'Random Comparison';
                    else
                        % i want to look in measurements
                        meas_idict = ga.getMeasurements();
                        for i = 1:1:meas_idict.length()
                            mesurements = meas_idict.getValue(i);
                            g = mesurements.getGroup();
                            if isequal(mesurements.getMeasureCode(), measure) && isequal(g, group1)
                                selected_case = mesurements;
                                update_list_t_d(selected_case)
                                break;
                            end
                        end
                        selected_action = 'Measurement';
                    end
                    if isempty(selected_case)
                        errordlg(['The measure: ' measure ' for ' selected_action ' does not exist.'])
                    else
                        if isequal(analysis.getClass(), 'AnalysisCON_WU')
                            switch selected_action
                                case 'Measurement'
                                    measure_data = selected_case.getGroupAverageValue();
                                case 'Comparison'
                                    atlases = ga.getCohort().getBrainAtlases();
                                    atlas = atlases{1};
                                    fdr_lim = ones(1, atlas.getBrainRegions().length());
                                    measure_data = selected_case.getDifference();
                                    p1 = selected_case.getP1();
                                    p2 = selected_case.getP2();
                                    calculate_fdr_lim()
                                otherwise
                                    atlases = ga.getCohort().getBrainAtlases();
                                    atlas = atlases{1};
                                    fdr_lim = ones(1, atlas.getBrainRegions().length());
                                    measure_data = selected_case.getDifference();
                                    p1 = selected_case.getP1();
                                    p2 = selected_case.getP2();
                                    calculate_fdr_lim()
                            end
                        elseif isequal(analysis.getClass(), 'AnalysisCON_BUT')
                            a = get(ui_list_threshold_or_density, 'String');
                            b = a{get(ui_list_threshold_or_density, 'Value')};
                            
                            switch selected_action
                                case 'Measurement'
                                    measurements = ga.getMeasurements().getValues();  % array
                                    for i = 1:1:length(measurements)
                                        m = measurements{i};
                                        if isequal(m.getClass(), selected_case.getClass()) && isequal(round(m.getThreshold(), 4), round(str2double(b), 4))
                                            refined_case = m;
                                            break;
                                        end
                                    end
                                    measure_data = refined_case.getGroupAverageValue();
                                case 'Comparison'
                                    comparisons = ga.getComparisons().getValues();
                                    for i = 1:1:length(comparisons)
                                        c = comparisons{i};
                                        if isequal(c.getClass(), selected_case.getClass()) && isequal(round(c.getThreshold(), 4), round(str2double(b), 4))
                                            refined_case = c;
                                            break;
                                        end
                                    end
                                    atlases = ga.getCohort().getBrainAtlases();
                                    atlas = atlases{1};
                                    fdr_lim = ones(1, atlas.getBrainregions().length());
                                    measure_data = refined_case.getDifference()';
                                    p1 = refined_case.getP1();
                                    p2 = refined_case.getP2();
                                    calculate_fdr_lim()
                                otherwise
                                    r_comparisons = ga.getRandomComparisons().getValues();
                                    for i = 1:1:length(r_comparisons)
                                        rc = r_comparisons{i};
                                        if isequal(rc.getClass(), selected_case.getClass()) && isequal(round(rc.getThreshold(), 4), round(str2double(b), 4))
                                            refined_case = rc;
                                            break;
                                        end
                                    end
                                    atlases = ga.getCohort().getBrainAtlases();
                                    atlas = atlases{1};
                                    fdr_lim = ones(1, atlas.getBrainregions().length());
                                    measure_data = refined_case.getDifference()';
                                    p1 = refined_case.getP1();
                                    p2 = refined_case.getP2();
                                    calculate_fdr_lim()
                            end
                        else  % density
                            a = get(ui_list_threshold_or_density, 'String');
                            b = a{get(ui_list_threshold_or_density, 'Value')};
                            
                            switch selected_action
                                case 'Measurement'
                                    measurements = ga.getMeasurements().getValues();  % array
                                    for i = 1:1:length(measurements)
                                        m = measurements{i};
                                        if isequal(m.getClass(), selected_case.getClass()) && isequal(round(m.getDensity(), 4), round(str2double(b), 4))
                                            refined_case = m;
                                            break;
                                        end
                                    end
                                    measure_data = refined_case.getGroupAverageValue();
                                case 'Comparison'
                                    comparisons = ga.getComparisons().getValues();
                                    for i = 1:1:length(comparisons)
                                        c = comparisons{i};
                                        if isequal(c.getClass(), selected_case.getClass()) && isequal(round(c.getDensity(), 4), round(str2double(b), 4))
                                            refined_case = c;
                                            break;
                                        end
                                    end
                                    atlases = ga.getCohort().getBrainAtlases();
                                    atlas = atlases{1};
                                    fdr_lim = ones(1, atlas.getBrainregions().length());
                                    measure_data = refined_case.getDifference()';
                                    p1 = refined_case.getP1();
                                    p2 = refined_case.getP2();
                                    calculate_fdr_lim()
                                otherwise
                                    r_comparisons = ga.getRandomComparisons().getValues();
                                    for i = 1:1:length(r_comparisons)
                                        rc = r_comparisons{i};
                                        if isequal(rc.getClass(), selected_case.getClass()) && isequal(round(rc.getDensity(), 4), round(str2double(b), 4))
                                            refined_case = rc;
                                            break;
                                        end
                                    end
                                    atlases = ga.getCohort().getBrainAtlases();
                                    atlas = atlases{1};
                                    fdr_lim = ones(1, atlas.getBrainregions().length());
                                    measure_data = refined_case.getDifference()';
                                    p1 = refined_case.getP1();
                                    p2 = refined_case.getP2();
                                    calculate_fdr_lim()
                            end
                        end
                    end
                else
                    % nothing
                end
            end
            function update_brain_meas_plot()
                if ~isempty(measure_data)
                    if isequal(size(measure_data, 2), 1)  % nodal
                        if iscell(measure_data)
                            measure_data_inner = [measure_data{:}];
                        else
                            measure_data_inner = measure_data;
                        end
                    elseif isequal(size(measure_data, 1), 1)  % global
                        % do nothing
                    else  % binodal
                    end
                    
                    if get(ui_checkbox_meas_symbolsize, 'Value')
                        
                        size_ = str2double(get(ui_edit_meas_symbolsize, 'String'));
                        offset = str2double(get(ui_edit_meas_offset, 'String'));
                        rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                        
                        if isempty(fdr_lim)
                            size_ = 1 + ((measure_data_inner - offset)./rescaling) * size_;
                        else
                            size_ = (1 + ((measure_data_inner - offset)./rescaling) * size_) .* fdr_lim;
                        end
                        
                        size_(isnan(size_)) = 0.1;
                        size_(size_<=0) = 0.1;
                        bg.br_syms([], 'Size', size_);
                    end
                    
                    if get(ui_checkbox_meas_symbolcolor, 'Value')
                        
                        offset = str2double(get(ui_edit_meas_offset, 'String'));
                        rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                        
                        colorValue = (measure_data_inner - offset)./rescaling;
                        %colorValue = (measure_data_inner - min(measure_data_inner))./(max(measure_data_inner)-min(measure_data_inner));
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
                        
                        if isempty(fdr_lim)
                            R = 1 + ((measure_data_inner - offset)./rescaling)*R;
                        else
                            R = (1 + ((measure_data_inner - offset)./rescaling)*R).*fdr_lim;
                        end
                        
                        R(isnan(R)) = 0.1;
                        R(R<=0) = 0.1;
                        bg.br_sphs([], 'R', R);
                    end
                    
                    if get(ui_checkbox_meas_spherecolor, 'Value')
                        
                        offset = str2double(get(ui_edit_meas_offset, 'String'));
                        rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                        
                        colorValue = (measure_data_inner - offset)./rescaling;
                        %colorValue = (measure_data_inner - min(measure_data_inner))./(max(measure_data_inner)-min(measure_data_inner));
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
                        
                        if isempty(fdr_lim)
                            alpha_vec = ((measure_data_inner - offset)./rescaling).*alpha;
                        else
                            alpha_vec = (((measure_data_inner - offset)./rescaling).*alpha).*fdr_lim;
                        end
                        alpha_vec(isnan(alpha_vec)) = 0;
                        alpha_vec(alpha_vec<0) = 0;
                        alpha_vec(alpha_vec>1) = 1;
                        bg.br_sphs([], 'Alpha', alpha_vec);
                    end
                    
                    if get(ui_checkbox_meas_labelsize, 'Value')
                        
                        size_ = str2double(get(ui_edit_meas_labelsize, 'String'));
                        offset = str2double(get(ui_edit_meas_offset, 'String'));
                        rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                        
                        if isempty(fdr_lim)
                            size_ = 1 + ((measure_data_inner - offset)./rescaling)*size_;
                        else
                            size_ = (1 + ((measure_data_inner - offset)./rescaling)*size_).*fdr_lim;
                        end
                        
                        size_(isnan(size_)) = 0.1;
                        size_(size_<=0) = 0.1;
                        bg.br_labs([], 'FontSize', size_);
                    end
                    
                    if get(ui_checkbox_meas_labelcolor, 'Value')
                        
                        offset = str2double(get(ui_edit_meas_offset, 'String'));
                        rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                        
                        colorValue = (measure_data_inner - offset)./rescaling;
                        %colorValue = (measure_data_inner - min(measure_data_inner))./(max(measure_data_inner)-min(measure_data_inner));
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
            function calculate_fdr_lim()
                i = get(ui_list_gr, 'Value');
                m = mlist{i};
                atlases = ga.getCohort().getBrainAtlases();
                atlas = atlases{1};
                if Measure.is_nodal(m)
                    fdr_lim = ones(1, atlas.getBrainRegions().length());
                    for i = 1:1:atlas.getBrainRegions().length()
                        if get(ui_checkbox_meas_fdr1, 'Value')
                            if p1(i) > fdr(p1, str2double(get(ui_edit_meas_fdr1, 'String')))
                                fdr_lim(i) = 0;
                            end
                        elseif get(ui_checkbox_meas_fdr2, 'Value')
                            if p2(i) > fdr(p2, str2double(get(ui_edit_meas_fdr2, 'String')))
                                fdr_lim(i) = 0;
                            end
                        end
                    end
                elseif Measure.is_binodal(m)
                    
                else
                    % do nothing
                end
            end
            function update_measure_control_panel()
                i = get(ui_list_gr, 'Value');
                measure = mlist{i};
                if (Measure.is_nodal(measure))
                    set(ui_measure_container_panel, 'Visible', 'on')
                    childs_visibility(ui_measure_container_panel, 'on')
                    set(ui_edge_value_show, 'Enable', 'off')
                    set(ui_edge_value_show, 'Visible', 'off')
                else
                    set(ui_measure_container_panel, 'Visible', 'off')
                    childs_visibility(ui_measure_container_panel, 'off')
                    set(ui_edge_value_show, 'Enable', 'on')
                    set(ui_edge_value_show, 'Visible', 'on')
                end
            end
            function childs_visibility(handle, rule)
                childs = allchild(handle);
                set(handle, 'visible', rule)
                for i = 1:1:length(childs)
                    set(childs(i), 'visible', rule)
                end
            end
            function cb_binodal_measure_show(~, ~)
                if iscell(measure_data)
                    measure_data_inner = [measure_data{:}];
                else
                    measure_data_inner = measure_data;
                end
                if get(ui_edge_value_show, 'Value')
                    for i = 1:1:size(measure_data_inner, 1)
                        for j = 1:1:size(measure_data_inner, 2)
                            if bg.link_edge_is_on(i, j) || bg.arrow_edge_is_on(i, j) || bg.cylinder_edge_is_on(i, j)
                                if bg.tex_edge_is_off(i, j)
                                    bg.text_edge_on(i, j)
                                else
                                    bg.text_edge(brain_axes, i, j, string(measure_data_inner(i, j)))
                                end
                            end
                        end
                    end
                else
                    for i = 1:1:size(measure_data_inner, 1)
                        for j = 1:1:size(measure_data_inner, 2)
                            if bg.link_edge_is_on(i, j) || bg.arrow_edge_is_on(i, j) || bg.cylinder_edge_is_on(i, j)
                                bg.text_edge_off(i, j);
                            end
                        end
                    end
                end
            end
            
            if nargout > 0
                h = f;
            end
        end
    end
    methods (Static)  % Save and load functions
        function analysis = load_from_xls(tmp, varargin)
            % directory
            directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_GETDIR, 'MSG', varargin{:});
                directory = uigetdir(msg);
            end
            
            % find all subfolders
            sub_folders = dir(directory);
            sub_folders = sub_folders([sub_folders(:).isdir] == 1);
            sub_folders = sub_folders(~ismember({sub_folders(:).name}, {'.', '..'}));
            
            if isa(tmp, 'Analysis')
                analysis = tmp;
                subject_class = analysis.getCohort().getSubjectClass();
            else
                % analysis information
                file_analysis = [directory filesep() 'analysis_info.xlsx'];
                analysis_id = '';
                analysis_label = '';
                analysis_notes = '';
                
                if exist(file_analysis, 'file')
                    raw_analysis = readcell(file_analysis);
                    analysis_id = raw_analysis{1, 2};
                    analysis_label = raw_analysis{2, 2};
                    analysis_notes = raw_analysis{3, 2};
                    type_of_analysis = raw_analysis{4, 2};
                    cohort_id = raw_analysis{5, 2};
%                     n_measurements = raw_analysis{6, 2};
%                     n_comparisons = raw_analysis{7, 2}; do i need this?
%                     n_rcomparisons = raw_analysis{8, 2};
                end
                
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
                if isequal(type_of_analysis, 'AnalysisCON_WU')
                    analysis = AnalysisCON_WU(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                elseif isequal(type_of_analysis, 'AnalysisCON_BUT')
                    analysis = AnalysisCON_BUT(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                elseif isequal(type_of_analysis, 'AnalysisCON_BUD')
                    analysis = AnalysisCON_BUD(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                else
                    errordlg('Type of Analysis does not exist.');
                end
                
                % load analyses
                for i = 1:1:length(sub_folders)
                    path = [directory filesep() sub_folders(i).name];
                    
                    % find all xls or xlsx files per sub folder
                    files = dir(fullfile(path, '*.xlsx'));
                    files2 = dir(fullfile(path, '*.xls'));
                    len = length(files);
                    for j = 1:1:length(files2)
                        files(len + j, 1) = files2(j, 1);
                    end
                    
                    % measurements
                    if isequal(sub_folders(i).name, 'measurements')
                        measurement_idict = analysis.getMeasurements();
                        for k = 1:1:length(files)
                            % get info main
                            raw_main = readcell(fullfile(path, files(k).name));
                            meas_id = raw_main{1, 2};
                            meas_lab = raw_main{2, 2};
                            meas_notes = raw_main{3, 2};
                            measure_code = raw_main{4, 2};
                            
                            % get values
                            raw_values = readmatrix(fullfile(path, files(k).name), 'Sheet', 2);
                            raw_avgs = readmatrix(fullfile(path, files(k).name), 'Sheet', 3);
                            
                            % create measurement
                            measurement = Measurement.getMeasurement(analysis.getMeasurementClass(), ...
                                meas_id, ...
                                meas_lab, ...  % meaurement label
                                meas_notes, ...  % meaurement notes
                                analysis.getCohort().getBrainAtlases(), ...
                                measure_code, ...
                                group,  ...
                                'MeasurementCON.values', raw_values, ...
                                'MeasurementCON.average_value', raw_avgs, ...
                                varargin{:});
                            measurement_idict.add(measurement, k);
                        end 
                    elseif isequal(sub_folders(i).name, 'comparisons')
                    elseif isequal(sub_folders(i).name, 'randomcomparisons')
                    else
                        continue;                        
                    end
                end   
            end
        end
        function save_to_xls(analysis, varargin)
            % save to folders separting by type of analysis
            
            % get saving info
            % get Root Directory
            root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);
            end
            
            analyses = {'measurements', 'comparisons', 'randomcomparisons'};
            for i = 1:1:3
                type_of_analysis = analyses{i};
                if ~exist([root_directory filesep() type_of_analysis], 'dir')
                    mkdir(root_directory, type_of_analysis);
                end
            end
            
            % get analysis info
            cohort = analysis.getCohort();
            measurements = analysis.getMeasurements();
            comparisons = analysis.getComparisons();
            random_comparisons = analysis.getRandomComparisons();
            
            % save analysis main file id, label, notes.
            analysis_main_file = [root_directory filesep() 'analysis_info.xlsx'];
            basic_info = {
                'Analysis ID:', analysis.getID();
                'Analysis Label:',  analysis.getLabel();
                'Analysis Notes:', analysis.getNotes();
                'Type of Analysis:', analysis.getClass();
                'Cohort:',  cohort.getID();
                'Number of Measurements:', measurements.length();
                'Number of Comparisons:', comparisons.length();
                'Number of Random Comparisons:' random_comparisons.length();
                };
            
            writecell(basic_info, analysis_main_file, 'Sheet', 1);
            
%             % save cohort  could ask if the user wants to save
%             SubjectCON.save_to_xls(cohort, 'Directory', root_directory);
            
            % measurements could ask for just certain measures 
            for i = 1:1:measurements.length()
                m = measurements.getValue(i);
                file_measurement = [root_directory filesep() 'measurements' filesep() m.getID() '.xlsx'];
                measurement_data = {
                    'Measurement ID:', m.getID();
                    'Measurement Label:', m.getLabel();
                    'Measurement Notes:', m.getNotes();
                    'Measure:', m.getMeasureCode();
                    'Group:', m.getGroup();
                    'Values (Sheet 2):', size(m.getMeasureValues);
                    'Group Average (Sheet 3):', size(m.getGroupAverageValue());
                    };
                
                writecell(measurement_data, file_measurement, 'Sheet', 1);
                writematrix([m.getMeasureValues{:}], file_measurement, 'Sheet', 2);
                writematrix(m.getGroupAverageValue, file_measurement, 'Sheet', 3);
            end
            
            % comparisons
            for i = 1:1:comparisons.length()
                c = comparisons.getValue(i);
                Values1 = c.getGroupValue(1);
                Values2 = c.getGroupValue(2);
                Avg_1 = c.getGroupAverageValue(1);
                Avg_2 = c.getGroupAverageValue(2);
                [g1, g2] = c.getGroups();
                file_comparisons = [root_directory filesep() 'comparisons' filesep() c.getID() '.xlsx'];
                comparisons_data = {
                    'Comparison ID:', c.getID();
                    'Comparison Label:', c.getLabel();
                    'Comparison Notes:', c.getNotes();
                    'Group 1:', g1;
                    'Group 2:', g2;
                    'Values Group 1 (Sheet 2):', size(Values1);
                    'Values Group 2 (Sheet 3):', size(Values2);
                    'Group 1 Average Value (Sheet 4):', size(Avg_1);
                    'Group 2 Average Value (Sheet 5):', size(Avg_2);
                    'Difference (Sheet 6):', size(c.getDifference());
                    'All Differences (Sheet 7):', size(c.getAllDifferences());
                    'P1 (Sheet 8):', size(c.getP1());
                    'P2 (Sheet 9):', size(c.getP2());
                    'Minimum Confidence Interval (Sheet 10):', size(c.getConfidenceIntervalMin());
                    'Maximum Confidence Interval (Sheet 11):', size(c.getConfidenceIntervalMax());
                    };
                
                writecell(comparisons_data, file_comparisons, 'Sheet', 1);
                writematrix([Values1{:}], file_comparisons, 'Sheet', 2);
                writematrix([Values2{:}], file_comparisons, 'Sheet', 3);
                writematrix([Avg_1{:}], file_comparisons, 'Sheet', 4)
                writematrix([Avg_2{:}], file_comparisons, 'Sheet', 5)
                writematrix([c.getDifference{:}], file_comparisons, 'Sheet', 6)
                writematrix([c.getAllDifferences{:}], file_comparisons, 'Sheet', 7)
                writematrix([c.getP1{:}], file_comparisons, 'Sheet', 8)
                writematrix([c.getP2{:}], file_comparisons, 'Sheet', 9)
                writematrix([c.getConfidenceIntervalMin{:}], file_comparisons, 'Sheet', 10)
                writematrix([c.getConfidenceIntervalMax{:}], file_comparisons, 'Sheet', 11)
            end
            
            % random comparisons
            for i = 1:1:random_comparisons.length()
                rc = random_comparisons.getValue(i);
                Values1 = rc.getGroupValue();
                Values2 = rc.getRandomValue();
                Avg_1 = rc.getAverageValue();
                Avg_2 = rc.getAverageRandomValue();
                group = rc.getGroups();
                file_random_comparisons = [root_directory filesep() 'randomcomparisons' filesep() rc.getID() '.xlsx'];
                random_comparisons_data = {
                    'Random Comparison ID:', rc.getID();
                    'Random Comparison Label:', rc.getLabel();
                    'Random Comparison Notes:', rc.getNotes();
                    'Values Group 1 (Sheet 2):', size(Values1);
                    'Values Random Group (Sheet 3):', size(Values2);
                    'Group 1 Average Value (Sheet 4):', size(Avg_1);
                    'Random Group Average Value (Sheet 5):', size(Avg_2);
                    'Difference (Sheet 6):', size(rc.getDifference());
                    'All Differences (Sheet 7):', size(rc.getAllDifferences());
                    'P1 (Sheet 8):', size(rc.getP1());
                    'P2 (Sheet 9):', size(rc.getP2());
                    'Minimum Confidence Interval (Sheet 10):', size(rc.getConfidenceIntervalMin());
                    'Maximum Confidence Interval (Sheet 11):', size(rc.getConfidenceIntervalMax());
                    };
                
                writecell(random_comparisons_data, file_random_comparisons, 'Sheet', 1);
                writematrix([rc.getGroupValue{:}], file_random_comparisons, 'Sheet', 2);
                writematrix([rc.getRandomValue{:}], file_random_comparisons, 'Sheet', 3);
                writematrix([rc.getAverageValue{:}], file_random_comparisons, 'Sheet', 4)
                writematrix([rc.getAverageRandomValue{:}], file_random_comparisons, 'Sheet', 5)
                writematrix([rc.getDifference{:}], file_random_comparisons, 'Sheet', 6)
                writematrix([rc.getAllDifferences{:}], file_random_comparisons, 'Sheet', 7)
                writematrix([rc.getP1{:}], file_random_comparisons, 'Sheet', 8)
                writematrix([rc.getP2{:}], file_random_comparisons, 'Sheet', 9)
                writematrix([rc.getConfidenceIntervalMin{:}], file_random_comparisons, 'Sheet', 10)
                writematrix([rc.getConfidenceIntervalMax{:}], file_random_comparisons, 'Sheet', 11)
            end
        end
        function analysis = load_from_json(tmp, varargin)
        end
        function save_to_json(analysis, varargin)
        end
    end
end