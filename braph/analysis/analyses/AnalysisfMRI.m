classdef AnalysisfMRI < Analysis
    methods
        function analysis = AnalysisfMRI(cohort, measurements, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, varargin{:});
        end
    end
    methods (Access = protected)
        function id = calculateMeasurementID(analysis, varargin)
            n = length(varargin);
            measurementpart = '';
            grouppart = '';
            atlaspart = '';
            for i = 1:1:n
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
        
    end
end