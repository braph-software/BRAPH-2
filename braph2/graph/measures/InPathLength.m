classdef InPathLength < Measure
    % InPathLength In-path length measure
    % InPathLength provides the in-path length of a node for binary directed (BD) 
    % and weighted directed (WD) graphs. 
    %
    % It is calculated as the average shortest in-path length from one node 
    % to another node within a layer.
    %    
    % InPathLength methods:
    %   InPathLength                - constructor             
    % 
    % InPathLength descriptive methods (Static)
    %   getClass                    - returns the in-path length class
    %   getName                     - returns the name of in-path length measure
    %   getDescription              - returns the description of in-path length measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the path length class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = InPathLength(g, varargin)
            % INPATHLENGTH(G) creates in-path length with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD, 
            % MultiplexGraphBD or MultiplexGraphWD).
            %   
            % INPATHLENGTH(G, 'InPathLengthRule', INPATHLENGTHRULE) creates  
            % path length measure and initializes the property PathLengthRule 
            % with INPATHLENGTHRULE. 
            % Admissible PATHLENGTHRULE options are:
            % INPATHLENGTHRULE = 'default' (default) - calculates PATHLENGTH 
            %                    with normal average
            %                    'subgraphs' - calculates PATHLENGTH of all
            %                    subgraphs.
            %                    'harmonic' - calculates PATHLENGTH with
            %                    harmonic average.
            %
            % INPATHLENGTH(G, 'VALUE', VALUE) creates in-path length, and sets 
            % the value to VALUE. G is a graph (e.g, an instance of GraphBD,
            % GraphWD, MultiplexGraphBD or MultiplexGraphWD).
            %   
            % See also Measure, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_path_length =  calculate(m)
            % CALCULATE calculates the in-path length value of a node
            %
            % INPATHLENGTH = CALCULATE(M) returns the value of the in-path 
            % length of a node.
            %
            % See also Measure, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('Distance')
                distance = g.getMeasureValue('Distance');
            else
                distance = Distance(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            L = g.layernumber();
                       
            in_path_length_rule = get_from_varargin('default', 'InPathLengthRule', m.getSettings());
            in_path_length = cell(L, 1);
            for li = 1:1:L
                in_path_length_layer = zeros(N(1), 1); 
                distance_layer = distance{li};
                
                switch lower(in_path_length_rule)
                    case {'subgraphs'}
                        for u = 1:1:N
                            Du = distance_layer(:, u);
                            in_path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));                        
                        end
                         in_path_length_layer(isnan(in_path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
                    case {'harmonic'}
                        for u = 1:1:N
                            Du = distance_layer(:, u);
                            in_path_length_layer(u) = harmmean(Du(Du~=0));
                        end
                    otherwise  % 'default'
                        for u = 1:1:N
                            Du = distance_layer(:, u);
                            in_path_length_layer(u) = mean(Du(Du~=0));
                        end
                end  
                
                in_path_length(li) = {in_path_length_layer};
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-path length measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InPathLength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-path length measure.
            %
            % See also getClass(), getDescription().
            
            name = 'In-path length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-path length measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The in-path length is the average shortest ' ...
                'in-path lengths of one node to all other nodes within a layer.' ...
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