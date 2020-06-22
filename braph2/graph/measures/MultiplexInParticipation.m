classdef MultiplexInParticipation < InDegree
    % MultiplexInParticipation Multiplex in-participation measure
    % MultiplexInParticipation provides the multiplex in-participation of a node for binary 
    % undirected (BU) and weighted undirected (WU) multiplexes. 
    %
    % It is the heterogenerity of the number of inward neighbours of a node across the layers.
    % It is calcualted as:
    % Pi = L/(L - 1) [1 - sum_{l=1}^{L} (ki(l)/oi)^2]
    % where L is the numebr of layers, ki(l) is the in-degree in the l-th
    % layer and oi is the overlapping in-degree of the node.
    % Pi = 1 when the in-degree is the same in all layers and Pi = 0 when a
    % node has non-zero in-degree in only one layer.
    % 
    % MultiplexInParticipation methods:
    %   MultiplexInParticipation    - constructor
    %
    % MultiplexInParticipation methods (Static)
    %   getClass                    - returns the multiplex in-participation class
    %   getName                     - returns the name of multiplex in-participation measure
    %   getDescription              - returns the description of multiplex in-participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InDegree, OverlappingInDegree, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = MultiplexInParticipation(g, varargin)
            % MULTIPLEXINPARTICIPATION(G) creates multiplex in-participation with default properties.
            % G is a directed multiplex (i.e., an instance of
            % MultiplexGraphBD or MultiplexGraphWD).
            %
            % See also Measure, InDegree, OverlappingInDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@InDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multiplex_in_participation = calculate(m)
            % CALCULATE calculates the multiplex in-participation value of a multiplex
            %
            % MULTIPLEXINPARTICIPATION = CALCULATE(M) returns the value of the multiplex
            % in-participation of a multiplex.
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
            
            multiplex_in_participation = zeros(N(1), 1);
            for li = 1:1:L
                multiplex_in_participation = multiplex_in_participation + (in_degree{li}./overlapping_in_degree{1}).^2;
            end
            multiplex_in_participation = {L / (L - 1) * (1 - multiplex_in_participation)};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multiplex in-participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'MultiplexInParticipation';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multiplex in-participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Multiplex in-participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multiplex in-participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multiplex in-participation measure.
            %
            % See also getClass, getName.

            description = [ ...
                'The multiplex in-participation of a node is the heterogeneity ' ...
                'of its number of inward neighbours across the layers. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultiplexInParticipation
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultiplexInParticipation. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultiplexInParticipation
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multiplex in-participation measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultiplexInParticipation
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multiplex in-participation measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with MultiplexInParticipation 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multiplex in-participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with MultiplexInParticipation
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to multiplex in-participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('MultiplexInParticipation');
        end
    end
end