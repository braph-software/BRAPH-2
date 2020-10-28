classdef InStrengthAv < InStrength
    % InStrengthAv < InStrength: Average in-strength measure
    % InStrengthAv provides the average in-strength of a graph for
    % weighted directed (WD) graphs. It is calculated as the average of the
    % sum of the weights of all inward edges connected to the node.
    % 
    % InStrengthAv methods:
    %   InStrengthAv                - constructor with InStrength properties.
    %
    % InStrengthAv methods (Access=protected):
    %   calculate                   - calculates the average in-strength of a graph.
    %
    % InStrengthAv methods (Static)
    %   getClass                    - returns the average in-strength class.
    %   getName                     - returns the name of average in-strength measure.
    %   getDescription              - returns the description of average in-strength measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average in-strength measure is global.
    %   is_nodal                    - boolean, checks if average in-strength measure is nodal.
    %   is_binodal                  - boolean, checks if average in-strength measure if binodal.
    %   getMeasure                  - returns the average in-strength class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, InStrength, OutStrengthAv, StrengthAv.
    
    methods
        function m = InStrengthAv(g, varargin)
            % INSTRENGTHAV(G) creates average in-strength with default InStrength
            % properties. G is a graph (e.g, an instance of Graph WD).
            %
            % INSTRENGTHAV(G, 'VALUE', VALUE) creates average in-strength, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of GraphWD).
            %
            % See also Measure, Graph, OutStrength, InStrengthAv, StrengthAv.
            
            m = m@InStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function in_strength_av = calculate(m)
            % CALCULATE calculates the average in-strength value of a
            % graph
            %
            % INSTRENGTHAV = CALCULATE(M) returns the value of the average 
            % in-strength of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InStrength')
                in_strength = g.getMeasureValue('InStrength');
            else
                in_strength = calculate@InStrength(m);
            end
            
            in_strength_av = mean(in_strength);
        end
    end
    methods(Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class
            %
            % MEASURE_CLASS = GETCLASS() returns the class of the average in-strength
            % measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InStrengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-strength measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Average In-Strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-strength description
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-strength measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average in-strength of a graph is ' ...
                'the average of the sum of the weights ' ...
                'of all inward edges connected to the node. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % InStrengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InStrengthAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if average in-strength measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average in-strenth measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal.
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average in-strength measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InStrengthAv.
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array
            % of compatible graph classes to InStrengthAv.
            % The measure will not work if the graph is not compatible.
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphWD', ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to InStrengthAv.
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InStrengthAv.
            %
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InStrengthAv');
        end
    end
end
