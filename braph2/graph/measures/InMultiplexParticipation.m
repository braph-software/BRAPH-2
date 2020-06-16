classdef InMultiplexParticipation < InDegree
    % InMultiplexParticipation In-multiplex participation measure
    % InMultiplexParticipation provides the in-multiplex participation of a node for binary 
    % undirected (BU) and weighted undirected (WU) multiplexes. 
    %
    % It is calculated as the number of inward neighbours of a node across the
    % layers.
    % 
    % InMultiplexParticipation methods:
    %   InMultiplexParticipation    - constructor
    %
    % InMultiplexParticipation methods (Static)
    %   getClass                    - returns the in-multiplex participation class
    %   getName                     - returns the name of in-multiplex participation measure
    %   getDescription              - returns the description of in-multiplex participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InDegree, OverlappingInDegree, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = InMultiplexParticipation(g, varargin)
            % INMULTIPLEXPARTICIPATION(G) creates in-multiplex participation with default properties.
            % G is a directed multiplex (i.e., an instance of
            % MultiplexGraphBD or MultiplexGraphWD).
            %
            % See also Measure, InDegree, OverlappingInDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@InDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function in_multiplex_participation = calculate(m)
            % CALCULATE calculates the in-multiplex participation value of a multiplex
            %
            % INMULTIPLEXPARTICIPATION = CALCULATE(M) returns the value of the in-multiplex
            % participation of a multiplex.
            %
            % See also Measure, InDegree, OverlappingInDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InDegree')
                in_degree = g.getMeasureValue('InDegree');
            else
                in_degree = calculate@InDegree(m);
            end
            
            if g.is_measure_calculated('OverlappingInDegree')
                overlapping_in_degree = g.getMeasureValue('OverlappingInDegree');
            else
                overlapping_in_degree = OverlappingInDegree(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            in_multiplex_participation = zeros(N(1), 1);
            for li = 1:1:L
                in_multiplex_participation = in_multiplex_participation + (in_degree{li}./overlapping_in_degree{1}).^2;
            end
            in_multiplex_participation = {L / (L - 1) * (1 - in_multiplex_participation)};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-multiplex participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'InMultiplexParticipation';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-multiplex participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'In-multiplex participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-multiplex participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-multiplex participation measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The in-multiplex participation of a node is the the heterogeneity ' ...
                'of the number of inward neighbours of a node across the layers. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InMultiplexParticipation
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InMultiplexParticipation. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InMultiplexParticipation
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of in-multiplex participation measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InMultiplexParticipation
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of in-multiplex participation measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with InMultiplexParticipation 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to in-multiplex participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with InMultiplexParticipation
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to in-multiplex participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('InMultiplexParticipation');
        end
    end
end