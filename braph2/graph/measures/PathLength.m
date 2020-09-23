classdef PathLength < Measure
    % PathLength Path length measure
    % PathLength provides the path length of a node for binary undirected (BU) 
    % and weighted undirected (WU) graphs. 
    %
    % It is calculated as the average shortest path length from one node 
    % to another node within a layer. The calculation of path length is 
    % controlled by the path length rule (setting 'PathLengthRule'), the
    % default option calculates the measure with normal average. 
    %    
    % PathLength methods:
    %   PathLength                  - constructor             
    % 
    % PathLength descriptive methods (Static)
    %   getClass                    - returns the path length class
    %   getName                     - returns the name of path length measure
    %   getDescription              - returns the description of path length measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the path length class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Distance, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = PathLength(g, varargin)
            % PATHLENGTH(G) creates path length with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU, 
            % MultiplexGraphBU or MultiplexGraphWU).
            %   
            % PATHLENGTH(G, 'PathLengthRule', PATHLENGTHRULE) creates path 
            % length measure and initializes the property PathLengthRule 
            % with PATHLENGTHRULE. 
            % Admissible PATHLENGTHRULE options are:
            % PATHLENGTHRULE = 'default' (default) - calculates PATHLENGTH 
            %                  with normal average
            %                  'subgraphs' - calculates PATHLENGTH of all
            %                  subgraphs.
            %                  'harmonic' - calculates PATHLENGTH with
            %                  harmonic average.
            %
            % PATHLENGTH(G, 'VALUE', VALUE) creates path length, and sets 
            % the value to VALUE. G is a graph (e.g, an instance of GraphBU,
            % GraphWU, MultiplexGraphBU or MultiplexGraphWU).
            %   
            % See also Measure, Distance, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function path_length =  calculate(m)
            % CALCULATE calculates the path length value of a node
            %
            % PATHLENGTH = CALCULATE(M) returns the value of the path length
            % of a node.
            %
            % See also Measure, Distance, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('Distance')
                distance = g.getMeasureValue('Distance');
            else
                distance = Distance(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            L = g.layernumber();
                       
            path_length_rule = get_from_varargin('default', 'PathLengthRule', m.getSettings());
            path_length = cell(L, 1);
            for li = 1:1:L
                path_length_layer = zeros(N(1), 1); 
                distance_layer = distance{li};
                
                switch lower(path_length_rule)
                    case {'subgraphs'}
                        for u = 1:1:N
                            Du = distance_layer(:, u);
                            path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));                        
                        end
                         path_length_layer(isnan(path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
                    case {'harmonic'}
                        for u = 1:1:N
                            Du = distance_layer(:, u);
                            path_length_layer(u) = harmmean(Du(Du~=0));
                        end
                    otherwise  % 'default'
                        for u = 1:1:N
                            Du = distance_layer(:, u);
                            path_length_layer(u) = mean(Du(Du~=0));
                        end
                end  
                path_length_layer(isnan(path_length_layer)) = 0;  % Should return zeros, not NaN
                path_length(li) = {path_length_layer};
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the path length measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'PathLength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the path length measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Path length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % path length measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The path length is the average shortest ' ...
                'path lengths of one node to all other nodes within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to PathLength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to PathLength. 
            % PATHLENGTHRULE = 'default' (default) - calculates PATHLENGTH 
            %                  with normal average
            %                  'subgraphs' - calculates PATHLENGTH of all
            %                  subgraphs.
            %                  'harmonic' - calculates PATHLENGTH with
            %                  harmonic average.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'PathLengthRule', BRAPH2.STRING, 'default', {'default', 'subgraphs', 'harmonic'};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of PathLength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of path length measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of PathLength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of path length measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of PathLength
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of path length measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with PathLength 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to path length. 
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
            % graphs with PathLength 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to path length.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('PathLength');
        end
    end
end