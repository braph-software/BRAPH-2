classdef MultiplexClusteringAv < MultiplexClustering
    % MultiplexClusteringAv Average multiplex clustering measure
    % MultiplexClusteringAv provides the average multiplex clustering of a network 
    % for binary undirected (BU) and weighted undirected (WU) multiplexes.
    %
    % It is calculated as the average of the multiplex clustering coefficients of all 
    % nodes within a multilayer network. 
    % 
    % MultiplexClusteringAv methods:
    %   MultiplexClusteringAv       - constructor 
    % 
    % MultiplexClusteringAv methods (Static)
    %   getClass                    - returns the average multiplex clustering class
    %   getName                     - returns the name of average multiplex clustering measure
    %   getDescription              - returns the description of average multiplex clustering measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the average multiplex clustering class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, MultiplexClustering, MultiplexTriangles, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = MultiplexClusteringAv (g, varargin)
            % MULTIPLEXCLUSTERINGAV(G) creates average multiplex clustering with default properties.
            % G is a multiplex (e.g, an instance of MultiplexGraphBU
            % or MultiplexGraphWU).  
            %
            % See also Measure, MultiplexClustering, MultiplexTriangles, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@MultiplexClustering(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multiplex_clustering_av = calculate(m)
            % CALCULATE calculates the average multiplex clustering value a multiplex or multilayer graph
            %
            % MULTIPLEXCLUSTERINGAV = CALCULATE(M) returns the value of the average 
            % multiplex clustering of a multiplex or multilayer graph.
            %
            % See also Measure, MultiplexClustering, MultiplexTriangles, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('MultiplexClustering')
                multiplex_clustering = g.getMeasureValue('MultiplexClustering');
            else
                multiplex_clustering = calculate@MultiplexClustering(m);
            end
            
            multiplex_clustering_av = cell(g.layernumber(), 1);
            for li = 1:1:length(multiplex_clustering_av)
                multiplex_clustering_av(li) = {mean(multiplex_clustering{li})};
            end
        end
    end  
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average multiplex clustering measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'MultiplexClusteringAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average multiplex clustering measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average multiplex clustering';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average multiplex clustering description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average multiplex clustering measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average multiplex clustering of a multiplex or multilayer graph is' ...
                'the average of the multiplex clustering coefficients.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultiplexClusteringAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultiplexClusteringAv. Empty array in this case. 
            % 
            % See also getCompatibleGraphList()

            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultiplexClusteringAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average multiplex clustering measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultiplexClusteringAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average multiplex clustering measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of MultiplexClusteringAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average multiplex clustering measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with MultiplexClusteringAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average multiplex clustering. 
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
            % graphs with MultiplexClusteringAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average multiplex clustering.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('MultiplexClusteringAv');
        end
    end  
end