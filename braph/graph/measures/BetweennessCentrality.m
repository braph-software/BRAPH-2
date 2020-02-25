classdef BetweennessCentrality < Measure
    methods
        function m = BetweennessCentrality(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function bc = calculate(m)
            g = m.getGraph(); 
            A = g.getA();
            
            if isa(g, 'GraphBD') || isa(g, 'GraphBU')
                
                N = size(A,1);      % number of nodes
                I = eye(N)~=0;      % logical identity matrix
                path_length_d = 1;  % start path length
                NPd = A;            % number of paths of length |d|
                NSPd = NPd;         % number of shortest paths of length |d|
                NSP = NSPd;         % number of shortest paths of any length
                NSP(I) = 1;    
                L = NSPd;           % length of shortest paths
                L(I) = 1;     
                
                % Forward pass: Compute the distance (L) and the number of 
                % shortest paths (NSP) between all pairs
                % Compute Path Count:
                while find(NSPd,1)
                    path_length_d = path_length_d + 1;
                    NPd = NPd*A;        % Index value corresponds to number of paths found of length d+1
                    NSPd = NPd.*(L==0);
                    NSP = NSP + NSPd;               % Add new found shortest paths
                    L = L+path_length_d.*(NSPd~=0); % Add new found shortest paths' distance
                end
                
                L(~L) = inf; L(I) = 0;      % Lenght for disconnected vertices is inf
                NSP(~NSP) = 1;              % NSP for disconnected vertices is 1
                
                % Backward pass: compute the dependencies (DP)
                DP = zeros(N);            	% vertex on vertex dependency
                diam = path_length_d-1;     % graph diameter

                for path_length_d = diam:-1:2       % L == path_length_d is zero for path_length_d = diam
                    DPd1 = (((L==path_length_d).*(1+DP)./NSP)*(A.')).*((L==(path_length_d-1)).*NSP);
                    DP = DP + DPd1;           %DPd1: dependencies on vertices |d-1| from source        
                end
                
                bc = sum(DP,1);         % compute betweenness
                bc = bc';
                
            % Weighted graphs WU and WD
            elseif isa(g, 'GraphWU') || isa(g, 'GraphWD')  
                N = size(A,2);      % number of nodes
                E = find(A); 
                A(E) = 1./A(E);     % invert weights
                bc = zeros(N,1);    % init vertex betweenness

                % Compute the distances and number of 
                % shortest paths between all pairs of vertices
                for u = 1:N             %One search for each source vertex u
                    D = inf(1,N);       
                    D(u) = 0;           % distance from u
                    NP = zeros(1,N);    
                    NP(u) = 1;          % number of paths from u
                    S = true(1,N);      % distance permanence S (true is temporary)
                    P = false(N);       % predecessors P
                    Q = zeros(1,N);     % order of non-increasing distance
                    q = N;  
                    G = A;              % graph G
                    V = u;              % set of nodes (V) of graph G
                    
                    % Forward pass: 
                    % Compute the shortest paths
                    % from the source u to all the other nodes in V
                    while 1
                        S(V) = 0;       % distance u->V is now permanent
                        G(:,V) = 0;    % no in-edges as already shortest
                        for v = V
                            Q(q) = v; 
                            q = q-1;
                            neighbours = find(G(v,:));     % neighbours of v
                            for neighbour = neighbours
                                Duw = D(v)+ G(v,neighbour);        % Duw path length to be tested
                                if Duw<D(neighbour)                 % if new u->w shorter than old
                                    D(neighbour) = Duw;
                                    NP(neighbour) = NP(v);          % NP(u->w) = NP of new path
                                    P(neighbour,:) = 0;
                                    P(neighbour,v) = 1;             % v is the only predecessor
                                elseif Duw==D(neighbour)            % if new u->w equal to old
                                    NP(neighbour) = NP(neighbour)+NP(v);    % NP(u->w) sum of old and new
                                    P(neighbour,v) = 1;             % v is also a predecessor
                                end
                            end
                        end

                        minD = min(D(S));                   % shortest distance
                        if isempty(minD), break             % all nodes reached, or
                        elseif isinf(minD)                  % some cannot be reached:
                            Q(1:q) = find(isinf(D)); break  % ...these are first-in-line
                        end
                        V = find(D==minD);                  
                    end
                    
                    % Compute dependencies (DP)
                    DP = zeros(N,1);  
                    for n = Q(1:N-1)           
                        bc(n) = bc(n)+DP(n);                            % update betweenness 
                        for v = find(P(n,:))
                            DP(v) = DP(v)+(1+DP(n)).*NP(v)./NP(n);      % dependency
                        end
                    end
                end
            end
            bc = bc/((N-1)*(N-2));  % Normalize betweenness
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'BetweennessCentrality';
        end
        function name = getName()
            name = 'Betweenness-Centrality';
        end
        function description = getDescription()
            description = [ ...
                'The betweenness centrality of a graph is ' ...
                'the fraction of all shortest paths in the ' ...
                'graph that pass through a given node. ' ...
                'Nodes with high values of betweenness centrality ' ...
                'participate in a large number of shortest paths. ' ...
                ];
        end
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function bool = is_binodal()
            bool = false;
        end
        function list = getCompatibleGraphList()
            list = { ...
                'GraphBD', ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('BetweennessCentrality');
        end
    end
end
