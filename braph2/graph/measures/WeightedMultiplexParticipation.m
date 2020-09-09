classdef WeightedMultiplexParticipation < Strength
    % WeightedMultiplexParticipation Weighted multiplex participation measure
    % WeightedMultiplexParticipation provides the w eightedmultiplex participation 
    % of a node for weighted undirected (WU) multiplexes. 
    %
    % It is the heterogenerity of the number of neighbours of a node across the layers.
    % It is calcualted as:
    % Pi = L/(L - 1) [1 - sum_{l=1}^{L} (si(l)/oi)^2]
    % where L is the number of layers, si(l) is the strength in the l-th
    % layer and oi is the overlapping strength of the node.
    % Pi = 1 when the strength is the same in all layers and Pi = 0 when a
    % node has non-zero strength in only one layer.
    % 
    % WeightedMultiplexParticipation methods:
    %   WeightedMultiplexParticipation - constructor
    %
    % WeightedMultiplexParticipation methods (Static)
    %   getClass                    - returns the weighted multiplex participation class
    %   getName                     - returns the name of weighted multiplex participation measure
    %   getDescription              - returns the description of weighted multiplex participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Strength, OverlappingStrength, MultiplexGraphWU.
    
    methods
        function m = WeightedMultiplexParticipation(g, varargin)
            % WEIGHTEDMULTIPLEXPARTICIPATION(G) creates weighted multiplex participation with default properties.
            % G is a weighted undirected multiplex (i.e., an instance of
            % MultiplexGraphWU).
            %
            % See also Measure, Strength, OverlappingStrength, MultiplexGraphWU.
            
            m = m@Strength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_multiplex_participation = calculate(m)
            % CALCULATE calculates the weighted multiplex participation value of a multiplex
            %
            % WEIGHTEDMULTIPLEXPARTICIPATION = CALCULATE(M) returns the value
            % of the weighted multiplex participation of a multiplex.
            %
            % See also Measure, Strength, OverlappingStrength, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Strength')
                strength = g.getMeasureValue('Strength');
            else
                strength = calculate@Strength(m);
            end
            
            if g.is_measure_calculated('OverlappingStrength')
                overlapping_strength = g.getMeasureValue('OverlappingStrength');
            else
                overlapping_strength = OverlappingStrength(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            weighted_multiplex_participation = zeros(N(1), 1);
            for li = 1:1:L
                weighted_multiplex_participation = weighted_multiplex_participation + (strength{li}./overlapping_strength{1}).^2;
            end
            weighted_multiplex_participation = {L / (L - 1) * (1 - weighted_multiplex_participation)};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multiplex participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'WeightedMultiplexParticipation';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the weighted multiplex participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Weighted multiplex participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the weighted multiplex participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % weighted multiplex participation measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The weighted multiplex participation of a node is the heterogeneity ' ...
                'of its number of neighbours across the layers. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to WeightedMultiplexParticipation
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to WeightedMultiplexParticipation. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of WeightedMultiplexParticipation
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of weighted multiplex participation measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of WeightedMultiplexParticipation
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of weighted multiplex participation measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of WeightedMultiplexParticipation
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of weighted multiplex participation measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with WeightedMultiplexParticipation 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to weighted multiplex participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with WeightedMultiplexParticipation
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to weighted multiplex participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedMultiplexParticipation');
        end
    end
end