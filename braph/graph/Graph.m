classdef Graph < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        A   % adjacency matrix
        mdict  % dictionary with calculated measures
        settings  % structure with the constructor varagin
    end
    methods (Access=protected)
        function g = Graph(A, varargin)
            
            mdict = get_from_varargin(containers.Map, 'MeasureDictionary', varargin{:});
            settings = get_from_varargin(varargin, 'Settings', varargin{:});
                        
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
        function str = tostring(g)
            str = [Graph.getClass(g) ' ' int2str(size(randn(2), 1)) ' rows x ' int2str(size(randn(2), 2)) ' columns'];
        end
        function disp(g)
            
            disp(['<a href="matlab:help ' Graph.getClass(g) '">' Graph.getClass(g) '</a>'])
            disp([' size: ' int2str(size(randn(2), 1)) ' rows x ' int2str(size(randn(2), 2)) ' columns'])
            disp([' measures: ' int2str(length(g.mdict))]);
            disp([' settings']);
            
            settings = g.getSettings();
            for i = 1:2:length(settings)
                disp(['  ' int2str(i) ' - ' settings{i} ' - ' tostring(settings{i+1})]);
            end
        end
        function A = getA(g)
            A = g.A;
        end
        function settings = getSettings(g)
            settings = g.settings;
        end
        function n = nodenumber(g)
            n = length(g.getA());
        end
        function m = getMeasure(g, measure_class)
            
            if isKey(g.mdict, measure_class)
                m = g.mdict(measure_class);
            else
                m = Measure.getMeasure(measure_class, g, g.getSettings());
                g.mdict(measure_class) = m;
            end 
        end
        function value = getMeasureValue(g, measure_class)
            value = g.getMeasure(measure_class).getValue();
        end
        function bool = is_measure_calculated(g, measure_class)

            if isKey(g.mdict, measure_class)
                bool = g.mdict(measure_class).is_value_calculated();
            else
                bool = false;
            end
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
        function graph_class_list = getList()
            graph_class_list = subclasses( ...
                'Graph', ...
                [fileparts(which('Graph')) filesep 'graphs'] ...
                );
        end
        function graph_class = getClass(g)
            % measure class (same as the measure object name)
            
            if isa(g, 'Graph')
                graph_class = class(g);
            else % g should be a string with the graph code
                graph_class = g;
            end
        end        
        function name = getName(g)
            % graph name
            
            name = eval([Graph.getClass(g) '.getName()']);
        end
        function name = getDescription(g)
            % graph description
            
            name = eval([Graph.getClass(g) '.getDescription()']);
        end
        function bool = is_selfconnected(g)
            % whether is self-connected
            
            bool = eval([Graph.getClass(g) '.is_selfconnected()']);
        end
        function bool = is_nonnegative(g)
            % whether is non-negative graph
            
            bool = eval([Graph.getClass(g) '.is_nonnegative()']);
        end
        function bool = is_weighted(g)
            % whether is weighted graph
            
            bool = eval([Graph.getClass(g) '.is_weighted()']);
        end
        function bool = is_binary(g)
            % whether is binary graph
            
            bool = eval([Graph.getClass(g) '.is_binary()']);
        end
        function bool = is_directed(g)
            % whether is directed graph
            
            bool = eval([Graph.getClass(g) '.is_directed()']);
        end
        function bool = is_undirected(g)
            % whether is undirected graph
            
            bool = eval([Graph.getClass(g) '.is_undirected()']);
        end
        function g_new = getGraph(g, A, varargin) %#ok<INUSD>
            
            g_new = eval([Graph.getClass(g) '(A, varargin{:})']);
        end
        function list = compatible_measure_list(g)
            % list of measures which work with graph
            
            if isa(g, 'Graph')
                graph_code = g.getGraphCode();
            else % g should be a string with the graph code
                graph_code = g;
            end
            
            measure_list = Measure.getMeasureList();
            
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
end