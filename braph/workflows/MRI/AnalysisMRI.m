classdef AnalysisMRI < Analysis
    methods
        function analysis = AnalysisMRI(cohort, measurements, randomcomparisons, comparisons, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods
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
        function comparison_id = getComparisonID(analysis, measure_code, groups, varargin)
            comparison_id = [ ...
                tostring(analysis.getComparisonClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(groups{1})) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(groups{2})) ...
                ];
        end
    end
    methods (Access = protected)
        function measurement = calculate_measurement(analysis, measure_code, group, varargin)
            subjects = group.getSubjects();
            atlases = analysis.cohort.getBrainAtlases();
            atlas = atlases{1};
            data = zeros(group.subjectnumber(), atlas.getBrainRegions().length());
            
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                data(i, :) = subject.getData('MRI').getValue();  % MRI data
            end
            
            correlation_rule = analysis.getSettings('AnalysisMRI.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisMRI.NegativeWeightRule');
            A = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
            
            graph_type = analysis.getSettings('AnalysisMRI.GraphType');
            g = Graph.getGraph(graph_type, A, varargin{:});
            
            measure = Measure.getMeasure(measure_code, g, varargin{:});
            measurement_value = {measure.getValue()};
            
            measurement = Measurement.getMeasurement('MeasurementMRI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), group,  ...
                'MeasurementMRI.measure_code', measure_code, ...
                'MeasurementMRI.value', measurement_value ...
                );
        end
        function calculated_random_comparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            calculated_random_comparison = '';
        end
        function comparison = calculate_comparison(analysis, measure_code, groups, varargin)
            verbose = analysis.getSettings('AnalysisMRI.ComparisonVerbose');
            interruptible = analysis.getSettings('AnalysisMRI.ComparionInterruptible');
            longitudinal = analysis.getSettings('AnalysisMRI.Longitudinal');
            M = get_from_varargin(1e+3, 'NumerOfPermutations', varargin{:});
            group_1 = groups{1};
            group_2 = groups{2};
            
            measurements_1 = analysis.calculateMeasurement(measure_code, group_1, varargin{:});
            value_1 = measurements_1.getMeasureValue();
            
            measurements_2 = analysis.calculateMeasurement(measure_code, group_2, varargin{:});
            value_2 = measurements_2.getMeasureValue();
            
            all_permutations_1 = cell(1, M);
            all_permutations_2 = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                if longitudinal
                    [permutation_1, permutation_2] = Permutation.permute(longitudinal, subjects_1, subjects_2);
                else
                    [permutation_1, permutation_2] = Permutation.permute(longitudinal, value_1, value_2);
                end
                
                mean_permutated_1 = mean(reshape(cell2mat(permutation_1), [size(permutation_1{1}, 1), size(permutation_1{1}, 2), group_1.subjectnumber()]), 3);
                mean_permutated_2 = mean(reshape(cell2mat(permutation_2), [size(permutation_2{1}, 1), size(permutation_2{1}, 2), group_2.subjectnumber()]), 3);
                
                all_permutations_1(1, i) = {mean_permutated_1};
                all_permutations_2(1, i) = {mean_permutated_2};
                
                difference_all_permutations{1, i} = mean_permutated_1 - mean_permutated_2; %#ok<AGROW>
                if interruptible
                    pause(interruptible)
                end
            end
            
            difference_mean = value_2 - value_1;  % difference of the mean values of the non permutated groups
            difference_all_permutations = cellfun(@(x) [x], difference_all_permutations, 'UniformOutput', false);  %#ok<NBRAK> % permutated group 1 - permutated group 2
            
            p1 = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
            p2 = pvalue2(difference_mean, difference_all_permutations);  % double tail
            percentiles = quantiles(difference_all_permutations, 100);
            [ci_lower, ci_upper] = confidence_interval(percentiles, 5, size(difference_mean));  % 95 percent
            
            comparison = Comparison.getComparison('ComparisonDTI', ...
                analysis.getComparisonID(measure_code, groups, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), groups, ...
                'ComparisonMRI.measure_code', measure_code, ...
                'ComparisonMRI.difference', difference_mean, ...
                'ComparisonMRI.all_differences', num2cell(difference_all_permutations, 1), ...
                'ComparisonMRI.p1', p1, ...
                'ComparisonMRI.p2', p2, ...
                'ComparisonMRI.confidence_min', ci_lower, ...
                'ComparisonMRI.confidence_max', ci_upper, ...
                'ComparisonMRI.values_1', value_1, ...
                'ComparisonMRI.values_2', value_2, ...
                'ComparisonMRI.number_of_permutations', M ....
                );
        end
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisMRI';
        end
        function name = getName()
            name = 'Analysis Structural MRI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectMRI';
        end
        function description = getDescription()
            description = [ ...
                'Analysis based on structural MRI data, ' ...
                'such as cortical thickness for each brain region' ...
                ];
        end
        function measurement_class = getMeasurementClass()
            measurement_class =  'MeasurementMRI';
        end
        function randomcomparison_class = getRandomComparisonClass()
            randomcomparison_class = 'RandomComparisonMRI';
        end
        function comparison_class = getComparisonClass()
            comparison_class = 'ComparisonMRI';
        end
        function available_settings = getAvailableSettings(m) %#ok<INUSD>
            available_settings = {
                {'AnalysisMRI.GraphType', Constant.STRING, 'GraphWU', {'GraphWU'}}, ...
                {'AnalysisMRI.CorrelationRule', Constant.STRING, 'pearson', Correlation.CORRELATION_RULE_LIST}, ...
                {'AnalysisMRI.NegativeWeightRule', Constant.STRING, 'default', Correlation.NEGATIVE_WEIGHT_RULE_LIST}, ...
                {'AnalysisMRI.ComparisonVerbose', Constant.LOGICAL, false, {false, true}}, ...
                {'AnalysisMRI.ComparionInterruptible', Constant.LOGICAL, false, {false, true}}, ...
                {'AnalysisMRI.Longitudinal', Constant.LOGICAL, false, {false, true}} ...
                };
        end
    end
end