classdef AnalysisDTI < Analysis
    methods
        function analysis = AnalysisDTI(cohort, measurements, randomcomparisons, comparisons, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisDTI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectDTI';
        end
        function measurmentList = getMeasurementClass()
             measurmentList = 'MeasurementDTI';
        end
        function randomcomparisonList = getRandomComparisonClass()
            randomcomparisonList = 'RandomComparisonDTI';  % RandomComparison.getList();  
        end
        function comparisonList = getComparisonClass()
            comparisonList = 'ComparisonDTI';  % Comparison.getList();
        end
        function name = getName()
            name = 'Analysis DTI';
        end
        function description = getDescription()
            description = [ ...
                'Analysis using DTI connectivity matrix,' ...
                'such as activation timeseries for each brain region' ...
                ];
        end        
    end
end