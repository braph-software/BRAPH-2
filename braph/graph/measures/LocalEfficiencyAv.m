classdef LocalEfficiencyAv < LocalEfficiency
    % LocalEfficiencyAv < LocalEfficiency: Average Local Efficiency measure
    % LocalEfficiencyAv provides the average local efficiency of a graph for    
    % binary undirected (BU) and weighted undirected (WU) graphs. It is calculated 
    % as the average of all the local efficiencies. 
    % 
    % LocalEfficiencyAv methods:
    %   LocalEfficiencyAv           - constructor with LocalEfficiency properties.
    %
    % LocalEfficiencyAv methods (Access=protected):
    %   calculate                   - calculates the average local efficiency of a graph.
    % 
    % LocalEfficiencyAv methods (Static)
    %   getClass                    - returns the average local efficiency class.
    %   getName                     - returns the name of average local efficiency measure.
    %   getDescription              - returns the description of average local efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average local efficiency measure is global.
    %   is_nodal                    - boolean, checks if average local efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if average local efficiency measure if binodal.
    %   getMeasure                  - returns the average local efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, LocalEfficiency, InLocalEfficiencyAv, OutLocalEfficiencyAv, GlobalEfficiencyAv.
    
    methods
        function m = LocalEfficiencyAv(g, varargin)
            % LOCALEFFICIENCYAV(G) creates average local efficiency with default LocalEfficiency properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %
            % LOCALEFFICIENCYAV(G, 'VALUE', VALUE) creates average local efficiency, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of  GraphBU, Graph WU).
            %   
            % See also Measure, Graph, LocalEfficiency, InLocalEfficiencyAv, OutLocalEfficiencyAv, GlobalEfficiencyAv.
            
            m = m@LocalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function local_efficiency_av = calculate(m)
            % CALCULATE calculates the average local efficiency value of a
            % graph
            %
            % LOCALEFFICIENCYAV = CALCULATE(M) returns the value of the average local 
            % efficiency of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('LocalEfficiency')
                local_efficiency = g.getMeasureValue('LocalEfficiency');
            else
                local_efficiency = calculate@LocalEfficiency(m);
            end
            
            local_efficiency_av = mean(local_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average local efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'LocalEfficiencyAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average local efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average-Local-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average local efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average local efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average local efficiency is the average of ' ...
                'all the local efficiencies.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to LocalEfficiencyAv.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to LocalEfficiencyAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if average local efficiency measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average local efficiency measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average local efficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to LocalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to LocalEfficiencyAv. 
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
            % graphs to LocalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to LocalEfficiencyAv.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('LocalEfficiencyAv');
        end
    end
end