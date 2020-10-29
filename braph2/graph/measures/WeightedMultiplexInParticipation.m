classdef WeightedMultiplexInParticipation < InStrength
    % WeightedMultiplexInParticipation Weighted multiplex in-participation measure
    % WeightedMultiplexInParticipation provides the weighted multiplex in-participation 
    % of a node for weighted directed (WD) multiplexes. 
    %
    % It is the heterogenerity of the number of neighbours of a node across the layers.
    % It is calculated as:
    % Pi = L/(L - 1) [1 - sum_{l=1}^{L} (si(l)/oi)^2]
    % where L is the number of layers, si(l) is the in-strength in the l-th
    % layer and oi is the overlapping in-strength of the node.
    % Pi = 1 when the strength is the same in all layers and Pi = 0 when a
    % node has non-zero in-strength in only one layer.
    % 
    % WeightedMultiplexInParticipation methods:
    %   WeightedMultiplexInParticipation - constructor
    %
    % WeightedMultiplexInParticipation methods (Static)
    %   getClass                    - returns the weighted multiplex in-participation class
    %   getName                     - returns the name of weighted multiplex in-participation measure
    %   getDescription              - returns the description of weighted multiplex in-participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the weighted multiplex in-participation class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InStrength, OverlappingInStrength, MultiplexGraphWD.
    
    methods
        function m = WeightedMultiplexInParticipation(g, varargin)
            % WeightedMultiplexInParticipation(G) creates weighted multiplex in-participation with default properties.
            % G is a weighted directed multiplex (i.e., an instance of
            % MultiplexGraphWD).
            %
            % See also Measure, InStrength, OverlappingInStrength, MultiplexGraphWD.
            
            m = m@InStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_multiplex_in_participation = calculate(m)
            % CALCULATE calculates the weighted multiplex in-participation value of a multiplex
            %
            % WeightedMultiplexInParticipation = CALCULATE(M) returns the value
            % of the weighted multiplex in-participation of a multiplex.
            %
            % See also Measure, InStrength, OverlappingInStrength, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InStrength')
                in_strength = g.getMeasureValue('InStrength');
            else
                in_strength = calculate@InStrength(m);
            end
            
            if g.is_measure_calculated('OverlappingInStrength')
                overlapping_in_strength = g.getMeasureValue('OverlappingInStrength');
            else
                overlapping_in_strength = OverlappingInStrength(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            weighted_multiplex_in_participation = zeros(N(1), 1);
            for li = 1:1:L
                weighted_multiplex_in_participation = weighted_multiplex_in_participation + (in_strength{li}./overlapping_in_strength{1}).^2;
            end
            weighted_multiplex_in_participation = L / (L - 1) * (1 - weighted_multiplex_in_participation);
            weighted_multiplex_in_participation(isnan(weighted_multiplex_in_participation)) = 0;  % Should return zeros, since NaN happens when in_strength = 0 and overlapping_in_strength = 0 for all regions
            weighted_multiplex_in_participation = {weighted_multiplex_in_participation};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multiplex in-participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'WeightedMultiplexInParticipation';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the weighted multiplex in-participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Weighted multiplex in-participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the weighted multiplex in-participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % weighted multiplex in-participation measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The weighted multiplex in-participation of a node is the heterogeneity ' ...
                'of its number of in-neighbours across the layers. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to WeightedMultiplexInParticipation
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to WeightedMultiplexInParticipation. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of WeightedMultiplexInParticipation
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of weighted multiplex in-participation measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of WeightedMultiplexInParticipation
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the measure scope
            % of weighted multiplex in-participation measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of WeightedMultiplexInParticipation
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the parametricity
            % of weighted multiplex in-participation measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with WeightedMultiplexInParticipation 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to weighted multiplex in-participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with WeightedMultiplexInParticipation
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to weighted multiplex in-participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedMultiplexInParticipation');
        end
    end
end