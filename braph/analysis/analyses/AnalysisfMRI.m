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
            subjects = group.getSubjects();
            measures = cell(1, group.subjectnumber());
            
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                data = subject.getData('fMRI').getValue();
                
                % filter data
                fmin = 0;  % values from braph 1
                fmax = Inf;
                T = 1;
                fs = 1/T;
                if fmax>fmin && T>0
                    NFFT = 2*ceil(size(data, 1)/2);
                    ft = fft(data, NFFT);  % Fourier transform
                    f = fftshift(fs*abs(-NFFT/2:NFFT/2-1)/NFFT ); % absolute frequency
                    ft(f<fmin|f>fmax, :) = 0;
                    data = ifft(ft, NFFT);
                end
                
                correlation_rule = analysis.getSettings('AnalysisfMRI.CorrelationRule');
                negative_weight_rule = analysis.getSettings('AnalysisfMRI.NegativeWeightRule');
                [A, ~] = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
                
                graph_type = analysis.getSettings('AnalysisfMRI.GraphType');
                g = Graph.getGraph(graph_type, A, varargin{:});
                measure = Measure.getMeasure(measure_code, g, varargin{:});
                
                measures{1, i} = measure.getValue();
            end
            
            measure_average = sum(cellfun(@sum, measures)) ./ sum(cellfun(@length, measures));
            
            measurement = Measurement.getMeasurement('MeasurementfMRI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), group,  ...
                'MeasurementfMRI.measure_code', measure_code, ...
                'MeasurementfMRI.subject_values', measures, ...
                'MeasurementfMRI.average_value', measure_average ...
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
            analysis_class = 'AnalysisfMRI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectfMRI';
        end
        function name = getName()
            name = 'Analysis Functional fMRI';
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
                {'AnalysisfMRI.NegativeWeightRule', Constant.STRING, 'default', Correlation.NEGATIVE_WEIGHT_RULE_LIST} ...
                };
        end
    end
end