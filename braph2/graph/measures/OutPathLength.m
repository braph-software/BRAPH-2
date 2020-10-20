classdef OutPathLength < Measure
    % OutPathLength Out-path length measure
    % OutPathLength provides the out-path length of a node for binary directed (BD) 
    % and weighted directed (WD) graphs. 
    %
    % It is calculated as the average shortest out-path length from one node 
    % to another node within a layer. The calculation of out-path length is 
    % controlled by the out-path length rule (setting 'OutPathLengthRule'), 
    % the default option calculates the measure with normal average. 
    %    
    % OutPathLength methods:
    %   OutPathLength               - constructor             
    % 
    % OutPathLength descriptive methods (Static)
    %   getClass                    - returns the out-path length class
    %   getName                     - returns the name of out-path length measure
    %   getDescription              - returns the description of out-path length measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the path length class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OutPathLength(g, varargin)
            % OUTPATHLENGTH(G) creates out-path length with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD, 
            % MultiplexGraphBD or MultiplexGraphWD).
            %   
            % OUTPATHLENGTH(G, 'OutPathLengthRule', OUTPATHLENGTHRULE) creates  
            % out-path length measure and initializes the property OutPathLengthRule 
            % with OUTPATHLENGTHRULE. 
            % Admissible OUTPATHLENGTHRULE options are:
            % OUTPATHLENGTHRULE = 'default' (default) - calculates OUTPATHLENGTH 
            %                     with normal average
            %                     'subgraphs' - calculates OUTPATHLENGTH of all
            %                     subgraphs.
            %                     'harmonic' - calculates OUTPATHLENGTH with
            %                     harmonic average.
            %
            % OUTPATHLENGTH(G, 'VALUE', VALUE) creates out-path length, and sets 
            % the value to VALUE. G is a graph (e.g, an instance of GraphBD,
            % GraphWD, MultiplexGraphBD or MultiplexGraphWD).
            %   
            % See also Measure, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_path_length =  calculate(m)
            % CALCULATE calculates the in-path length value of a node
            %
            % OUTPATHLENGTH = CALCULATE(M) returns the value of the in-path 
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
                       
            out_path_length_rule = get_from_varargin('default', 'OutPathLengthRule', m.getSettings());
            out_path_length = cell(L, 1);
            for li = 1:1:L
                out_path_length_layer = zeros(N(1), 1); 
                distance_layer = distance{li};
                
                switch lower(out_path_length_rule)
                    case {'subgraphs'}
                        for u = 1:1:N
                            Du = distance_layer(u, :);
                            out_path_length_layer(u) = mean(Du(Du~=0 & Du~=Inf));
                        end
                        out_path_length_layer(isnan(out_path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
                    case {'harmonic'}
                        for u = 1:1:N
                            Du = distance_layer(u, :);
                            out_path_length_layer(u) = harmmean(Du(Du~=0));
                        end
                    otherwise  % 'default'
                        for u = 1:1:N
                            Du = distance_layer(u, :);
                            out_path_length_layer(u) = mean(Du(Du~=0));
                        end
                end  
                out_path_length(li) = {out_path_length_layer};
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the out-path length measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'OutPathLength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-path length measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Out-path length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-path length measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The out-path length is the average shortest ' ...
                'out-path lengths of one node to all other nodes within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OutPathLength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutPathLength. 
            % OUTPATHLENGTHRULE = 'default' (default) - calculates OUTPATHLENGTH 
            %                     with normal average
            %                     'subgraphs' - calculates OUTPATHLENGTH of all
            %                     subgraphs.
            %                     'harmonic' - calculates OUTPATHLENGTH with
            %                     harmonic average.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'OutPathLengthRule', BRAPH2.STRING, 'default', {'default', 'subgraphs', 'harmonic'};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutPathLength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of out-path length measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutPathLength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of out-path length measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OutPathLength
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of out-path length measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with OutPathLength 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to out-path length. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with OutPathLength 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to out-path length.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutPathLength');
        end
    end
end