classdef AnalysisDTI < Analysis
    methods  % Constructor
        function analysis = AnalysisDTI(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            
            analysis = analysis@Analysis(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin{:});
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
%         function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
%             randomcomparison_id = [ ...
%                 tostring(analysis.getRandomComparisonClass()) ' ' ...
%                 tostring(measure_code) ' ' ...
%                 tostring(analysis.cohort.getGroups().getIndex(group)) ...
%                 ];
%         end
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
          function measurement = calculate_measurement(analysis, measure_code, group, varargin) %#ok<*INUSL>
            graph_type = AnalysisDTI.getGraphType();
            
            subjects = group.getSubjects();
            
            measures = cell(1, group.subjectnumber());
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                A = subject.getData('DTI').getValue();  % DTI matrix
                g = Graph.getGraph(graph_type, A, varargin{:});
                measure = Measure.getMeasure(measure_code, g, varargin{:});
                measures{i} = cell2mat(measure.getValue());
            end
            
            measure_average = mean(reshape(cell2mat(measures), [size(measures{1}, 1), size(measures{1}, 2), group.subjectnumber()]), 3);
            
            measurement = Measurement.getMeasurement('MeasurementDTI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'MeasurementDTI.values', measures, ...
                'MeasurementDTI.average_value', measure_average ...
                );
        end
%        function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
%             % rules
%             attemptsPerEdge = analysis.getSettings('AnalysisDTI.AttemptsPerEdge');
%             numerOfWeights = analysis.getSettings('AnalysisDTI.NumberOfWeights');
%             graph_type = analysis.getSettings('AnalysisDTI.GraphType');
%             verbose = analysis.getSettings('AnalysisDTI.ComparisonVerbose');
%             interruptible = analysis.getSettings('AnalysisDTI.ComparionInterruptible');
%             is_longitudinal = analysis.getSettings('AnalysisDTI.Longitudinal');
%             M = get_from_varargin(1e+3, 'NumerOfPermutations', varargin{:});
%    
%             % get randomize graphs of subjects
%             subjects = group.getSubjects();
%             for i = 1:1:numel(subjects)
%                 subject = subjects{i};
%                 subject_class = subject.getClass();
%                 atlas = subject.getBrainAtlases();
%                 A = subject.getData('DTI').getValue();
%                 g = Graph.getGraph(graph_type, A);
%                 [permutated_A, ~] = g.randomize_graph('AttemptsPerEdge', attemptsPerEdge, 'NumberOfWeights', numerOfWeights);
%                 permuted_subject = Subject.getSubject(subject_class, atlas, 'DTI', permutated_A);
%                 permuted_subjects{i} = permuted_subject; %#ok<AGROW>
%             end
%             
%             permuted_group = Group(subject_class, permuted_subjects, 'GroupName', ['RandomGroup_' group.getName()]);
%             
%             % create Measurements
%             measurement_group = analysis.calculate_measurement(measure_code, group, varargin{:});
%             measurement_random = analysis.calculate_measurement(measure_code, permuted_group, 'is_randomDTI', 1, varargin{:});
%             
%             % get compared values
%             values_group = measurement_group.getMeasureValues();
%             values_random = measurement_random.getMeasureValues();
%             average_values_group =  mean(reshape(cell2mat(values_group), [size(values_group{1}, 1), size(values_group{1}, 2), group.subjectnumber()]), 3);
%             average_values_random = mean(reshape(cell2mat(values_random), [size(values_random{1}, 1), size(values_random{1}, 2), permuted_group.subjectnumber()]), 3);
%             
%             all_permutations_1 = cell(1, M);
%             all_permutations_2 = cell(1, M);
%             
%             start = tic;
%             for i = 1:1:M
%                 if verbose
%                     disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
%                 end
%                 
%                 if is_longitudinal
%                     [permutation_1, permutation_2] = Permutation.permute(values_group, values_random, is_longitudinal);
%                 else
%                     [permutation_1, permutation_2] = Permutation.permute(values_group, values_random, is_longitudinal);
%                 end
%                 
%                 mean_permutated_1 = mean(reshape(cell2mat(permutation_1), [size(permutation_1{1}, 1), size(permutation_1{1}, 2), group.subjectnumber()]), 3);
%                 mean_permutated_2 = mean(reshape(cell2mat(permutation_2), [size(permutation_2{1}, 1), size(permutation_2{1}, 2), permuted_group.subjectnumber()]), 3);
%                 
%                 all_permutations_1(1, i) = {mean_permutated_1};
%                 all_permutations_2(1, i) = {mean_permutated_2};
%                 
%                 difference_all_permutations{1, i} = mean_permutated_1 - mean_permutated_2; %#ok<AGROW>
%                 if interruptible
%                     pause(interruptible)
%                 end
%             end
%             
%             difference_mean = average_values_random - average_values_group;  % difference of the mean values of the non permutated groups
%             difference_all_permutations = cellfun(@(x) [x], difference_all_permutations, 'UniformOutput', false);  %#ok<NBRAK> % permutated random group - permutated group
%             
%             p1 = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
%             p2 = pvalue2(difference_mean, difference_all_permutations);  % double tail
%             percentiles = quantiles(difference_all_permutations, 40);  % for confidence interval
%             if size(percentiles) == [1 1] %#ok<BDSCA>
%                 ci_lower = percentiles{1}(2);
%                 ci_upper = percentiles{1}(40); % 95 percent
%             elseif size(percentiles) == [size(difference_mean, 1) 1] %#ok<BDSCA>
%                 for i = 1:1:length(percentiles)
%                     percentil = percentiles{i};
%                     ci_lower{i, 1} = percentil(2);  %#ok<AGROW>
%                     ci_upper{i, 1} = percentil(40); %#ok<AGROW>
%                 end
%             else
%                 for i = 1:1:size(percentiles, 1)
%                     for j = 1:1:size(percentiles, 2)
%                         percentil = percentiles{i, j};
%                         ci_lower{i, j} = percentil(2); %#ok<AGROW>
%                         ci_upper{i, j} = percentil(40); %#ok<AGROW>
%                     end
%                 end
%             end            
%             
%             % create randomComparisonClass
%             randomcomparison = RandomComparison.getRandomComparison('RandomComparisonDTI', ...
%                 analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
%                 analysis.getCohort().getBrainAtlases(), group, ...
%                 'RandomComparisonDTI.measure_code', measure_code, ...
%                 'RandomComparisonDTI.values_group', values_group, ...
%                 'RandomComparisonDTI.values_random', values_random, ...
%                 'RandomComparisonDTI.average_values_group', average_values_group, ...
%                 'RandomComparisonDTI.average_values_random', average_values_random, ...
%                 'RandomComparisonDTI.difference', difference_mean, ...
%                 'RandomComparisonDTI.all_differences', difference_all_permutations, ...
%                 'RandomComparisonDTI.p1', p1, ...
%                 'RandomComparisonDTI.p2', p2, ....
%                 'RandomComparisonDTI.confidence_min', ci_lower, ...
%                 'RandomComparisonDTI.confidence_max', ci_upper, ...
%                 'RandomComparisonDTI.number_of_permutations', M ...
%                 );            
%         end
        function comparison = calculate_comparison(analysis, measure_code, group_1, group_2, varargin)
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            
            is_longitudinal = analysis.getSettings('AnalysisDTI.Longitudinal');      
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
            
            comparison = Comparison.getComparison('ComparisonDTI', ...
                analysis.getComparisonID(measure_code, group_1, group_2, varargin{:}), ...
                '', ...  % comparison label
                '', ...  % comparison notes    
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group_1, ...
                group_2, ...
                'ComparisonDTI.PermutationNumber', M, ...
                'ComparisonDTI.values_1', values_1, ...
                'ComparisonDTI.average_values_1', res_1, ...
                'ComparisonDTI.values_2', values_2, ...
                'ComparisonDTI.average_values_2', res_2, ...
                'ComparisonDTI.difference', difference_mean, ...
                'ComparisonDTI.all_differences', difference_all_permutations, ...
                'ComparisonDTI.p1', p1, ...
                'ComparisonDTI.p2', p2, ...
                'ComparisonDTI.confidence_min', ci_lower, ...
                'ComparisonDTI.confidence_max', ci_upper ...
                );
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            analysis_class = 'AnalysisDTI';
        end
        function name = getName()
            name = 'Analysis DTI';
        end
        function description = getDescription()
            description = [ ...
                'Analysis using DTI connectivity matrix, ' ...
                'e.g. activation timeseries for each brain region. ' ...
                'It provides a graph for each subject.' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = 'GraphWU';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectDTI';
        end
        function measurement_class = getMeasurementClass()
            measurement_class =  'MeasurementDTI';
        end
%         function randomcomparison_class = getRandomComparisonClass()
%             randomcomparison_class = 'RandomComparisonDTI';
%         end
        function comparison_class = getComparisonClass()
            comparison_class = 'ComparisonDTI';
        end
        function available_settings = getAvailableSettings(m) %#ok<INUSD>
            available_settings = {
                {'AnalysisDTI.Longitudinal', BRAPH2.LOGICAL, false, {false, true}}, ...
                {'AnalysisDTI.AttemptsPerEdge', BRAPH2.NUMERIC, 1, {}}, ...
                {'AnalysisDTI.NumberOfWeights', BRAPH2.NUMERIC, 1, {}} ...
                };
        end
    end
end