classdef Strength < Measure
    % Strength Strength measure
    % Strength provides the strength of a node for weighted 
    % undirected (WU) graphs.
    %
    % It is calculated as the sum of all weights of the edges connected to
    % a node within a layer, i.e., it is the sum of the rows or the columns
    % of the adjacency matrix.
    %
    % Strength methods:
    %   Strength                    - constructor
    %
    % Strength descriptive methods (Static)
    %   getClass                    - returns the strength class
    %   getName                     - returns the name of strength measure
    %   getDescription              - returns the description of strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope 
    %   getMeasure                  - returns the strength class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphWU, MultiplexGraphWU.
    
    methods
        function m = Strength(g, varargin)
            % STRENGTH(G) creates strength with default properties.
            % G is a weighted undirected (WU) graph (e.g, an instance of 
            % GraphWU or MultiplexGraphWU).
            %
            % See also Measure, GraphWU, MultiplexGraphWU.

            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function strength = calculate(m)
            % CALCULATE calculates the strength value of a graph
            %
            % STRENGTH = CALCULATE(M) returns the value of the strength of a
            % weighted undirected (WU) graph or multiplex.
            %
            % See also Measure, GraphWU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            
            strength = cell(g.layernumber(), 1);
            for li = 1:1:g.layernumber()
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                strength(li) = {sum(Aii, 2)};  % calculates the strength of a node for layer li
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the strength
            % measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'Strength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the strength measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % strength measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The strength of a node is ' ...
                'the sum of the weights of ' ...
                'all the edges connected to a node within a layer ' ...
                'for weighted undirected (WU) graphs. ' ...
                'Strengths are calculated ' ...
                'as sums over either rows or colums of ' ...
                'the weighted connectivity matrix. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Strength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Strength. Empty array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Strength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of strength measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Strength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of strength measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with Strength
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphWU' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with Strength 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to strength.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Strength');
        end
    end
end