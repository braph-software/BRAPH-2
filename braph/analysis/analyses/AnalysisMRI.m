classdef AnalysisMRI < Analysis
    methods
        function analysis = AnalysisMRI(cohort, measurements, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, varargin{:});
        end
    end
    methods (Access = protected)
         function id = calculate_measurement_id(analysis,  measurement_class, measure_code, groups, varargin)
           grouppart = '';  % its needed
            for i = 1:1:length(groups)              
                if isa(groups{i}, 'Group')
                    grouppart = [grouppart '' groups{i}];             
                end
            end
       
            id = [measurement_class '' measure_code '' grouppart '' varargin ];  % imo varargin is not neeeded
            id = id(find(~isspace(id)));  % removes spaces.
        end
        function calculate_measurement(analysis)
            % one graph for the grouup
            % its directly the timeseries. 
            
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