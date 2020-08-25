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
    %  getGlobalPanel               - creates a uipanel for GUIAnalysis
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

            measurement = Measurement.getMeasurement(analysis.getMeasurementClass(), ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'MeasurementST.value', measurement_value, ...
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
                        matrix_plot = GraphBU.plot(A, 'Graph.PlotType', graph_type_value);
                    else         
                        % get atlas labels
                        atlases = analysis.getCohort().getBrainAtlases();
                        atlas = atlases{1};
                        br_labels = atlas.getBrainRegions().getKeys();
                        matrix_plot = GraphWU.plot(A, graph_rule, ...
                            graph_rule_value, 'Graph.PlotType', graph_type_value, 'xlabels', br_labels, 'ylabels', br_labels);
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
            
            % declre constans
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
                    set(ui_global_tbl, 'Position', [.02 .19 .5 .79])                    
                    GUI.setUnits(ui_plot_measure_panel)
                    GUI.setBackgroundColor(ui_plot_measure_panel) 
                    set(ui_plot_measure_panel, 'Position', [.52 .00 .48 .98])
                    
                    set(ui_plot_measure_axes, 'Parent', ui_plot_measure_panel)
                    set(ui_plot_measure_axes, 'Position', [.1 .2 .8 .79])
                end
                    set(ui_global_tbl, 'CellEditCallback', {@cb_global_table_edit})
                
                set(ui_global_tbl, 'Units', 'normalized')
                set(ui_button_brainmeasures_selectall, 'Position', [.2 .14 .10 .03])
                set(ui_button_brainmeasures_selectall, 'String', SELECTALL_MEAS_CMD)
                set(ui_button_brainmeasures_selectall, 'TooltipString', SELECTALL_MEAS_TP)
                set(ui_button_brainmeasures_selectall, 'Callback', {@cb_global_selectall})
                
                set(ui_button_brainmeasures_clearselection, 'Position', [.3 .14 .10 .03])
                set(ui_button_brainmeasures_clearselection, 'String', CLEARSELECTION_MEAS_CMD)
                set(ui_button_brainmeasures_clearselection, 'TooltipString', CLEARSELECTION_MEAS_TP)
                set(ui_button_brainmeasures_clearselection, 'Callback', {@cb_global_clearselection})
                
                set(ui_button_brainmeasures_remove, 'Position', [.4 .14 .10 .03])
                set(ui_button_brainmeasures_remove, 'String', REMOVE_MEAS_CMD)
                set(ui_button_brainmeasures_remove, 'TooltipString', REMOVE_MEAS_TP)
                set(ui_button_brainmeasures_remove, 'Callback', {@cb_global_remove})
                
                set(ui_checkbox_brainmeasures_meas, 'Position', [.2 .09 .10 .03])
                set(ui_checkbox_brainmeasures_meas, 'String', 'measure')
                set(ui_checkbox_brainmeasures_meas, 'Value', true)
                set(ui_checkbox_brainmeasures_meas, 'TooltipString', 'Select measure')
                set(ui_checkbox_brainmeasures_meas, 'FontWeight', 'bold')
                set(ui_checkbox_brainmeasures_meas, 'Callback', {@cb_global_meas})
                
                set(ui_checkbox_brainmeasures_comp, 'Position',[.3 .09 .10 .03])
                set(ui_checkbox_brainmeasures_comp, 'String', 'comparison')
                set(ui_checkbox_brainmeasures_comp, 'Value', false)
                set(ui_checkbox_brainmeasures_comp, 'TooltipString', 'Select comparison')
                set(ui_checkbox_brainmeasures_comp, 'Callback', {@cb_global_comp})
                
                set(ui_checkbox_brainmeasures_rand, 'Position', [.4 .09 .15 .03])
                set(ui_checkbox_brainmeasures_rand, 'String', 'random comparison')
                set(ui_checkbox_brainmeasures_rand, 'Value', false)
                set(ui_checkbox_brainmeasures_rand, 'TooltipString', 'Select random comparison')
                set(ui_checkbox_brainmeasures_rand, 'Callback', {@cb_global_rand})  
                
                set(ui_popup_globalmeasures_group1, 'Position', [.02 .1 .15 .07])
                set(ui_popup_globalmeasures_group1, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_globalmeasures_group1, 'Callback', {@cb_global_table})
                set(ui_popup_globalmeasures_group1, 'Enable', 'off')
                set(ui_popup_globalmeasures_group1, 'Visible', 'off')
                
                set(ui_popup_globalmeasures_group2, 'Position', [.02 .02 .15 .07])
                set(ui_popup_globalmeasures_group2, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_popup_globalmeasures_group2, 'Callback', {@cb_global_table})
                set(ui_popup_globalmeasures_group2, 'Enable', 'off')
                set(ui_popup_globalmeasures_group2, 'Visible', 'off')
                
                set(ui_listbox_brainmeasures_comp_groups, 'Position',[.02 .02 .15 .145])
                set(ui_listbox_brainmeasures_comp_groups, 'String', analysis.getCohort().getGroups().getKeys())
                set(ui_listbox_brainmeasures_comp_groups, 'TooltipString', 'Select group 1');
                set(ui_listbox_brainmeasures_comp_groups, 'Callback', {@cb_global_table})
                
            end
            function update_global_table()
                data = {}; %#ok<NASGU>
                RowName = [];
                
                selected_index = get(ui_listbox_brainmeasures_comp_groups, 'Value');                
                group = analysis.getCohort().getGroups().getValue(selected_index);

                if get(ui_checkbox_brainmeasures_meas, 'Value')
                    for j = 1:1:analysis.getMeasurements().length()
                        measurement = analysis.getMeasurements().getValue(j);
                        if isa(group, 'cell') && ismember(measurement.getMeasureCode(), global_list)
                            for k =1:1:length(group)
                                g = group{k};
                                if isequal(measurement.getGroup(), g) 
                                    global_measurements{j} = measurement; %#ok<AGROW>
                                end
                            end
                        else
                            if ismember(measurement.getMeasureCode(), global_list) && isequal(measurement.getGroup(), group)
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
                     for j = 1:1:analysis.getComparisons().length()
                        comparison = analysis.getComparisons().getValue(j);
                        [a, b] = comparison.getGroups();
                        if isa(group, 'cell') && ismember(comparison.getMeasureCode(), global_list)
                            for k =1:1:length(group)
                                g = group{k};
                                if isequal(a, g) || isequal (b, g)
                                    global_comparison{j} = comparison; %#ok<AGROW>
                                end
                            end
                        else
                            if ismember(comparison.getMeasureCode(), global_list) && (isequal(a, group) || isequal (b, group))
                                global_comparison{j} = comparison;                 
                            end
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
                                if isequal(randomcomparison.getGroup(), g) 
                                    global_randomcomparison{j} = randomcomparison; %#ok<AGROW>
                                end
                            end
                        else
                            if ismember(randomcomparison.getMeasureCode(), global_list) && isequal(randomcomparison.getGroup(), group)
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
                class_name = analysis.getClass();
                class_suffix = class_name(end-2:end);                
                if  isequal(class_suffix, 'BUT')
                    if get(ui_checkbox_brainmeasures_meas, 'Value')
                        analysis.getGlobalMeasurePlot(ui_plot_measure_panel, ui_plot_measure_axes, get(ui_listbox_brainmeasures_comp_groups, 'Value'), 'XLabel', 'Threshold');
                    elseif get(ui_checkbox_brainmeasures_comp, 'Value')
                        analysis.getGlobalComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, get(ui_popup_globalmeasures_group1, 'Value'), get(ui_popup_globalmeasures_group2, 'Value'), 'XLabel', 'Threshold');
                    elseif get(ui_checkbox_brainmeasures_rand, 'Value')
                        analysis.getGlobalRancomComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, get(ui_listbox_brainmeasures_comp_groups, 'Value'), 'XLabel', 'Threshold');
                    end                    
                elseif isequal(class_suffix, 'BUD')
                    if get(ui_checkbox_brainmeasures_meas, 'Value')
                        analysis.getGlobalMeasurePlot(ui_plot_measure_panel, ui_plot_measure_axes, get(ui_listbox_brainmeasures_comp_groups, 'Value'), 'XLabel', 'Density');
                    elseif get(ui_checkbox_brainmeasures_comp, 'Value')
                        analysis.getGlobalComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, get(ui_popup_globalmeasures_group1, 'Value'), get(ui_popup_globalmeasures_group2, 'Value'), 'XLabel', 'Density');
                    elseif get(ui_checkbox_brainmeasures_rand, 'Value')
                        analysis.getGlobalRandomComparisonPlot(ui_plot_measure_panel, ui_plot_measure_axes, get(ui_listbox_brainmeasures_comp_groups, 'Value'), 'XLabel', 'Density');
                    end                
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
                analysis.getMeasurements().remove(selected_brainmeasures);
                update_global_table()
            end
            
            update_global_table()
            init_plot_measure_panel()
            
            if nargout > 0
                global_panel = ui_mainpanel;
            end
        end        
    end
end