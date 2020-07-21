classdef AnalysisST_BUT < Analysis
    methods  % Constructor
        function analysis = AnalysisST_BUT(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            
            analysis = analysis@Analysis(id, label, notes, cohort, measurements, randomcomparisons, comparisons, 'threshold', threshold, varargin{:});
        end
    end
    methods  % ID functions
        function measurement_id = getMeasurementID(analysis, measure_code, group, varargin)
            measurement_id = [ ...
                tostring(analysis.getMeasurementClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group)) ...
                ];
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
            randomcomparison_id = [ ...
                tostring(analysis.getRandomComparisonClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group)) ...
                ];
        end
        function comparison_id = getComparisonID(analysis, measure_code, group_1, group_2, varargin)
            comparison_id = [ ...
                tostring(analysis.getComparisonClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group_1)) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group_2)) ...
                ];
        end
    end
    methods (Access = protected)  % Calculation functions
        function g = get_graph_for_subjects(analysis, subjects)
            atlases = analysis.cohort.getBrainAtlases();
            atlas = atlases{1};
            
            subject_number = numel(subjects);

            data = zeros(subject_number, atlas.getBrainRegions().length());
            for i = 1:1:subject_number
                subject = subjects{i};
                data(i, :) = subject.getData('ST').getValue();  % st data
            end
            
            correlation_rule = analysis.getSettings('AnalysisST_WU.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisST_WU.NegativeWeightRule');
            A = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
            
            graph_type = AnalysisST_WU.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
        function measurement = calculate_measurement(analysis, measure_code, group, varargin)
            subjects = group.getSubjects();

            g = get_graph_for_subjects(analysis, subjects);
            
            measure = Measure.getMeasure(measure_code, g, varargin{:});
            measurement_value = measure.getValue();

            measurement = Measurement.getMeasurement('MeasurementST_WU', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'MeasurementST_WU.value', measurement_value ...
                );
        end
        function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});

            M = get_from_varargin(1e+3, 'RandomizationNumber', varargin{:});
            attempts_per_edge = get_from_varargin(5, 'AttemptsPerEdge', varargin{:});
            number_of_weights = get_from_varargin(1, 'NumberOfWeights', varargin{:});

            % Measurements for the group
            measurement_group = analysis.getMeasurement(measure_code, group, varargin{:});
            value_group = measurement_group.getMeasureValue();

            g = get_graph_for_subjects(analysis, group.getSubjects());
            
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

            randomcomparison = RandomComparison.getRandomComparison('RandomComparisonST_WU', ...
                analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
                '', ...  % random comparison label
                '', ...  % random comparison notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group, ...
                'RandomComparisonST_WU.RandomizationNumber', M, ...
                'RandomComparisonST_WU.AttemptsPerEdge', attempts_per_edge, ...
                'RandomComparisonST_WU.NumberOfWeights', number_of_weights, ...
                'RandomComparisonST_WU.value_group', value_group, ...
                'RandomComparisonST_WU.value_random', value_random, ...
                'RandomComparisonST_WU.difference', difference, ...
                'RandomComparisonST_WU.all_differences', all_differences, ...
                'RandomComparisonST_WU.p1', p1, ...
                'RandomComparisonST_WU.p2', p2, ....
                'RandomComparisonST_WU.confidence_min', ci_lower, ...
                'RandomComparisonST_WU.confidence_max', ci_upper ...
                );
        end
        function comparison = calculate_comparison(analysis, measure_code, group_1, group_2, varargin)
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            
            is_longitudinal = analysis.getSettings('AnalysisST_WU.Longitudinal');
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
                
                graph_permutated_1 = get_graph_for_subjects(analysis, permutation_subjects_1);
                measure_permutated_1 = Measure.getMeasure(measure_code, graph_permutated_1, varargin{:});
                measure_permutated_value_1 = measure_permutated_1.getValue();

                graph_permutated_2 = get_graph_for_subjects(analysis, permutation_subjects_2);
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
            
            comparison = Comparison.getComparison('ComparisonST_WU', ...
                analysis.getComparisonID(measure_code, group_1, group_2, varargin{:}), ...
                '', ...  % comparison label
                '', ...  % comparison notes                
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group_1, ...
                group_2, ...
                'ComparisonST_WU.PermutationNumber', M, ...
                'ComparisonST_WU.value_1', value_1, ...
                'ComparisonST_WU.value_2', value_2, ...
                'ComparisonST_WU.difference', difference_mean, ...
                'ComparisonST_WU.all_differences', difference_all_permutations, ...
                'ComparisonST_WU.p1', p1, ...
                'ComparisonST_WU.p2', p2, ...
                'ComparisonST_WU.confidence_min', ci_lower, ...
                'ComparisonST_WU.confidence_max', ci_upper ...
                );
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            analysis_class = 'AnalysisST_WU';
        end
        function name = getName()
            name = 'Analysis Structural WU';
        end
        function description = getDescription()
            description = [ ...
                'Analysis based on structural data using weighted graphs, ' ...
                'e.g. cortical thickness for each brain region. ' ...
                'It provides a single graph for each subject group.' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = 'GraphWU';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectST';
        end
        function measurement_class = getMeasurementClass()
            measurement_class =  'MeasurementST_WU';
        end
        function randomcomparison_class = getRandomComparisonClass()
            randomcomparison_class = 'RandomComparisonST_WU';
        end
        function comparison_class = getComparisonClass()
            comparison_class = 'ComparisonST_WU';
        end
        function available_settings = getAvailableSettings(m) %#ok<INUSD>
            available_settings = {
                {'AnalysisST_WU.CorrelationRule', BRAPH2.STRING, 'pearson', Correlation.CORRELATION_RULE_LIST}, ...
                {'AnalysisST_WU.NegativeWeightRule', BRAPH2.STRING, 'zero', Correlation.NEGATIVE_WEIGHT_RULE_LIST}, ...
                {'AnalysisST_WU.Longitudinal', BRAPH2.LOGICAL, false, {false, true}} ...
                };
        end
    end
end