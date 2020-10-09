classdef MultiplexClustering < MultiplexTriangles
    % MultiplexClustering Multiplex clustering measure
    % MultiplexClustering provides the two multiplex clustering coefficient 
    % of a node for binary undirected (BU) and weighted undirected (WU) multiplex
    % and multilayer graphs.
    %
    % For each node i, it is calculated as the ratio between the number of 
    % two-multiplex triangles (triangles which use edges from two different layers)
    % with a vertex in node i and the number of one-triads centered in i. 
    % In formula:
    %
    % $$C_{i} = \frac{\sum_{\alpha} \sum_{\alpha' \neq \alpha}\sum_{j\neq i,m\neq i}(a_{ij}^{[\alpha]}a_{jm}^{[\alpha']}a_{mi}^{[\alpha]})}{(M-1)\sum_{\alpha} k_{i}^{[\alpha]}(k_{i}^{[\alpha]} - 1)}$$
    %
    % MultiplexClustering methods:
    %   MultiplexClustering         - constructor 
    % 
    % MultiplexClustering methods (Static)
    %   getClass                    - returns the multiplex clustering class
    %   getName                     - returns the name of multiplex clustering measure
    %   getDescription              - returns the description of multiplex clustering measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the multiplex clustering class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, MultiplexTriangles, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = MultiplexClustering (g, varargin)
            % MULTIPLEXCLUSTERING(G) creates multiplex clustering with default properties.
            % G is a multiplex (e.g, an instance of MultiplexGraphBU
            % or MultiplexGraphWU).  
            %
            % See also Measure, MultiplexTriangles, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@MultiplexTriangles(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multiplex_clustering = calculate(m)
            % CALCULATE calculates the multiplex clustering coefficient of a node
            %
            % MULTIPLEXCLUSTERING = CALCULATE(M) returns the coefficient of the multiplex
            % clustering of a node.
            %
            % See also Measure, MultiplexTriangles, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            L = g.layernumber();
            N = g.nodenumber();
            
            if g.is_measure_calculated('MultiplexTriangles')
                multiplex_triangles = g.getMeasureValue('MultiplexTriangles');
            else
                multiplex_triangles = calculate@MultiplexTriangles(m);
            end
            if g.is_measure_calculated('Degree')
                degree = g.getMeasureValue('Degree');
            else
                degree = Degree(g, g.getSettings()).getValue();
            end
                
            multiplex_clustering_degree = zeros(N(1), 1);
            for i=1:1:L-1
                k1 = degree{i};
                for j=i+1:1:L
                    k2 = degree{j};
                    multiplex_clustering_degree = multiplex_clustering_degree + (k1 .* (k1 - 1) + k2 .* (k2 - 1));
                end
            end
            multiplex_clustering = multiplex_triangles{1}./ ((L-1)*multiplex_clustering_degree);
            multiplex_clustering(isnan(multiplex_clustering)) = 0;  % Should return zeros, not NaN
            multiplex_clustering = {multiplex_clustering}; 
        end
    end  
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multiplex clustering measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'MultiplexClustering';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multiplex clustering measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Multiplex clustering';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multiplex clustering description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multiplex clustering measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The multiplex clustering coefficient of a node is the fraction' ...
                'of multiplex triangles present around a node between each pair of layers.' ...
                'The multiplex clustering coefficient is calculated as the ratio between' ...
                'the number of multiplex triangles present around a node and' ...
                'the maximum number of multiplex triangles that could possibly' ...
                'be formed around that node.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultiplexClustering
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultiplexClustering. Empty array in this case. 
            % 
            % See also getCompatibleGraphList()

            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultiplexClustering
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multiplex clustering measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultiplexClustering
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multiplex clustering measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of MultiplexClustering
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of multiplex clustering measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with MultiplexClustering 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multiplex clustering. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with MultiplexClustering 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to multiplex clustering.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('MultiplexClustering');
        end
    end  
end