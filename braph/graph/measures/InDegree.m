classdef InDegree < Measure
    % InDegree < Measure: In-Degree measure
    % InDegree provides the in-degree of a node for binary directed (BD) and 
    % weighted directed (WD) graphs. It is calculated as the number of
    % inward edges connected to the node. 
    % 
    % InDegree methods:
    %   InDegree                    - constructor with Measure properties.
    %
    % InDegree methods (Access=protected):
    %   calculate                   - calculates the in-degree of a node.
    % 
    % InDegree methods (Static)
    %   getClass                    - returns the in-degree class.
    %   getName                     - returns the name of in-degree measure.
    %   getDescription              - returns the description of in-degree measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if in-degree measure is global.
    %   is_nodal                    - boolean, checks if in-degree measure is nodal.
    %   is_binodal                  - boolean, checks if in-degree measure if binodal.
    %   getMeasure                  - returns the in-degree class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Degree, Distance, Efficiency.
    
    methods
        function m = InDegree(g, varargin)
            % INDEGREE(G) creates in-degree with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % INDEGREE(G, 'VALUE', VALUE) creates in-degree, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Degree, Distance, Efficency. 
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods(Access=protected)
        function in_degree = calculate(m)
            % CALCULATE calculates the in-degree value of a node
            %
            % INDEGREE = CALCULATE(M) returns the value of the in-degree of a
            % node.
            
            g = m.getGraph(); % graph from measure class
            A = g.getA(); % adjency matrix of the graph
            in_degree = sum(A, 1)';  % column sum of A
        end
    end
    methods (Static) 
         function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-degree measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'InDegree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-degree measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'In-Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-degree measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The in-degree of a node is ' ...
                'the number of inward edges connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InDegree. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if in-degree measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
                                   
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if in-degree measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if in-degree measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function bool = is_compatible_graph(g)
            bool = g.is_directed();
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InDegree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to InDegree. 
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
            % graphs to InDegree 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InDegree.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InDegree');
        end
    end
end