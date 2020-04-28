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
            
            m1 = analysis.calculateMeasurement(measure_code, groups{1}, varargin{:});
            values1 = m1.getMeasureValues();
            res1 = mean([values1{:}], 1);  
            
            m2 = analysis.calculateMeasurement(measure_code, groups{2}, varargin{:});
            values2 = m2.getMeasureValues();
            res2 = mean([values2{:}], 1);  
            
            values = [[values1{:}]; [values2{:}];];
            all1 = zeros(M, numel(res1));
            all2 = zeros(M, numel(res2));
            
            number_sub1 = size([values1{:}], 1);
            number_sub2 = size([values2{:}], 1);            
            n_substmp = number_sub1 + number_sub2;
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                if longitudinal
                    subs1 = [1:1:number_sub1]; %#ok<*NBRAK>
                    subs2 = number_sub1 + [1:1:number_sub2];
                    [permutation1, permutation2] = Permutation.getPermutation(longitudinal, subs1, subs2, n_substmp, number_sub1);
                else
                    subs1= 0;
                    subs2 = 0;
                    [permutation1, permutation2] = Permutation.getPermutation(longitudinal, subs1, subs2, n_substmp, number_sub1);
                end
                
                valuesperm1 = values(permutation1, :);
                mperm1 = mean(valuesperm1, 1);
                
                valuesperm2 = values(permutation2,:);
                mperm2 = mean(valuesperm2,1);
                
                all1(i,:) = reshape(mperm1,1,numel(mperm1));
                all2(i,:) = reshape(mperm2,1,numel(mperm2));
                
                if interruptible
                    pause(interruptible)
                end
            end
            
            dm = res2 - res1;
            dall = all2-all1;
            
            p_single = pvalue1(dm, dall);
            p_double = pvalue2(dm, dall);
            percentiles = quantiles(dall, 100);
            
            comparison = Comparison.getComparison('ComparisonDTI', ...
                analysis.getComparisonID(measure_code, groups, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), groups, ...
                'ComparisonDTI.measure_code', measure_code, ...
                'ComparisonDTI.difference_mean', dm, ...
                'ComparisonDTI.difference_all', dall, ...
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
                {'AnalysisDTI.Longitudinal', Constant.LOGICAL, false, Permutation.PERMUTATION_LONGITUDINAL_RULE_LIST} ...
                };
        end
    end
end