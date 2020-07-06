classdef MultiplexOutParticipation < OutDegree
    % MultiplexOutParticipation Multiplex out-participation measure
    % MultiplexOutParticipation provides the multiplex out-participation of a node for binary 
    % undirected (BU) and weighted undirected (WU) multiplexes. 
    %
    % It is the heterogenerity of the number of outward neighbours of a node across the layers.
    % It is calcualted as:
    % Pi = L/(L - 1) [1 - sum_{l=1}^{L} (ki(l)/oi)^2]
    % where L is the numebr of layers, ki(l) is the out-degree in the l-th
    % layer and oi is the overlapping out-degree of the node.
    % Pi = 1 when the out-degree is the same in all layers and Pi = 0 when a
    % node has non-zero out-degree in only one layer.
    % 
    % MultiplexOutParticipation methods:
    %   MultiplexOutParticipation   - constructor
    %
    % MultiplexOutParticipation methods (Static)
    %   getClass                    - returns the multiplex out-participation class
    %   getName                     - returns the name of multiplex out-participation measure
    %   getDescription              - returns the description of multiplex out-participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OutDegree, OverlappingOutDegree, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = MultiplexOutParticipation(g, varargin)
            % MULTIPLEXOUTPARTICIPATION(G) creates multiplex out-participation with default properties.
            % G is a directed multiplex (i.e., an instance of
            % MultiplexGraphBD or MultiplexGraphWD).
            %
            % See also Measure, OutDegree, OverlappingOutDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@OutDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multiplex_out_participation = calculate(m)
            % CALCULATE calculates the multiplex out-participation value of a multiplex
            %
            % MULTIPLEXOUTPARTICIPATION = CALCULATE(M) returns the value of the multiplex
            % out-participation of a multiplex.
            %
            % See also Measure, OutDegree, OverlappingOutDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutDegree')
                out_degree = g.getMeasureValue('OutDegree');
            else
                out_degree = calculate@OutDegree(m);
            end
            
            if g.is_measure_calculated('OverlappingOutDegree')
                overlapping_out_degree = g.getMeasureValue('OverlappingOutDegree');
            else
                overlapping_out_degree = OverlappingOutDegree(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            multiplex_out_participation = zeros(N(1), 1);
            for li = 1:1:L
                multiplex_out_participation = multiplex_out_participation + (out_degree{li}./overlapping_out_degree{1}).^2;
            end
            multiplex_out_participation = {L / (L - 1) * (1 - multiplex_out_participation)};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multiplex out-participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'MultiplexOutParticipation';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multiplex out-participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Multiplex out-participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multiplex out-participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multiplex out-participation measure.
            %
            % See also getClass, getName.

            description = [ ...
                'The multiplex out-participation of a node is the heterogeneity ' ...
                'of its number of outward neighbours across the layers. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultiplexOutParticipation
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultiplexOutParticipation. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultiplexOutParticipation
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multiplex out-participation measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultiplexOutParticipation
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multiplex out-participation measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with MultiplexOutParticipation 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multiplex out-participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with MultiplexOutParticipation
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to multiplex out-participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('MultiplexOutParticipation');
        end
    end
end