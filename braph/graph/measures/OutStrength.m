classdef OutStrength < Measure
    % OutStrength < Measure: Out-Strength measure
    % OutStrength provides the sum of all weights of the outward edges
    % connected to a node. For weighted directed (WD) graphs the OutStrength
    % is the sum over the rows of the adjacency matrix.
    %
    % OutStrength methods:
    %   OutStrength                 - constructor with Measure properties.
    %
    % OutStrength methods (Access=protected):
    %   calculate                   - calculates the out-strength of a node.
    %
    % OutStrength methods (Static)
    %   getClass                    - returns the out-strength class.
    %   getName                     - returns the name of out-strength measure.
    %   getDescription              - returns the description of out-strength measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if out-strength measure is global.
    %   is_nodal                    - boolean, checks if out-strength measure is nodal.
    %   is_binodal                  - boolean, checks if out-strength measure if binodal.
    %   getMeasure                  - returns the out-strength class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Efficiency.
    
    methods
        function m = OutStrength(g, varargin)
            % OUTSTRENGTH(G) creates out-strength with default measure
            % properties. G is a graph (e.g, an instance of Graph WD).
            %
            % OUTSTRENGTH(G, 'VALUE', VALUE) creates out-strength, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphWD).
            %
            % See also Measure, Graph, Strength, Distance, Efficiency.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function out_strength = calculate(m)
            % CALCULATE calculates the out-strength value of a node
            %
            % OUTSTRENGTH = CALCULATE(M) returns the value of the out-strength
            % of a node.
            
            g = m.getGraph(); % graph from measure class
            A = g.getA(); % adjency matrix of the graph
            out_strength = sum(A, 2);  % row sum of A
        end
    end
    methods (Static)
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
            
            name = 'Out-Strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-strength description
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-strength measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The out-strength of a node is ' ...
                'the sum of the weights of all ' ...
                'the outward edges connected to a node.' ...
                'For WD graphs, out-strengths are calculated ' ...
                'as sums over rows of ' ...
                'the weighted connectivity matrix. ' ...
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
        function bool = is_global()
            % IS_GLOBAL checks if out-strength measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if out-strenth measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal.
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if out-strength measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to OutStrength.
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array
            % of compatible graph classes to OutStrength.
            % The measure will not work if the graph is not compatible.
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to OutStrength.
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to OutStrength.
            %
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutStrength');
        end
    end
end