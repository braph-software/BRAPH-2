classdef OutDegree < Measure
    % OutDegree < Measure: Out-Degree measure
    % OutDegree provides the out-degree of a node for binary directed (BD) and 
    % weighted directed (WD) graphs. It is calculated as the number of
    % outward edges connected to the node. 
    % 
    % OutDegree methods:
    %   OutDegree                   - constructor with Measure properties.
    %
    % OutDegree methods (Access=protected):
    %   calculate                   - calculates the out-degree of a node.
    % 
    % OutDegree methods (Static)
    %   getClass                    - returns the out-degree class.
    %   getName                     - returns the name of out-degree measure.
    %   getDescription              - returns the description of out-degree measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if out-degree measure is global.
    %   is_nodal                    - boolean, checks if out-degree measure is nodal.
    %   is_binodal                  - boolean, checks if out-degree measure if binodal.
    %   getMeasure                  - returns the out-degree class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Degree, InDegree, Distance.
    
    methods
        function m = OutDegree(g, varargin)
            % OUTDEGREE(G) creates out-degree with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % OUTDEGREE(G, 'VALUE', VALUE) creates out-degree, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Degree, InDegree, Distance.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods(Access = protected)
        function out_degree = calculate(m)
            % CALCULATE calculates the out-degree value of a node
            %
            % OUTDEGREE = CALCULATE(M) returns the value of the out-degree of a
            % node.
            
            g = m.getGraph(); % graph from measure class
            A = g.getA(); % adjency matrix of the graph
            out_degree = sum(A, 2);  % row sum of A
        end
    end
    methods (Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the out-degree measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'OutDegree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-degree measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Out-Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-degree measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The out-degree of a node is ' ...
                'the number of outward edges connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OutDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutDegree. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
       function bool = is_global()
            % IS_GLOBAL checks if out-degree measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
                                   
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if out-degree measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if out-degree measure is binodal (false)
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
            % to OutDegree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to OutDegree. 
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
            % graphs to OutDegree 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to OutDegree.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutDegree');
        end
    end
end