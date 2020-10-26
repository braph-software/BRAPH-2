classdef WeightedMultiplexOutParticipation < OutStrength
    % WeightedMultiplexOutParticipation Weighted multiplex out-participation measure
    % WeightedMultiplexOutParticipation provides the weighted multiplex out-participation 
    % of a node for weighted directed (WD) multiplexes. 
    %
    % It is the heterogenerity of the number of neighbours of a node across the layers.
    % It is calcualted as:
    % Pi = L/(L - 1) [1 - sum_{l=1}^{L} (si(l)/oi)^2]
    % where L is the number of layers, si(l) is the out-strength in the l-th
    % layer and oi is the overlapping out-strength of the node.
    % Pi = 1 when the strength is the same in all layers and Pi = 0 when a
    % node has non-zero strength in only one layer.
    % 
    % WeightedMultiplexOutParticipation methods:
    %   WeightedMultiplexOutParticipation - constructor
    %
    % WeightedMultiplexOutParticipation methods (Static)
    %   getClass                    - returns the weighted multiplex out-participation class
    %   getName                     - returns the name of weighted multiplex out-participation measure
    %   getDescription              - returns the description of weighted multiplex out-participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the weighted multiplex out-participation class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OutStrength, OverlappingOutStrength, MultiplexGraphWD.
    
    methods
        function m = WeightedMultiplexOutParticipation(g, varargin)
            % WeightedMultiplexOutParticipation(G) creates weighted multiplex out-participation with default properties.
            % G is a weighted directed multiplex (i.e., an instance of
            % MultiplexGraphWD).
            %
            % See also Measure, OutStrength, OverlappingOutStrength, MultiplexGraphWD.
            
            m = m@OutStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_multiplex_out_participation = calculate(m)
            % CALCULATE calculates the weighted multiplex out-participation value of a multiplex
            %
            % WeightedMultiplexOutParticipation = CALCULATE(M) returns the value
            % of the weighted multiplex out-participation of a multiplex.
            %
            % See also Measure, OutStrength, OverlappingOutStrength, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutStrength')
                out_strength = g.getMeasureValue('OutStrength');
            else
                out_strength = calculate@OutStrength(m);
            end
            
            if g.is_measure_calculated('OverlappingOutStrength')
                overlapping_out_strength = g.getMeasureValue('OverlappingOutStrength');
            else
                overlapping_out_strength = OverlappingOutStrength(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            weighted_multiplex_out_participation = zeros(N(1), 1);
            for li = 1:1:L
                weighted_multiplex_out_participation = weighted_multiplex_out_participation + (out_strength{li}./overlapping_out_strength{1}).^2;
            end
            weighted_multiplex_out_participation = L / (L - 1) * (1 - weighted_multiplex_out_participation);
            weighted_multiplex_out_participation(isnan(weighted_multiplex_out_participation)) = 0;  % Should return zeros, since NaN happens when out_strength = 0 and overlapping_ouot_strength = 0 for all regions
            weighted_multiplex_out_participation = {weighted_multiplex_out_participation};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multiplex out-participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'WeightedMultiplexOutParticipation';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the weighted multiplex out-participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Weighted multiplex out-participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the weighted multiplex out-participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % weighted multiplex out-participation measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The weighted multiplex out-participation of a node is the heterogeneity ' ...
                'of its number of out-neighbours across the layers. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to WeightedMultiplexOutParticipation
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to WeightedMultiplexOutParticipation. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of WeightedMultiplexOutParticipation
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of weighted multiplex out-participation measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of WeightedMultiplexOutParticipation
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the measure scope
            % of weighted multiplex out-participation measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of WeightedMultiplexOutParticipation
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the parametricity
            % of weighted multiplex out-participation measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with WeightedMultiplexOutParticipation 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to weighted multiplex out-participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with WeightedMultiplexOutParticipation
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to weighted multiplex out-participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedMultiplexOutParticipation');
        end
    end
end