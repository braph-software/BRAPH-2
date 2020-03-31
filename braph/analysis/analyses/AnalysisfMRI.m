classdef AnalysisfMRI < Analysis
    methods
        function analysis = AnalysisfMRI(cohort, measurements, varargin)
            
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
            
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart '' varargin{i}];
            end
            
            id = [measurement_class ' ' measure_code ' ' grouppart ' ' vararginpart ];
        end
        function calculate_measurement(analysis)
%             % several graphs 
%             % ? A is not directly taken, time series  of all subjects corrcoeff / corr
%            arrayOutput = cell(analysis.cohort.subjectnumber());
%             for i =1:1:analysis.cohort.subjectnumber()
%                 A = analysis.cohort.getSubjects().getData();  % does not exists. Also Data ~= A... needs more
%                 graph = Graph.getGraph(measure_code, A, varargin);  % whats the adjacency matrix? Im guessing is the data in subjects plus some statistic treatment
%                 arrayOutput{i} = graph.getValue();  % a, {a,b}, {a; b;};  nodal, global, binodal
%             end
%             
%             %store it in measurement, the graph, passes as varargin?
%             measurement = Measurement.getMeasurement(calculate_measurement_id( ...
%                 measurement_class, measure_code, groups, varargin), ...
%                 measurement_class, arrayOutput, varargin);  % creates a measurement
%             
%             % return measurement with graphs
%             calculate = measurement;
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