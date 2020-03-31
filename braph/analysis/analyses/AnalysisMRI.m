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
            
            for i = 1:1:length(varargin)                
                vararginpart = [vararginpart '' varargin{i}];                
            end

            id = [measurement_class ' ' measure_code ' ' grouppart ' ' vararginpart ];          
        end
        function calculate_measurement(analysis,  measurement_class, measure_code, groups, varargin)
            % one graph for the grouup
            % its directly the timeseries.
            
%             %create graph
%             arrayOutput = cell(analysis.cohort.subjectnumber());
%             for i =1:1:analysis.cohort.subjectnumber()
%                 data_codes = analysis.cohort.getSubjects().getDataCodes();
%                 
%                 A = analysis.cohort.getSubjects().getData(data_codes{2});  % A ~= DATA    corr missing
%                 
%                 graph = Graph.getGraph(measure_code, A, varargin);  % whats the adjacency matrix? Im guessing is the data in subjects plus some statistic treatment
%                 arrayOutput{i} = graph.getValue();  % a, {a,b}, {a; b;};  nodal, global, binodal
%             end
%             
%             A = corr (A);
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