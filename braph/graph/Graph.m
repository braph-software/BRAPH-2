classdef Graph < handle & matlab.mixin.Copyable
    properties (GetAccess=public, SetAccess=protected)
        A   % adjacency matrix
        mdict  % dictionary with calculated measures
        settings  % structure with the constructor varagin
    end
    methods (Access=protected)
        function g = Graph(A, varargin)
            
            % 'MeasureDictionary' (input from varargin)
            mdict = containers.Map;
            for n = 1:1:length(varargin)-1
                if strcmpi(varargin{n}, 'MeasureDictionary')
                    mdict = varargin{n+1};
                end
            end            
            
            % 'Settings' (input from varargin)
            settings = varargin;
            for n = 1:1:length(varargin)-1
                if strcmpi(varargin{n}, 'Value')
                    settings = varargin{n+1};
                end
            end
            
            g.A = A;
            g.mdict = mdict;
            g.settings = settings;
        end
        function g_copy = copyElement(g)
            
            % Make a shallow copy
            g_copy = copyElement@matlab.mixin.Copyable(g);
            
            % Make a deep copy of mdict
            g_copy.mdict = containers.Map;
            measures = values(g.mdict);
            for i = 1:1:length(measures)
                m = measures{i};
                if m.is_value_calculated()
                    g_copy.mdict(m.getMeasureCode()) = Measure.getMeasure( ...
                        m.getMeasureCode(), ...
                        g_copy, ...
                        'Value', m.getValue(), ...
                        'Settings', m.getSettings() ...
                        );
                else
                    g_copy.mdict(m.getMeasureCode()) = Measure.getMeasure( ...
                        m.getMeasureCode(), ...
                        g_copy, ...
                        'Settings', m.getSettings() ...
                        );                    
                end
            end
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
        function m = getMeasure(g, measure_code)
            
            if isKey(g.mdict, measure_code)
                m = g.mdict(measure_code);
            else
                m = Measure.getMeasure(measure_code, g, g.getSettings());
                g.mdict(measure_code) = m;
            end 
        end
        function value = getMeasureValue(g, measure_code)
            value = g.getMeasure(measure_code).getValue();
        end
        function bool = is_measure_calculated(g, measure_code)

            if isKey(g.mdict, measure_code)
                bool = g.mdict(measure_code).is_value_calculated();
            else
                bool = false;
            end
        end
        function n = node_number(g)
            n = length(g.getA());
        end
        function sg = subgraph(g, nodes) %#ok<INUSD>
            settings = g.getSettings(); %#ok<NASGU,PROPLC>
            sg = eval([g.getGraphCode() '(g.A(nodes,nodes), settings{:})']);
        end
        function ga = nodeattack(g, nodes)
            
            A = g.getA(); %#ok<PROPLC>
            for i = 1:1:numel(nodes)
                A(nodes(i), :) = 0; %#ok<PROPLC>
                A(:, nodes(i)) = 0; %#ok<PROPLC>
            end
            
            settings = g.getSettings(); %#ok<NASGU,PROPLC>
            
            ga = eval([g.getGraphCode() '(A, settings{:})']);
        end
        function ga = edgeattack(g, nodes1, nodes2)
                        
            A = g.getA(); %#ok<PROPLC>
            A(sub2ind(size(A), nodes1, nodes2)) = 0; %#ok<NASGU,PROPLC>

            settings = g.getSettings(); %#ok<NASGU,PROPLC>

            ga = eval([g.getGraphCode() '(A, settings{:})']);
        end
    end
    methods (Static)
        function g = getGraph(graph_code, A, varargin) %#ok<INUSD>
            g = eval([graph_code '(A, varargin{:})']);
        end
        function list = compatible_measure_list(g)
            % list of measures which work with graph
            
            if isa(g, 'Graph')
                graph_code = g.getGraphCode();
            else % g should be a string with the graph code
                graph_code = g;
            end
            
            measure_list = subclasses('Measure');
            
            list = cell(1, length(measure_list));
            for i = 1:1:length(measure_list)
                measure = measure_list{i};
                
                if Graph.is_compatible_with_measure(graph_code, measure)
                    list{i} = measure;
                end
            end
            list(cellfun('isempty', list)) = [];
        end
        function n = compatible_measure_number(g)
            measure_list = Graph.compatible_measure_list(g);
            n = numel(measure_list);            
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