classdef PathLength < Measure
    % PathLength Path length measure
    % PathLength provides the path length of a node for binary undirected (BU) 
    % and weighted undirected (WU) graphs. 
    %
    % It is calculated as the average shortest path length from one node 
    % to another node within a layer.
    %    
    % PathLength methods:
    %   PathLength                  - constructor             -
    % 
    % PathLength descriptive methods (Static)
    %   getClass                    - returns the path length class
    %   getName                     - returns the name of path length measure
    %   getDescription              - returns the description of path length measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the path length class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Graph, Strength, Distance, Degree.
    
    methods
        function m = PathLength(g, varargin)
            % PATHLENGTH(G) creates path length with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU, 
            % MultiplexGraphBU or MultiplexGraphWU).
            %   
            % PATHLENGTH(G, 'PathLengthRule', PATHLENGTHRULE) creates path 
            % length measure and initializes the property PathLengthRule 
            % with PATHLENGTHRULE. 
            % PathLength available PATHLENGTHRULE are: 
            % subgraphs     -   Calculates PATHLENGTH of all subgraphs
            % harmonic      -   Calculates PATHLENGTH with harmonic average
            % default       -   Calculates PATHLENGTH with normal average
            %
            % PATHLENGTH(G, 'VALUE', VALUE) creates path length, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBU, Graph WU).
            %   
            % See also Measure, Graph, Strength, Distance, GlobalEfficiency. 
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function path_length =  calculate(m)
            % CALCULATE calculates the path length value of a node
            %
            % PATHLENGTH = CALCULATE(M) returns the value of the path length
            % of a node.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('Distance')
                distance = g.getMeasureValue('Distance');
            else
                distance = Distance(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            path_length = zeros(N, 1);            
          
            pathLength_rule = get_from_varargin('default', 'PathLengthAvRule', m.getSettings());
            switch lower(pathLength_rule)
                case {'subgraphs'}
                    for u = 1:1:N
                        Du = distance(:, u);
                        path_length(u) = mean(Du(Du~=Inf & Du~=0));                        
                    end
                     path_length(isnan(path_length)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
                case {'harmonic'}
                    for u = 1:1:N
                        Du = distance(:, u);
                        path_length(u) = harmmean(Du(Du~=0));
                    end
                otherwise  % 'default'
                    for u = 1:1:N
                        Du = distance(:, u);
                        path_length(u) = mean(Du(Du~=0));
                    end
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
                'path lengths of one node to all other nodes.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to PathLength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to PathLength. 
            % PATHLENGTHAVRULE = 'default' (default) - calculates path length of nodal graph.
            %                    'subgraphs' - calculates path length of each subgraph.
            %                    'harmonic'  - calculates the path length using harmonic mean.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'PathLengthRule', Constant.STRING, 'default', {'default', 'subgraphs', 'harmonic'};
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