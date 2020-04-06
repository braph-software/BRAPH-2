classdef GlobalEfficiency < Measure
    % GlobalEfficiency < Measure: GlobalEfficiency measure
    % GlobalEfficiency provides the global efficiency of a node for binary undirected (BU) and 
    % weighted undirected (WU) graphs. It is calculated as average inverse
    % shortest path length in the graph. 
    % 
    % GlobalEfficiency methods:
    %   GlobalEfficiency            - constructor with Measure properties.
    %
    % GlobalEfficiency methods (Access=protected):
    %   calculate                   - calculates the globalefficiency of a node.
    % 
    % GlobalEfficiency methods (Static)
    %   getClass                    - returns the globalefficiency class.
    %   getName                     - returns the name of globalefficiency measure.
    %   getDescription              - returns the description of globalefficiency measure.
    %   is_global                   - boolean, checks if globalefficiency measure is global.
    %   is_nodal                    - boolean, checks if globalefficiency measure is nodal.
    %   is_binodal                  - boolean, checks if globalefficiency measure if binodal.
    %   getMeasure                  - returns the globalefficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Degree, InGlobalEfficiency, OutGlobalEfficiency, LocalEfficiency,
    methods
        function m = GlobalEfficiency(g, varargin)
            % GLOBALEFFICIENCY(G) creates globalefficiency with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %   
            % GLOBALEFFICIENCY(G, 'Settings', SETTINGS) creates globalefficiency measure and
            % initializes the property settings with SETTINGS. 
            % Currently GLOBALEFFICIENCY does not utilize SETTINGS.
            %   
            % See also Measure, Graph, Strength, Distance.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function global_efficiency = calculate(m)
            % CALCULATE calculates the global efficiency value of a node
            %
            % GLOBALEFFICIENCY = CALCULATE(M) returns the value of the global_efficiency of a
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
            global_efficiency = (sum(Di, 2) / (N-1));    
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the globalefficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'GlobalEfficiency';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the globalefficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Global-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the globalefficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % globalefficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The global efficiency is the average inverse ' ...
                'shortest path length in the graph. ' ...
                'It is inversely related to the characteristic path length.';
                ];
        end
        function bool = is_global()
            % IS_GLOBAL checks if globalefficiency measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if globalefficiency measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if globalefficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to globalefficiency 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to globalefficiency. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...               
                'GraphBU', ...           
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to globalefficiency 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to globalefficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('GlobalEfficiency');
        end
    end
end