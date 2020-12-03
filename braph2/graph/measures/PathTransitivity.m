classdef PathTransitivity < Measure
    % PathTransitivity Path transitivity measure
    % PathTransitivity provides the density of triangles that are
    % available along the shortest-paths between pairs of nodes for binary undirected (BU) graph. 
    % 
    % It is calculated as the density of triangles that are available along the
    % shortest-paths between all pairs of nodes within a layer.
    %
    % PathTransitivity methods:
    %   PathTransitivity            - constructor
    % 
    % PathTransitivity descriptive methods (Static)
    %   getClass                    - returns the path transitivity class
    %   getName                     - returns the name of path transitivity measure
    %   getDescription              - returns the description of path transitivity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the path transitivity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBU, MultiplexGraphBU.
    
    methods
        function m = PathTransitivity(g, varargin)
            % PATHTRANSITIVITY(G) creates path transitivity with default properties.
            % G is a graph (e.g, an instance of GraphBU, MultiplexGraphBU). 
            %  
            % See also Measure, GraphBU, MultiplexGraphBU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function path_transitivity = calculate(m)
            % CALCULATE calculates the path transitivity pairwise matrix of graph
            %
            % PATHTRANSITIVITY = CALCULATE(M) returns the value of the path transitivity pairwise matrix
            % of a binary undirected (BU) graph or multiplex.
            %
            % See also Measure, GraphBU, MultiplexGraphBU.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix (for graph) or 2D-cell array (for multiplex)
            N = g.nodenumber();
            L = g.layernumber();
            path_transitivity = cell(L, 1);
            for li = 1:1:L        
                path_transitivity_single = zeros(N(li),N(li));
                if(g.getConnectivityType() == Graph.BINARY)
                    if g.is_graph(g)
                        Aii = A;
                    else
                        Aii = A{li, li};
                    end
                    m = zeros(N(li),N(li));
                    for i=1:N(li)-1
                        for j=i+1:N(li)
                            x=0;
                            y=0;
                            z=0;
                            for k=1:N(li)
                                if Aii(i, k)~=0 && Aii(j, k)~=0 && k~=i && k~=j
                                    x = x + Aii(i, k) + Aii(j, k);
                                end
                                if k~=j
                                    y = y + Aii(i, k);
                                end
                                if k~=i
                                    z = z + Aii(j, k);
                                end
                            end
                            m(i,j) = x/(y+z);
                        end
                    end
                    m = m+m';
                    % Calculate hops and Pmat
                    SPL = Aii;  % Unweighted/Weighted shortest path-length matrix.
                    SPL(SPL == 0) = inf;
                    n = size(Aii,2);    
                    hops = double(Aii ~= 0);  % Number of edges in the shortest path matrix. 
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
                    n = length(Aii);
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
                        path_transitivity_single(i,j)=2*x/(K*(K-1));
                    end
                    end
                    path_transitivity_single = path_transitivity_single + path_transitivity_single';
                    path_transitivity_single(isnan(path_transitivity_single)) = 0; % Should return zeros, not NaN
                    path_transitivity(li) = {path_transitivity_single};
                else
                    path_transitivity(li) = {path_transitivity_single};
                end
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the path transitivity measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'PathTransitivity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the path transitivity measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Path transitivity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the path transitivity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % path transitivity measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The path transitivity of a graph is the density of ' ...
                'triangles that are available along the ' ...
                'shortest-paths between all pairs of nodes within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to PathTransitivity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to PathTransitivity. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of PathTransitivity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of path transitivity measure (BINODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of PathTransitivity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of path transitivity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of PathTransitivity
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of path transitivity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with PathTransitivity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to path transitivity. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBU', ...
                'GraphWU', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU', ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with PathTransitivity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to path transitivity.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('PathTransitivity');
        end
    end
end