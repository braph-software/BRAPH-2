classdef DummyOrderedMultilayer < Graph
    % DummyOrderedMultilayer An Ordered Multilayer graph
    % DummyOrderedMultilayer represents an ordered multilayer graph.
    %
    % DummyOrderedMultilayer is constituted by two binary directed graphs and
    % one weighted directed graph. Thus, it only accepts a number of layers
    % equal to three. It is a sequence of layers with ordinal connections.
    %
    % DummyOrderedMultilayer methods:
    %   DummyOrderedMultilayer  - constructor
    %
    % DummyOrderedMultilayer descriptive methods (static):
    %   getClass                - returns the class name
    %   getName                 - returns the complete name
    %   getDescription          - returns the description
    %   getGraphType            - returns the graph type
    %   getConnectivityType     - returns if the graph is binary or weighted
    %   getDirectionalityType   - returns if graph is directed or undirected
    %   getSelfConnectivityType - returns if graph is self-connected or not self-connected
    %   getNegativityType       - returns if graph is negative or non-negative
    %
    % Graph randomization method (static):
    %   randomize               - randomize graph
    %
    % See also Graph, DummyGraph, DummyMultigraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultiplex.
    
    methods  % Constructor
        function g = DummyOrderedMultilayer(A, varargin)
            % DUMMYORDEREDMULTILAYER() creates a DUMMYORDEREDMULTILAYER class
            % with a default supra-adjacency matrix A:
            % A =   BD(4)     BD(4, 3)  []
            %       BD(3, 4)  BD(3)     BD(3, 2)
            %       []        BD(2, 3)  WD(2)
            % where all weights are initialized randomly and
            %       BD(4) = binary directed 4 x 4 with weights in 0 or 1
            %       BD(3) = binary directed 3 x 3 with weights in 0 or 1
            %       WD(2) = weighted directed 2 x 2 with weights in [0, 1]
            %
            % DUMMYORDEREDMULTILAYER(A) creates a DUMMYORDEREDMULTILAYER
            % class with supra-adjacency matrix A.
            % It throws an error if the number of layers of A is not three.
            % It calls the constructor of Graph.
            %
            % DUMMYORDEREDMULTILAYER(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % initializes DUMMYORDEREDMULTILAYER with the properties and values
            % PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...
            %
            % See also Graph, DummyGraph, DummyMultigraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultiplex.
            
            if isempty(A)
                A = {
                    round(rand(4))      round(rand(4, 3))   {}
                    round(rand(3, 4))   round(rand(3))      round(rand(3, 2))
                    {}                  round(rand(2, 3))   rand(2)
                    };
            end
            
            assert(length(A) == 3, ...
                [BRAPH2.STR ':DummyOrderedMultilayer' BRAPH2.WRONG_INPUT], ...
                ['The number of layers for DummyOrderedMultilayer must be three,' ...
                ' while it is ' tostring(length(A))])
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'DummyOrderedMultilayer'.
            %
            % See also getName, getDescription.
            
            graph_class = 'DummyOrderedMultilayer';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Dummy Ordered Multilayer'.
            %
            % See also getClass, getDescription.
            
            name = 'Dummy Ordered Multilayer';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of DUMMYORDEREDMULTILAYER.
            %
            % See also getClass, getName.
            
            description = [ ...
                'Dummy ordered multilayer used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns Graph.ORDERED_MULTILAYER.
            %
            % See also getConnectivityType, getDirectionalityType, getNegativityType, getSelfConnectivityType.
            
            graph_type = Graph.ORDERED_MULTILAYER;
        end
        function connectivity_type = getConnectivityType(varargin)
            % GETCONNECTIVITYTYPE returns the connectivity type of the graph
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns a
            % matrix with BINARY for the first and second layers, and
            % WEIGHTED for the third layer.
            % It returns:
            % CONNECTIVITY_TYPE = BINARY   BINARY  BINARY
            %                     BINARY   BINARY  BINARY
            %                     BINARY   BINARY  WEIGHTED
            % where BINARY = Graph.BINARY and WEIGHTED = Graph.WEIGHTED.
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(LAYERNUMBER) returns a
            % matrix with BINARY for the first and second layers, and
            % WEIGHTED for the third layer.
            % It returns:
            % CONNECTIVITY_TYPE = BINARY   BINARY  BINARY
            %                     BINARY   BINARY  BINARY
            %                     BINARY   BINARY  WEIGHTED
            % where BINARY = Graph.BINARY and WEIGHTED = Graph.WEIGHTED.
            %
            % See also Graph, getDirectionalityType, getGraphType, getNegativityType, getSelfConnectivityType.
            
            connectivity_type = [
                Graph.BINARY    Graph.BINARY    Graph.BINARY
                Graph.BINARY    Graph.BINARY    Graph.BINARY
                Graph.BINARY    Graph.BINARY    Graph.WEIGHTED
                ];
        end
        function directionality_type = getDirectionalityType(varargin)
            % GETDIRECTIONALITYTYPE returns the directionality type of the graph
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE() returns
            % Graph.DIRECTED.
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(LAYERNUMBER) returns
            % a matrix with Graph.DIRECTED for all the elements.
            % For example, for the default matrix it returns:
            % DIRECTIONALITY_TYPE = DIRECTED  DIRECTED  DIRECTED
            %                       DIRECTED  DIRECTED  DIRECTED
            %                       DIRECTED  DIRECTED  DIRECTED
            % where DIRECTED = Graph.DIRECTED.
            % If LAYERNUMBER is not three, it throws an error.
            %
            % See also Graph, getConnectivityType, getGraphType, getNegativityType, getSelfConnectivityType.
            
            if isempty(varargin)
                directionality_type = Graph.DIRECTED;
            else
                layernumber = varargin{1};
                
                assert(layernumber == 3, ...
                    [BRAPH2.STR ':DummyOrderedMultilayer:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyOrderedMultilayer must be three,' ...
                    ' while it is ' tostring(layernumber)])
                
                directionality_type = Graph.DIRECTED * ones(layernumber);
            end
        end
        function selfconnectivity_type = getSelfConnectivityType(varargin)
            % GETSELFCONNECTIVITYTYPE returns the self-connectivity type of the graph
            %
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE() returns
            % Graph.SELFCONNECTED.
            %
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(LAYERNUMBER) returns
            % a matrix with Graph.SELFCONNECTED for all the elements.
            % For example, for the default matrix it returns:
            % NEGATIVITY_TYPE = SELFCONNECTED  SELFCONNECTED  SELFCONNECTED
            %                   SELFCONNECTED  SELFCONNECTED  SELFCONNECTED
            %                   SELFCONNECTED  SELFCONNECTED  SELFCONNECTED
            % where SELFCONNECTED = Graph.SELFCONNECTED.
            % If LAYERNUMBER is not three, it throws an error.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getNegativityType.
            
            if isempty(varargin)
                selfconnectivity_type = Graph.SELFCONNECTED;
            else
                layernumber = varargin{1};
                
                assert(layernumber == 3, ...
                    [BRAPH2.STR ':DummyOrderedMultilayer:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyOrderedMultilayer must be three,' ...
                    ' while it is ' tostring(layernumber)])
                
                selfconnectivity_type = Graph.SELFCONNECTED * ones(layernumber);
            end
        end
        function negativity_type = getNegativityType(varargin)
            % GETNEGATIVITYTYPE returns the negativity type of the graph
            %
            % NEGATIVITY_TYPE  = GETNEGATIVITYTYPE() returns Graph.NONNEGATIVE.
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(LAYERNUMBER) returns
            % a matrix with Graph.NONNEGATIVE for all the elements.
            % For example, for the default matrix it returns:
            % NEGATIVITY_TYPE = NONNEGATIVE  NONNEGATIVE  NONNEGATIVE  NONNEGATIVE
            %                   NONNEGATIVE  NONNEGATIVE  NONNEGATIVE  NONNEGATIVE
            %                   NONNEGATIVE  NONNEGATIVE  NONNEGATIVE  NONNEGATIVE
            %                   NONNEGATIVE  NONNEGATIVE  NONNEGATIVE  NONNEGATIVE
            % where NONNEGATIVE = Graph.NONNEGATIVE.
            % If LAYERNUMBER is not three, it throws an error.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getSelfConnectivityType.
            
            if isempty(varargin)
                negativity_type = Graph.NONNEGATIVE;
            else
                layernumber = varargin{1};
                
                assert(layernumber == 3, ...
                    [BRAPH2.STR ':DummyOrderedMultilayer:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyOrderedMultilayer must be three,' ...
                    ' while it is ' tostring(layernumber)])
                
                negativity_type =  Graph.NONNEGATIVE * ones(layernumber);
            end
        end
    end
    methods (Static)
        function gr = randomize_A(g, varargin)
            % RANDOMIZE returns a the graph unchanged for DummyOrderedMultilayer
            %
            % GR = RANDOMIZE(G) returns a the graph unchanged for
            % DummyOrderedMultilayer. Utilizes available graph settings.
            
            A = g.getA(); % get A, which is left unchanged
            gr = Graph.getGraph(Graph.getClass(g), A, g.getSettings());
        end
    end
    methods
        function gr = randomize(g, varargin)
            A = g.getA(); % get A, which is left unchanged
            gr = Graph.getGraph(Graph.getClass(g), A, g.getSettings());
        end
    end
end
