classdef AnalysisDTI < Analysis
    methods
        function analysis = AnalysisDTI(cohort, measurements, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, varargin{:});
        end
    end
    methods (Access = protected)
        function id = calculate_measurement_id(analysis,  measurement_class, measure_code, groups, varargin) % string 
            % id is a string of concatenating measurement class,
            % measure_code, groups, varargin.
            grouppart = '';  % its needed
            for i = 1:1:length(groups)              
                if isa(groups{i}, 'Group')
                    grouppart = [grouppart '' groups{i}];             
                end
            end
       
            id = [measurement_class '' measure_code '' grouppart '' varargin ];  % imo varargin is not neeeded
            id = id(find(~isspace(id)));  % removes spaces.
        end
        function calculate = calculate_measurement(analysis, measurement_class, measure_code, groups, varargin)
            % conversation notes
            % ? in dti, the measurement pass mtrix to graph. measure_code
            % is the type  DTI several subjects, with and A each one. 

            %create graph 
            arrayOutput = cell(analysis.cohort.getSubjects());
            for i =1:1:lentgth(analysis.cohort.getSubjects())
                A = analysis.cohort.getSubjects().getData();  % does not exists. Also Data ~= A... needs more
                graph = Graph.getGraph(measure_code, A, varargin);  % whats the adjacency matrix? Im guessing is the data in subjects plus some statistic treatment 
                arrayOutput{i} = graph.getValue();  % a, {a,b}, {a; b;};  nodal, global, binodal
            end                
            
            %store it in measurement, the graph, passes as varargin? 
            measurement = Measurement.getMeasurement(calculate_measurement_id( ...
                          measurement_class, measure_code, groups, varargin), ...
                          measurement_class, arrayOutput, varargin);  % creates a measurement
                
           % return measurement with graphs
           calculate = measurement;
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