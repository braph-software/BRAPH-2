classdef AnalysisfMRI < Analysis
    methods
        function analysis = AnalysisfMRI(cohort, measurements, randomcomparisons, comparisons,varargin)
            
            analysis = analysis@Analysis(cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods (Access = protected)
        function measurement_id = getMeasurementID(analysis, measure_code, varargin)
            vararginpart = '';
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart '' varargin{i}]; %#ok<*AGROW>
            end
            measurement_id = [tostring(analysis.getMeasurements().getValueClass()) ' ' tostring(measure_code) ' ' tostring(analysis.getCohort().getGroups().getValue(1).getName()) ' ' tostring(vararginpart)];
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, varargin)
            vararginpart = '';
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart '' varargin{i}];
            end
            randomcomparison_id = [tostring(analysis.getRandomComparisons().getValueClass()) ' ' tostring(measure_code) ' ' tostring(analysis.getCohort().getGroups().getValue(1).getName()) ' ' tostring(vararginpart)];
        end
        function comparison_id = getComparisonID(analysis, measure_code, varargin)
            vararginpart = '';
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart '' varargin{i}];
            end
            comparison_id = [tostring(analysis.getComparisons().getValueClass()) ' ' tostring(measure_code) ' ' tostring(analysis.getCohort().getGroups().getValue(1).getName()) ' ' tostring(analysis.getCohort().getGroups().getValue(2).getName()) ' ' tostring(vararginpart)];
        end
        function calculate_measurement(analysis, measure_code, varargin)
        end
        function calculate_random_comparison(analysis, measure_code, varargin)
        end
        function calculate_comparison(analysis, measure_code, varargin)
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
    end
end