classdef OutGlobalEfficiency < Measure
    % OutGlobalEfficiency < Measure: Out-Global Efficiency measure
    % OutGlobalEfficiency provides the out-global efficiency of a node for binary directed (BD) and 
    % weighted directed (WD) graphs. It is calculated as average inverse
    % shortest out-path length in the graph. 
    % 
    % OutGlobalEfficiency methods:
    %   OutGlobalEfficiency         - constructor with Measure properties.
    %
    % OutGlobalEfficiency methods (Access=protected):
    %   calculate                   - calculates the out-global efficiency of a node.
    % 
    % OutGlobalEfficiency methods (Static)
    %   getClass                    - returns the out-global efficiency class.
    %   getName                     - returns the name of out-global efficiency measure.
    %   getDescription              - returns the description of out-global efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if out-global efficiency measure is global.
    %   is_nodal                    - boolean, checks if out-global efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if out-global efficiency measure if binodal.
    %   getMeasure                  - returns the out-global efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Degree, InGlobalEfficiency, LocalEfficiency.
    methods
        function m = OutGlobalEfficiency(g, varargin)
            % OUTGLOBALEFFICIENCY(G) creates out-global efficiency with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD). 
            %   
            % OUTGLOBALEFFICIENCY(G, 'Settings', SETTINGS) creates out-global efficiency measure and
            % initializes the property settings with SETTINGS. 
            % Currently OUTGLOBALEFFICIENCY does not utilize SETTINGS.
            %
            % OUTGLOBALEFFICIENCY(G, 'VALUE', VALUE) creates out-global efficiency, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphWD).
            %   
            % See also Measure, Graph, Strength, Distance. 
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_global_efficiency = calculate(m)
            % CALCULATE calculates the out-global efficiency value of a node
            %
            % OUTGLOBALEFFICIENCY = CALCULATE(M) returns the value of the
            % out_global_efficiency of a node.
            
            g = m.getGraph();  % graph from measure class
            N = g.nodenumber();
            
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            Di = D.^-1;  % inverse distance
            Di(1:N+1:end) = 0;   
            out_global_efficiency = (sum(Di, 2) / (N-1));
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the out-globalefficiency measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'OutGlobalEfficiency';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-globalefficiency measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Global-Out-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-globalefficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-globalefficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The global out efficiency is the average inverse ' ...
                'shortest out path length in the graph. ' ...
                'It is inversely related to the characteristic out path length.';
                ];
        end
        function available_settings = getAvailableSettings()  
            % GETAVAILABLESETTINGS returns the setting available to OutGlobalEfficiency.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutGlobalEfficiency. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if out-globalefficiency measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if out-globalefficiency measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal.
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if out-globalefficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to out-globalefficiency 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to out-globalefficiency. 
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
            % graphs to out-globalefficiency 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to out-globalefficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutGlobalEfficiency');
        end
    end
end