classdef DummyGraph < Graph

    methods  % Constructor
        function g = DummyGraph(~, varargin)
            
            A = get_from_varargin( ...
                [
                0   1   1
                1   0   0
                1   0   0
                ], ...
                'A', ...
                varargin);
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'GraphBD'.
            %
            % See also getName().
            
            graph_class = 'DummyGraph';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Binary Directed Graph'.
            %
            % See also getClass().
            
            name = 'Dummy Multilayer Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHBD.
            %
            % See also getName().
            
            description = [ ...
                'Dummy Graph used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = Graph.GRAPH;
        end
        function connectivity_type = getConnectivityType(varargin)
            
            connectivity_type = Graph.BINARY;
        end
        function edge_type = getEdgeType(varargin)
            
            edge_type = Graph.UNDIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType()
            
            selfconnectivity_type = Graph.NONSELFCONNECTED;
        end
        function negativity_type = getNegativityType()
            % GETNEGATIVITYTYPE checks if the graph is non-negative or negative
            %
            % BOOL = GETNEGATIVITYTYPE() returns NONNEGATIVE for GRAPHBD.
            %
            % See also getConnectivityType(), getEdgeType(), getGraphType() and getSelfConnectivityType().
            
            negativity_type =  Graph.NONNEGATIVE;
        end
    end
end