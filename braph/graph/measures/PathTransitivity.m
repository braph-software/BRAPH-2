classdef PathTransitivity < Measure
    % PathTransitivity < Measure: PathTransitivity measure
    % Path Transitivity provides the density of triangles that are
    % available along the shortest-paths between pairs of nodes.
    % 
    % PathTransitivity methods:
    %   PathTransitivity            - constructor with Measure properties.
    %
    % PathTransitivity methods (Access=protected):
    %   calculate                   - calculates the path transitivity of a graph.
    % 
    % PathTransitivity methods (Static)
    %   getClass                    - returns the PathTransitivity class.
    %   getName                     - returns the name of PathTransitivity measure.
    %   getDescription              - returns the description of PathTransitivity measure.    
    %   getAvailableSettings        - returns the settings available to PathTransitivity measure.
    %   is_global                   - boolean, checks if PathTransitivity measure is global.
    %   is_nodal                    - boolean, checks if PathTransitivity measure is nodal.
    %   is_binodal                  - boolean, checks if PathTransitivity measure if binodal.
    %   getMeasure                  - returns the PathTransitivity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, EdgeNumberDistance,
    % EdgeBetweennessCentrality, Distance, Transitivity.
    
    methods
        function m = PathTransitivity(g, varargin)
            % PATHTRANSITIVITY(G) creates degree with default measure properties.
            % G is a graph (e.g, an instance of GraphBU)
            %   
            % See also Measure, Graph, EdgeNumberDistance, EdgeBetweennessCentrality, Distance, Transitivity.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function path_transitivity = calculate(m)
            % CALCULATE calculates the path transitivity pairwise matrix of
            % a graph
            %
            % PATH_TRANSITIVITY = CALCULATE(M) returns the path
            % transitivity pairwise matrix of a graph node.
            
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
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the
            % PathTransitivity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'PathTransitivity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the PathTransitivity
            % measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Path-Transitivity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the PathTransitivity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % PathTransitivity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The path transitivity of a graph is the density of ' ...
                'triangles that are available along the ' ...
                'shortest-paths between all pairs of nodes.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the settings available to
            % PathTransitivity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to PathTransitivity. Empty Array in this
            % case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global() 
            % IS_GLOBAL checks if PathTransitivity measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
                                   
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if PathTransitivity measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if PathTransitivity measure is binodal (true)
            %
            % BOOL = IS_BINODAL() returns true.
            %
            % See also is_global, is_nodal.
            
            bool = true;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to PathTransitivity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to PathTransitivity. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to PathTransitivity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to PathTransitivity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('PathTransitivity');
        end
    end
    
end