classdef MultiplexParticipation < Degree
    % MultiplexParticipation Multiplex participation measure
    % MultiplexParticipation provides the multiplex participation of a node for binary 
    % undirected (BU) and weighted undirected (WU) multiplexes. 
    %
    % It is the homogeneity of the number of neighbours of a node across the layers.
    % It is calcualted as:
    % Pi = L/(L - 1) [1 - sum_{l=1}^{L} (ki(l)/oi)^2]
    % where L is the number of layers, ki(l) is the degree in the l-th
    % layer and oi is the overlapping degree of the node.
    % Pi = 1 when the degree is the same in all layers and Pi = 0 when a
    % node has non-zero degree in only one layer.
    % 
    % MultiplexParticipation methods:
    %   MultiplexParticipation      - constructor
    %
    % MultiplexParticipation methods (Static)
    %   getClass                    - returns the multiplex participation class
    %   getName                     - returns the name of multiplex participation measure
    %   getDescription              - returns the description of multiplex participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Degree, OverlappingDegree, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = MultiplexParticipation(g, varargin)
            % MULTIPLEXPARTICIPATION(G) creates multiplex participation with default properties.
            % G is an undirected multiplex (i.e., an instance of
            % MultiplexGraphBU or MultiplexGraphWU).
            %
            % See also Measure, Degree, OverlappingDegree, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@Degree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multiplex_participation = calculate(m)
            % CALCULATE calculates the multiplex participation value of a multiplex
            %
            % MULTIPLEXPARTICIPATION = CALCULATE(M) returns the value of the multiplex
            % participation of a multiplex.
            %
            % See also Measure, Degree, OverlappingDegree, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Degree')
                degree = g.getMeasureValue('Degree');
            else
                degree = calculate@Degree(m);
            end
            
            if g.is_measure_calculated('OverlappingDegree')
                overlapping_degree = g.getMeasureValue('OverlappingDegree');
            else
                overlapping_degree = OverlappingDegree(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            multiplex_participation = zeros(N(1), 1);
            for li = 1:1:L
                multiplex_participation = multiplex_participation + (degree{li}./overlapping_degree{1}).^2;
            end
            multiplex_participation = L / (L - 1) * (1 - multiplex_participation);
            multiplex_participation(isnan(multiplex_participation)) = 0;  % Should return zeros, since NaN happens when degree = 0 and overlapping degree = 0 for all regions
            multiplex_participation = {multiplex_participation};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multiplex participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'MultiplexParticipation';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multiplex participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Multiplex participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multiplex participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multiplex participation measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The multiplex participation of a node is the homogeneity ' ...
                'of its number of neighbours across the layers. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultiplexParticipation
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultiplexParticipation. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultiplexParticipation
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multiplex participation measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultiplexParticipation
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multiplex participation measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of MultiplexParticipation
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of multiplex participation measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with MultiplexParticipation 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multiplex participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with MultiplexParticipation
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to multiplex participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('MultiplexParticipation');
        end
    end
end