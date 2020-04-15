classdef AnalysisfMRI < Analysis
    methods
        function analysis = AnalysisfMRI(cohort, measurements, randomcomparisons, comparisons,varargin)
            
            analysis = analysis@Analysis(cohort, measurements, randomcomparisons, comparisons, varargin{:});
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