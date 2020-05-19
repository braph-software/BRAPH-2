classdef DummyMultilayerGraph < Graph

    methods  % Constructor
        function g = DummyMultilayerGraph(~, varargin)
            
            A = {
                round(rand(4))      round(rand(4, 3))   randn(4, 2)
                round(rand(3, 4))   round(rand(3))      round(rand(3, 2))
                randn(2, 4)         round(rand(2, 3)) 	randn(2)
                };
            
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
            
            graph_class = 'DummyMultilayerGraph';
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
                'Dummy Multilayer Graph used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = Graph.MULTILAYER;
        end
        function graph_type = getConnectionType(varargin)
            
            graph_type = [ 
                Graph.BINARY    Graph.BINARY    Graph.WEIGHTED
                Graph.BINARY    Graph.BINARY    Graph.BINARY 
                Graph.WEIGHTED  Graph.BINARY    Graph.WEIGHTED
                ];
        end
        function graph_type = getEdgeType()
            graph_type = Graph.DIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType()
            selfconnectivity_type = Graph.NOT_SELFCONNECTED;
        end
        function negativity_type = getNegativityType()
            % GETNEGATIVITYTYPE checks if the graph is non-negative or negative
            %
            % BOOL = GETNEGATIVITYTYPE() returns NONNEGATIVE for GRAPHBD.
            %
            % See also getConnectionType(), getEdgeType(), getGraphType() and getSelfConnectivityType().
            
            negativity_type = Graph.NONNEGATIVE;
        end
    end
end