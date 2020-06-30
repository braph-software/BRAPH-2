classdef LocalEfficiency < Measure
    % LocalEfficiency Local efficiency measure
    % LocalEfficiency provides the local efficiency of a node for binary 
    % undirected (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as the average inverse shortest path length with local 
    % nodes within each layer. 
    % 
    % LocalEfficiency methods:
    %   LocalEfficiency             - constructor
    %
    % LocalEfficiency methods (Static)
    %   getClass                    - returns the local efficiency class
    %   getName                     - returns the name of local efficiency measure
    %   getDescription              - returns the description of local efficiency measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope  
    %   getMeasure                  - returns the local efficiency class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = LocalEfficiency(g, varargin)
            % LOCALEFFICIENCY(G) creates local efficiency with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU, 
            % MultiplexGraphBU or MultiplexGraphWU). 
            %   
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function local_efficiency = calculate(m)
            % CALCULATE calculates the local efficiency value of a node
            %
            % LOCALEFFICIENCY = CALCULATE(M) returns the value of the local efficiency of a
            % node.
            %
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix (for graph) or 2D-cell array (for multiplex)
            N = g.nodenumber();
            L = g.layernumber();
            
            local_efficiency = cell(L, 1);
            for li = 1:1:L
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                local_efficiency_layer = zeros(N(li), 1);
                for i = 1:1:N(li)
                    nodes = find(Aii(i, :)  | Aii(:, i).');  % neighbours of u
                    if numel(nodes) > 1
                        sub_graph = g.subgraph(g, nodes);
                        global_efficiency = GlobalEfficiency(sub_graph, g.getSettings()).getValue();
                        local_efficiency_layer(i) = mean(global_efficiency{1});
                    end
                end
                local_efficiency(li) = {local_efficiency_layer};
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the local efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'LocalEfficiency';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the local efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Local efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the local efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % local efficiency measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The local efficiency is the average inverse ' ...
                'shortest path length with local nodes within each layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to LocalEfficiency.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to LocalEfficiency. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
       function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of LocalEfficiency
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of local efficiency measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of LocalEfficiency
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of local efficiency measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with LocalEfficiency
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to local efficiency. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...               
                'GraphBU', ...           
                'GraphWU' ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with LocalEfficiency
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to local efficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('LocalEfficiency');
        end
    end
end