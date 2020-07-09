classdef AnalysisMultiplexMRI < Analysis
    methods  % Constructor
        function analysis = AnalysisMultiplexMRI(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            
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
        function g = get_graph_for_subjects(analysis, subjects)
            atlases = analysis.cohort.getBrainAtlases();
            atlas = atlases{1};
            
            subject_number = numel(subjects);

            data = zeros(subject_number, atlas.getBrainRegions().length());
            for i = 1:1:subject_number
                subject = subjects{i};
                data(i, :) = subject.getData('MRI').getValue();  % MRI data
            end
            
            correlation_rule = analysis.getSettings('AnalysisMRI.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisMRI.NegativeWeightRule');
            A = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
            
            graph_type = AnalysisMRI.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end        
        function measurement = calculate_measurement(analysis, measure_code, group, varargin)
            atlases = analysis.cohort.getBrainAtlases();
            atlas = atlases{1};

            subjects = group.getSubjects();

            data1 = zeros(group.subjectnumber(), atlas.getBrainRegions().length());
            data2 = zeros(group.subjectnumber(), atlas.getBrainRegions().length());
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                data1(i, :) = subject.getData('MRI1').getValue();  % MRI data layer 1
                data2(i, :) = subject.getData('MRI2').getValue();  % MRI data layer 2
            end
            
            correlation_rule = analysis.getSettings('AnalysisMultiplexMRI.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisMultiplexMRI.NegativeWeightRule');
            A11 = Correlation.getAdjacencyMatrix(data1, correlation_rule, negative_weight_rule);
            A22 = Correlation.getAdjacencyMatrix(data2, correlation_rule, negative_weight_rule);
            A12 = eye(length(A11));
            A21 = eye(length(A11));
            A = {A11, A12; A21, A22};
            
            graph_type = AnalysisMultiplexMRI.getGraphType();
            g = Graph.getGraph(graph_type, A, varargin{:});
            
            measure = Measure.getMeasure(measure_code, g, varargin{:});
            measurement_value = measure.getValue();

            measurement = Measurement.getMeasurement('MeasurementMultiplexMRI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'MeasurementMultiplexMRI.value', measurement_value ...
                );
        end
%         function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
%             % rules
%             attemptsPerEdge = analysis.getSettings('AnalysisMRI.AttemptsPerEdge');
%             numerOfWeights = analysis.getSettings('AnalysisMRI.NumberOfWeights');
%             graph_type = analysis.getSettings('AnalysisMRI.GraphType');
%             verbose = analysis.getSettings('AnalysisMRI.ComparisonVerbose');
%             interruptible = analysis.getSettings('AnalysisMRI.ComparionInterruptible');
%             correlation_rule = analysis.getSettings('AnalysisMRI.CorrelationRule');
%             negative_weight_rule = analysis.getSettings('AnalysisMRI.NegativeWeightRule');
%             is_longitudinal = analysis.getSettings('AnalysisMRI.Longitudinal');
%             M = get_from_varargin(1e+3, 'NumerOfPermutations', varargin{:});
%             
%             % get info from subjects
%             subjects = group.getSubjects();
%             subject_class = group.getSubjectClass();
%             atlases = analysis.getCohort().getBrainAtlases();
%             A = zeros(atlases{1}.getBrainRegions().length());
%             for i = 1:1:numel(subjects)
%                 subject = subjects{i};
%                 A(i, :) = subject.getData('MRI').getValue();
%             end
%             
%             % get randomize graphs of subjects
%             g = Graph.getGraph(graph_type, A);
%             [permuted_A, ~] = g.randomize_graph('AttemptsPerEdge', attemptsPerEdge, 'NumberOfWeights', numerOfWeights);
%             
%             % create subjects with new data
%             for i = 1:1:numel(subjects)
%                 info_subject =  permuted_A(i, :);
%                 permuted_subjects{i} = Subject.getSubject(subject_class, atlases{1}, 'MRI', info_subject'); %#ok<AGROW>
%             end
%             
% 
%             permuted_group = Group(subject_class, permuted_subjects, 'GroupName', ['RandomGroup_' group.getName()]);
%             
%             % create Measurements
%             measurement_group = analysis.calculate_measurement(measure_code, group, varargin{:});
%             measurement_random = analysis.calculate_measurement(measure_code, permuted_group, 'is_randomMRI', 1, varargin{:});
%             
%             value_group = measurement_group.getMeasureValue();
%             value_random = measurement_random.getMeasureValue();
%             
%                         
%             for i = 1:1:group.subjectnumber()
%                 subject = subjects{i};
%                 subjects_data_1(:, i) = subject.getData('MRI').getValue();  %#ok<AGROW> % MRI data % here we swaps dimensions to be compatible with permutation
%             end
%             
%             for i = 1:1:permuted_group.subjectnumber()
%                 subject = permuted_subjects{i};
%                 subjects_data_2(:, i) = subject.getData('MRI').getValue(); %#ok<AGROW>
%             end
%             
%             % compare
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
%                     [permutation_1, permutation_2] = Permutation.permute(subjects_1, subjects_2, is_longitudinal);
%                 else
%                     [permutation_1, permutation_2] = Permutation.permute(subjects_data_1, subjects_data_2, is_longitudinal);
%                 end
%                 
%                 A_permutated_1 = Correlation.getAdjacencyMatrix(permutation_1', correlation_rule, negative_weight_rule);  % swap dimensions again
%                 graph_permutated_1 = Graph.getGraph(graph_type, A_permutated_1, varargin{:});
%                 measure_permutated_1 = Measure.getMeasure(measure_code, graph_permutated_1, varargin{:});
%                 measure_permutated_value_1 = measure_permutated_1.getValue();
%                 
%                 A_permutated_2 = Correlation.getAdjacencyMatrix(permutation_2', correlation_rule, negative_weight_rule);
%                 graph_permutated_2 = Graph.getGraph(graph_type, A_permutated_2, varargin{:});
%                 measure_permutated_2 = Measure.getMeasure(measure_code, graph_permutated_2, varargin{:});
%                 measure_permutated_value_2 = measure_permutated_2.getValue();
%                 
%                 
%                 all_permutations_1(1, i) = {measure_permutated_value_1};
%                 all_permutations_2(1, i) = {measure_permutated_value_2};
%                 
%                 difference_all_permutations{1, i} = measure_permutated_value_2 - measure_permutated_value_1; %#ok<AGROW>
%                 if interruptible
%                     pause(interruptible)
%                 end
%             end
%             
%             difference_mean = cell2mat(value_random) - cell2mat(value_group);  % difference of the mean values of non permuted random group minus the non permuted group 
%             difference_all_permutations = cellfun(@(x) [x], difference_all_permutations, 'UniformOutput', false);  %#ok<NBRAK> % permutated group 1 - permutated group 2
%             
%             p1 = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
%             p2 = pvalue2(difference_mean, difference_all_permutations);  % double tail
%             percentiles = quantiles(difference_all_permutations, 100);
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
%             randomcomparison = RandomComparison.getRandomComparison('RandomComparisonMRI', ...
%                 analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
%                 analysis.getCohort().getBrainAtlases(), group, ...
%                 'RandomComparisonMRI.measure_code', measure_code, ...
%                 'RandomComparisonMRI.values_group', value_group, ...
%                 'RandomComparisonMRI.values_random', value_random, ...
%                 'RandomComparisonMRI.difference', difference_mean, ...
%                 'RandomComparisonMRI.all_differences', difference_all_permutations, ...
%                 'RandomComparisonMRI.p1', p1, ...
%                 'RandomComparisonMRI.p2', p2, ....
%                 'RandomComparisonMRI.confidence_min', ci_lower, ...
%                 'RandomComparisonMRI.confidence_max', ci_upper, ...
%                 'RandomComparisonMRI.number_of_permutations', M ...
%                 );
%         end
        function comparison = calculate_comparison(analysis, measure_code, group_1, group_2, varargin)
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            
            is_longitudinal = analysis.getSettings('AnalysisMultiplexMRI.Longitudinal');
            M = get_from_varargin(1e+3, 'PermutationNumber', varargin{:});

            % Measurements for groups 1 and 2, and their difference
            measurements_1 = analysis.getMeasurement(measure_code, group_1, varargin{:});
            value_1 = measurements_1.getMeasureValue();
            
            measurements_2 = analysis.getMeasurement(measure_code, group_2, varargin{:});
            value_2 = measurements_2.getMeasureValue();
            
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
% TODO: update with new version of pvalue1 and pvalue2 once available
% p1 = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
% p2 = pvalue2(difference_mean, difference_all_permutations);  % double tail
            p1 = {pvalue1(difference_mean{1}, difference_all_permutations)};  % singe tail,
            p2 = {pvalue2(difference_mean{1}, difference_all_permutations)};  % double tail
            
% TODO: update with new version of quantiles once available (if needed)
% ci_lower = quantiles(difference_all_permutations, 40, {2, 40});
            qtl = quantiles(difference_all_permutations, 40);
            ci_lower = {cellfun(@(x) x(2), qtl)};
            ci_upper = {cellfun(@(x) x(40), qtl)};
            
            comparison = Comparison.getComparison('ComparisonMultiplexMRI', ...
                analysis.getComparisonID(measure_code, group_1, group_2, varargin{:}), ...
                '', ...  % comparison label
                '', ...  % comparison notes                
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group_1, ...
                group_2, ...
                'ComparisonMultiplexMRI.PermutationNumber', M, ...
                'ComparisonMultiplexMRI.value_1', value_1, ...
                'ComparisonMultiplexMRI.value_2', value_2, ...
                'ComparisonMultiplexMRI.difference', difference_mean, ...
                'ComparisonMultiplexMRI.all_differences', difference_all_permutations, ...
                'ComparisonMultiplexMRI.p1', p1, ...
                'ComparisonMultiplexMRI.p2', p2, ...
                'ComparisonMultiplexMRI.confidence_min', ci_lower, ...
                'ComparisonMultiplexMRI.confidence_max', ci_upper ...
                );
       end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            analysis_class = 'AnalysisMultiplexMRI';
        end
        function name = getName()
            name = 'Analysis multiplex structural MRI';
        end
        function description = getDescription()
            description = [ ...
                'Analysis based on structural MRI data in the two layers, ' ...
                'e.g. cortical thickness for each brain region. ' ...
                'It provides a multiplex graph of two layers for each subject group.' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = 'MultiplexGraphWU';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectMultiplexMRI';
        end
        function measurement_class = getMeasurementClass()
            measurement_class =  'MeasurementMultiplexMRI';
        end
%         function randomcomparison_class = getRandomComparisonClass()
%             randomcomparison_class = 'RandomComparisonMRI';
%         end
        function comparison_class = getComparisonClass()
            comparison_class = 'ComparisonMultiplexMRI';
        end
        function available_settings = getAvailableSettings(m) %#ok<INUSD>
            available_settings = {
                {'AnalysisMultiplexMRI.CorrelationRule', BRAPH2.STRING, 'pearson', Correlation.CORRELATION_RULE_LIST}, ...
                {'AnalysisMultiplexMRI.NegativeWeightRule', BRAPH2.STRING, 'zero', Correlation.NEGATIVE_WEIGHT_RULE_LIST}, ...
                {'AnalysisMultiplexMRI.Longitudinal', BRAPH2.LOGICAL, false, {false, true}}, ...
                {'AnalysisMultiplexMRI.AttemptsPerEdge', BRAPH2.NUMERIC, 1, {}}, ...
                {'AnalysisMultiplexMRI.NumberOfWeights', BRAPH2.NUMERIC, 1, {}} ...
                };
        end
    end
end