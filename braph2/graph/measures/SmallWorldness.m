classdef SmallWorldness < PathLengthAv
    % SmallWorldness Small-worldness measure
    % SmallWorldness provides the small-worldness coefficient of a graph for  
    % binary undirected (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as the fraction of the clustering coefficient and 
    % average path length of the graph and the clustering coefficient and
    % average path length of 100 random graphs.
    % 
    % SmallWorldness methods:
    %   SmallWorldness              - constructor 
    %
    % SmallWorldness descriptive methods (Static)
    %   getClass                    - returns the small-worldness class
    %   getName                     - returns the name of small-worldness measure
    %   getDescription              - returns the description of small-worldness measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the small-worldness class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = SmallWorldness(g, varargin)
            % SMALLWORLDNESS(G) creates small-worldness with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU, 
            % MultiplexGraphBU or MultiplexGraphWU). 
            %
            % SMALLWORLDNESS(G, 'PathLengthRule', PATHLENGTHRULE) creates  
            % small-worldness measure and initializes the property PathLengthRule 
            % with PATHLENGTHRULE. 
            % Admissible PATHLENGTHRULE options are:
            % PATHLENGTHRULE = 'default' (default) - calculates PATHLENGTH 
            %                  with normal average
            %                  'subgraphs' - calculates PATHLENGTH of all
            %                  subgraphs.
            %                  'harmonic' - calculates PATHLENGTH with
            %                  harmonic average.
            %
            % SMALLWORLDNESS(G, 'VALUE', VALUE) creates average small-worldness, 
            % and sets the value to VALUE. G is a graph (e.g, an instance 
            % of GraphBU, GraphWU, MultiplexGraphBU or MultiplexGraphWU).
            %   
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@PathLengthAv(g, varargin{:});
        end
    end
    methods (Access = protected)
        function small_worldness = calculate(m)
            % CALCULATE calculates the small-worldness value of a graph
            %
            % GLOBALEFFICIENCY = CALCULATE(M) returns the value of the 
            % small-worldness of a graph.
            %
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class          
            L = g.layernumber();
            
            if g.is_measure_calculated('ClusteringAv')
                clustering_av = g.getMeasure('ClusteringAv').getValue();
            else
                clustering_av = ClusteringAv(g, g.getSettings()).getValue();
            end
            
            if g.is_measure_calculated('PathLengthAv')
                path_length_av = g.getMeasureValue('PathLengthAv');
            else
                path_length_av = calculate@PathLengthAv(m);
            end
            
            M = 100;  % number of random graphs
            clustering_av_random = cell(1,M);
            path_length_av_random = cell(1,M);        
            for r = 1:1:M
                g_random = g.randomize();
                
                if g_random.is_measure_calculated('ClusteringAv')
                    clustering_av_random(r) = {g_random.getMeasure('ClusteringAv').getValue()};
                else
                    clustering_av_random(r) = {ClusteringAv(g_random, g_random.getSettings()).getValue()};
                end
                
                if g_random.is_measure_calculated('PathLengthAv')
                    path_length_av_random(r) = {g_random.getMeasureValue('PathLengthAv')};
                else
                    path_length_av_random(r) = {calculate@PathLengthAv(m)};
                end
            end
            path_length_av_random = cellfun(@(x) cell2mat(x), path_length_av_random, 'UniformOutput', false);
            clustering_av_random = cellfun(@(x) cell2mat(x), clustering_av_random, 'UniformOutput', false);
            path_length_av_random = cell2mat(path_length_av_random);
            clustering_av_random = cell2mat(clustering_av_random);
            path_length_av_random = mean(path_length_av_random, 2);
            clustering_av_random = mean(clustering_av_random, 2);
            
            small_worldness = cell(L, 1);
            for li = 1:1:L
                small_worldness_layer = (clustering_av{li}/clustering_av_random(li)) / (path_length_av{li}/path_length_av_random(li));
%                 small_worldness_layer(isnan(small_worldness_layer)) = 0;  % Should return zeros, not NaN
                small_worldness(li) = {small_worldness_layer};
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the small-worldness measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'SmallWorldness';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the small-worldness measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Small-worldness';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the small-worldnessdescription 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % small-worldness measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The small-worldness coefficient is the fraction of the ' ...
                'clustering coefficient and average path length of each layer ' ...
                'and the clustering coefficient and average path length of 100 ' ...
                'random graphs.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the settings available to SmallWorldness.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to SmallWorldness. 
            % PATHLENGTHRULE = 'default' (default) - calculates PATHLENGTH
            %                  with normal average
            %                  'subgraphs' - calculates PATHLENGTH of all
            %                  subgraphs.
            %                  'harmonic' - calculates PATHLENGTH with
            %                  harmonic average.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = getAvailableSettings@PathLengthAv();
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of SmallWorldness
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of small-worldness measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of SmallWorldness
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of small-worldness measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of SmallWorldness
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of small-worldness measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with SmallWorldness 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to small-worldness. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...               
                'GraphBU', ...           
                'GraphWU' ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with SmallWorldness 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to small-worldness.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('SmallWorldness');
        end
    end
end