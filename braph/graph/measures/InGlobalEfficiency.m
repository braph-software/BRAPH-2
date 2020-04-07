classdef InGlobalEfficiency < Measure
    % InGlobalEfficiency < Measure: InGlobalEfficiency measure
    % InGlobalEfficiency provides the in-global efficiency of a node for binary directed (BD) and 
    % weighted directed (WD) graphs. It is calculated as average inverse
    % shortest in-path length in the graph. 
    % 
    % InGlobalEfficiency methods:
    %   InGlobalEfficiency          - constructor with Measure properties.
    %
    % InGlobalEfficiency methods (Access=protected):
    %   calculate                   - calculates the in-globalefficiency of a node.
    % 
    % InGlobalEfficiency methods (Static)
    %   getClass                    - returns the in-globalefficiency class.
    %   getName                     - returns the name of in-globalefficiency measure.
    %   getDescription              - returns the description of in-globalefficiency measure.
    %   is_global                   - boolean, checks if in-globalefficiency measure is global.
    %   is_nodal                    - boolean, checks if in-globalefficiency measure is nodal.
    %   is_binodal                  - boolean, checks if in-globalefficiency measure if binodal.
    %   getMeasure                  - returns the in-globalefficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Degree, OutGlobalEfficiency, LocalEfficiency.    
    methods
        function m = InGlobalEfficiency(g, varargin)
            % INGLOBALEFFICIENCY(G) creates in-global efficiency with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD). 
            %   
            % INGLOBALEFFICIENCY(G, 'Settings', SETTINGS) creates in-globalefficiency measure and
            % initializes the property settings with SETTINGS. 
            % Currently INGLOBALEFFICIENCY does not utilize SETTINGS.
            %   
            % See also Measure, Graph, Strength, Distance.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_global_efficiency = calculate(m)
            % CALCULATE calculates the in-globalefficiency value of a node
            %
            % INGLOBALEFFICIENCY = CALCULATE(M) returns the value of the in_global_efficiency of a
            % node.
            
            g = m.getGraph();
            N = g.nodenumber();

            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            Di = D.^-1;  % inverse distance
            Di(1:N+1:end) = 0;
            in_global_efficiency = (sum(Di, 1) / (N-1))';
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-globalefficiency measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'InGlobalEfficiency';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-globalefficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Global-In-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-globalefficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-globalefficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The global in efficiency is the average inverse ' ...
                'shortest in path length in the graph. ' ...
                'It is inversely related to the characteristic in path length.';
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InGlobalEfficiency.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InGlobalEfficiency. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if in-globalefficiency measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if in-globalefficiency measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal.
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if in-globalefficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to in-globalefficiency 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to in-globalefficiency. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to in-globalefficiency 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to in-globalefficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InGlobalEfficiency');
        end
    end
end