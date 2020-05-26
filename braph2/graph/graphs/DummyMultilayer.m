classdef DummyMultilayer < Graph

    methods  % Constructor
        function g = DummyMultilayer(A, varargin)
            
            if isempty(A)
                A = {
                round(rand(4))      round(rand(4, 3))   randn(4, 2)
                round(rand(3, 4))   round(rand(3))      round(rand(3, 2))
                randn(2, 4)         round(rand(2, 3)) 	randn(2)
                };
            end
            
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
            
            graph_class = 'DummyMultilayer';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Binary Directed Graph'.
            %
            % See also getClass().
            
            name = 'Dummy Multilayer';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHBD.
            %
            % See also getName().
            
            description = [ ...
                'Dummy Multilayer used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = Graph.MULTILAYER;
        end
        function connectivity_type = getConnectivityType(varargin)
            
            connectivity_type = [ 
                Graph.BINARY    Graph.BINARY    Graph.WEIGHTED
                Graph.BINARY    Graph.BINARY    Graph.BINARY 
                Graph.WEIGHTED  Graph.BINARY    Graph.WEIGHTED
                ];
        end
        function directionality_type = getDirectionalityType(varargin)
            directionality_type = Graph.DIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType(varargin)
            selfconnectivity_type = Graph.SELFCONNECTED;
        end
        function negativity_type = getNegativityType(varargin)
            % GETNEGATIVITYTYPE checks if the graph is non-negative or negative
            %
            % BOOL = GETNEGATIVITYTYPE() returns NONNEGATIVE for GRAPHBD.
            %
            % See also getConnectivityType(), getEdgeType(), getGraphType() and getSelfConnectivityType().
            
            negativity_type = [ 
                Graph.NONNEGATIVE	Graph.NONNEGATIVE   Graph.NEGATIVE
                Graph.NONNEGATIVE   Graph.NONNEGATIVE   Graph.NONNEGATIVE 
                Graph.NEGATIVE      Graph.NONNEGATIVE   Graph.NEGATIVE
                ];
        end
    end
end