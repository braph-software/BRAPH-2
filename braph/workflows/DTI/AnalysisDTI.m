classdef AnalysisDTI < Analysis
    methods
        function analysis = AnalysisDTI(cohort, measurements, randomcomparisons, comparisons, varargin)
            
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
        function measurement = calculate_measurement(analysis, measure_code, group, varargin) %#ok<*INUSL>
            
            graph_type = analysis.getSettings('AnalysisDTI.GraphType');
            
            subjects = group.getSubjects();
            
            measures = cell(1, group.subjectnumber());
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                A = subject.getData('DTI').getValue();  % DTI matrix
                g = Graph.getGraph(graph_type, A, varargin{:});
                measure = Measure.getMeasure(measure_code, g, varargin{:});
                measures{i} = measure.getValue();
            end
            
            measure_average = mean(reshape(cell2mat(measures), [size(measures{1}, 1), size(measures{1}, 2), group.subjectnumber()]), 3);
            
            measurement = Measurement.getMeasurement('MeasurementDTI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), group,  ...
                'MeasurementDTI.measure_code', measure_code, ...
                'MeasurementDTI.values', measures, ...
                'MeasurementDTI.average_value', measure_average ...
                );
        end
        function random_comparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            random_comparison = '';
        end
        function comparison = calculate_comparison(analysis, measure_code, groups, varargin)
            verbose = analysis.getSettings('AnalysisDTI.ComparisonVerbose');
            interruptible = analysis.getSettings('AnalysisDTI.ComparionInterruptible');
            is_longitudinal = analysis.getSettings('AnalysisDTI.Longitudinal');
            M = get_from_varargin(1e+3, 'NumerOfPermutations', varargin{:});
            group_1 = groups{1};
            group_2 = groups{2};
            
            measurements_1 = analysis.calculateMeasurement(measure_code, group_1, varargin{:});
            values_1 = measurements_1.getMeasureValues();
            res_1 = mean(reshape(cell2mat(values_1), [size(values_1{1}, 1), size(values_1{1}, 2), group_1.subjectnumber()]), 3);
            
            measurements_2 = analysis.calculateMeasurement(measure_code, group_2, varargin{:});
            values_2 = measurements_2.getMeasureValues();
            res_2 =  mean(reshape(cell2mat(values_2), [size(values_2{1}, 1), size(values_2{1}, 2), group_2.subjectnumber()]), 3);
            
            all_permutations_1 = cell(1, M);
            all_permutations_2 = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                if is_longitudinal
                    [permutation_1, permutation_2] = Permutation.permute(values_1, values_2, is_longitudinal);
                else
                    [permutation_1, permutation_2] = Permutation.permute(values_1, values_2, is_longitudinal);
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
            
            difference_mean = res_2 - res_1;  % difference of the mean values of the non permutated groups
            difference_all_permutations = cellfun(@(x) [x], difference_all_permutations, 'UniformOutput', false);  %#ok<NBRAK> % permutated group 1 - permutated group 2
            
            p1 = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
            p2 = pvalue2(difference_mean, difference_all_permutations);  % double tail
            percentiles = quantiles(difference_all_permutations, 40);  % for confidence interval
            if size(percentiles) == [1 1] %#ok<BDSCA>
                ci_lower = percentiles{1}(2);
                ci_upper = percentiles{1}(40); % 95 percent
            elseif size(percentiles) == [size(difference_mean, 1) 1] %#ok<BDSCA>
                for i = 1:1:length(percentiles)
                    percentil = percentiles{i};
                    ci_lower{i, 1} = percentil(2);  %#ok<AGROW>
                    ci_upper{i, 1} = percentil(40); %#ok<AGROW>
                end
            else
                for i = 1:1:size(percentiles, 1)
                    for j = 1:1:size(percentiles, 2)
                        percentil = percentiles{i, j};
                        ci_lower{i, j} = percentil(2); %#ok<AGROW>
                        ci_upper{i, j} = percentil(40); %#ok<AGROW>
                    end
                end
            end            
            
            comparison = Comparison.getComparison('ComparisonDTI', ...
                analysis.getComparisonID(measure_code, groups, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), groups, ...
                'ComparisonDTI.measure_code', measure_code, ...
                'ComparisonDTI.difference', difference_mean, ...
                'ComparisonDTI.all_differences', difference_all_permutations, ...
                'ComparisonDTI.p1', p1, ...
                'ComparisonDTI.p2', p2, ...
                'ComparisonDTI.confidence_min', ci_lower, ...
                'ComparisonDTI.confidence_max', ci_upper, ...
                'ComparisonDTI.values_1', values_1, ...
                'ComparisonDTI.average_values_1', res_1, ...
                'ComparisonDTI.values_2', values_2, ...
                'ComparisonDTI.average_values_2', res_2, ...
                'ComparisonDTI.number_of_permutations', M ...
                );
        end
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisDTI';
        end
        function name = getName()
            name = 'Analysis DTI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectDTI';
        end
        function description = getDescription()
            description = [ ...
                'Analysis using DTI connectivity matrix,' ...
                'such as activation timeseries for each brain region' ...
                ];
        end
        function measuerment_class = getMeasurementClass()
            measuerment_class = 'MeasurementDTI';
        end
        function randomcomparison_class = getRandomComparisonClass()
            randomcomparison_class = 'RandomComparisonDTI';
        end
        function comparison_class = getComparisonClass()
            comparison_class = 'ComparisonDTI';
        end
        function available_settings = getAvailableSettings(analysis) %#ok<*INUSD>
            available_settings = {
                {'AnalysisDTI.GraphType', Constant.STRING, 'GraphWU', {'GraphWU'}}, ...
                {'AnalysisDTI.ComparisonVerbose', Constant.LOGICAL, false, {false, true}}, ...
                {'AnalysisDTI.ComparionInterruptible', Constant.LOGICAL, false, {false, true}}, ...
                {'AnalysisDTI.Longitudinal', Constant.LOGICAL, false, {false, true}} ...
                };
        end
    end
end