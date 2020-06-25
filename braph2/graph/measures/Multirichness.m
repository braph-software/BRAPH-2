classdef Multirichness < Richness
    % Multirichness Multirichness measure
    % Multirichness provides the multirichness of a node for binary undirected (BU),
    % binary directed (BD), weighted undirected (WU) and weighted directed (WD)  
    % multiplexes. 
    %
    % It is calculated as the sum of the number of edges that connect nodes
    % of degree k or higher in all layers. The value of k is set by the
    % user (setting 'RichnessThreshold'), the default value is equal to the
    % maximum degree - 1. The relevance of each layer is controlled by the
    % coefficients c (setting 'MultirichnessCoefficients') that are between
    % 0 and 1, and add up to one; the default coefficients are (1/layernumber)
    % 
    % Multirichness methods:
    %   Multirichness               - constructor
    %
    % Multirichness methods (Static)
    %   getClass                    - returns the multirichness class
    %   getName                     - returns the name of multirichness measure
    %   getDescription              - returns the description of multirichness measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Richness, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = Multirichness(g, varargin)
            % MULTIRICHNESS(G) creates multirichness with default properties.
            % G is a multiplex (e.g, an instance of MultiplexGraphBD,
            % MultiplexGraphBU, MultiplexGraphWD or MultiplexGraphWU). 
            % 
            % MULTIRICHNESS(G, 'RichnessThreshold', RICHNESSTHRESHOLD,
            % 'MultirichnessCoefficients', MULTIRICHNESSCOEFFICIENTS)  
            % creates multirichness measure and initializes the property
            % RichnessThreshold with RICHNESSTHRESHOLD and the property
            % MultirichnessCoefficients with MULTIRICHNESSCOEFFICIENTS.
            % Admissible THRESHOLD and COEFFICIENTS options are:
            % RICHNESSTHRESHOLD = 0 (default) - RICHNESS k threshold is set 
            %                    to the maximum degree - 1.
            %                    value - RICHNESS k threshold is set to the
            %                    specificied value (numeric).
            % MULTIRICHNESSCOEFFICIENTS = 0 (default) - MULTIRICHNESS c coefficients
            %                    will be set to (1/layernumber) per each layer.
            %                    values - MULTIRICHNESS c coefficients
            %                    will be set to the values specified per
            %                    each layer if the length of values is
            %                    equal to the number of layers.
            %
            % MULTIRICHNESS(G, 'VALUE1', VALUE1, 'VALUE2', VALUE2) creates
            % multirichness, and sets the value1 to VALUE1 and value2 to
            % VALUE2. G is a graph (e.g, an instance of MultiplexGraphBD,
            % MultiplexGraphBU, MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, Richness, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Richness(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multirichness = calculate(m)
            % CALCULATE calculates the multirichness value of a multiplex
            %
            % MULTIRICHNESS = CALCULATE(M) returns the value of the multirichness
            % of a multiplex.
            %
            % See also Measure, Richness, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('Richness')
                richness = g.getMeasureValue('Richness');
            else
                richness = calculate@Richness(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            multirichness_coefficients = get_from_varargin(0, 'MultirichnessCoefficients', m.getSettings());
            assert(length(multirichness_coefficients) == L || all(multirichness_coefficients == 0), ...
                [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
                ['Multirichness coefficients must have the same length than the ' ...
                'number of layers (' tostring(L) ') while its length is ' tostring(length(multirichness_coefficients))])

            if length(multirichness_coefficients) == L
                assert(all(multirichness_coefficients <= 1) && all(multirichness_coefficients >= 0), ...
                    [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
                    ['Multirichness coefficients must be between 0 and 1 ' ...
                    'while they are ' tostring(multirichness_coefficients)])
                c = multirichness_coefficients;
            else  % same relevance for each layer
                c = ones(1, L)/L;
            end
            
            multirichness = zeros(N(1), 1);
            for li = 1:1:L
                multirichness = multirichness + c(li)*richness{li};
            end
            multirichness = {multirichness};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multirichness measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'Multirichness';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multirichness measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Multirichness';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multirichness description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multirichness measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The multirichness of a node is the sum of ' ...
                'the edges that connect nodes of degree k or higher in all layers. ' ...
                'The relevance of each layer is controlled by the coefficients c ' ...
                'that are between 0 and 1; the default coefficients are (1/layernumber). ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Multirichness
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Multirichness.
            % RICHNESSTHRESHOLD = 0 (default) - RICHNESS k threshold is set 
            %                    to the maximum degree - 1.
            %                    value - RICHNESS k threshold is set to the
            %                    specificied value (numeric).
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
            % GETMEASUREFORMAT returns the measure format of Multirichness
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multirichness measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Multirichness
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multirichness measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with Multirichness 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multirichness. 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with Multirichness
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with multirichness.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('Multirichness');
        end
    end
end