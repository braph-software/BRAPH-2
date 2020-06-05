classdef DummyMultigraph < Graph
    % DummyMultigraph A Multigraph
    % DummyMultigraph represents a multigraph.
    %
    % DummyMultigraph is constituted by a collection of weighted directed
    % graphs that are not connected between each other. The graphs can be
    % of different size.
    % The connections between layers are empty matrices.
    %
    % DummyMultigraph methods:
    %   DummyMultigraph         - constructor
    %
    % DummyMultigraph descriptive methods (static):
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
    % See also Graph, DummyGraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultilayer, DummyOrderedMultiplex.
    
    methods  % Constructor
        function g = DummyMultigraph(A, varargin)
            % DUMMYMULTIGRAPH() creates a DUMMYMULTIGRAPH class with a
            % default supra-adjacency matrix A:
            % A =   WD(3) []  [] 
            %       []  WD(3) [] 
            %       []  []  WD(4) 
            % where all weights are initialized randomly and
            %       WD(3) = weighted directed 3 x 3 with weights in [0, 1]
            %       WD(4) = weighted directed 4 x 4 with weights in [0, 1]
            %
            % DUMMYMULTIGRAPH(A) creates a DUMMYMULTIGRAPH class with
            % supra-adjacency matrix A.
            % It calls the constructor of Graph.
            %
            % DUMMYMULTIGRAPH(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % initializes DUMMYMULTIGRAPH with the properties and values
            % PROPERTY1, VALUE1, PROPERTY2, VALUE2, ... 
            %
            % See also Graph, DummyGraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultilayer, DummyOrderedMultiplex.
                       
            if isempty(A)
                A = {
                rand(3)	{}      {}
                {}      rand(3) {}
                {}      {}      rand(4)
                };
            end
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'DummyMultigraph'.
            %
            % See also getName, getDescription.
            
            graph_class = 'DummyMultigraph';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Dummy Multigraph'.
            %
            % See also getClass, getDescription.
            
            name = 'Dummy Multigraph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of DUMMYMULTIGRAPH.
            %
            % See also getClass, getName.
            
            description = [ ...
                'Dummy Multipgraph used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns Graph.MULTIGRAPH.
            %
            % See also getConnectivityType, getDirectionalityType, getNegativityType, getSelfConnectivityType.
        
            graph_type = Graph.MULTIGRAPH;
        end
        function connectivity_type = getConnectivityType(varargin)
            % GETCONNECTIVITYTYPE returns the self-connectivity type of the graph
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns
            % Graph.WEIGHTED.
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(LAYERNUMBER) returns 
            % a matrix with Graph.WEIGHTED for all the elements.
            % For example, for the default matrix it returns:
            % CONNECTIVITY_TYPE = WEIGHTED  WEIGHTED  WEIGHTED
            %                     WEIGHTED  WEIGHTED  WEIGHTED  
            %                     WEIGHTED  WEIGHTED  WEIGHTED  
            % where WEIGHTED = Graph.WEIGHTED.
            %
            % See also Graph, getDirectionalityType, getGraphType, getNegativityType, getSelfConnectivityType.
                      
            if isempty(varargin)
                connectivity_type = Graph.WEIGHTED;
                
            else
                layernumber = varargin{1};
                connectivity_type = diag(Graph.WEIGHTED * ones(1, layernumber));
            end
            
        end
        function directionality_type = getDirectionalityType(varargin)
            % GETDIRECTIONALITYTYPE returns the self-connectivity type of the graph
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
            %
            % See also Graph, getConnectivityType, getGraphType, getNegativityType, getSelfConnectivityType.
                        
            if isempty(varargin)
                directionality_type = Graph.DIRECTED;
            else
                layernumber = varargin{1};
                directionality_type = diag(Graph.DIRECTED * ones(1, layernumber));
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
            % SELFCONNECTIVITY_TYPE = SELFCONNECTED  SELFCONNECTED  SELFCONNECTED  
            %                         SELFCONNECTED  SELFCONNECTED  SELFCONNECTED  
            %                         SELFCONNECTED  SELFCONNECTED  SELFCONNECTED 
            % where SELFCONNECTED = Graph.SELFCONNECTED.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getNegativityType.
                      
            if isempty(varargin)
                selfconnectivity_type = Graph.SELFCONNECTED;
            else
                layernumber = varargin{1};
                selfconnectivity_type = diag(Graph.SELFCONNECTED * ones(1, layernumber));
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
            % NEGATIVITY_TYPE = NONNEGATIVE  NONNEGATIVE  NONNEGATIVE  
            %                   NONNEGATIVE  NONNEGATIVE  NONNEGATIVE  
            %                   NONNEGATIVE  NONNEGATIVE  NONNEGATIVE 
            % where NONNEGATIVE = Graph.NONNEGATIVE.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getNegativityType.
                
            if isempty(varargin)
                negativity_type = Graph.NONNEGATIVE;
            else
                layernumber = varargin{1};
                negativity_type =  diag(Graph.NONNEGATIVE * ones(1, layernumber));
            end

        end
    end
end