classdef ClusteringAv < Clustering
    % ClusteringAv < Clustering: Average clustering measure
    % ClusteringAv provides the average clustering of a graph for binary
    % undirected (BU), binary directed (BD), weighted undirected (WU) and 
    % weighted directed (WD) graphs. It is calculated as the average of the    
    % clustering coefficients of all nodes. 
    % 
    % ClusteringAv methods:
    %   ClusteringAv                - constructor with Clustering properties.
    %
    % ClusteringAv methods (Access=protected):
    %   calculate                   - calculates the average clustering coefficient of a graph.
    % 
    % ClusteringAv methods (Static)
    %   getClass                    - returns the average clustering class.
    %   getName                     - returns the name of average clustering measure.
    %   getDescription              - returns the description of average clustering measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average clustering measure is global.
    %   is_nodal                    - boolean, checks if average clustering measure is nodal.
    %   is_binodal                  - boolean, checks if average clustering measure if binodal.
    %   getMeasure                  - returns the average clustering class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Clustering, Triangles, Measure, Graph, Transitivity.
    
    methods
        function m = ClusteringAv(g, varargin)
            % CLUSTERINGAV(G) creates average clustering with default clustering properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % CLUSTERINGAV(G, 'DirectedTrianglesRule', DIRECTEDTRIANGLESRULE) creates average clustering             
            % measure and initializes the property DirectedTrianglesRule with DIRECTEDTRIANGLESRULE. 
            % Admissible RULE options are:
            % DIRECTEDTRIANGLESRULE = 'cycle' (default) - calculates CLUSTERING of a node using the cycle rule for directed graphs.
            %                    'all' - calculates CLUSTERING of a node
            %                    using the all rule for directed graphs.
            %                    'middleman' - calculates CLUSTERING of a
            %                    node using the middleman rule for directed graphs.
            %                    'in' - calculates CLUSTERING of a node
            %                    using the in rule for directed graphs.
            %                    'out' - calculates CLUSTERING of a node
            %                    using the out rule for directed graphs.
            % 
            % CLUSTERINGAV(G, 'VALUE', VALUE) creates average clustering, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Clustering, Triangles, Measure, Graph, Transitivity.
            
            m = m@Clustering(g, varargin{:});
        end
    end
    methods (Access=protected)
        function clustering_av = calculate(m)
            % CALCULATE calculates the average clustering of a graph
            %
            % CLUSTERINGAV = CALCULATE(M) returns the average of the clustering 
            % of a graph.
                      
            g = m.getGraph();
            
            if g.is_measure_calculated('Clustering')
                clustering = g.getMeasureValue('Clustering');
            else
                clustering = calculate@Clustering(m);
            end
            
            clustering_av = mean(clustering);
        end
    end
    methods(Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average clustering measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'ClusteringAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average clustering measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average Clustering';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average clustering description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average clustering measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average clustering of a graph is ' ...
                'the average of the clustering coefficients of all nodes. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % ClusteringAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Clustering. 
            % DIRECTEDTRIANGLESRULE = 'cycle' (default) - calculates CLUSTERING of a node using the cycle rule for directed graphs.
            %                    'all' - calculates CLUSTERING of a node
            %                    using the all rule for directed graphs.
            %                    'middleman' - calculates CLUSTERING of a
            %                    node using the middleman rule for directed graphs.
            %                    'in' - calculates CLUSTERING of a node
            %                    using the in rule for directed graphs.
            %                    'out' - calculates CLUSTERING of a node
            %                    using the out rule for directed graphs.
            % 
            % See also getCompatibleGraphList()

            available_settings = {
                'DirectedTrianglesRule', Constant.STRING, 'cycle', {'cycle', 'all', 'middleman', 'in', 'out'};
                };
        end
        function bool = is_global()
            % IS_GLOBAL checks if clustering average measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                                
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if clustering average measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal.
          
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if clustering average measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to ClusteringAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to ClusteringAv. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to ClusteringAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to ClusteringAv.
            % 
            % See also getCompatibleGraphList().
                       
            n = Measure.getCompatibleGraphNumber('ClusteringAv');
        end
    end
end
