classdef LocalEfficiency < Measure
    % LocalEfficiency < Measure: Local Efficiency measure
    % LocalEfficiency provides the local efficiency of a node for binary undirected   
    % (BU) and weighted undirected (WU) graphs. It is calculated as average 
    % inverse shortest path length with local nodes. 
    % 
    % LocalEfficiency methods:
    %   LocalEfficiency             - constructor with Measure properties.
    %
    % LocalEfficiency methods (Access=protected):
    %   calculate                   - calculates the local efficiency of a node.
    % 
    % LocalEfficiency methods (Static)
    %   getClass                    - returns the local efficiency class.
    %   getName                     - returns the name of local efficiency measure.
    %   getDescription              - returns the description of local efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if local efficiency measure is global.
    %   is_nodal                    - boolean, checks if local efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if local efficiency measure if binodal.
    %   getMeasure                  - returns the local efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, PathLength, InLocalEfficiency, OutLocalEfficiency, GlobalEfficiency.
    
    methods
        function m = LocalEfficiency(g, varargin)
            % LOCALEFFICIENCY(G) creates local efficiency with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %
            % LOCALEFFICIENCY(G, 'VALUE', VALUE) creates local efficiency, and sets the value
            % to VALUE. G is a graph (e.g, an instance of  GraphBU, Graph WU).
            %   
            % See also Measure, Graph, PathLength, InLocalEfficiency, OutLocalEfficiency, GlobalEfficiency.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function local_efficiency = calculate(m)
            % CALCULATE calculates the local efficiency value of a node
            %
            % LOCALEFFICIENCY = CALCULATE(M) returns the value of the local efficiency of a
            % node.
            
            g = m.getGraph(); % graph from measure class
            A = g.getA(); % adjency matrix of the graph
            n = g.nodenumber();
            
            local_efficiency = zeros(n,1);
            for i = 1:1:n
                nodes = find(A(i, :)  | A(:, i).');  % neighbours of u
                if numel(nodes) > 1
                    sub_graph = g.subgraph(nodes);
                    local_efficiency(i) = mean(GlobalEfficiency(sub_graph, g.getSettings()).getValue());
                end
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
            
            name = 'Local-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the local efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % local efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The local efficiency is the average inverse ' ...
                'shortest path length with local nodes.' ...
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
       function bool = is_global()
            % IS_GLOBAL checks if local efficiency measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if local efficiency measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if local efficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to LocalEfficiency
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to LocalEfficiency. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...               
                'GraphBU', ...           
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to LocalEfficiency
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to LocalEfficiencyy.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('LocalEfficiency');
        end
    end
end