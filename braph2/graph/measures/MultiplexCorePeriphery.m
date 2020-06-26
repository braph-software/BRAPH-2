classdef MultiplexCorePeriphery < Multirichness
    % MultiplexCorePeriphery Multiplex core periphery measure
    % MultiplexCorePeriphery provides the multiplex core periphery of a node 
    % for binary undirected (BU), binary directed (BD), weighted undirected 
    % (WU) and weighted directed (WD) multiplexes. 
    %
    % It is calculated as the value of the rank corresponding to the
    % maximum multirichness with degree k or higher. It returns 1 for a
    % node belonging to the core and zero otherwise. The value of k is set 
    % by the user (setting 'RichnessThreshold'), the default value is equal
    % to the maximum degree - 1. The relevance of each layer is controlled
    % by the coefficients c (setting 'MultirichnessCoefficients') that are
    % between 0 and 1, and add up to one; the default coefficients are
    % (1/layernumber).
    % 
    % MultiplexCorePeriphery methods:
    %   MultiplexCorePeriphery      - constructor
    %
    % MultiplexCorePeriphery methods (Static)
    %   getClass                    - returns the multiplex core periphery class
    %   getName                     - returns the name of multiplex core periphery measure
    %   getDescription              - returns the description of multiplex core periphery measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Multirichness, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = MultiplexCorePeriphery(g, varargin)
            % MULTIPLEXCOREPERIPHERY(G) creates multiplex core periphery with default properties.
            % G is a multiplex (e.g, an instance of MultiplexGraphBD,
            % MultiplexGraphBU, MultiplexGraphWD or MultiplexGraphWU). 
            %
            % MULTIPLEXCOREPERIPHERY(G, 'RichnessThreshold', RICHNESSTHRESHOLD, 
            % 'MultirichnessCoefficients', MULTIRICHNESSCOEFFICIENTS) 
            % creates multiplex core periphery, measure and initializes the 
            % property RichnessThreshold with RICHNESSTHRESHOLD and the
            % property MultirichnessCoefficients with MULTIRICHNESSCOEFFICIENTS. 
            % Admissible THRESHOLD and COEFFICIENTS options are:
            % RICHNESSTHRESHOLD = -1 (default) - RICHNESS k threshold is set 
            %                    to the maximum degree - 1.
            %                    value - RICHNESS k threshold is set to the
            %                    specificied value if the value is positive.
            %                    For negative values, k is set to the
            %                    maximum degree - value.
            % MULTIRICHNESSCOEFFICIENTS = 0 (default) - MULTIRICHNESS c coefficients
            %                    will be set to (1/layernumber) per each layer.
            %                    values - MULTIRICHNESS c coefficients
            %                    will be set to the values specified per
            %                    each layer if the length of values is
            %                    equal to the number of layers.
            %
            % MULTIPLEXCOREPERIPHERY(G, 'VALUE1', VALUE1, 'VALUE2', VALUE2) creates
            % multiplex core periphery, and sets the value1 to VALUE1 and value2 to
            % VALUE2. G is a graph (e.g, an instance of MultiplexGraphBD,
            % MultiplexGraphBU, MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, Multirichness, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Multirichness(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multiplex_core_periphery = calculate(m)
            % CALCULATE calculates the multiplex core periphery value of a multiplex
            %
            % MULTIPLEXCOREPERIPHERY = CALCULATE(M) returns the value of the multiplex core periphery
            % of a multiplex.
            %
            % See also Measure, Multirichness, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Multirichness')
                multirichness = g.getMeasureValue('Multirichness');
            else
                multirichness = calculate@Multirichness(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
  
            multirichness_coefficients = get_from_varargin(0, 'MultirichnessCoefficients', m.getSettings());
            assert(length(multirichness_coefficients) == L || all(multirichness_coefficients == 0), ...
                [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.WRONG_INPUT], ...
                ['Multirichness coefficients must have the same length than the ' ...
                'number of layers (' tostring(L) ') while its length is ' tostring(length(multirichness_coefficients))])

            if length(multirichness_coefficients) == L
                assert(all(multirichness_coefficients <= 1) && all(multirichness_coefficients >= 0), ...
                    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.WRONG_INPUT], ...
                    ['Multirichness coefficients must be between 0 and 1 ' ...
                    'while they are ' tostring(multirichness_coefficients)])
                c = multirichness_coefficients;
            else  % same relevance for each layer
                c = ones(1, L)/L;
            end
            
            directionality_type =  g.getDirectionalityType(g.layernumber());
            overlapping_degree_coefficients = zeros(N(1), 1);
            for li = 1:1:L
                if g.is_graph(g)
                    directionality_layer = directionality_type;
                else
                    directionality_layer = directionality_type(li, li);
                end
                
                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                    
                    if g.is_measure_calculated('Degree')
                        degree = g.getMeasureValue('Degree');
                    else
                        degree = Degree(g, g.getSettings()).getValue();
                    end
                    
                    deg = degree{li};
                    
                else  % directed graphs
                    
                    if g.is_measure_calculated('InDegree')
                        in_degree = g.getMeasureValue('InDegree');
                    else
                        in_degree = InDegree(g, g.getSettings()).getValue();
                    end
                    
                    if g.is_measure_calculated('OutDegree')
                        out_degree = g.getMeasureValue('OutDegree');
                    else
                        out_degree = OutDegree(g, g.getSettings()).getValue();
                    end
                    
                    deg = (in_degree{li} + out_degree{li})/2;
                end
                overlapping_degree_coefficients = overlapping_degree_coefficients + c(li)*deg;
            end
            
            [~, rankingInd] = sort(overlapping_degree_coefficients, 'descend');
            multirichness = multirichness{1};
            [~, rankOfMaxMultirichness] = max(multirichness(rankingInd));
            multiplex_core_periphery = zeros(N(1), 1);
            multiplex_core_periphery(rankingInd(1:rankOfMaxMultirichness)) = 1;
            multiplex_core_periphery = {multiplex_core_periphery};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multiplex core periphery measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'MultiplexCorePeriphery';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multiplex core periphery measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Multiplex core periphery';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multiplex core periphery description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multiplex core periphery measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The multiplex core periphery of a node returns one if ' ...
                'the node belongs to the core and zero otherwise. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultiplexCorePeriphery
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultiplexCorePeriphery.
            % RICHNESSTHRESHOLD = -1 (default) - RICHNESS k threshold is set 
            %                    to the maximum degree - 1.
            %                    value - RICHNESS k threshold is set to the
            %                    specificied value if the value is positive.
            %                    For negative values, k is set to the
            %                    maximum degree - value.
            % MULTIRICHNESSCOEFFICIENTS = 0 (default) - MULTIRICHNESS c coefficients 
            %                    will be set to (1/layernumber) per each layer.
            %                    values - MULTIRICHNESS c coefficients
            %                    will be set to the values specified per
            %                    each layer if the length of values is
            %                    equal to the number of layers.
            
            available_settings = getAvailableSettings@Richness();

            available_settings(end+1, :) = {
                 'MultirichnessCoefficients', BRAPH2.NUMERIC, 0, {};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultiplexCorePeriphery
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multiplex core periphery measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultiplexCorePeriphery
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multiplex core periphery measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with MultiplexCorePeriphery 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multiplex core periphery. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with MultiplexCorePeriphery
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with multiplex core periphery.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('MultiplexCorePeriphery');
        end
    end
end