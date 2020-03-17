classdef AnalysisDTI < Analysis
    methods
        function analysis = AnalysisDTI(cohort, varargin)
            
            analysis = analysis@Analysis(cohort, varargin{:});
        end
    end
    methods (Static)
        function analysis_class = getClass()
                analysis_class = 'AnalysisDTI';
        end
        function subject_class = getSubjectClass()
                subject_class = 'SubjectDTI';
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