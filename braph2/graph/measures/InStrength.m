classdef InStrength < Measure
    % InStrength In-strength measure
    % InStrength provides the in-strength of a node for weighted 
    % directed (WD) graphs.
    %
    % It is calculated as the sum of all weights of the inward edges
    % connected to a node within a layer, i.e., it is the sum of the 
    % columns of the adjacency matrix. 
    %
    % InStrength methods:
    %   InStrength                  - constructor
    %
    % InStrength descriptive methods (Static)
    %   getClass                    - returns the in-strength class
    %   getName                     - returns the name of in-strength measure
    %   getDescription              - returns the description of in-strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope 
    %   getMeasure                  - returns the strength class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OutStrength, GraphWD, MultiplexGraphWD.
    
    methods
        function m = InStrength(g, varargin)
            % INSTRENGTH(G) creates in-strength with default properties.
            % G is a weighted directed graph (e.g, an instance of GraphWU 
            % or MultiplexGraphWU).
            %
            % See also Measure, OutStrength, GraphWD, MultiplexGraphWD.

            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function in_strength = calculate(m)
            % CALCULATE calculates the in-strength value of a node
            %
            % INSTRENGTH = CALCULATE(M) returns the value of the in-strength 
            % of a node.
            %
            % See also Measure, OutStrength, GraphWU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            
            in_strength = cell(g.layernumber(), 1);      
            for li = 1:1:g.layernumber()
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                in_strength(li) = {sum(Aii, 1)'};  % calculates the in-strength of a node for layer li
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-strength
            % measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'InStrength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-strength measure.
            %
            % See also getClass, getDescription.
            
            name = 'In-strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-strength measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The in-strength of a node is ' ...
                'the sum of the weights of all ' ...
                'the inward edges connected to a node within a layer ' ...
                'for weighted directed (WD) graphs. ' ...
                'In-strengths are calculated as sums ' ...
                'over colums of the weighted connectivity matrix.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InStrength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InStrength. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InStrength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of in-strength measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InStrength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of in-strength measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of InStrength
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of in-strength measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with InStrength
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to in-strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber.
            
            list = { ...
                'GraphWD' ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with InStrength 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to in-strength.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('InStrength');
        end
    end
end