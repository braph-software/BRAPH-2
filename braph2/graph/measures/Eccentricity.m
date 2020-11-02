classdef Eccentricity < Measure
    % Eccentricity Eccentricity measure
    % Eccentricity provides the eccentricity of a node for binary undirected
    % (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as the maximal shortest path length between a node
    % and any other node within a layer.
    % 
    % Eccentricity methods:
    %   Eccentricity                - constructor 
    %
    % Eccentricity descriptive methods (Static)
    %   getClass                    - returns the eccentricity class
    %   getName                     - returns the name of eccentricity measure
    %   getDescription              - returns the description of eccentricity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the eccentricity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Distance, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = Eccentricity(g, varargin)
            % ECCENTRICITY(G) creates eccentricity with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU, MultiplexGraphWU). 
            %   
            % ECCENTRICITY(G, 'EccentricityRule', ECCENTRICITYRULE) creates eccentricity 
            % measure and initializes the property EccentricityRule with ECCENTRICITYRULE. 
            % Admissible ECCENTRICITYRULE options are:
            % ECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            %
            % ECCENTRICITY(G, 'VALUE', VALUE) creates eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU, MultiplexGraphWU). 
            %   
            % See also Measure, Distance, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.

            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function eccentricity = calculate(m)
            % CALCULATE calculates the eccentricity value of a node
            %
            % ECCENTRICITY = CALCULATE(M) returns the value of the eccentricity of a
            % node.
            %
            % See also Measure, Distance, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            L = g.layernumber();
            
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            ecc_rule = get_from_varargin('default', 'EccentricityRule', m.getSettings());
            eccentricity = cell(L, 1);
            for li = 1:1:L
                switch(ecc_rule)
                    case {'subgraphs'}
                        eccentricity(li)  = {max(D{li}.*(D{li}~=Inf), [], 2)}; 
                    otherwise  % {'default'}
                        eccentricity(li)  = {max(D{li}, [], 2)};
                end    
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'Eccentricity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the eccentricity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The Eccentricity of a node is ' ...
                'the maximal shortest path length between a ' ...
                'node and any other node within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Eccentricity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Eccentricity.
            % ECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'EccentricityRule', BRAPH2.STRING, 'default', {'default', 'subgraphs'};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Eccentricity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of eccentricity measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Eccentricity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of eccentricity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of Eccentricity
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of eccentricity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with Eccentricity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to eccentricity. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBU', ...
                'GraphWU', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with Eccentricity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to eccentricity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Eccentricity');
        end
    end
end