classdef OutStrengthAv < OutStrength
    % OutStrengthAv < OutStrength: Average out-strength measure
    % OutStrengthAv provides the average out-strength of a graph for
    % weighted directed (WD) graphs. It is calculated as the average of the
    % sum of the weights of all outward edges connected to the node.
    % 
    % OutStrengthAv methods:
    %   OutStrengthAv               - constructor with OutStrength properties.
    %
    % OutStrengthAv methods (Access=protected):
    %   calculate                   - calculates the average out-strength of a graph.
    %
    % OutStrengthAv methods (Static)
    %   getClass                    - returns the average out-strength class.
    %   getName                     - returns the name of average out-strength measure.
    %   getDescription              - returns the description of average out-strength measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average out-strength measure is global.
    %   is_nodal                    - boolean, checks if average out-strength measure is nodal.
    %   is_binodal                  - boolean, checks if average out-strength measure if binodal.
    %   getMeasure                  - returns the average out-strength class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, OutStrength, InStrengthAv, StrengthAv.
    
    methods
        function m = OutStrengthAv(g, varargin)
            % OUTSTRENGTHAV(G) creates average out-strength with default OutStrength
            % properties. G is a graph (e.g, an instance of Graph WD).
            %
            % OUTSTRENGTHAV(G, 'VALUE', VALUE) creates average out-strength, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of GraphWD).
            %
            % See also Measure, Graph, OutStrength, InStrengthAv, StrengthAv.
            
            m = m@OutStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function out_strength_av = calculate(m)
            % CALCULATE calculates the average out-strength value of a
            % graph
            %
            % OUTSTRENGTHAV = CALCULATE(M) returns the value of the average 
            % out-strength of a graph.
            
            g = m.getGraph(); % graph from measure class

            if g.is_measure_calculated('OutStrength')
                out_strength = g.getMeasureValue('OutStrength');
            else
                out_strength = calculate@OutStrength(m);
            end
            
            out_strength_av = mean(out_strength);
        end
    end
    methods(Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class
            %
            % MEASURE_CLASS = GETCLASS() returns the class of the average out-strength
            % measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'OutStrengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average out-strength measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Average Out-Strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-strength description
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-strength measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average out-strength of a graph is ' ...
                'the average of the sum of the weights ' ...
                'of all outward edges connected to the node. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % OutStrengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutStrengthAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if average out-strength measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average out-strenth measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal.
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average out-strength measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to OutStrengthAv.
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array
            % of compatible graph classes to OutStrengthAv.
            % The measure will not work if the graph is not compatible.
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphWD', ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to OutStrengthAv.
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to OutStrengthAv.
            %
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutStrengthAv');
        end
    end
end