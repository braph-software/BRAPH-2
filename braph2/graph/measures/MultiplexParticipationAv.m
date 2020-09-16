classdef MultiplexParticipationAv < MultiplexParticipation
    % MultiplexParticipationAv Average multiplex participation measure
    % MultiplexParticipationAv provides the average multiplex participation 
    % of a graph for binary undirected (BU) and weighted undirected (WU) multiplexes. 
    %
    % It is the average of the homogeneity of the number of neighbours of 
    % a node across the layers.
    % It is calcualted as the mean of the multiplex participation.
    % 
    % MultiplexParticipationAv methods:
    %   MultiplexParticipationAv    - constructor
    %
    % MultiplexParticipationAv methods (Static)
    %   getClass                    - returns the average multiplex participation class
    %   getName                     - returns the name of average multiplex participation measure
    %   getDescription              - returns the description of average multiplex participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the average multiplex participation class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, MultiplexParticipation, Degree, OverlappingDegree, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = MultiplexParticipationAv(g, varargin)
            % MULTIPLEXPARTICIPATIONAV(G) creates average multiplex participation with default properties.
            % G is an undirected multiplex (i.e., an instance of
            % MultiplexGraphBU or MultiplexGraphWU).
            %
            % See also Measure, MultiplexParticipation, Degree, OverlappingDegree, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@MultiplexParticipation(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multiplex_participation_av = calculate(m)
            % CALCULATE calculates the average multiplex participation value of a multiplex
            %
            % MULTIPLEXPARTICIPATIONAV = CALCULATE(M) returns the value of the 
            % average multiplex participation of a multiplex.
            %
            % See also Measure, MultiplexParticipation, Degree, OverlappingDegree, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('MultiplexParticipation')
                multiplex_participation = g.getMeasureValue('MultiplexParticipation');
            else
                multiplex_participation = calculate@MultiplexParticipation(m);
            end
            
            multiplex_participation_av = {mean(multiplex_participation{1})}; 
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average multiplex participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'MultiplexParticipationAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average multiplex participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average multiplex participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average multiplex participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average multiplex participation measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average multiplex participation of a network is the average ' ...
                'homogeneity of its nodes number of neighbours across the layers. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultiplexParticipationAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultiplexParticipationAv. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultiplexParticipationAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average multiplex participation measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultiplexParticipationAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average multiplex participation measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of MultiplexParticipationAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average multiplex participation measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with MultiplexParticipationAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average multiplex participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with MultiplexParticipationAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average multiplex participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('MultiplexParticipationAv');
        end
    end
end