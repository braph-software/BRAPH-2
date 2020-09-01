classdef WeightedMultiplexCorePeriphery < WeightedMultirichness
    % WeightedMultiplexCorePeriphery Weighted multiplex core periphery measure
    % WeightedMultiplexCorePeriphery provides the weighted multiplex core 
    % periphery of a node for weighted undirected (WU) and weighted directed 
    % (WD) multiplexes. 
    %
    % It is calculated as the value of the rank corresponding to the
    % maximum multirichness with strength k or higher. It returns 1 for a
    % node belonging to the core and zero otherwise. The value of k is set 
    % by the user (setting 'RichnessThreshold'), the default value is equal
    % to the maximum strength - 1. The relevance of each layer is controlled
    % by the coefficients c (setting 'MultirichnessCoefficients') that are
    % between 0 and 1, and add up to one; the default coefficients are
    % (1/layernumber).
    % 
    % WeightedMultiplexCorePeriphery methods:
    %   WeightedMultiplexCorePeriphery - constructor
    %
    % WeightedMultiplexCorePeriphery methods (Static)
    %   getClass                    - returns the weighted multiplex core periphery class
    %   getName                     - returns the name of weighted multiplex core periphery measure
    %   getDescription              - returns the description of weighted multiplex core periphery measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, WeightedMultirichness, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = WeightedMultiplexCorePeriphery(g, varargin)
            % WEIGHTEDMULTIPLEXCOREPERIPHERY(G) creates weighted multiplex core periphery with default properties.
            % G is a weighted multiplex (e.g, an instance of MultiplexGraphWD,
            %  or MultiplexGraphWU). 
            %
            % WEIGHTEDMULTIPLEXCOREPERIPHERY(G, 'WeightedRichnessThreshold', 
            % WEIGHTEDRICHNESSTHRESHOLD, 'WeightedMultirichnessCoefficients', 
            % WEIGHTEDMULTIRICHNESSCOEFFICIENTS) creates weighted multiplex 
            % core periphery measure and initializes the property 
            % WeightedRichnessThreshold with WEIGHTEDRICHNESSTHRESHOLD and 
            % the property WeightedMultirichnessCoefficients with 
            % WEIGHTEDMULTIRICHNESSCOEFFICIENTS. 
            % Admissible THRESHOLD and COEFFICIENTS options are:
            % WEIGHTEDRICHNESSTHRESHOLD = -1 (default) - WEIGHTEDRICHNESS k threshold  
            %                           is set to the maximum strength - 1.
            %                           value - WEIGHTEDRICHNESS k threshold is 
            %                           set to the specificied value if the
            %                           value is positive. For negative
            %                           values, k is set to the maximum
            %                           strength - value
            % WEIGHTEDMULTIRICHNESSCOEFFICIENTS = 0 (default) - WEIGHTEDMULTIRICHNESS c coefficients
            %                                   will be set to (1/layernumber) per each layer.
            %                                   values - WEIGHTEDMULTIRICHNESS c coefficients
            %                                   will be set to the values specified per
            %                                   each layer if the length of values is
            %                                   equal to the number of layers.
            %
            % WEIGHTEDMULTIPLEXCOREPERIPHERY(G, 'VALUE1', VALUE1, 'VALUE2', VALUE2) 
            % creates weighted multiplex core periphery, and sets the value1 to
            % VALUE1 and value2 to VALUE2. G is a graph (e.g, an instance of
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, WeightedMultirichness, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@WeightedMultirichness(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_multiplex_core_periphery = calculate(m)
            % CALCULATE calculates the weighted multiplex core periphery value of a weighted multiplex
            %
            % WEIGHTEDMULTIPLEXCOREPERIPHERY = CALCULATE(M) returns the value 
            % of the weighted multiplex core periphery of a weighted multiplex.
            %
            % See also Measure, WeightedMultirichness, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('WeightedMultirichness')
                weighted_multirichness = g.getMeasureValue('WeightedMultirichness');
            else
                weighted_multirichness = calculate@WeightedMultirichness(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
  
            weighted_multirichness_coefficients = get_from_varargin(0, 'WeightedMultirichnessCoefficients', m.getSettings());
            assert(length(weighted_multirichness_coefficients) == L || all(weighted_multirichness_coefficients == 0), ...
                [BRAPH2.STR ':WeightedMultirichness:' BRAPH2.WRONG_INPUT], ...
                ['WeightedMultirichness coefficients must have the same length than the ' ...
                'number of layers (' tostring(L) ') while its length is ' tostring(length(weighted_multirichness_coefficients))])

            if length(weighted_multirichness_coefficients) == L
                assert(all(weighted_multirichness_coefficients <= 1) && all(weighted_multirichness_coefficients >= 0), ...
                    [BRAPH2.STR ':WeightedMultiplexCorePeriphery:' BRAPH2.WRONG_INPUT], ...
                    ['WeightedMultiplexCorePeriphery coefficients must be between 0 and 1 ' ...
                    'while they are ' tostring(weighted_multirichness_coefficients)])
                c = weighted_multirichness_coefficients;
            else  % same relevance for each layer
                c = ones(1, L)/L;
            end
            
            directionality_type =  g.getDirectionalityType(g.layernumber());
            overlapping_strength_coefficients = zeros(N(1), 1);
            for li = 1:1:L
                if g.is_graph(g)
                    directionality_layer = directionality_type;
                else
                    directionality_layer = directionality_type(li, li);
                end
                
                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                    
                    if g.is_measure_calculated('Strength')
                        strength = g.getMeasureValue('Strength');
                    else
                        strength = Strength(g, g.getSettings()).getValue();
                    end
                    
                    st = strength{li};
                    
                else  % directed graphs
                    
                    if g.is_measure_calculated('InStrength')
                        in_strength = g.getMeasureValue('InStrength');
                    else
                        in_strength = InStrength(g, g.getSettings()).getValue();
                    end
                    
                    if g.is_measure_calculated('OutStrength')
                        out_strength = g.getMeasureValue('OutStrength');
                    else
                        out_strength = OutStrength(g, g.getSettings()).getValue();
                    end
                    
                    st = (in_strength{li} + out_strength{li})/2;
                end
                overlapping_strength_coefficients = overlapping_strength_coefficients + c(li)*st;
            end
            
            [~, rankingInd] = sort(overlapping_strength_coefficients, 'descend');
            weighted_multirichness = weighted_multirichness{1};
            [~, rankOfMaxWeightedMultirichness] = max(weighted_multirichness(rankingInd));
            weighted_multiplex_core_periphery = zeros(N(1), 1);
            weighted_multiplex_core_periphery(rankingInd(1:rankOfMaxWeightedMultirichness)) = 1;
            weighted_multiplex_core_periphery = {weighted_multiplex_core_periphery};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the weighted multiplex core periphery measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'WeightedMultiplexCorePeriphery';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the weighted multiplex core periphery measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Weighted multiplex core periphery';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the weighted multiplex core periphery description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % weighted multiplex core periphery measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The weighted multiplex core periphery of a node returns one if ' ...
                'the node belongs to the core and zero otherwise in a weighted multiplex. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to WeightedMultiplexCorePeriphery
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to WeightedMultiplexCorePeriphery.
            % WEIGHTEDRICHNESSTHRESHOLD = -1 (default) - WEIGHTEDRICHNESS k threshold  
            %                           is set to the maximum strength - 1.
            %                           value - WEIGHTEDRICHNESS k threshold is 
            %                           set to the specificied value if the
            %                           value is positive. For negative
            %                           values, k is set to the maximum
            %                           strength - value
            % WEIGHTEDMULTIRICHNESSCOEFFICIENTS = 0 (default) - WEIGHTEDMULTIRICHNESS c coefficients
            %                                   will be set to (1/layernumber) per each layer.
            %                                   values - WEIGHTEDMULTIRICHNESS c coefficients
            %                                   will be set to the values specified per
            %                                   each layer if the length of values is
            %                                   equal to the number of layers.
            
            available_settings = getAvailableSettings@WeightedRichness();

            available_settings(end+1, :) = {
                 'WeightedMultirichnessCoefficients', BRAPH2.NUMERIC, 0, {};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of WeightedMultiplexCorePeriphery
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of weighted multiplex core periphery measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of WeightedMultiplexCorePeriphery
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of weighted multiplex core periphery measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of WeightedMultiplexCorePeriphery
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of weighted multiplex core periphery measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with WeightedMultiplexCorePeriphery 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to weighted multiplex core periphery. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with WeightedMultiplexCorePeriphery
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with weighted multiplex core periphery.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedMultiplexCorePeriphery');
        end
    end
end