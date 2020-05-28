classdef DummyMultiplex < Graph
    % DummyMultiplex < Graph: A Multiplex graph
    % DummyMultiplex represents a multiplex graph formed by pairs of
    % GraphWU and GraphBD graphs.
    % It accepts even number of layers. The first half of layers are
    % weighted undirected graphs and the second half binary directed. If
    % the number of layers is not given, all layers will be weighted directed. 
    %
    % DummyMultiplex methods:
    %   DummyMultiplex     - constructor.
    %
    % DummyMultiplex methods (static):
    %   getClass	- return the class type DummyMultiplex.
    %   getName     - return the complete name of DummyMultiplex.
    %   getDescription  - return the description of DummyMultiplex.
    %   getGraphType    - returns the graph type.
    %   getConnectivityType     - returns if the graph is binary or weighted.
    %   getDirectionalityType   - returns if graph is directed or undirected.
    %   getSelfConnectivityType     - returns if graph is self-connected or not self-connected.
    %   getNegativityType   - returns if graph is negative or non-negative
    %   getCompatibleMeasureList - returns a list with compatible measures.
    %   getCompatibleMeasureNumber - returns the number of compatible measures.
    %
    % See also Graph, DummyMultigraph, DummyMultilayer, DummyOrderedMultigraph, DummyOrderedMultilayer.
    
    methods  % Constructor
        function g = DummyMultiplex(A, varargin)
            % DUMMYMULTIPLEX(A) creates a DUMMYMULTIPLEX class with supra-adjacency matrix A.
            % This function is the constructor, it initializes the class
            % with the 2D-cell array of adjacency matrices A.
            % It calls the superclass constructor GRAPH.
            %
            % DUMMYMULTIPLEX(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a DUMMYMULTIPLEX class with supra-adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN.
            % This function is the constructor, it initializes the class 
            % with the 2D-cell array of adjacency matrices A.
            % It calls the superclass constructor GRAPH.
            %
            % See also Graph, DummyMultigraph, DummyMultilayer, DummyOrderedMultigraph, DummyOrderedMultilayer.
                     
            if isempty(A)
                A = {
                    symmetrize(rand(4))     round(diag(rand(4, 1)))     round(diag(rand(4, 1)))     round(diag(rand(4, 1)))
                    round(diag(rand(4, 1))) symmetrize(rand(4))         round(diag(rand(4, 1)))     round(diag(rand(4, 1)))
                    round(diag(rand(4, 1))) round(diag(rand(4, 1)))     round(rand(4))              round(diag(rand(4, 1)))
                    round(diag(rand(4, 1))) round(diag(rand(4, 1)))     round(diag(rand(4, 1)))     round(rand(4))
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
            % See also getName().
            
            graph_class = 'DummyMultiplex';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Dummy Multiplex'.
            %
            % See also getClass().
            
            name = 'Dummy Multiplex';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of DUMMYMULTIPLEX.
            %
            % See also getName().
            
            description = [ ...
                'Dummy Multiplex used mainly' ...
                'for unit testing and debugging. ' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns MULTIPLEX for DUMMYMULTIPLEX.
            %
            % See also getConnectivityType(), getDirectionalityType(), getNegativityType() and getSelfConnectivityType().

            graph_type = Graph.MULTIPLEX;
        end
        function connectivity_type = getConnectivityType(varargin)
            % GETCONNECTIVITYTYPE returns the connectivity type of the graph
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns WEIGHTED for DUMMYMULTIPLEX.
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(LAYERNUMBER) returns BINARY 
            % for the first half of graphs and WEIGHTED for the second half for DUMMYMULTIPLEX.
            %           
            % See also getDirectionalityType(), getGraphType(), getNegativityType() and getSelfConnectivityType().
                  
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
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE() returns DIRECTED for DUMMYMULTIPLEX.
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(LAYERNUMBER) returns UNDIRECTED 
            % for the first half of graphs and DIRECTED for the second half for DUMMYMULTIPLEX.
            %
            % See also getConnectivityType(), getGraphType(), getNegativityType() and getSelfConnectivityType().
                       
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
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE() returns SELFCONNECTED for DUMMYMULTIPLEX.
            %
            % See also getConnectivityType(), getDirectionalityType(), getGraphType() and getNegativityType().
                      
            if isempty(varargin)
                selfconnectivity_type = Graph.SELFCONNECTED;
            else
                layernumber = varargin{1};
                selfconnectivity_type = Graph.SELFCONNECTED * ones(layernumber);
            end
        end
        function negativity_type = getNegativityType(varargin)
            % GETNEGATIVITYTYPE returns the negativity type of the graph
            %
            % NEGATIVITY_TYPE  = GETNEGATIVITYTYPE() returns NONNEGATIVE for DUMMYMULTIPLEX.
            %
            % See also getConnectivityType(), getDirectionalityType(), getGraphType() and getSelfConnectivityType().
            
            if isempty(varargin)
                negativity_type = Graph.NONNEGATIVE;
            else
                layernumber = varargin{1};
                negativity_type =  Graph.NONNEGATIVE * ones(layernumber);
            end       
        end
    end
end