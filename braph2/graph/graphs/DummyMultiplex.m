classdef DummyMultiplex < Graph

    methods  % Constructor
        function g = DummyMultiplex(A, varargin)
            
            if isempty(A)
                A = {
                    symmetrize(rand(4))     round(diag(rand(4, 1)))     round(diag(rand(4, 1)))     round(diag(rand(4, 1)))
                    round(diag(rand(4, 1))) symmetrize(rand(4))         round(diag(rand(4, 1)))     round(diag(rand(4, 1)))
                    round(diag(rand(4, 1))) round(diag(rand(4, 1)))     round(rand(4))              round(diag(rand(4, 1)))
                    round(diag(rand(4, 1))) round(diag(rand(4, 1)))     round(diag(rand(4, 1)))     round(rand(4))
                };
            end
            
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
            graph_type = Graph.MULTIPLEX;
        end
        function connectivity_type = getConnectivityType(varargin)
            % GETCONNECTIVITYTYPE checks if the graph is binary or weighted
            %
            % BOOL = GETCONNECTIVITYTYPE() returns NONNEGATIVE for DUMMYMULTIPLEX.
            %
            % See also getDirectionalityType(), getGraphType(), getNegativityType() and getSelfConnectivityType().
                  
            if isempty(varargin)
                layernumber = 2;
            else
                layernumber = varargin{1};
            end
            
            assert(mod(layernumber, 2) == 0, ...
                [BRAPH2.STR ':DummyMultiplex:' BRAPH2.WRONG_INPUT], ...
                ['The number of layers for DummyMultiplex must be even,' ... 
                ' while it is ' int2str(layernumber)])
            
            connectivity_type = Graph.BINARY * ones(layernumber);
            connectivity_type(1:length(connectivity_type)+1:layernumber.^2 / 2) = Graph.WEIGHTED;       
        end
        function directionality_type = getDirectionalityType(varargin)
            % GETDIRECTIONALITYTYPE checks if the graph is directed or undirected
            %
            % BOOL = GETDIRECTIONALITYTYPE() returns NONNEGATIVE for DUMMYMULTIPLEX.
            %
            % See also getConnectivityType(), getGraphType(), getNegativityType() and getSelfConnectivityType().
                       
            if isempty(varargin)
                layernumber = 1;
            else
                layernumber = varargin{1};
                assert(mod(layernumber, 2) == 0, ...
                    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.WRONG_INPUT], ...
                    ['The number of layers for DummyMultiplex must be even,' ... 
                    ' while it is ' tostring(layernumber)])
            end
            
            directionality_type = Graph.DIRECTED * ones(layernumber);
            directionality_type(1: length(directionality_type)+1: layernumber/2*(length(directionality_type)+1)) = Graph.UNDIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType(varargin)
            % GETSELFCONNECTIVITYTYPE checks if the graph is self-connected or not
            %
            % BOOL = GETSELFCONNECTIVITYTYPE() returns NONNEGATIVE for DUMMYMULTIPLEX.
            %
            % See also getConnectivityType(), getDirectionalityType(), getGraphType() and getNegativityType().
                      
            if isempty(varargin)
                layernumber = 1;
            else
                layernumber = varargin{1};
            end
            
            selfconnectivity_type = Graph.SELFCONNECTED * ones(layernumber);
        end
        function negativity_type = getNegativityType(varargin)
            % GETNEGATIVITYTYPE checks if the graph is non-negative or negative
            %
            % BOOL = GETNEGATIVITYTYPE() returns NONNEGATIVE for DUMMYMULTIPLEX.
            %
            % See also getConnectivityType(), getDirectionalityType(), getGraphType() and getSelfConnectivityType().
            
            if isempty(varargin)
                layernumber = 1;
            else
                layernumber = varargin{1};
            end
            
            negativity_type =  Graph.NONNEGATIVE * ones(layernumber);
        end
    end
end