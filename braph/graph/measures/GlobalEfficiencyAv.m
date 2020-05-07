classdef GlobalEfficiencyAv < GlobalEfficiency
    % GlobalEfficiencyAv < GlobalEfficiency: Average Global Efficiency measure
    % GlobalEfficiencyAv provides the average global efficiency of a graph for    
    % binary undirected (BU) and weighted undirected (WU) graphs. It is calculated 
    % as the average of the global efficiency. 
    % 
    % GlobalEfficiencyAv methods:
    %   GlobalEfficiencyAv          - constructor with GlobalEfficiency properties.
    %
    % GlobalEfficiencyAv methods (Access=protected):
    %   calculate                   - calculates the average global efficiency of a graph.
    % 
    % GlobalEfficiencyAv methods (Static)
    %   getClass                    - returns the average global efficiency class.
    %   getName                     - returns the name of average global efficiency measure.
    %   getDescription              - returns the description of average global efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average global efficiency measure is global.
    %   is_nodal                    - boolean, checks if average global efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if average global efficiency measure if binodal.
    %   getMeasure                  - returns the average global efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, GlobalEfficiency, InGlobalEfficiencyAv, OutGlobalEfficiencyAv, LocalEfficiencyAv.
    
    methods
        function m = GlobalEfficiencyAv(g, varargin)
            % GLOBALEFFICIENCYAV(G) creates average global efficiency with default GlobalEfficiency properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %
            % GLOBALEFFICIENCYAV(G, 'VALUE', VALUE) creates average global efficiency, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of  GraphBU, Graph WU).
            %   
            % See also Measure, Graph, GlobalEfficiency, InGlobalEfficiencyAv, OutGlobalEfficiencyAv, LocalEfficiencyAv.
            
            m = m@GlobalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function  global_efficiency_av = calculate(m)
            % CALCULATE calculates the average global efficiency value of a
            % graph
            %
            % GLOBALEFFICIENCYAV = CALCULATE(M) returns the value of the average global 
            % efficiency of a graph.
            
            g = m.getGraph(); % graph from measure class  
            
            if g.is_measure_calculated('GlobalEfficiency')
                global_efficiency = g.getMeasureValue('GlobalEfficiency');
            else
                global_efficiency = calculate@GlobalEfficiency(m);
            end
            
             global_efficiency_av = mean(global_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average global efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'GlobalEfficiencyAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average global efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average-Global-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average global efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average global efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average global efficiency is the average of the' ...
                'global efficiency ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to GlobalEfficiencyAv.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to GlobalEfficiencyAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
       function bool = is_global()
            % IS_GLOBAL checks if average global efficiency measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average global efficiency measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average global efficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to GlobalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to GlobalEfficiencyAv. 
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
            % graphs to GlobalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to GlobalEfficiencyAv.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('GlobalEfficiencyAv');
        end
    end
end