classdef AnalysisDTI < Analysis
    methods
        function analysis = AnalysisDTI(cohort, measurements, randomcomparisons, comparisons, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods
        function measurement_id = getMeasurementID(analysis, measure_code, group, varargin)
            vararginpart = '';
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart ' ' varargin{i}]; %#ok<*AGROW>
            end
            measurement_id = [tostring(analysis.getMeasurementClass()) ' ' tostring(measure_code) ' ' tostring(group.getName()) ' ' tostring(vararginpart)];
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
            vararginpart = '';
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart '' varargin{i}];
            end
            randomcomparison_id = [tostring(analysis.getRandomComparisonClass()) ' ' tostring(measure_code) ' ' tostring(group.getName()) ' ' tostring(vararginpart)];
        end
        function comparison_id = getComparisonID(analysis, measure_code, groups, varargin)
            vararginpart = '';
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart '' varargin{i}];
            end
            comparison_id = [tostring(analysis.getComparisonClass()) ' ' tostring(measure_code) ' ' tostring(groups{1}.getName()) ' ' tostring(groups{2}.getName()) ' ' tostring(vararginpart)];
        end
    end
    methods (Access = protected)
        function calculated_measurement = calculate_measurement(analysis, measure_code, group, varargin) %#ok<*INUSL>
            subjects = group.getSubjects();
            graph_type = get_from_varargin('GraphBD', 'GraphType', varargin{:});                     
            measure_array = cell(1, group.subjectnumber());
           
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                A = subject.getData('DTI').getValue();  % data codes: age, dti
                g = Graph.getGraph(graph_type, A, varargin{:});
                measure = Measure.getMeasure(measure_code, g, varargin{:});
                measure_array{1, i} = measure.getValue();
            end            
            
            group_average = sum(cellfun(@sum, measure_array)) ./ sum(cellfun(@length, measure_array));
            
            %  group);
            calculated_measurement = Measurement.getMeasurement('MeasurementDTI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), group,  ...
                'MeasurementDTI.subject_values', measure_array, ...
                'MeasurementDTI.average_value', group_average, ...
                'measure_code', measure_code ...
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
    end
end