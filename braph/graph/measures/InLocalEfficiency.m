classdef InLocalEfficiency < Measure
    % InLocalEfficiency < Measure: In-Local Efficiency measure
    % InLocalEfficiency provides the in-local efficiency of a node for binary directed   
    % (BD) and weighted directed (WD) graphs. It is calculated as average 
    % inverse shortest path length with local nodes. 
    % 
    % InLocalEfficiency methods:
    %   InLocalEfficiency           - constructor with Measure properties.
    %
    % InLocalEfficiency methods (Access=protected):
    %   calculate                   - calculates the in-local efficiency of a node.
    % 
    % InLocalEfficiency methods (Static)
    %   getClass                    - returns the in-local efficiency class.
    %   getName                     - returns the name of in-local efficiency measure.
    %   getDescription              - returns the description of in-local efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if in-local efficiency measure is global.
    %   is_nodal                    - boolean, checks if in-local efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if in-local efficiency measure if binodal.
    %   getMeasure                  - returns the in-local efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, PathLength, LocalEfficiency, OutLocalEfficiency, GlobalEfficiency.
    
    methods
        function m = InLocalEfficiency(g, varargin)
            % INLOCALEFFICIENCY(G) creates in-local efficiency with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %
            % INLOCALEFFICIENCY(G, 'VALUE', VALUE) creates in-local efficiency, and sets the value
            % to VALUE. G is a graph (e.g, an instance of  GraphBU, Graph WU).
            %   
            % See also Measure, Graph, PathLength, LocalEfficiency, OutLocalEfficiency, GlobalEfficiency.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_local_efficiency = calculate(m)
            % CALCULATE calculates the in-local efficiency value of a node
            %
            % INLOCALEFFICIENCY = CALCULATE(M) returns the value of the in-local efficiency of a
            % node.
            
            g = m.getGraph(); % graph from measure class
            A = g.getA(); % adjency matrix of the graph
            n = g.nodenumber();
            
            in_local_efficiency = zeros(n,1);
            for i = 1:1:n
                nodes = find(A(i, :)  | A(:, i).');  % neighbours of u
                if numel(nodes) > 1
                    sub_graph = g.subgraph(nodes);
                    in_local_efficiency(i) = mean(InGlobalEfficiency(sub_graph, g.getSettings()).getValue());
                end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-local efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InLocalEfficiency';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-local efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'In-Local-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-local efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-local efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The in local efficiency is the average inverse ' ...
                'shortest in path length with local nodes.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InLocalEfficiency.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InLocalEfficiency. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
       function bool = is_global()
            % IS_GLOBAL checks if in-local efficiency measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if in-local efficiency measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if in-local efficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InLocalEfficiency
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to InLocalEfficiency. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...               
                'GraphBD', ...           
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to InLocalEfficiency
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InLocalEfficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InLocalEfficiency');
        end
    end
end