classdef WeightedMultiplexParticipationAv < WeightedMultiplexParticipation
    % WeightedMultiplexParticipationAv Average wegihted multiplex participation measure
    % WeightedMultiplexParticipationAv provides the average weighted multiplex 
    % participation of a node for weighted undirected (WU) multiplexes. 
    %
    % It is the average of the heterogenerity of the number of neighbours of a node across the layers.
    % 
    % WeightedMultiplexParticipationAv methods:
    %   WeightedMultiplexParticipationAv - constructor
    %
    % WeightedMultiplexParticipationAv methods (Static)
    %   getClass                    - returns the average weighted multiplex participation class
    %   getName                     - returns the name of average weighted multiplex participation measure
    %   getDescription              - returns the description of average weighted multiplex participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the average weighted multiplex class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, WeightedMultiplexParticipation, Strength, OverlappingStrength, MultiplexGraphWU.
    
    methods
        function m = WeightedMultiplexParticipationAv(g, varargin)
            % WEIGHTEDMULTIPLEXPARTICIPATIONAV(G) creates average weighted multiplex participation with default properties.
            % G is a average weighted undirected multiplex (i.e., an instance of
            % MultiplexGraphWU).
            %
            % See also Measure, WeightedMultiplexParticipation, Strength, OverlappingStrength, MultiplexGraphWU.
            
            m = m@WeightedMultiplexParticipation(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_multiplex_participation_av = calculate(m)
            % CALCULATE calculates the average weighted multiplex participation value of a multiplex
            %
            % WEIGHTEDMULTIPLEXPARTICIPATIONAV = CALCULATE(M) returns the value
            % of the average weighted multiplex participation of a multiplex.
            %
            % See also Measure, WeightedMultiplexParticipation, Strength, OverlappingStrength, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('WeightedMultiplexParticipation')
                weighted_multiplex_participation = g.getMeasureValue('WeightedMultiplexParticipation');
            else
                weighted_multiplex_participation = calculate@WeightedMultiplexParticipation(m);
            end
            
            weighted_multiplex_participation_av = {mean(weighted_multiplex_participation{1})}; 
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average multiplex participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'WeightedMultiplexParticipationAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average weighted multiplex participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average weighted multiplex participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average weighted multiplex participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average weighted multiplex participation measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average weighted multiplex participation of a network is the heterogeneity ' ...
                'of its number of neighbours across the layers. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to WeightedMultiplexParticipationAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to WeightedMultiplexParticipationAv. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of WeightedMultiplexParticipationAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average weighted multiplex participation measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of WeightedMultiplexParticipationAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average weighted multiplex participation measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of WeightedMultiplexParticipationAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average weighted multiplex participation measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with WeightedMultiplexParticipationAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average weighted multiplex participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with WeightedMultiplexParticipationAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average weighted multiplex participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedMultiplexParticipationAv');
        end
    end
end