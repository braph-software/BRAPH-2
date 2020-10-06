classdef MultiplexClustering < MultiplexTriangles
    % MultiplexClustering Multiplex clustering measure
    % MultiplexClustering provides the multiplex clustering coefficient of a node 
    % for binary undirected (BU) and weighted undirected (WU) multiplexes.
    %
    % It is calculated as the ratio between the number of multiplex triangles 
    % present around a node and the maximum number of multiplex triangles 
    % that could possibly be formed around that node between a layer.
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
            % MULTIPLEXCLUSTERING(G, 'MultiplexTrianglesLayers', MULTIPLEXTRIANGLESLAYERS)
            % creates multiplex clustering measure and initializes the property 
            % MultiplexTrianglesLayers with MULTIPLEXTRIANGLESLAYERS. 
            % Admissible RULE options are:
            % MULTIRPLEXTRIANGLESLAYERS = [1, 2] (default) - MULTIPLEXCLUSTERING  
            %                    layers' indexes will be set to 1 and 2.
            %                    values - MULTIPLEXCLUSTERING layers' indexes 
            %                    will be set to the values specified if the 
            %                    values are integers between 1 and the
            %                    number of layers.
            % 
            % MULTIPLEXCLUSTERING(G, 'VALUE', VALUE) creates multiplex clustering, and sets 
            % the value to VALUE. G is a multiplex (e.g, an instance of MultiplexGraphBU,
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
            % A = g.getA();  % adjacency matrix of the graph
            L = g.layernumber();
            
            if g.is_measure_calculated('MultiplexTriangles')
                multiplex_triangles = g.getMeasureValue('MultiplexTriangles');
            else
                multiplex_triangles = calculate@MultiplexTriangles(m);
            end
                
            multiplex_triangles_layers = get_from_varargin([1, 2], 'MultiplexTrianglesLayers', m.getSettings());
            assert(length(multiplex_triangles_layers) == 2, ...
                [BRAPH2.STR ':MultiplexClustering' BRAPH2.WRONG_INPUT], ...
                ['Multiplex clustering layers must contain the index of ' ...
                'two layers (' tostring(L) ') while it contains ' tostring(length(multiplex_triangles_layers))])
            assert(all(ismember(multiplex_triangles_layers, 1:L)), ...
                [BRAPH2.STR ':MultiplexClustering:' BRAPH2.WRONG_INPUT], ...
                ['Multiplex clustering layers indexes must be integers and be between 1 and the ' ...
                'number of layers (' tostring(L) ') while they are ' tostring(multiplex_triangles_layers)])   
            
            multiplex_clustering = cell(g.layernumber(), 1);
            if g.is_measure_calculated('Degree')
                degree = g.getMeasureValue('Degree');
            else
                degree = Degree(g, g.getSettings()).getValue();
            end
            
            degree_l1 = degree{multiplex_triangles_layers(1)};
            degree_l2 = degree{multiplex_triangles_layers(2)};
            multiplex_triangles = {diag(A11.^(1/3)*A22.^(1/3)*A11.^(1/3)) + diag(A22.^(1/3)*A11.^(1/3)*A22.^(1/3))};
            
            clustering_layer_l1 = 2 * multiplex_triangles{li} ./ (L-1)*(degree_l1{li} .* (degree_l1{li} - 1));
            clustering_layer_l2 = 2 * multiplex_triangles{li} ./ (L-1)*(degree_l2{li} .* (degree_l2{li} - 1));
            clustering_layer_l1(isnan(clustering_layer_l1)) = 0;  % Should return zeros, not NaN
            clustering_layer_l2(isnan(clustering_layer_l2)) = 0;  % Should return zeros, not NaN
            multiplex_clustering(li) = {clustering_layer_l1}; % cl1 or cl2
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
                'The multiplex clustering coefficient of a node is ' ...
                'the fraction of multiplex triangles present around a node between two layers.' ...
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
            % settings available to MultiplexClustering. 
            % MULTIRPLEXTRIANGLESLAYERS = [1, 2] (default) - MULTIPLEXCLUSTERING  
            %                    layers' indexes will be set to 1 and 2.
            %                    values - MULTIPLEXCLUSTERING layers' indexes 
            %                    will be set to the values specified if the 
            %                    values are integers between 1 and the
            %                    number of layers.
            % 
            % See also getCompatibleGraphList()

            available_settings = getAvailableSettings@Triangles();
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