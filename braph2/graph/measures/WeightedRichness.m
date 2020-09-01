classdef WeightedRichness < Strength
    % WeightedRichness Weighted richness measure
    % WeightedRichness provides the weighted richness of a node for weighted 
    % undirected (WU) and weighted directed (WD) graphs. 
    %
    % It is calculated as the sum of the weighted edges that connect nodes
    % of strength k or higher within a layer. The value of k is set by the
    % user (setting 'WeightedRichnessThreshold'), the default value is 
    % equal to the maximum strength - 1. For positive thresholds, k equals 
    % to the threshold value; while for negative thresholds, k equals to 
    % the maximum strength - threshold value.
    % 
    % WeightedRichness methods:
    %   WeightedRichness            - constructor
    %
    % WeightedRichness methods (Static)
    %   getClass                    - returns the weighted richness class
    %   getName                     - returns the name of weighted richness measure
    %   getDescription              - returns the description of weighted richness measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the degree class
    %   getParameterName            - returns the name of richness measure's parameter
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % WeightedRichness methods 
    %   getParameterValues          - returns the values of weighted richness measure's parameter
    %
    % See also Measure, Strength, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = WeightedRichness(g, varargin)
            % WEIGHTEDRICHNESS(G) creates weighted richness with default properties.
            % G is a weighted graph (e.g, an instance of GraphWD, GraphWU,
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % WEIGHTEDRICHNESS(G, 'WeightedRichnessThreshold', WEIGHTEDRICHNESSTHRESHOLD) 
            % creates weighted richness measure and initializes the property 
            % WeightedRichnessThreshold with WEIGHTEDRICHNESSTHRESHOLD. 
            % Admissible THRESHOLD options are:
            % WEIGHTEDRICHNESSTHRESHOLD = 1(default) - WEIGHTEDRICHNESS k   
            %                           threshold is set to 1.
            %                           value - WEIGHTEDRICHNESS k threshold 
            %                           is set to the specificied value.
            % 
            % WEIGHTEDRICHNESS(G, 'VALUE', VALUE) creates weighted richness, and sets 
            % the value to VALUE. G is a graph (e.g, an instance of GraphWD, GraphWU,
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, Strength, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Strength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_richness = calculate(m)
            % CALCULATE calculates the weighted richness value of a graph
            %
            % WEIGHTEDRICHNESS = CALCULATE(M) returns the value of the weighted richness
            % of a graph.
            %
            % See also Measure, Strength, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            
            weighted_richness = cell(g.layernumber(), 1);
            directionality_type =  g.getDirectionalityType(g.layernumber());
            for li = 1:1:L
                
                if g.is_graph(g)
                    Aii = A;
                    directionality_layer = directionality_type;
                else
                    Aii = A{li, li};
                    directionality_layer = directionality_type(li, li);
                end
                
                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                    
                    if g.is_measure_calculated('Strength')
                        strength = g.getMeasureValue('Strength');
                    else
                        strength = calculate@Strength(m);
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
                
                weighted_richness_threshold = get_from_varargin(1, 'WeightedRichnessThreshold', m.getSettings());
                assert(isnumeric(weighted_richness_threshold) == 1, ...
                    [BRAPH2.STR ':WeightedRichness:' BRAPH2.WRONG_INPUT], ...
                    ['WeightedRichness threshold must be a positive number ' ...
                    'while it is ' tostring(weighted_richness_threshold)])

                k_level = abs(weighted_richness_threshold);
                m.setParameter(k_level)  % Set the parameter
                
                weighted_richness_layer = zeros(N(1), 1, k_level);
                for k = 1:1:k_level
                    low_rich_nodes = find(st <= k);  % get lower rich nodes with strength <= k
                    subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <=k of Aii
                    subAii(low_rich_nodes, :) = 0;  % remove rows
                    subAii(:, low_rich_nodes) = 0;  % remove columns

                    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                        weighted_richness_layer(:, :, k) = {round(sum(subAii, 1), 6)'};  % strength of high rich nodes   
                    else
                        weighted_richness_layer(:, :, k) = {round((sum(subAii, 1)' + sum(subAii, 2)), 6)/2};  % strength of high rich nodes   
                    end
                end
                weighted_richness(li) = {richness_layer};  % add richness of layer li
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the weighted richness measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'WeightedRichness';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the weighted richness measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Weighted richness';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the weighted richness description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % weighted richness measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The weighted richness of a node is the sum of ' ...
                'the weighted edges that connect nodes of strength k or higher within a layer. ' ...
                'k is set by the user; the default value is equal to 1 ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to WeightedRichness
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to WeightedRichness.
            % WEIGHTEDRICHNESSTHRESHOLD = 1 (default) - WEIGHTEDRICHNESS k   
            %                           threshold is set to 1.
            %                           value - WEIGHTEDRICHNESS k threshold 
            %                           is set to the specificied value.
            
            available_settings = {
                'WeightedRichnessThreshold', BRAPH2.NUMERIC, 1, {};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of WeightedRichness
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of weighted richness measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of WeightedRichness
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of weighted richness measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of WeightedRichness
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of weighted richness measure (PARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.PARAMETRIC;
        end
        function name = getParameterName()
            % GETPARAMETERNAME returns the name of WeightedRichness' parameter
            %
            % NAME = GETPARAMETERNAME() returns the name (string) of 
            % the weighted richness' parameter.
            
            name = 'Richness threshold';
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with WeightedRichness 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to weighted richness. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with WeightedRichness
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with weighted richness.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedRichness');
        end
    end
    methods
        function values = getParameterValues(m)
            % GETPARAMETERVALUES returns the values of the WeightedRichness' parameter
            %
            % VALUES = GETPARAMETERVALUES() returns the values of
            % the weighted richness' parameter.
            
            values = 1:1:m.getParameter();
        end
    end
end