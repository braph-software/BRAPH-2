classdef Distance < Measure
    % Distance < Measure: Distance measure
    % Distance provides the distance of a graph for binary undirected (BU),
    % binary directed (BD), weighted undirected (WU) and weighted directed (WD)  
    % graphs. It is calculated as the shortest path between all pairs of
    % nodes in the graph. 
    % 
    % Distance methods:
    %   Distance                    - constructor
    %
    % Distance methods (Access=protected):
    %   calculate                   - calculates the distance of a graph
    % 
    % Distance methods (Static)
    %   getClass                    - returns the distance class
    %   getName                     - returns the name of distance measure
    %   getDescription              - returns the description of distance measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the distance class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Graph, Degree, Strength, PathLength.
    
    properties (GetAccess=protected, SetAccess=protected)
        B  % number of edges matrix 
    end
    methods
        function m = Distance(g, varargin)
            % DISTANCE(G) creates distance with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % DISTANCE(G, 'VALUE', VALUE) creates distance, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Degree, Strength, PathLength. 
          
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function D = calculate(m)
            % CALCULATE calculates the distance value of a graph
            %
            % DISTANCE = CALCULATE(M) returns the value of the distance of a
            % graph.
            
            g = m.getGraph();  % graph from measure class
            graph_class = g.getClass();
            A = g.getA();  % adjency matrix of the graph
            
            if isequal(graph_class, 'GraphWD') || isequal(graph_class, 'GraphWU')
                ind = A~=0;
                A(ind) = A(ind).^-1;
                n = length(A);
                D = inf(n);
                D(1:n+1:end) = 0;  % distance matrix
                B = zeros(n);  % number of edges matrix
                
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
                            B(u, ind) = B(u, v) + 1;  % increment no. of edges in lengthened paths
                        end
                        
                        minD = min(D(u, S));
                        if isempty(minD) || isinf(minD)  % isempty: all nodes reached;
                            break  % isinf: some nodes cannot be reached
                        end
                        
                        V = find(D(u,:)==minD);
                    end
                end
                m.B = B;
            else
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
                D = dediagonalize(D);  % assign 0 to the diagonal
            end
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
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The distance of a graph is ' ...
                'the shortest path between all pairs of nodes in the graph. ' ...
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
            % GETMEASUREFORMAT returns the measure format of distance
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of distance measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of distance
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of distance measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to Distance 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to Distance. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBD', ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
%                 'MultiplexGraphBD', ...
%                 'MultiplexGraphBU', ...
%                 'MultiplexGraphWD' ...
%                 'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to Distance 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to Distance.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('Distance');
        end
    end
end
