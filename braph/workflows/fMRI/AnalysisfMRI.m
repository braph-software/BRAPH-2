classdef AnalysisfMRI < Analysis
    methods
        function analysis = AnalysisfMRI(cohort, measurements, randomcomparisons, comparisons,varargin)
            
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
            
            measures = cell(1, group.subjectnumber());

            subjects = group.getSubjects();
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                data = subject.getData('fMRI').getValue();
                
                % filter data
                fmin = 0;  % values from braph 1
                fmax = Inf;
                T = 1;
                fs = 1 / T;
                if fmax > fmin && T > 0
                    NFFT = 2 * ceil(size(data, 1) / 2);
                    ft = fft(data, NFFT);  % Fourier transform
                    f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
                    ft(f < fmin | f > fmax, :) = 0;
                    data = ifft(ft, NFFT);
                end
                
                correlation_rule = analysis.getSettings('AnalysisfMRI.CorrelationRule');
                negative_weight_rule = analysis.getSettings('AnalysisfMRI.NegativeWeightRule');
                A = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
                
                graph_type = analysis.getSettings('AnalysisfMRI.GraphType');
                g = Graph.getGraph(graph_type, A, varargin{:});
                measure = Measure.getMeasure(measure_code, g, varargin{:});
                
                measures{1, i} = measure.getValue();
            end
            
            measures_average = mean(reshape(cell2mat(measures), [size(measures{1}, 1), size(measures{1}, 2), group.subjectnumber()]), 3);
            
            measurement = Measurement.getMeasurement('MeasurementfMRI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), group,  ...
                'MeasurementfMRI.measure_code', measure_code, ...
                'MeasurementfMRI.values', measures, ...
                'MeasurementfMRI.average_value', measures_average ...
                );
        end
        function calculated_random_comparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            calculated_random_comparison = '';
        end
        function comparison = calculate_comparison(analysis, measure_code, groups, varargin)
            verbose = analysis.getSettings('AnalysisfMRI.ComparisonVerbose');
            interruptible = analysis.getSettings('AnalysisfMRI.ComparionInterruptible');
            longitudinal = analysis.getSettings('AnalysisfMRI.Longitudinal');
            M = get_from_varargin(1e+3, 'NumerOfPermutations', varargin{:});
            
            measurements_1 = analysis.calculateMeasurement(measure_code, groups{1}, varargin{:});
            values_1 = measurements_1.getMeasureValues();
            res_1 = mean([values_1{:}], 1);
            
            measurements_2 = analysis.calculateMeasurement(measure_code, groups{2}, varargin{:});
            values_2 = measurements_2.getMeasureValues();
            res_2 = mean([values_2{:}], 1);
            
            all_permutations_1 = zeros(M, numel(res_1));
            all_permutation_2 = zeros(M, numel(res_2));
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                if longitudinal
%                     subjects_1 = [1:1:number_subjects_group_1]; %#ok<*NBRAK>
%                     subjects_2 = number_subjects_group_1 + [1:1:number_subjects_group_2];
                    [permutation_1, permutation_2] = Permutation.permute(longitudinal, values_1, values_2);
                else
                    [permutation_1, permutation_2] = Permutation.permute(longitudinal, values_1, values_2);
                end
                
                mean_permutated_1 = calculate_measurement_average(measure_code, permutation_1);
                mean_permutated_2 = calculate_measurement_average(measure_code, permutation_2);

                all_permutations_1(i,:) = reshape(mean_permutated_1,1,numel(mean_permutated_1));
                all_permutation_2(i,:) = reshape(mean_permutated_2,1,numel(mean_permutated_2));
                
                if interruptible
                    pause(interruptible)
                end
            end
            
            difference_mean = res_2 - res_1;  % difference of the mean values of the non permutated groups
            difference_all_permutations = all_permutation_2 - all_permutations_1;  % permutated group 1 - permutated group 2
            
            p_single = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
            p_double = pvalue2(difference_mean, difference_all_permutations);  % double tail
            percentiles = quantiles(difference_all_permutations, 100);
            
            comparison = Comparison.getComparison('ComparisonfMRI', ...
                analysis.getComparisonID(measure_code, groups, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), groups, ...
                'ComparisonfMRI.measure_code', measure_code, ...
                'ComparisonfMRI.difference_mean', difference_mean, ...
                'ComparisonfMRI.difference_all', difference_all_permutations, ...
                'ComparisonfMRI.p_single', p_single, ...
                'ComparisonfMRI.p_double', p_double, ...
                'ComparisonfMRI.percentiles', percentiles, ...
                'ComparisonfMRI.value_group_1', values_1, ...
                'ComparisonfMRI.mean_value_group_1', res_1, ...
                'ComparisonfMRI.value_group_2', values_2, ...
                'ComparisonfMRI.mean_value_group_2', res_2 ...
                );
        end
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisfMRI';
        end
        function name = getName()
            name = 'Analysis Functional fMRI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectfMRI';
        end       
        function description = getDescription()
            description = [ ...
                'Analysis using functional MRI data, ' ...
                'such as activation timeseries for each brain region' ...
                ];
        end
        function measurement_class = getMeasurementClass()
            measurement_class = 'MeasurementfMRI';
        end
        function randomcomparison_class = getRandomComparisonClass()
            randomcomparison_class = 'RandomComparisonfMRI';
        end
        function comparison_class = getComparisonClass()
            comparison_class = 'ComparisonfMRI';
        end
        function available_settings = getAvailableSettings(analysis) %#ok<INUSD>
            available_settings = {
                {'AnalysisfMRI.GraphType', Constant.STRING, 'GraphWU', {'GraphWU'}}, ...
                {'AnalysisfMRI.CorrelationRule', Constant.STRING, 'pearson', Correlation.CORRELATION_RULE_LIST}, ...
                {'AnalysisfMRI.NegativeWeightRule', Constant.STRING, 'default', Correlation.NEGATIVE_WEIGHT_RULE_LIST}, ...
                {'AnalysisfMRI.ComparisonVerbose', Constant.LOGICAL, false, {false, true}}, ...
                {'AnalysisfMRI.ComparionInterruptible', Constant.LOGICAL, false, {false, true}}, ...
                {'AnalysisfMRI.Longitudinal', Constant.LOGICAL, false, {false, true}} ...
                };
        end
    end
end