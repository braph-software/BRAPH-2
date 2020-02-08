classdef Graph < handle & matlab.mixin.Copyable
    properties (GetAccess=public, SetAccess=protected)
        A   % adjacency matrix
        mdict  % dictionary with calculated measures
        settings  % structure with the constructor varagin
    end
    methods (Access=protected)
        function g = Graph(A, varargin)
            g.A = A;
            g.mdict = containers.Map;
            g.settings = varargin;
        end
    end
    methods
        function graph_code = getGraphCode(g)
            % measure code (same as the measure object name)
                        
            graph_code = class(g);
        end        
        function A = getA(g)
            A = g.A;
        end
        function settings = getSettings(g)
            settings = g.settings;
        end
        function m = getMeasure(g, measure_code, varargin)
            
            if isKey(g.mdict, measure_code)
                m = g.mdict(measure_code);
            else
                m = Measure.getMeasure(measure_code, g, varargin{:});
                g.mdict(measure_code) = m;
            end 
        end
    end
    methods (Static)
        function list = compatible_measure_list(g)
            % list of measures which work with graph
            
            if isa(g, 'Graph')
                graph_code = g.getGraphCode();
            else % g should be a string with the graph code
                graph_code = g;
            end
            
            measure_list = subclasses('Measure');
            
            list = {};
            for i = 1:1:length(measure_list)
                measure = measure_list{i};
                
                if are_compatible(measure, graph_code)
                    list{end+1} = measure;
                end
            end
        end
        function bool = is_compatible_with_measure(g, m)
            % whether measure and graph are compatible

            if isa(g, 'Graph')
                graph_code = g.getGraphCode();
            else % g should be a string with the graph code
                graph_code = g;
            end 

            compatible_graph_list = {};
            if isa(m, 'Measure')
                compatible_graph_list = m.compatible_graph_list();
            else % m should be a string with the measure code
                eval(['compatible_graph_list = ' m '.compatible_graph_list();'])
            end
            
            bool = any(strcmp(compatible_graph_list, graph_code));
        end        
    end
    methods (Static, Abstract)
        getName()  % graph name
        getDescription()  % graph description
        is_weighted()  % whether is weighted graph
        is_binary()  % whether is binary graph
        is_directed()  % whether is directed graph
        is_undirected()  % whether is undirected graph
        is_selfconnected()  % whether is self-connected
        is_nonnegative()  % whether is non-negative graph
    end
end