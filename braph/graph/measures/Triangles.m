classdef Triangles < Measure
    % Triangles < Measure: Triangles measure
    % Triangles provides the number of triangles of a node for binary
    % undirected (BU), binary directed (BD), weighted undirected (WU) and 
    % weighted directed (WD) graphs. It is calculated as the number of a node's   
    % neighbor pairs that are connected to each other. In weighted graphs,
    % the triangles are calculated as geometric mean of the weights of the
    % edges forming the triangle. 
    % 
    % Triangles methods:
    %   Triangles                   - constructor with Measure properties.
    %
    % Triangles methods (Access=protected):
    %   calculate                   - calculates the number of triangles of a node.
    % 
    % Triangles methods (Static)
    %   getClass                    - returns the triangles class.
    %   getName                     - returns the name of triangles measure.
    %   getDescription              - returns the description of triangles measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if triangles measure is global.
    %   is_nodal                    - boolean, checks if triangles measure is nodal.
    %   is_binodal                  - boolean, checks if triangles measure if binodal.
    %   getMeasure                  - returns the triangles class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Triangles, Measure, Graph, Transitivity, Strength, Degree.
    
    methods
        function m = Triangles(g, varargin)  
            % TRIANGLES(G) creates triangles with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % TRIANGLES(G, 'DirectedTrianglesRule', DIRECTEDTRIANGLESRULE) creates triangles             
            % measure and initializes the property DirectedTrianglesRule with DIRECTEDTRIANGLESRULE. 
            % Admissible RULE options are:
            % DIRECTEDTRIANGLESRULE = 'cycle' (default) - calculates TRIANGLES of a node using the cycle rule for directed graphs.
            %                    'all' - calculates TRIANGLES of a node
            %                    using the all rule for directed graphs.
            %                    'middleman' - calculates TRIANGLES of a
            %                    node using the middleman rule for directed graphs.
            %                    'in' - calculates TRIANGLES of a node
            %                    using the in rule for directed graphs.
            %                    'out' - calculates TRIANGLES of a node
            %                    using the out rule for directed graphs.
            %           
            % TRIANGLES(G, 'VALUE', VALUE) creates triangles, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Strength, Degree, Clustering.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function triangles = calculate(m)
            % CALCULATE calculates the number of triangles of a node
            %
            % TRIANGLES = CALCULATE(M) returns the triangles 
            % of a node.
            
            g = m.getGraph(); % graph from measure class
            A = g.getA(); % adjency matrix of the graph
            if isa(g, 'GraphBU') || isa(g, 'GraphWU')
                triangles = diag((A.^(1/3))^3) / 2;
                triangles(isnan(triangles)) = 0;  % Should return zeros, not NaN
                
            elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')
                directed_triangles_rule = get_from_varargin('cycle', 'DirectedTrianglesRule', m.getSettings());
                switch lower(directed_triangles_rule)
                    case {'all'}  % all rule
                        triangles = diag((A.^(1/3) + transpose(A).^(1/3))^3) / 2;
                    case {'middleman'}  % middleman rule
                        triangles = diag(A.^(1/3) * transpose(A).^(1/3) * A.^(1/3));
                    case {'in'}  % in rule
                        triangles = diag(transpose(A).^(1/3) * (A.^(1/3))^2);
                    case {'out'}  % out rule
                        triangles = diag((A.^(1/3))^2 * transpose(A).^(1/3));
                    otherwise  % {'cycle'}  % cycle rule
                        triangles = diag((A.^(1/3))^3);
                end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the triangles measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'Triangles';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the triangles measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Triangles';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the triangles description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % triangles measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The triangles of a node are ' ...
                'the number of its neighbor pairs' ...
                'that are connected to each other. ' ...
                'In weighted graphs, the triangles are calculated' ...
                'as geometric mean of the weights of the edges' ...
                'forming the triangle.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % Triangles
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Triangles. 
            % DIRECTEDTRIANGLESRULE = 'cycle' (default) - calculates TRIANGLES of a node using the cycle rule for directed graphs.
            %                    'all' - calculates TRIANGLES of a node
            %                    using the all rule for directed graphs.
            %                    'middleman' - calculates TRIANGLES of a
            %                    node using the middleman rule for directed graphs.
            %                    'in' - calculates TRIANGLES of a node
            %                    using the in rule for directed graphs.
            %                    'out' - calculates TRIANGLES of a node
            %                    using the out rule for directed graphs.
            % 
            % See also getCompatibleGraphList()

            available_settings = {
                'DirectedTrianglesRule', Constant.STRING, 'cycle', {'cycle', 'all', 'middleman', 'in', 'out'};
                };
        end
        function bool = is_global()
            % IS_GLOBAL checks if triangles measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
               
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if triangles measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal.
              
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if triangles measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to Triangles 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to Triangles. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
                      
            list = { ...
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to Triangles 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to Triangles.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Triangles');
        end
    end
end
