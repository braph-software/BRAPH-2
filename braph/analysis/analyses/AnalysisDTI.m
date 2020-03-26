classdef AnalysisDTI < Analysis
    methods
        function analysis = AnalysisDTI(cohort, measurements, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, varargin{:});
        end
    end
    methods (Access = protected)
        function id = calculate_measurement_id(analysis, varargin)
            measurementpart = '';
            grouppart = '';
            atlaspart = '';
            for i = 1:1:length(varargin)
                if isa(varargin{i}, 'BrainAtlas')
                    atlaspart = strcat(atlaspart, varargin{i}.getName());
                elseif isa(varargin{i}, 'Group')
                    grouppart = strcat(grouppart, varargin{i}.getName());
                elseif isa(varargin{i}, 'char')
                    measurementpart = varargin{i};
                end
            end
            id = strcat(measurementpart, atlaspart, grouppart);
        end
        function calculate_measurement(analysis)
            % ?
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