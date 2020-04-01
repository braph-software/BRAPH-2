classdef PathTransitivity < Measure
    methods
        function m = PathTransitivity(g, varargin)
            
            settings = clean_varargin({}, varargin{:});
            
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access=protected)
        function path_transitivity = calculate(m)
            g = m.getGraph(); 
            A = g.getA();
            
            if isa(g, 'GraphBU')
                
                n = length(A);
                m = zeros(n,n);
                path_transitivity = zeros(n,n);
                for i=1:n-1
                    for j=i+1:n
                        x=0;
                        y=0;
                        z=0;
                        for k=1:n
                            if A(i, k)~=0 && A(j, k)~=0 && k~=i && k~=j
                                x = x + A(i, k) + A(j, k);
                            end
                            if k~=j
                                y = y + A(i, k);
                            end
                            if k~=i
                                z = z + A(j, k);
                            end
                        end
                        m(i,j) = x/(y+z);
                    end
                end
                m = m+m';
                % Calculate hops and Pmat
                SPL = A;  % Unweighted/Weighted shortest path-length matrix.
                SPL(SPL == 0) = inf;
                n = size(A,2);    
                hops = double(A ~= 0);  % Number of edges in the shortest path matrix. 
                Pmat = 1:n;  % Elements {i,j} of this matrix indicate the next node in the hortest path between i and j. 
                Pmat = Pmat(ones(n,1),:);
                for k = 1:n
                    i2k_k2j = bsxfun(@plus, SPL(:,k), SPL(k,:));
                    path = bsxfun(@gt, SPL, i2k_k2j);
                    [i,j] = find(path);
                    hops(path) = hops(i,k) + hops(k,j)';
                    Pmat(path) = Pmat(i,k);
                    SPL = min(SPL, i2k_k2j);
                end

                hops(eye(n)>0)=0;
                Pmat(eye(n)>0)=0;
                % Calculate path transitivity 
                n = length(A);
                for i=1:n-1
                    for j=i+1:n
                        x=0;
                        % Retrieve shortest path
                        s = i;
                        t = j;
                        path_length = hops(s,t);
                        if path_length ~= 0
                            path = nan(path_length+1,1);
                            path(1) = s;
                            for ind = 2:length(path)
                                s = Pmat(s,j);
                                path(ind) = t;
                            end
                        else
                            path = [];
                        end

                        K=length(path);

                        for t=1:K-1
                            for l=t+1:K
                                x=x+m(path(t),path(l));
                            end
                        end
                        path_transitivity(i,j)=2*x/(K*(K-1));
                    end
                end
                path_transitivity = path_transitivity + path_transitivity';
            end
        end
    end  
    methods (Static)
        function measure_class = getClass()
            measure_class = 'PathTransitivity';
        end
        function name = getName()
            name = 'Path-Transitivity';
        end
        function description = getDescription()
            description = [ ...
                'The path transitivity of a graph is the density of ' ...
                'triangles to that are available along the ' ...
                'shortest-paths between all pairs of nodes.' ...
                ];
        end
        function bool = is_global()                
            bool = false;
        end
        function bool = is_nodal()
            bool = false;
        end
        function bool = is_binodal()
            bool = true;
        end
        function list = getCompatibleGraphList()
            list = { ...
                'GraphBU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('PathTransitivity');
        end
    end
    
end