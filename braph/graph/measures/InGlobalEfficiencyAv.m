classdef InGlobalEfficiencyAv < InGlobalEfficiency
    % InGlobalEfficiencyAv < InGlobalEfficiency: Average In-Global Efficiency measure
    % InGlobalEfficiencyAv provides the average in-global efficiency of a graph for    
    % binary directed (BD) and weighted directed (WD) graphs. It is calculated 
    % as the average of the in-global efficiency. 
    % 
    % InGlobalEfficiencyAv methods:
    %   InGlobalEfficiencyAv        - constructor with InGlobalEfficiency properties.
    %
    % InGlobalEfficiencyAv methods (Access=protected):
    %   calculate                   - calculates the average in-global efficiency of a graph.
    % 
    % InGlobalEfficiencyAv methods (Static)
    %   getClass                    - returns the average in-global efficiency class.
    %   getName                     - returns the name of average in-global efficiency measure.
    %   getDescription              - returns the description of average in-global efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average in-global efficiency measure is global.
    %   is_nodal                    - boolean, checks if average in-global efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if average in-global efficiency measure if binodal.
    %   getMeasure                  - returns the average in-global efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, InGlobalEfficiency, GlobalEfficiencyAv, OutGlobalEfficiencyAv, LocalEfficiencyAv.
    
    methods
        function m = InGlobalEfficiencyAv(g, varargin)
            % INGLOBALEFFICIENCYAV(G) creates average in-global efficiency with default InGlobalEfficiency properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %
            % INGLOBALEFFICIENCYAV(G, 'VALUE', VALUE) creates average in-global efficiency, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of  GraphBU, Graph WU).
            %   
            % See also Measure, Graph, InGlobalEfficiency, GlobalEfficiencyAv, OutGlobalEfficiencyAv, LocalEfficiencyAv.
            
            m = m@InGlobalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_global_efficiency_av = calculate(m)
            % CALCULATE calculates the average in-global efficiency value of a
            % graph
            %
            % INGLOBALEFFICIENCYAV = CALCULATE(M) returns the value of the 
            % average in-global efficiency of a graph.
            
            g = m.getGraph();  % graph from measure class  
            
            if g.is_measure_calculated('InGlobalEfficiency')
                in_global_efficiency = g.getMeasureValue('InGlobalEfficiency');
            else
                in_global_efficiency = calculate@InGlobalEfficiency(m);
            end
            
            in_global_efficiency_av = mean(in_global_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average in-global efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InGlobalEfficiencyAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-global efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average-In-Global-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-global efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-global efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average in global efficiency is the average of the' ...
                'in-global efficiency ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InGlobalEfficiencyAv.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InGlobalEfficiencyAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
       function bool = is_global()
            % IS_GLOBAL checks if average in-global efficiency measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average in-global efficiency measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average in-global efficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InGlobalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to InGlobalEfficiencyAv. 
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
            % graphs to InGlobalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InGlobalEfficiencyAv.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InGlobalEfficiencyAv');
        end
    end
end