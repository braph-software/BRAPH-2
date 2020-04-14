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
        function measurmentList = getMeasurementClass()
            measurmentList = 'MeasurementfMRI';
        end
        function randomcomparisonList = getRandomComparisonClass()
            randomcomparisonList = 'RandomComparisonfMRI';  % RandomComparison.getList();
        end
        function comparisonList = getComparisonClass()
            comparisonList = 'ComparisonfMRI';  % Comparison.getList();
        end
        function description = getDescription()
            description = [ ...
                'Analysis using functional MRI data, ' ...
                'such as activation timeseries for each brain region' ...
                ];
        end
        
    end
end