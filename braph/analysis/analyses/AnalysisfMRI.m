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
        function calculated_measurement = calculate_measurement(analysis, measure_code, group, varargin)            
            subjects = group.getSubjects();
            measures = cell(1, group.subjectnumber());
            correlation_p_values = cell(1, group.subjectnumber());
            
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                data = subject.getData('fMRI').getValue();
                % treat data
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
                adjacency_matrix = AdjacencyMatrix(data, analysis.settings{2, 2}, analysis.settings{3, 2});
                [A, P] = adjacency_matrix.getCorrelation(analysis.settings{2, 2});
                g = Graph.getGraph(analysis.settings{1, 2}, A, varargin{:});
                measure = Measure.getMeasure(measure_code, g, varargin{:});
                measures{1, i} = measure.getValue();
                correlation_p_values{1, i} = P;
            end
            
            measure_average = sum(cellfun(@sum, measures)) ./ sum(cellfun(@length, measures));
            
            calculated_measurement = Measurement.getMeasurement('MeasurementfMRI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), group,  ...
                'MeasurementfMRI.measure_code', measure_code, ...
                'MeasurementfMRI.subject_values', measures, ...
                'MeasurementfMRI.average_value', measure_average, ...
                'MeasurementfMRI.correlation_p_value', correlation_p_values ...
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
        function available_settings = getAvailableSettings(m) %#ok<INUSD>
            available_settings = {
                {'AnalysisfMRI.GraphType', Constant.STRING, 'GraphWU', {'GraphWU'}}, ...
                {'AnalysisfMRI.CorrelationRule', Constant.STRING, 'pearson', AdjacencyMatrix.CORRELATION_RULE_LIST}, ...
                {'AnalysisfMRI.NegativeWeightRule', Constant.STRING, 'default', AdjacencyMatrix.NEGATIVE_WEIGHT_RULE_LIST} ...
                };
        end
    end
end