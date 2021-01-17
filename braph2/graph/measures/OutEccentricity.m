classdef OutEccentricity < Measure
    % OutEccentricity Out-eccentricity measure
    % OutEccentricity provides the out-eccentricity of a node for binary directed
    % (BD) and weighted directed (WD) graphs. 
    %
    % It is calculated as the maximal shortest out-path length between a node
    % and any other node within a layer.
    % 
    % OutEccentricity methods:
    %   OutEccentricity             - constructor 
    % 
    % OutEccentricity descriptive methods (Static)
    %   getClass                    - returns the out-eccentricity class
    %   getName                     - returns the name of out-eccentricity measure
    %   getDescription              - returns the description of out-eccentricity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the out-eccentricity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Eccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OutEccentricity(g, varargin)
            % OUTECCENTRICITY(G) creates out-eccentricity with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD,
            % MultiplexGraphBD, MultiplexGraphWD). 
            %   
            % OUTECCENTRICITY(G, 'EccentricityRule', ECCENTRICITIRULE) creates out-eccentricity 
            % measure and initializes the property EccentricityRule with ECCENTRICITYRULE. 
            % Admissible RULE options are:
            % ECCENTRICITYRULE = 'default' (default) - calculates OUTECCENTRICITY of global graph.
            %                       'subgraphs' - calculates OUTECCENTRICITY within connected subgraphs.
            %
            % OUTECCENTRICITY(G, 'VALUE', VALUE) creates out-eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphWD,
            % MultiplexGraphBD, MultiplexGraphWD). 
            %   
            % See also Measure, Eccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_eccentricity = calculate(m)
            % CALCULATE calculates the out-eccentricity value of a node
            %
            % out-eccentricity = CALCULATE(M) returns the value of the out-eccentricity of a
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
            out_eccentricity = cell(L, 1);
            for li = 1:1:L
                switch(ecc_rule)
                    case {'subgraphs'}
                        out_eccentricity(li)  = {max(D{li}.*(D{li}~=Inf), [], 2)}; 
                    otherwise  % {'default'}
                        out_eccentricity(li)  = {max(D{li}, [], 2)};
                end    
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the out-eccentricity measure.
            %
            % See also getName(), getDescription(). 
            measure_class = 'OutEccentricity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-eccentricity measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Out-eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The out-eccentricity of a node is ' ...
                'the maximal shortest out-path length between a ' ...
                'node and any other node within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OutEccentricity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutEccentricityRule. 
            % ECCENTRICITYRULE = 'default' (default) - calculates OUTECCENTRICITY of global graph.
            %                       'subgraphs' - calculates OUTECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'EccentricityRule', BRAPH2.STRING, 'default', {'default', 'subgraphs'};
                };
        end
       function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutEccentricity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of out-eccentricity measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutEccentricity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of out-eccentricity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OutEccentricity
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of out-eccentricity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with OutEccentricity
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to out-eccentricity. 
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
            % graphs with OutEccentricity
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to out-eccentricity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutEccentricity');
        end
    end
end