classdef DummyMultilayer < Graph
    % DummyMultilayer A Multilayer graph
    % DummyMultilayer represents a multilayer graph.
    %
    % DummyMultilayer is constituted by two directed binary graphs and a
    % third weighted directed graph.
    % Thus, it only accepts a number of layers equal to three.
    %
    % DummyMultilayer methods:
    %   DummyMultilayer     - constructor.
    %
    % DummyMultilayer descriptive methods (static):
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
    % See also Graph, DummyGraph, DummyMultigraph, DummyMultiplex, DummyOrderedMultilayer, DummyOrderedMultiplex.
    
    methods  % Constructor
        function g = DummyMultilayer(A, varargin)
            % DUMMYMULTILAYER() creates a DUMMYMULTILAYER class with a
            % default supra-adjacency matrix A:
            % A =   BD(4)       BD(4, 3)    WD(4, 2) 
            %       BD(3, 4)    BD(3)       BD(3, 2)  
            %       WD(2, 4)    BD(2, 3)    WD(2) 
            % where all weights are initialized randomly and
            %       WD(2) = weighted undirected 2 x 2 with weights in [0, 1]
            %       BD(4) = binary directed 4 x 4 with weights in 0 or 1
            %       BD(3) = binary directed 3 x 3 with weights in 0 or 1
            %
            % DUMMYMULTILAYER(A) creates a DUMMYMULTILAYER class with supra-adjacency matrix A.
            % It throws an error if the number of layers of A is not equal to three.
            % It calls the constructor of Graph.
            %
            % DUMMYMULTILAYER(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % initializes DUMMYMULTILAYER with the properties and values
            % PROPERTY1, VALUE1, PROPERTY2, VALUE2, ... 
            %
            % See also Graph, DummyGraph, DummyMultigraph, DummyMultiplex, DummyOrderedMultilayer, DummyOrderedMultiplex.
                        
            if isempty(A)
                A = {
                round(rand(4))      round(rand(4, 3))   randn(4, 2)
                round(rand(3, 4))   round(rand(3))      round(rand(3, 2))
                randn(2, 4)         round(rand(2, 3)) 	randn(2)
                };
            end
            
            assert(length(A) == 3, ...
                [BRAPH2.STR ':DummyMultilayer:' BRAPH2.WRONG_INPUT], ...
                ['The number of layers for DummyMultilayer must be three,' ...
                ' while it is ' tostring(length(A))])
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'DummyMultilayer'.
            %
            % See also getName(), getDescription().
            
            graph_class = 'DummyMultilayer';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Dummy Multilayer'.
            %
            % See also getClass(), getDescription().
            
            name = 'Dummy Multilayer';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of DUMMYMULTILAYER.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'Dummy Multilayer used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns Graph.MULTILAYER 
            %
            % See also getConnectivityType(), getDirectionalityType(), getNegativityType(), getSelfConnectivityType().

            graph_type = Graph.MULTILAYER;
        end
        function connectivity_type = getConnectivityType(varargin)
            % GETCONNECTIVITYTYPE returns the connectivity type of the graph
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns a 
            % matrix with BINARY for the first and second layers, and
            % WEIGHTED for the third layer.
            % It returns:
            % CONNECTIVITY_TYPE = BINARY    BINARY  WEIGHTED  
            %                     BINARY    BINARY  BINARY  
            %                     WEIGHTED  BINARY  WEIGHTED 
            % where BINARY = Graph.BINARY and WEIGHTED = Graph.WEIGHTED.
            %           
            % See also Graph, getDirectionalityType(), getGraphType(), getNegativityType(), getSelfConnectivityType().
                        
            connectivity_type = [ 
                Graph.BINARY    Graph.BINARY    Graph.WEIGHTED
                Graph.BINARY    Graph.BINARY    Graph.BINARY 
                Graph.WEIGHTED  Graph.BINARY    Graph.WEIGHTED
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
            %                   DIRECTED  DIRECTED  DIRECTED  
            %                   DIRECTED  DIRECTED  DIRECTED  
            % where DIRECTED = Graph.DIRECTED.
            % If LAYERNUMBER is not three, it throws an error.
            %            
            % See also Graph, getConnectivityType(), getGraphType(), getNegativityType(), getSelfConnectivityType().
             
            if isempty(varargin)
                directionality_type = Graph.DIRECTED;
            else
                layernumber = varargin{1};
                
                assert(layernumber == 3, ...
                    [BRAPH2.STR ':DummyMultilayer:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyMultilayer must be three,' ...
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
            % See also Graph, getConnectivityType(), getDirectionalityType(), getGraphType(), getNegativityType().
            
            if isempty(varargin)
                selfconnectivity_type = Graph.SELFCONNECTED;
            else
                layernumber = varargin{1};
                                
                assert(layernumber == 3, ...
                    [BRAPH2.STR ':DummyMultilayer:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyMultilayer must be three,' ... 
                    ' while it is ' tostring(layernumber)])
                   
                selfconnectivity_type = Graph.SELFCONNECTED * ones(layernumber);
            end
        end
        function negativity_type = getNegativityType(varargin)
            % GETNEGATIVITYTYPE returns the negativity type of the graph
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE() returns 
            % a matrix with Graph.NONNEGATIVE for the first and second
            % layers, and Graph.NEGATIVE for the third layer.
            % It returns:
            % NEGATIVITY_TYPE = NONNEGATIVE  NONNEGATIVE  NEGATIVE  
            %                   NONNEGATIVE  NONNEGATIVE  NONNEGATIVE  
            %                   NEGATIVE     NONNEGATIVE  NEGATIVE  
            % where NONNEGATIVE = Graph.NONNEGATIVE and NEGATIVE = Graph.NEGATIVE.
            %
            % See also Graph, getConnectivityType(), getDirectionalityType(), getGraphType(), getSelfConnectivityType().
          
            negativity_type = [ 
                Graph.NONNEGATIVE	Graph.NONNEGATIVE   Graph.NEGATIVE
                Graph.NONNEGATIVE   Graph.NONNEGATIVE   Graph.NONNEGATIVE 
                Graph.NEGATIVE      Graph.NONNEGATIVE   Graph.NEGATIVE
                ];
        end
    end
end