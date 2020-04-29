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
            subjects = group.getSubjects();
            measures = cell(1, group.subjectnumber());
            graph_type = analysis.getSettings('AnalysisDTI.GraphType');
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                A = subject.getData('DTI').getValue();  % DTI matrix
                g = Graph.getGraph(graph_type, A, varargin{:});
                measure = Measure.getMeasure(measure_code, g, varargin{:});
                measures{1, i} = measure.getValue();
            end
            
            measure_average = sum(cellfun(@sum, measures)) ./ sum(cellfun(@length, measures));
            
            measurement = Measurement.getMeasurement('MeasurementDTI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), group,  ...
                'MeasurementDTI.measure_code', measure_code, ...
                'MeasurementDTI.subject_values', measures, ...
                'MeasurementDTI.average_value', measure_average ...
                );
        end
        function random_comparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            random_comparison = '';
        end
        function comparison = calculate_comparison(analysis, measure_code, groups, varargin)
            verbose = analysis.getSettings('AnalysisDTI.ComparisonVerbose');
            interruptible = analysis.getSettings('AnalysisDTI.ComparionInterruptible');
            longitudinal = analysis.getSettings('AnalysisDTI.Longitudinal');
            M = get_from_varargin(1e+3, 'NumerOfPermutations', varargin{:});
            
            measurements_1 = analysis.calculateMeasurement(measure_code, groups{1}, varargin{:});
            values_1 = measurements_1.getMeasureValues();
            res_1 = mean([values_1{:}], 1);  
            
            measurements_2 = analysis.calculateMeasurement(measure_code, groups{2}, varargin{:});
            values_2 = measurements_2.getMeasureValues();
            res_2 = mean([values_2{:}], 1);  
            
            values = [[values_1{:}]; [values_2{:}];];
            all_permutations_1 = zeros(M, numel(res_1));
            all_permutation_2 = zeros(M, numel(res_2));
            
            number_subjects_group_1 = size([values_1{:}], 1);
            number_subjects_group_2 = size([values_2{:}], 1);           

            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                if longitudinal
                    subjects_1 = [1:1:number_subjects_group_1]; %#ok<*NBRAK>
                    subjects_2 = number_subjects_group_1 + [1:1:number_subjects_group_2];
                    [permutation_1, permutation_2] = Permutation.permute(longitudinal, subjects_1, subjects_2);
                else
                    subjects_1 = [1:1:number_subjects_group_1];
                    subjects_2 = [1:1:number_subjects_group_2];
                    [permutation_1, permutation_2] = Permutation.permute(longitudinal, subjects_1, subjects_2);
                end
                
                values_permutated_1 = values(permutation_1, :);
                mean_permutated_1 = mean(values_permutated_1, 1);
                
                values_permutated_2 = values(permutation_2,:);
                mean_permutated_2 = mean(values_permutated_2,1);
                
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
            
            comparison = Comparison.getComparison('ComparisonDTI', ...
                analysis.getComparisonID(measure_code, groups, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), groups, ...
                'ComparisonDTI.measure_code', measure_code, ...
                'ComparisonDTI.difference_mean', difference_mean, ...
                'ComparisonDTI.difference_all', difference_all_permutations, ...
                'ComparisonDTI.p_single', p_single, ...
                'ComparisonDTI.p_double', p_double, ...
                'ComparisonDTI.percentiles', percentiles ...
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