classdef BetweennessCentrality < Measure
    % BetweennessCentrality < Measure: Betweenness Centrality measure
    % BetweennessCentrality provides the betweenness centrality of a node for 
    % binary undirected (BU),  binary directed (BD), weighted undirected (WU) 
    % and weighted directed (WD) graphs. It is calculated as the fraction
    % of all shortest paths in the graph that pass through a node. Nodes
    % with high values of betweenness centrality participate in a large
    % number of shortest paths. 
    % 
    % BetweennessCentrality methods:
    %   BetweennessCentrality       - constructor with Measure properties.
    %
    % BetweennessCentrality methods (Access=protected):
    %   calculate                   - calculates the betweenness centrality of a node.
    % 
    % BetweennessCentrality methods (Static)
    %   getClass                    - returns the betweenness centrality class.
    %   getName                     - returns the name of betweenness centrality measure.
    %   getDescription              - returns the description of betweenness centrality measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if betweenness centrality measure is global.
    %   is_nodal                    - boolean, checks if betweenness centrality measure is nodal.
    %   is_binodal                  - boolean, checks if betweenness centrality measure if binodal.
    %   getMeasure                  - returns the betweenness centrality class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Degree, Strength, Distance.
    
    methods
        function m = BetweennessCentrality(g, varargin)
            % BETWEENNESSCENTRALITY(G) creates betweenness centrality with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % BETWEENNESSCENTRALITY(G, 'VALUE', VALUE) creates betweenness centrality, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Degree, Strength, Distance. 
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function betweenness_centrality = calculate(m)
            % CALCULATE calculates the betweenness centrality value of a
            % node.
            %
            % BETWEENNESSCENTRALITY = CALCULATE(M) returns the value of the betweenness centrality 
            % of a node.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix of the graph
            
            if isa(g, 'GraphBD') || isa(g, 'GraphBU')
                N = size(A, 1);  % number of nodes
                I = eye(N)~=0;  % logical identity matrix
                d = 1;  % start path length d
                NPd = A;  % number of paths of length |d|
                NSPd = NPd;  % number of shortest paths of length |d|
                NSP = NSPd;  % number of shortest paths of any length
                NSP(I) = 1;     
                L = NSPd;  % length of shortest paths
                L(I) = 1;     
                
                % Forward pass: Compute the distance (L) and the number of 
                % shortest paths (NSP) between all pairs
                % Compute Path Count:
                while find(NSPd, 1)
                    d = d + 1;
                    NPd = NPd*A;  % Index value corresponds to number of paths found of length d+1
                    NSPd = NPd.*(L==0);
                    NSP = NSP + NSPd;  % Add new found shortest paths
                    L = L+d.*(NSPd~=0);  % Add new found shortest paths' distance
                end 
                L(~L) = inf; L(I) = 0;  % Lenght for disconnected vertices is inf
                NSP(~NSP) = 1;  % NSP for disconnected vertices is 1
                
                % Backward pass: compute the dependencies (DP)
                DP = zeros(N);  % vertex on vertex dependency
                diam = d-1;  % graph diameter
                for d = diam:-1:2  % L == path_length_d is zero for path_length_d = diam
                    DPd1 = (((L==d).*(1+DP)./NSP)*(A.')).*((L==(d-1)).*NSP);
                    DP = DP + DPd1;  %DPd1: dependencies on vertices |d-1| from source        
                end
                betweenness_centrality = sum(DP, 1);  % compute betweenness
                betweenness_centrality = betweenness_centrality';
                
            % Weighted graphs WU and WD
            elseif isa(g, 'GraphWU') || isa(g, 'GraphWD')  
                N = size(A, 2);  % number of nodes
                E = find(A); 
                A(E) = 1./A(E);  % invert weights
                betweenness_centrality = zeros(N, 1);  % init vertex betweenness

                % Compute the distances and number of 
                % shortest paths between all pairs of vertices
                for u = 1:N  % One search for each source vertex u
                    D = inf(1, N);       
                    D(u) = 0;  % distance from u
                    NP = zeros(1, N);    
                    NP(u) = 1;  % number of paths from u
                    S = true(1, N);  % distance permanence S (true is temporary)
                    P = false(N);  % predecessors P
                    Q = zeros(1, N);  % order of non-increasing distance
                    q = N;  
                    G = A;  % graph G
                    V = u;  % set of nodes (V) of graph G
                    
                    % Forward pass: 
                    % Compute the shortest paths
                    % from the source u to all the other nodes in V
                    while 1
                        S(V) = 0;  % distance u->V is now permanent
                        G(:,V) = 0;  % no in-edges as already shortest
                        for v = V
                            Q(q) = v; 
                            q = q-1;
                            neighbours = find(G(v,:));  % neighbours of v
                            for neighbour = neighbours
                                Duw = D(v) + G(v, neighbour);  % Duw path length to be tested
                                if Duw<D(neighbour)  % if new u->w shorter than old
                                    D(neighbour) = Duw;
                                    NP(neighbour) = NP(v);  % NP(u->w) = NP of new path
                                    P(neighbour,:) = 0;
                                    P(neighbour, v) = 1;  % v is the only predecessor
                                elseif Duw==D(neighbour)  % if new u->w equal to old
                                    NP(neighbour) = NP(neighbour)+NP(v);  % NP(u->w) sum of old and new
                                    P(neighbour, v) = 1;  % v is also a predecessor
                                end
                            end
                        end
                        minD = min(D(S));  % shortest distance
                        if isempty(minD), break  % all nodes reached, or
                        elseif isinf(minD)  % some cannot be reached:
                            Q(1:q) = find(isinf(D)); break  % ...these are first-in-line
                        end
                        V = find(D==minD);                  
                    end
                    
                    % Compute dependencies (DP)
                    DP = zeros(N, 1);  
                    for n = Q(1:N-1)           
                        betweenness_centrality(n) = betweenness_centrality(n)+DP(n);  % update betweenness 
                        for v = find(P(n,:))
                            DP(v) = DP(v)+(1+DP(n)).*NP(v)./NP(n);  % dependency
                        end
                    end
                end
            end
            betweenness_centrality = betweenness_centrality/((N-1)*(N-2));  % Normalize betweenness
            betweenness_centrality(isnan(betweenness_centrality)) = 0; % Should return zeros, not NaN
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the betweenness centrality measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'BetweennessCentrality';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the betweenness centrality measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Betweenness-Centrality';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the betweenness centrality description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % betweenness centrality measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The betweenness centrality of a graph is ' ...
                'the fraction of all shortest paths in the ' ...
                'graph that pass through a given node. ' ...
                'Nodes with high values of betweenness centrality ' ...
                'participate in a large number of shortest paths. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to BetweennessCentrality
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to BetweennessCentrality. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if betweenness centrality measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if betweenness centrality measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if betweenness centrality measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to BetweennessCentrality 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to BetweennessCentrality. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD', ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to BetweennessCentrality 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to BetweennessCentrality.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('BetweennessCentrality');
        end
    end
end
