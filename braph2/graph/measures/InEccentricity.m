classdef InEccentricity < Measure
    % InEccentricity In-eccentricity measure
    % InEccentricity provides the in-eccentricity of a node for binary directed
    % (BD) and weighted directed (WD) graphs.
    % 
    % It is calculated as the maximal shortest in-path length between a node
    % and any other node within a layer.
    % 
    % InEccentricity methods:
    %   InEccentricity              - constructor
    % 
    % InEccentricity descriptive methods (Static)
    %   getClass                    - returns the in-eccentricity class
    %   getName                     - returns the name of in-eccentricity measure
    %   getDescription              - returns the description of in-eccentricity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the in-eccentricity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Eccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = InEccentricity(g, varargin)
            % INECCENTRICITY(G) creates in-eccentricity with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD,
            % MultiplexGraphBD, MultiplexGraphWD). 
            %   
            % INECCENTRICITY(G, 'EccentricityRule', ECCENTRICITYRULE) creates in-eccentricity             
            % measure and initializes the property EccentricityRule with ECCENTRICITYRULE. 
            % Admissible RULE options are:
            % ECCENTRICITYRULE = 'default' (default) - calculates INECCENTRICITY of global graph.
            %                      'subgraphs' - calculates INECCENTRICITY within connected subgraphs.
            %
            % INECCENTRICITY(G, 'VALUE', VALUE) creates in-eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphWD,
            % MultiplexGraphBD, MultiplexGraphWD). 
            %   
            % See also Measure, Eccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.        
           
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_eccentricity = calculate(m)
            % CALCULATE calculates the in-eccentricity value of a node
            %
            % in-eccentricity = CALCULATE(M) returns the value of the in-eccentricity of a
            % node.
            %
            % See also Measure, Eccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            L = g.layernumber();
            
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            ecc_rule = get_from_varargin('default', 'EccentricityRule', m.getSettings());
            in_eccentricity = cell(L, 1);
            for li = 1:1:L
                switch(ecc_rule)
                    case {'subgraphs'}
                        in_eccentricity(li)  = {max(D{li}.*(D{li}~=Inf), [], 1)'}; 
                    otherwise  % {'default'}
                        in_eccentricity(li)  = {max(D{li}, [], 1)'};
                end    
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'InEccentricity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-eccentricity measure.
            %
            % See also getClass(), getDescription().
            
            name = 'In-eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The in-eccentricity of a node is ' ...
                'the maximal shortest in-path length between a ' ...
                'node and any other node within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InEccentricity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InEccentricity.
            % ECCENTRICITYRULE = 'default' (default) - calculates INECCENTRICITY of global graph.
            %                    'subgraphs' - calculates INECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'EccentricityRule', BRAPH2.STRING, 'default', {'default', 'subgraphs'};
                };
        end
       function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InEccentricity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of in-eccentricity measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InEccentricity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of in-eccentricity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of InEccentricity
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of in-eccentricity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with InEccentricity
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to in-eccentricity. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD', ...
                'GraphWD', ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with InEccentricity
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to in-eccentricity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InEccentricity');
        end
    end
end