classdef OutStrength < Measure
    % OutStrength Out-strength measure
    % OutStrength provides the out-strength of a node for weighted 
    % directed (WD) graphs.
    %
    % It is calculated as the sum of all weights of the outward edges
    % connected to a node, i.e., it is the sum of the columns of the 
    % adjacency matrix. 
    %
    % OutStrength methods:
    %   OutStrength                 - constructor
    %
    % OutStrength descriptive methods (Static)
    %   getClass                    - returns the out-strength class
    %   getName                     - returns the name of out-strength measure
    %   getDescription              - returns the description of out-strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope 
    %   getMeasure                  - returns the strength class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InStrength, GraphWD, MultiplexGraphWD.
    
    methods
        function m = OutStrength(g, varargin)
            % OUTSTRENGTH(G) creates out-strength with default properties.
            % G is a weighted directed (WD) graph (e.g, an instance of GraphWD 
            % or MultiplexGraphWD).
            %
            % See also Measure, InStrength, GraphWD, MultiplexGraphWD.

            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function out_strength = calculate(m)
            % CALCULATE calculates the out-strength value of a node
            %
            % OUTSTRENGTH = CALCULATE(M) returns the value of the out-strength 
            % of a node.
            %
            % See also Measure, InStrength, GraphWD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix or 2D-cell array 
            
            out_strength = cell(g.layernumber(), 1);      
            for li = 1:1:g.layernumber()
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                out_strength(li) = {sum(Aii, 2)};  % calculates the out-strength of a node for layer li
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the out-strength
            % measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'OutStrength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-strength measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Out-strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-strength measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The out-strength of a node is ' ...
                'the sum of the weights of all ' ...
                'the outward edges connected to a node ' ...
                'for weighted directed (WD) graphs. ' ...
                'Out-strengths are calculated as sums ' ...
                'over colums of the weighted connectivity matrix.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OutStrength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutStrength. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutStrength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of out-strength measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutStrength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of out-strength measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OutStrength.
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to out-strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphWD' ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OutStrength 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to out-strength.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutStrength');
        end
    end
end