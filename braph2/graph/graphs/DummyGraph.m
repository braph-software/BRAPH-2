classdef DummyGraph < Graph
    % DummyGraph < Graph: A binary undirected graph
    % DummyGraph represents a binary undirected graph.
    %
    % DummyGraph consists of a binary undirected graph.
    %  
    % DummyGraph methods:
    %   DummyGraph     - constructor.
    %
    % DummyGraph descriptive methods (static):
    %   getClass                - return the class name
    %   getName                 - return the complete name
    %   getDescription          - return the description
    %   getGraphType            - returns the graph type
    %   getConnectivityType     - returns if the graph is binary or weighted
    %   getDirectionalityType   - returns if graph is directed or undirected
    %   getSelfConnectivityType - returns if graph is self-connected or not self-connected
    %   getNegativityType       - returns if graph is negative or non-negative
    %   getCompatibleMeasureList - returns a list with compatible measures
    %   getCompatibleMeasureNumber - returns the number of compatible measures
    %
    % See also Graph, DummyMultigraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultilayer, DummyOrderedMultiplex.
    
    methods  % Constructor
        function g = DummyGraph(A, varargin)
            % DUMMYGRAPH() creates a DUMMYGRAPH class with a
            % default matrix A:
            % A =   0 1 1  
            %       1 0 0
            %       1 0 0
            %
            % DUMMYGRAPH(A) creates a DUMMYGRAPH class with matrix A.
            % It calls the constructor of Graph.
            %
            % DUMMYGRAPH(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % inizializes DUMMYGRAPH with the properties and values
            % PROPERTY1, VALUE1, PROPERTY2, VALUE2, ... 
            %
            % See also Graph, DummyMultigraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultilayer, DummyOrderedMultiplex.
      
            if isempty(A)
                A = [
                0   1   1
                1   0   0
                1   0   0
                ];
            end
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'DummyGraph'.
            %
            % See also getName(), getDescription().
            
            graph_class = 'DummyGraph';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Binary Directed Graph'.
            %
            % See also getClass(), getDescription().
            
            name = 'Dummy graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of DUMMYGRAPH.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'Dummy graph used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns GRAPH for DUMMYGRAPH.
            %
            % See also getConnectivityType(), getDirectionalityType(), getNegativityType() and getSelfConnectivityType().
           
            graph_type = Graph.GRAPH;
        end
        function connectivity_type = getConnectivityType(varargin)
            % GETCONNECTIVITYTYPE returns the connectivity type of the graph
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns BINARY for DUMMYGRAPH.
            %    
            % See also Graph, getDirectionalityType(), getGraphType(), getNegativityType() and getSelfConnectivityType().
            
            connectivity_type = Graph.BINARY;
        end
        function directionality_type = getDirectionalityType(varargin)
            % GETDIRECTIONALITYTYPE returns the directionality type of the graph
            %   
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE() returns UNDIRECTED for DUMMYGRAPH.
            %
            % See also Graph, getConnectivityType(), getGraphType(), getNegativityType() and getSelfConnectivityType().
            
            directionality_type = Graph.UNDIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType(varargin)
            % GETSELFCONNECTIVITYTYPE returns the self-connectivity type of the graph
            %    
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE() returns UNDIRECTED for DUMMYGRAPH.
            %
            % See also Graph, getConnectivityType(), getDirectionalityType(), getGraphType() and getNegativityType().
            
            selfconnectivity_type = Graph.NONSELFCONNECTED;
        end
        function negativity_type = getNegativityType(varargin)
            % GETNEGATIVITYTYPE returns the negativity type of the graph
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE() returns NONNEGATIVE for DUMMYGRAPH.
            %
            % See also Graph, getConnectivityType(), getDirectionalityType(), getGraphType() and getSelfConnectivityType().
            
            negativity_type =  Graph.NONNEGATIVE;
        end
    end
end