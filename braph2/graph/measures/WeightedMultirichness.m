classdef WeightedMultirichness < WeightedRichness
    % WeightedMultirichness Weighted multirichness measure
    % WeightedMultirichness provides the weighted multirichness of a node for
    % weighted undirected (WU) and weighted directed (WD) multiplexes. 
    %
    % It is calculated as the sum of the weighted edges that connect nodes
    % of strength k or higher in all layers. The value of s is set by the
    % user (setting 'WeightedRichnessThreshold'), the default value is equal 
    % to 1. The relevance of each layer is controlled 
    % by the coefficients c (setting 'MultirichnessCoefficients') that are 
    % between 0 and 1, and add up to one; the default coefficients are
    % (1/layernumber).
    % 
    % WeightedMultirichness methods:
    %   WeightedMultirichness       - constructor
    %
    % WeightedMultirichness methods (Static)
    %   getClass                    - returns the weighted multirichness class
    %   getName                     - returns the name of weighted multirichness measure
    %   getDescription              - returns the description of weighted multirichness measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the degree class
    %   getParameterName            - returns the name of weighted multirichness measure's parameter
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % WeightedMultirichness methods 
    %   getParameterValues          - returns the values of weighted multirichness measure's parameter
    %
    % See also Measure, WeightedRichness, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = WeightedMultirichness(g, varargin)
            % WEIGHTEDMULTIRICHNESS(G) creates weighted multirichness with default properties.
            % G is a weighted multiplex (e.g, an instance of MultiplexGraphWD
            % or MultiplexGraphWU). 
            % 
            % WEIGHTEDMULTIRICHNESS(G, 'WeightedRichnessThreshold', WEIGHTEDRICHNESSTHRESHOLD, 
            % 'WeightedMultirichnessCoefficients', WEIGHTEDMULTIRICHNESSCOEFFICIENTS) 
            % creates weighted multirichness measure and initializes the property 
            % WeightedRichnessThreshold with WEIGHTEDRICHNESSTHRESHOLD and the property
            % WeightedMultirichnessCoefficients with MULTIRICHNESSCOEFFICIENTS. 
            % Admissible THRESHOLD and COEFFICIENTS options are:
            % WEIGHTEDRICHNESSTHRESHOLD = 1(default) - WEIGHTEDRICHNESS s   
            %                           threshold is set to 1.
            %                           value - WEIGHTEDRICHNESS s  
            %                           threshold is set to the specificied 
            %                           values (vector).
            % WEIGHTEDMULTIRICHNESSCOEFFICIENTS = 0 (default) - WEIGHTEDMULTIRICHNESS c coefficients
            %                                   will be set to (1/layernumber) per each layer.
            %                                   values - WEIGHTEDMULTIRICHNESS c coefficients
            %                                   will be set to the values specified per
            %                                   each layer if the length of values is
            %                                   equal to the number of layers.
            %
            % MULTIRICHNESS(G, 'VALUE1', VALUE1, 'VALUE2', VALUE2) creates
            % multirichness, and sets the value1 to VALUE1 and value2 to
            % VALUE2. G is a graph (e.g, an instance of MultiplexGraphWD
            % or MultiplexGraphWU). 
            %
            % See also Measure, WeightedRichness, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@WeightedRichness(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_multirichness = calculate(m)
            % CALCULATE calculates the weighted multirichness value of a multiplex
            %
            % WEIGHTEDMULTIRICHNESS = CALCULATE(M) returns the value of the  
            % weighted multirichness of a multiplex.
            %
            % See also Measure, WeightedRichness, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('WeightedRichness')
                weighted_richness = g.getMeasureValue('WeightedRichness');
            else
                weighted_richness = calculate@WeightedRichness(m);
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
                    [BRAPH2.STR ':WeightedMultirichness:' BRAPH2.WRONG_INPUT], ...
                    ['WeightedMultirichness coefficients must be between 0 and 1 ' ...
                    'while they are ' tostring(weighted_multirichness_coefficients)])
                c = weighted_multirichness_coefficients;
            else  % same relevance for each layer
                c = ones(1, L)/L;
            end
            
            weighted_richness_threshold = get_from_varargin(1, 'WeightedRichnessThreshold', m.getSettings());
            s_levels = abs(weighted_richness_threshold);
            m.setParameter(s_levels)  % Set the parameter
                            
            weighted_multirichness = zeros(N(1), 1, length(s_levels));
            for li = 1:1:L
                wrich = weighted_richness{li};
                % loop over the 3rd dimension of richness (k_level)
                for s = 1:1:length(s_levels)
                    weighted_multirichness(:, :, s) = weighted_multirichness(:, :, s) + c(li)*wrich(:, :, s);
                end
            end
            weighted_multirichness = {weighted_multirichness};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the weighted multirichness measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'WeightedMultirichness';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the weighted multirichness measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Weighted multirichness';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the weighted multirichness description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % weighted multirichness measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The weighted multirichness of a node is the sum of ' ...
                'the weighted edges that connect nodes of strength s or higher in all layers. ' ...
                'The relevance of each layer is controlled by the coefficients c ' ...
                'that are between 0 and 1; the default coefficients are (1/layernumber). ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to WeightedMultirichness
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to WeightedMultirichness.
            % WEIGHTEDRICHNESSTHRESHOLD = 1(default) - WEIGHTEDRICHNESS s   
            %                           threshold is set to 1.
            %                           value - WEIGHTEDRICHNESS s  
            %                           threshold is set to the specificied 
            %                           values (vector).
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
            % GETMEASUREFORMAT returns the measure format of WeightedMultirichness
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of weighted multirichness measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of WeightedMultirichness
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of weighted multirichness measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of WeightedMultirichness
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of weighted multirichness measure (PARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.PARAMETRIC;
        end
        function name = getParameterName()
            % GETPARAMETERNAME returns the name of the WeightedMultirichness' parameter
            %
            % NAME = GETPARAMETERNAME() returns the name (string) of 
            % the weighted multirichness' parameter.
            
            name = 'Weighted multirichness thresholds';
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with WeightedMultirichness 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to weighted multirichness. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with WeightedMultirichness
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with weighted multirichness.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedMultirichness');
        end
    end
    methods
        function values = getParameterValues(m)
            % GETPARAMETERVALUES returns the values of the WeightedMultirichness' parameter
            %
            % VALUES = GETPARAMETERVALUES() returns the values of
            % the weighted multirichness' parameter.
            
            values = m.getParameter();
        end
    end
end