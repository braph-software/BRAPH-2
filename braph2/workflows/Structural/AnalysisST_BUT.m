classdef AnalysisST_BUT < AnalysisST_WU
    % AnalysisST_BUT An analysis of structural data of fixed threshold binary undirected graphs
    % AnalysisST_BUT is a subclass of AnalysisST_WU and implements the methods
    % needed for structural analysis.
    %
    % AnalysisST_BUT implements AnalysisST_WU calculting methods
    % to obtain a structural data of fixed threshold binary undirected graphs
    % measurement, a random comprison or a comparison.
    % Structural data can be for example MRI or PET data.
    %
    % AnalysisST_BUT constructor methods:
    %  AnalysisST_BUT               - Constructor
    %
    % AnalysisST_BUT calcultion methods (Access = protected):
    %  get_graph_for_subjects       - returns the graph of the correlated matrix
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
    % See also Analysis, MeasurementST_BUT, RandomComparisonST_BUT, ComparisonST_BUT
    
    methods
        function analysis = AnalysisST_BUT(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % AnalysisST_BUT(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a structural analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISST_WU with default settings.
            %
            % AnalysisST_BUT(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a structural analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISST_WU with specified settings VALUES.
            %
            % See also MeasurementST_WU, RandomComparisonST_WU, ComparisonST_WU.
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            analysis = analysis@AnalysisST_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, 'threshold', threshold, varargin{:});
        end
    end
    methods (Access = protected)
        function g = get_graph_for_subjects(analysis, subjects, varargin)
            atlases = analysis.cohort.getBrainAtlases();
            atlas = atlases{1};
            
            subject_number = numel(subjects);
            
            data = zeros(subject_number, atlas.getBrainRegions().length());
            for i = 1:1:subject_number
                subject = subjects{i};
                data(i, :) = subject.getData('ST').getValue();  % st data
            end
            
            correlation_rule = analysis.getSettings('AnalysisST_BUT.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisST_BUT.NegativeWeightRule');
            A = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
            
            A = binarize(A, varargin{:});
            
            graph_type = AnalysisST_.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
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
            
            g = get_graph_for_subjects(analysis, subjects, varargin{:});
            
            measure = Measure.getMeasure(measure_code, g, varargin{:});
            measurement_value = measure.getValue();
            
            measurement = Measurement.getMeasurement('MeasurementST_BUT', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'MeasurementST_BUT.value', measurement_value ...
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
            
            g = get_graph_for_subjects(analysis, group.getSubjects(), varargin{:});
            
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
            
            randomcomparison = RandomComparison.getRandomComparison('RandomComparisonST_BUT', ...
                analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
                '', ...  % random comparison label
                '', ...  % random comparison notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group, ...
                'RandomComparisonST_BUT.RandomizationNumber', M, ...
                'RandomComparisonST_BUT.AttemptsPerEdge', attempts_per_edge, ...
                'RandomComparisonST_BUT.NumberOfWeights', number_of_weights, ...
                'RandomComparisonST_BUT.value_group', value_group, ...
                'RandomComparisonST_BUT.value_random', value_random, ...
                'RandomComparisonST_BUT.difference', difference, ...
                'RandomComparisonST_BUT.all_differences', all_differences, ...
                'RandomComparisonST_BUT.p1', p1, ...
                'RandomComparisonST_BUT.p2', p2, ....
                'RandomComparisonST_BUT.confidence_min', ci_lower, ...
                'RandomComparisonST_BUT.confidence_max', ci_upper ...
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
            %
            % See also calculate_random_comparison, calculate_measurement.
            
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            
            is_longitudinal = analysis.getSettings('AnalysisST_BUT.Longitudinal');
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
                
                graph_permutated_1 = get_graph_for_subjects(analysis, permutation_subjects_1, varargin{:});
                measure_permutated_1 = Measure.getMeasure(measure_code, graph_permutated_1, varargin{:});
                measure_permutated_value_1 = measure_permutated_1.getValue();
                
                graph_permutated_2 = get_graph_for_subjects(analysis, permutation_subjects_2, varargin{:});
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
            
            comparison = Comparison.getComparison('AnalysisST_BUT', ...
                analysis.getComparisonID(measure_code, group_1, group_2, varargin{:}), ...
                '', ...  % comparison label
                '', ...  % comparison notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group_1, ...
                group_2, ...
                'AnalysisST_BUT.PermutationNumber', M, ...
                'AnalysisST_BUT.value_1', value_1, ...
                'AnalysisST_BUT.value_2', value_2, ...
                'AnalysisST_BUT.difference', difference_mean, ...
                'AnalysisST_BUT.all_differences', difference_all_permutations, ...
                'AnalysisST_BUT.p1', p1, ...
                'AnalysisST_BUT.p2', p2, ...
                'AnalysisST_BUT.confidence_min', ci_lower, ...
                'AnalysisST_BUT.confidence_max', ci_upper ...
                );
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
            % NAME = GETNAME() returns the name of ANALYSIS.
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
                'Analysis based on structural data using weighted graphs, ' ...
                'e.g. cortical thickness for each brain region. ' ...
                'It provides a single graph for each subject group. ' ...
                'Structural data can be for example MRI or PET data.' ...
                ];
        end
        function measurement_class = getMeasurementClass()
            % GETMEASUREMENTCLASS returns the class of structural analysis measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS() returns the
            % class of AnalysisST_WU measurement, 'MeasurementST_BUT'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementST_BUT';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of structural analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisST_WU randomcomparison,
            % 'RandomComparisonST_BUT'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonST_BUT';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of structural analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisST_WU comparison, 'ComparisonST_BUT'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonST_BUT';
        end
        function available_settings = getAvailableSettings(m) %#ok<INUSD>
            % GETAVAILABLESETTINGS returns the available settings of structural analysis
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(M) returns the
            % available settings of AnalysisST_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {
                {'AnalysisST_BUT.CorrelationRule', BRAPH2.STRING, 'pearson', Correlation.CORRELATION_RULE_LIST}, ...
                {'AnalysisST_BUT.NegativeWeightRule', BRAPH2.STRING, 'zero', Correlation.NEGATIVE_WEIGHT_RULE_LIST}, ...
                {'AnalysisST_BUT.Longitudinal', BRAPH2.LOGICAL, false, {false, true}} ...
                };
        end
    end
end