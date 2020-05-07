classdef InStrength < Measure
    % InStrength < Measure: In-Strength measure
    % InStrength provides the sum of all weights of the inward edges
    % connected to a node. For weighted directed (WD) graphs the InStrength
    % is the sum over the columns of the adjacency matrix.
    %
    % InStrength methods:
    %   InStrength                      - constructor with Measure properties.
    %
    % InStrength methods (Access=protected):
    %   calculate                   - calculates the in-strength of a node.
    %
    % InStrength methods (Static)
    %   getClass                    - returns the in-strength class.
    %   getName                     - returns the name of in-strength measure.
    %   getDescription              - returns the description of in-strength measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if in-strength measure is global.
    %   is_nodal                    - boolean, checks if in-strength measure is nodal.
    %   is_binodal                  - boolean, checks if in-strength measure if binodal.
    %   getMeasure                  - returns the in-strength class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Degree, Distance, Efficiency.
    
    methods
        function m = InStrength(g, varargin)
            % INSTRENGTH(G) creates in-strength with default measure
            % properties. G is a graph (e.g, an instance of Graph WD).
            %
            % INSTRENGTH(G, 'VALUE', VALUE) creates in-strength, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphWD).
            %
            % See also Measure, Graph, Degree, Distance, Efficiency.

            m = m@Measure(g, varargin{:});
        end
    end    
    methods (Access=protected)
        function in_strength = calculate(m)
            % CALCULATE calculates the IN_STRENGTH value of a node
            %
            % INSTRENGTH = CALCULATE(M) returns the value of the IN_SRENGTH
            % of a node.
            
            g = m.getGraph(); % graph from measure class
            A = g.getA(); % adjency matrix of the graph
            in_strength = sum(A, 1)';  % column sum of A        
        end
    end  
    methods (Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class
            %
            % MEASURE_CLASS = GETCLASS() returns the class of the in-strength
            % measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InStrength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-strength measure.
            %
            % See also getClass(), getDescription().
            
            name = 'In-Strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-strength description
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-strength measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The in-strength of a node is ' ...
                'the sum of the weights of all ' ...
                'the inward edges connected to a node.' ...
                'For WD graphs, in-strengths are calculated ' ...
                'as sums over columns of ' ...
                'the weighted connectivity matrix. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InStrength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InStrength. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()   
            % IS_GLOBAL checks if in-strength measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if in-strenth measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal.
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if in-strength measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to in-strength.
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array
            % of compatible graph classes to in-strength.
            % The measure will not work if the graph is not compatible.
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to in-strength.
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to in-strength.
            %
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InStrength');
        end
    end
end