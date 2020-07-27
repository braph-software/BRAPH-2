classdef AnalysisCON_WU < Analysis
    methods  % Constructor
        function analysis = AnalysisCON_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            
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
        function graphs = get_graphs_for_group(analysis, group, varargin)          
            
            graph_type = analysis.getGraphType();            
            subjects = group.getSubjects();
            graphs = cell(1, group.subjectnumber());
            
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                A = subject.getData('CON').getValue();  % DTI matrix
                A = binarize(A, varargin{:});
                graphs{i} = Graph.getGraph(graph_type, A);                 
            end            
        end
        function measurement = calculate_measurement(analysis, measure_code, group, varargin) %#ok<*INUSL>
           
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
                'MeasurementCON.average_value', measure_average ...
                );
        end
        function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            % rules
            attempts_per_edge = analysis.getSettings('AnalysisCON.AttemptsPerEdge');
            number_of_weights = analysis.getSettings('AnalysisCON.NumberOfWeights');             
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            M = get_from_varargin(1e+3, 'RandomComparisonCON.RandomizationNumber', varargin{:});
            
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
                'ComparisonCON.confidence_max', ci_upper ...
                );
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            analysis_class = 'AnalysisCON_WU';
        end
        function name = getName()
            name = 'Analysis Connectivity WU';
        end
        function description = getDescription()
            description = [ ...
                'Analysis using CON connectivity matrix, ' ...
                'e.g. activation timeseries for each brain region. ' ...
                'It provides a graph for each subject.' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = 'GraphWU';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectCON';
        end
        function measurement_class = getMeasurementClass()
            measurement_class =  'MeasurementCON_WU';
        end
        function randomcomparison_class = getRandomComparisonClass()
            randomcomparison_class = 'RandomComparisonCON_WU';
        end
        function comparison_class = getComparisonClass()
            comparison_class = 'ComparisonCON_WU';
        end
        function available_settings = getAvailableSettings(m) %#ok<INUSD>
            available_settings = {
                {'AnalysisCON.Longitudinal', BRAPH2.LOGICAL, false, {false, true}}, ...
                {'AnalysisCON.AttemptsPerEdge', BRAPH2.NUMERIC, 1, {}}, ...
                {'AnalysisCON.NumberOfWeights', BRAPH2.NUMERIC, 1, {}} ...
                };
        end
    end
end