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
            [A, ~] = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
            
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
        function calculated_comparison = calculate_comparison(analysis, measure_code, groups, varargin)
            calculated_comparison = '';
        end
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisMRI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectMRI';
        end
        function name = getName()
            name = 'Analysis Structural MRI';
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
                {'AnalysisMRI.NegativeWeightRule', Constant.STRING, 'default', Correlation.NEGATIVE_WEIGHT_RULE_LIST} ...
                };
        end
    end
end