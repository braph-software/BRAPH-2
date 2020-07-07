classdef DummyOrderedMultiplex < Graph
    % DummyOrderedMultiplex An Ordered Multiplex graph
    % DummyOrderedMultiplex represents an ordered multiplex graph.
    %
    % DummyOrderedMultiplex is constituted by two binary directed graphs and
    % one weighted directed graph. Thus, it only accepts a number of layers
    % equal to three. It is a sequence of layers with ordinal connections.
    %
    % DummyOrderedMultiplex methods:
    %   DummyOrderedMultiplex   - constructor
    %
    % DummyOrderedMultiplex descriptive methods (static):
    %   getClass                - returns the class name
    %   getName                 - returns the complete name
    %   getDescription          - returns the description
    %   getGraphType            - returns the graph type
    %   getConnectivityType     - returns if the graph is binary or weighted
    %   getDirectionalityType   - returns if graph is directed or undirected
    %   getSelfConnectivityType - returns if graph is self-connected or not self-connected
    %   getNegativityType       - returns if graph is negative or non-negative
    %   getCompatibleMeasureList - returns a list with compatible measures
    %   getCompatibleMeasureNumber - returns the number of compatible measures
    %
    % Graph randomization method (static):
    %   randomize               - randomize graph
    % 
    % See also Graph, DummyGraph, DummyMultigraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultilayer.
    
    methods  % Constructor
        function g = DummyOrderedMultiplex(A, varargin)
            % DUMMYORDEREDMULTIPLEX() creates a DUMMYORDEREDMULTIPLEX class
            % with a default supra-adjacency matrix A:
            % A =   BD(4) D(4)  []  
            %       D(4)  BD(4) D(4)  
            %       []    D(4)  WD(4) 
            % where all weights are initialized randomly and
            %       WD(4) = weighted directed 4 x 4 with weights in [0, 1]
            %       BD(4) = binary directed 4 x 4 with weights in 0 or 1
            %       D(4) = diagonal 4 x 4 with weights in [0, 1] 
            %
            % DUMMYORDEREDMULTIPLEX(A) creates a DUMMYORDEREDMULTIPLEX 
            % class with supra-adjacency matrix A.
            % It throws an error if the number of layers of A is not three.
            % It calls the constructor of Graph.
            %
            % DUMMYORDEREDMULTIPLEX(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % initializes DUMMYMULIPLEX with the properties and values
            % PROPERTY1, VALUE1, PROPERTY2, VALUE2, ... 
            %
            % See also Graph, DummyGraph, DummyMultigraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultilayer.
                     
            if isempty(A)
                A = {
                    round(rand(4))          round(diag(rand(4, 1)))     {} 
                    round(diag(rand(4, 1))) round(rand(4))              round(diag(rand(4, 1)))    
                    {}                      round(diag(rand(4, 1)))     rand(4)             
                };
            end
            
            assert(length(A) == 3, ...
                [BRAPH2.STR ':DummyOrderedMultiplex:' BRAPH2.WRONG_INPUT], ...
                ['The number of layers for DummyOrderedMultiplex must be three,' ...
                ' while it is ' tostring(length(A))])
                
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'DummyOrderedMultiplex'.
            %
            % See also getName, getDescription.
            
            graph_class = 'DummyOrderedMultiplex';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Dummy Ordered Multiplex'.
            %
            % See also getClass, getDescription.
            
            name = 'Dummy Ordered Multiplex';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of DUMMYORDEREDMULTIPLEX.
            %
            % See also getClass, getName.
            
            description = [ ...
                'Dummy ordered multiplex used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns Graph.ORDERED_MULTIPLEX.
            %
            % See also getConnectivityType, getDirectionalityType, getNegativityType, getSelfConnectivityType.

            graph_type = Graph.ORDERED_MULTIPLEX;
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
                    [BRAPH2.STR ':DummyOrderedMultiplex:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyOrderedMultiplex must be three,' ...
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
                    [BRAPH2.STR ':DummyOrderedMultiplex:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyOrderedMultiplex must be three,' ... 
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
                    [BRAPH2.STR ':DummyOrderedMultiplex:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyOrderedMultiplex must be three,' ... 
                    ' while it is ' tostring(layernumber)])
                
                negativity_type =  Graph.NONNEGATIVE * ones(layernumber);
            end       
        end
    end
    methods
        function gr = randomize(g, varargin)
                     
            A = g.getA(); % get A, which is left unchanged
            gr = Graph.getGraph(Graph.getClass(g), A, g.getSettings());
        end
    end
end
