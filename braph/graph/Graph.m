classdef Graph < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        A   % adjacency matrix
        settings  % structure with the constructor varagin
        mdict  % dictionary with calculated measures
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
            
            % Make a deep copy of settings
            g_copy.settings = copy_varargin(g.settings{:});

            % Make a deep copy of mdict
            g_copy.mdict = containers.Map;
            measures = values(g.mdict);
            for i = 1:1:length(measures)
                m = measures{i};
                m_settings = m.getSettings();
                if m.is_value_calculated()
                    g_copy.mdict(m.getMeasureCode()) = Measure.getMeasure( ...
                        m.getMeasureCode(), ...
                        g_copy, ...
                        'Value', m.getValue(), ...
                        'Settings', copy_varargin(m_settings{:}) ...
                        );
                else
                    g_copy.mdict(m.getMeasureCode()) = Measure.getMeasure( ...
                        m.getMeasureCode(), ...
                        g_copy, ...
                        'Settings', copy_varargin(m_settings{:}) ...
                        );                    
                end
            end
        end        
    end
    methods
        function str = tostring(g)
            str = [Graph.getClass(g) ' ' int2str(size(g.getA(), 1)) ' rows x ' int2str(size(g.getA(), 2)) ' columns'];
        end
        function disp(g)
            disp(['<a href="matlab:help ' Graph.getClass(g) '">' Graph.getClass(g) '</a>'])
            disp([' size: ' int2str(size(g.getA(), 1)) ' rows x ' int2str(size(g.getA(), 2)) ' columns'])
            disp([' measures: ' int2str(length(g.mdict))]);
            disp([' settings']); %#ok<NBRAK>
            settings = g.getSettings(); %#ok<PROP>
            for i = 1:2:length(settings) %#ok<PROP>
                disp(['  ' settings{i} ' = ' tostring(settings{i+1})]); %#ok<PROP>
            end
        end
        function A = getA(g)
            A = g.A;
        end
        function n = nodenumber(g)
            n = length(g.getA());
        end
        function res = getSettings(g, setting_code)

            if nargin<2
                res = g.settings;
            else
                res = get_from_varargin([], setting_code, g.settings{:});
            end
        end
        function m = getMeasure(g, measure_class)
            
            if isKey(g.mdict, measure_class)
                m = g.mdict(measure_class);
            else
                m = Measure.getMeasure(measure_class, g, g.settings{:});
                g.mdict(measure_class) = m;
            end 
        end
        function bool = is_measure_calculated(g, measure_class)

            if isKey(g.mdict, measure_class)
                bool = g.mdict(measure_class).is_value_calculated();
            else
                bool = false;
            end
        end
        function value = getMeasureValue(g, measure_class)
            value = g.getMeasure(measure_class).getValue();
        end
        function sg = subgraph(g, nodes)
            
            settings = g.getSettings(); %#ok<PROPLC>
            
            sg = Graph.getGraph(g.getGraphCode(), g.A(nodes,nodes), settings{:}); %#ok<PROPLC>
        end
        function ga = nodeattack(g, nodes)
            
            A = g.getA(); %#ok<PROPLC>
            for i = 1:1:numel(nodes)
                A(nodes(i), :) = 0; %#ok<PROPLC>
                A(:, nodes(i)) = 0; %#ok<PROPLC>
            end
            
            settings = g.getSettings(); %#ok<PROPLC>
            
            ga = Graph.getGraph(g.getGraphCode(), A, settings{:}); %#ok<PROPLC>
        end
        function ga = edgeattack(g, nodes1, nodes2)
                        
            A = g.getA(); %#ok<PROPLC>
            A(sub2ind(size(A), nodes1, nodes2)) = 0; %#ok<PROPLC>

            settings = g.getSettings(); %#ok<PROPLC>

            ga = Graph.getGraph(g.getGraphCode(), A, settings{:}); %#ok<PROPLC>
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
        function list = getCompatibleMeasureList(g)
            % list of measures which work with graph
            
            graph_class = Graph.getClass(g);
            
            measure_code_list = Measure.getList();
            
            list = cell(1, length(measure_code_list));
            for i = 1:1:length(measure_code_list)
                measure_code = measure_code_list{i};
                
                if are_compatible(graph_class, measure_code)
                    list{i} = measure_code;
                end
            end
            list(cellfun('isempty', list)) = [];
        end
        function n = getCompatibleMeasureNumber(g)
            
            list = Graph.getCompatibleMeasureList(g);
            n = numel(list);
        end       
    end
end
