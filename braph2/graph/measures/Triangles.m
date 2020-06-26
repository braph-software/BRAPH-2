classdef Triangles < Measure
    % Triangles Triangles measure
    % Triangles provides the number of triangles of a node for binary
    % undirected (BU), binary directed (BD), weighted undirected (WU) and 
    % weighted directed (WD) graphs. 
    %
    % It is calculated as the number of a node's neighbor pairs that are   
    % connected to each other. In weighted graphs, the triangles are 
    % calculated as geometric mean of the weights of the edges forming
    % the triangle. For directed graphs the useer can set the rule to
    % calculate the triangles (setting 'DirectedTrianglesRule').
    % 
    % Triangles methods:
    %   Triangles                   - constructor
    %
    % Triangles methods (Static)
    %   getClass                    - returns the triangles class
    %   getName                     - returns the name of triangles measure
    %   getDescription              - returns the description of triangles measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope
    %   getMeasure                  - returns the triangles class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Graph, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = Triangles(g, varargin)  
            % TRIANGLES(G) creates triangles with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU).  
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
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU). 
            %   
            % See also Measure, Graph, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function triangles_layer = calculate(m)
            % CALCULATE calculates the number of triangles of a node
            %
            % TRIANGLES = CALCULATE(M) returns the triangles 
            % of a node.
            %
            % See also Measure, Graph, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix of the graph
            L = g.layernumber();
            
            triangles = cell(g.layernumber(), 1);
            directionality_type =  g.getDirectionalityType(g.layernumber());
            for li = 1:1:L
                
                if g.is_graph(g)
                    Aii = A;
                    directionality_layer = directionality_type;
                else
                    Aii = A{li, li};
                    directionality_layer = directionality_type(li, li);
                end
                
                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                    triangles_layer = diag((Aii.^(1/3))^3) / 2;
                    triangles_layer(isnan(triangles_layer)) = 0;  % Should return zeros, not NaN
                    triangles(li) = {triangles_layer};

                else  % directed graphs
                    directed_triangles_rule = get_from_varargin('cycle', 'DirectedTrianglesRule', m.getSettings());
                    switch lower(directed_triangles_rule)
                        case {'all'}  % all rule
                            triangles_layer = diag((Aii.^(1/3) + transpose(Aii).^(1/3))^3) / 2;
                        case {'middleman'}  % middleman rule
                            triangles_layer = diag(Aii.^(1/3) * transpose(Aii).^(1/3) * Aii.^(1/3));
                        case {'in'}  % in rule
                            triangles_layer = diag(transpose(Aii).^(1/3) * (Aii.^(1/3))^2);
                        case {'out'}  % out rule
                            triangles_layer = diag((Aii.^(1/3))^2 * transpose(Aii).^(1/3));
                        otherwise  % {'cycle'}  % cycle rule
                            triangles_layer = diag((Aii.^(1/3))^3);
                    end
                    triangles(li) = {triangles_layer};
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
            % See also getClass, getName.
            
            description = [ ...
                'The triangles of a node are ' ...
                'the number of its neighbor pairs' ...
                'that are connected to each other within a layer. ' ...
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
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Triangles
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of triangles measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Triangles
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of triangles measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with Triangles 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to triangles. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
                      
            list = { ...
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with Triangles 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to triangles.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Triangles');
        end
    end
end
