classdef ClusteringAv < Clustering
    % ClusteringAv Average clustering measure
    % ClusteringAv provides the average clustering of a graph for binary
    % undirected (BU), binary directed (BD), weighted undirected (WU) and 
    % weighted directed (WD) graphs. 
    %
    % It is calculated as the average of the clustering coefficients of all 
    % nodes within a layer. 
    % 
    % ClusteringAv methods:
    %   ClusteringAv                - constructor
    %
    % ClusteringAv descriptive methods (Static)
    %   getClass                    - returns the average clustering class
    %   getName                     - returns the name of average clustering measure
    %   getDescription              - returns the description of average clustering measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the average degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Clustering, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = ClusteringAv(g, varargin)
            % CLUSTERINGAV(G) creates average clustering with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU, GraphWD,
            % GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU). 
            %
            % CLUSTERINGAV(G, 'DirectedTrianglesRule', DIRECTEDTRIANGLESRULE)  
            % creates average clustering measure and initializes the property 
            % DirectedTrianglesRule with DIRECTEDTRIANGLESRULE. 
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
            % CLUSTERINGAV(G, 'VALUE', VALUE) creates average clustering, 
            % and sets the value to VALUE. G is a graph (e.g, an instance 
            % of GraphBD, GraphBU, GraphWD, GraphWU, MultiplexGraphBD, 
            % MultiplexGraphBU, MultiplexGraphWD or MultiplexGraphWU). 
            %   
            % See also Measure, Clustering, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.

            m = m@Clustering(g, varargin{:});
        end
    end
    methods (Access=protected)
        function clustering_av = calculate(m)
            % CALCULATE calculates the average clustering value of a graph
            %
            % CLUSTERINGAV = CALCULATE(M) returns the value of the average clustering 
            % of a graph or multiplex.
            %
            % See also Measure, Clustering, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Clustering')
                clustering = g.getMeasureValue('Clustering');
            else
                clustering = calculate@Clustering(m);
            end
            
            clustering_av = cell(g.layernumber(), 1);
            for li = 1:1:length(clustering_av)
                clustering_av(li) = {mean(clustering{li})};
            end
        end
    end
    methods(Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average
            % clustering measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'ClusteringAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average clustering measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average clustering';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average clustering description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average clustering measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The average clustering of a graph is ' ...
                'the average of the clustering coefficients of all nodes within a layer. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % ClusteringAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to ClusteringAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = getAvailableSettings@Triangles();
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of ClusteringAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average clustering measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of ClusteringAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average clustering measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList() 
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with ClusteringAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average clustering. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBD' ...
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
            % graphs with ClusteringAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average clustering .
            % 
            % See also getCompatibleGraphList.
                      
            n = Measure.getCompatibleGraphNumber('ClusteringAv');
        end
    end
end
