classdef Distance < Measure
    % Distance Distance measure
    % Distance provides the distance of a graph for binary undirected (BU),
    % binary directed (BD), weighted undirected (WU) and weighted directed (WD)  
    % graphs. 
    %
    % It is calculated as the shortest path between all pairs of
    % nodes within a layer. 
    % 
    % Distance methods:
    %   Distance                    - constructor
    % 
    % Distance descriptive methods (Static)
    %   getClass                    - returns the distance class
    %   getName                     - returns the name of distance measure
    %   getDescription              - returns the description of distance measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the distance class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    properties (GetAccess=protected, SetAccess=protected)
        B  % number of edges matrix 
    end
    methods
        function m = Distance(g, varargin)
            % DISTANCE(G) creates distance with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU). 
            %
            % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
          
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)   
        function distance = calculate(m)
            % CALCULATE calculates the distance value of a graph
            %
            % DISTANCE = CALCULATE(M) returns the value of the distance of a
            % graph or multiplex.
            %
            % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            
            distance = cell(g.layernumber(), 1);
            connectivity_type =  g.getConnectivityType(g.layernumber());
            for li = 1:1:g.layernumber()
                
                if g.is_graph(g)
                    Aii = A;
                    connectivity_layer = connectivity_type;
                else
                    Aii = A{li, li};
                    connectivity_layer = connectivity_type(li, li);
                end
                
                if connectivity_layer == Graph.WEIGHTED  % weighted graphs
                    distance(li) = {m.getWeightedCalculation(Aii)};
                else  % binary graphs
                    distance(li) = {m.getBinaryCalculation(Aii)};
                end
            end       
        end
        function weighted_distance = getWeightedCalculation(m, A)
            % GETWEIGHTEDCALCULATION calculates the distance value of a weighted adjacency matrix
            %
            % WEIGHTED_DISTANCE = GETWEIGHTEDCALCULATION(M, A) returns the value of the distance of a
            % weighted adjacency matrix A.
            
            ind = A~=0;
            A(ind) = A(ind).^-1;
            n = length(A);
            D = inf(n);
            D(1:n+1:end) = 0;  % distance matrix
            B = zeros(n);  %#ok<PROPLC> % number of edges matrix
            
            for u = 1:n
                S = true(1, n);  % distance permanence (true is temporary)
                L1 = A;
                V = u;
                
                while 1
                    S(V) = 0;  % distance u->V is now permanent
                    L1(:, V) = 0;  % no in-edges as already shortest
                    
                    for v = V
                        T = find(L1(v, :));  % neighbours of shortest nodes
                        [d, wi] = min([D(u, T);D(u, v)+L1(v, T)]);
                        D(u, T) = d;  % smallest of old/new path lengths
                        ind = T(wi==2);  % indices of lengthened paths
                        B(u, ind) = B(u, v) + 1;  %#ok<PROPLC> % increment no. of edges in lengthened paths
                    end
                    
                    minD = min(D(u, S));
                    if isempty(minD) || isinf(minD)  % isempty: all nodes reached;
                        break  % isinf: some nodes cannot be reached
                    end
                    
                    V = find(D(u,:)==minD);
                end
            end
            m.B = B;  %#ok<PROPLC>
            weighted_distance = D;
        end
        function binary_distance = getBinaryCalculation(m, A)
            % GETBINARYCALCULATION calculates the distance value of a binary adjacency matrix
            %
            % BINARY_DISTANCE = GETBINARYCALCULATION(A) returns the
            % value of the distance of a binary adjacency matrix A.

            l = 1;  % path length
            D = A;  % distance matrix
            
            Lpath = A;
            Idx = true;
            while any(Idx(:))
                l = l+1;
                Lpath = Lpath * A;
                Idx = (Lpath ~= 0) & (D == 0);
                D(Idx) = l;
            end
            
            D(~D) = inf;  % assign inf to disconnected nodes
            binary_distance = dediagonalize(D);  % assign 0 to the diagonal
        end     
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the distance measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'Distance';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the distance measure.
            %
            % See also getClass, getDescription. 
          
            name = 'Distance';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the distance description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % distance measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The distance of a graph is ' ...
                'the shortest path between all pairs of nodes within a layer of the graph. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Distance
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Distance. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Distance
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of distance measure (BINODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Distance
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of distance measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of Distance
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of distance measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with Distance 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to distance. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBD', ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with Distance 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to distance.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('Distance');
        end
    end
end
