classdef AnalysisMRI < Analysis
    methods
        function analysis = AnalysisMRI(cohort, varargin)
            
            analysis = analysis@Analysis(cohort, varargin{:});
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
        
    end
end