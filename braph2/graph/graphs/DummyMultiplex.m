classdef DummyMultiplex < Graph
    % DummyMultiplex A Multiplex graph
    % DummyMultiplex represents a multiplex graph.
    %
    % DummyMultiplex is constituted by pairs of weighted undirected and
    % binary directed graphs. Thus, it only accepts even number of layers:
    % The first half of layers are weighted undirected graphs;
    % and the second half binary directed.
    % The connections between layers are binary directed.
    %
    % DummyMultiplex methods:
    %   DummyMultiplex          - constructor
    %
    % DummyMultiplex descriptive methods (static):
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
    % See also Graph, DummyGraph, DummyMultigraph, DummyMultilayer, DummyOrderedMultilayer, DummyOrderedMultiplex.
    
    methods  % Constructor
        function g = DummyMultiplex(A, varargin)
            % DUMMYMULTIPLEX() creates a DUMMYMULTIPLEX class with a
            % default supra-adjacency matrix A:
            % A =   WU(4) D(4)  D(4)  D(4)
            %       D(4)  WU(4) D(4)  D(4)
            %       D(4)  D(4)  BD(4) D(4)
            %       D(4)  D(4)  D(4)  BD(4)
            % where all weights are initialized randomly and
            %       WU(4) = weighted undirected 4 x 4 with weights in [0, 1]
            %       BD(4) = binary directed 4 x 4 with weights in 0 or 1
            %       D(4) = diagonal 4 x 4 with weights in [0, 1]
            %
            % DUMMYMULTIPLEX(A) creates a DUMMYMULTIPLEX class with supra-adjacency matrix A.
            % It throws an error if the number of layers of A is not even.
            % It calls the constructor of Graph.
            %
            % DUMMYMULTIPLEX(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % initializes DUMMYMULIPLEX with the properties and values
            % PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...
            %
            % See also Graph, DummyGraph, DummyMultigraph, DummyMultilayer, DummyOrderedMultilayer, DummyOrderedMultiplex.
            
            if isempty(A)
                A = {
                    symmetrize(rand(4))     round(diag(rand(4, 1))) round(diag(rand(4, 1)))	round(diag(rand(4, 1)))
                    round(diag(rand(4, 1))) symmetrize(rand(4)) 	round(diag(rand(4, 1)))	round(diag(rand(4, 1)))
                    round(diag(rand(4, 1))) round(diag(rand(4, 1)))	round(rand(4))          round(diag(rand(4, 1)))
                    round(diag(rand(4, 1))) round(diag(rand(4, 1)))	round(diag(rand(4, 1)))	round(rand(4))
                    };
            end
            
            assert(mod(length(A), 2) == 0, ...
                [BRAPH2.STR ':DummyMultiplex:' BRAPH2.WRONG_INPUT], ...
                ['The number of layers for DummyMultiplex must be even,' ...
                ' while it is ' tostring(length(A))])
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'DummyMultiplex'.
            %
            % See also getName, getDescription.
            
            graph_class = 'DummyMultiplex';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Dummy Multiplex'.
            %
            % See also getClass, getDescription.
            
            name = 'Dummy Multiplex';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of DUMMYMULTIPLEX.
            %
            % See also getClass, getName.
            
            description = [ ...
                'Dummy multiplex used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns Graph.MULTIPLEX.
            %
            % See also getConnectivityType, getDirectionalityType, getNegativityType, getSelfConnectivityType.
            
            graph_type = Graph.MULTIPLEX;
        end
        function connectivity_type = getConnectivityType(varargin)
            % GETCONNECTIVITYTYPE returns the connectivity type of the graph
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns Graph.WEIGHTED.
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(LAYERNUMBER) returns a
            % matrix with BINARY for the off-diagonal elements and the second
            % half of the diagonal; and WEIGHTED for the first half.
            % For example, for the default matrix it returns:
            % CONNECTIVITY_TYPE = WEIGHTED  BINARY      BINARY  BINARY
            %                     BINARY    WEIGHTED    BINARY  BINARY
            %                     BINARY    BINARY      BINARY  BINARY
            %                     BINARY    BINARY      BINARY  BINARY
            % where BINARY = Graph.BINARY and WEIGHTED = Graph.WEIGHTED.
            % If LAYERNUMBER is odd, it throws an error.
            %
            % See also Graph, getDirectionalityType, getGraphType, getNegativityType, getSelfConnectivityType.
            
            if isempty(varargin)
                connectivity_type = Graph.WEIGHTED;
            else
                layernumber = varargin{1};
                
                assert(mod(layernumber, 2) == 0, ...
                    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyMultiplex must be even,' ...
                    ' while it is ' int2str(layernumber)])
                
                connectivity_type = Graph.BINARY * ones(layernumber);
                connectivity_type(1:layernumber+1:layernumber.^2 / 2) = Graph.WEIGHTED;
            end
        end
        function directionality_type = getDirectionalityType(varargin)
            % GETDIRECTIONALITYTYPE returns the directionality type of the graph
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE() returns
            % Graph.DIRECTED.
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(LAYERNUMBER) returns
            % a matrix with DIRECTED for the off-diagonal elements and the second
            % half of the diagonal; and UNDIRECTED for the first half.
            % For example, for the default matrix it returns:
            % DIRECTIONALITY_TYPE = UNDIRECTED  DIRECTED      DIRECTED  DIRECTED
            %                       DIRECTED    UNDIRECTED    DIRECTED  DIRECTED
            %                       DIRECTED    DIRECTED      DIRECTED  DIRECTED
            %                       DIRECTED    DIRECTED      DIRECTED  DIRECTED
            % where DIRECTED = Graph.DIRECTED and UNDIRECTED = Graph.UNDIRECTED.
            % If LAYERNUMBER is odd, it throws an error.
            %
            % See also Graph, getConnectivityType, getGraphType, getNegativityType, getSelfConnectivityType.
            
            if isempty(varargin)
                directionality_type = Graph.DIRECTED;
            else
                layernumber = varargin{1};
                
                assert(mod(layernumber, 2) == 0, ...
                    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyMultiplex must be even,' ...
                    ' while it is ' tostring(layernumber)])
                
                directionality_type = Graph.DIRECTED * ones(layernumber);
                directionality_type(1:layernumber+1:layernumber.^2 / 2) = Graph.UNDIRECTED;
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
            % SELFCONNECTIVITY_TYPE = SELFCONNECTED  SELFCONNECTED  SELFCONNECTED  SELFCONNECTED
            %                         SELFCONNECTED  SELFCONNECTED  SELFCONNECTED  SELFCONNECTED
            %                         SELFCONNECTED  SELFCONNECTED  SELFCONNECTED  SELFCONNECTED
            %                         SELFCONNECTED  SELFCONNECTED  SELFCONNECTED  SELFCONNECTED
            % where SELFCONNECTED = Graph.SELFCONNECTED.
            % If LAYERNUMBER is odd, it throws an error.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getNegativityType.
            
            if isempty(varargin)
                selfconnectivity_type = Graph.SELFCONNECTED;
            else
                layernumber = varargin{1};
                
                assert(mod(layernumber, 2) == 0, ...
                    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyMultiplex must be even,' ...
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
            % If LAYERNUMBER is odd, it throws an error.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getSelfConnectivityType.
            
            if isempty(varargin)
                negativity_type = Graph.NONNEGATIVE;
            else
                layernumber = varargin{1};
                
                assert(mod(layernumber, 2) == 0, ...
                    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyMultiplex must be even,' ...
                    ' while it is ' tostring(layernumber)])
                
                negativity_type =  Graph.NONNEGATIVE * ones(layernumber);
            end
        end
    end
    methods (Static)
        function gr = randomize_A(g, varargin)
            % RANDOMIZE returns a the graph unchanged for DummyMultiplex
            %
            % GR = RANDOMIZE(G) returns a the graph unchanged for
            % DummyMultiplex. Utilizes available graph settings.
            
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
