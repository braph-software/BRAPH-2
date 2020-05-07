classdef OutGlobalEfficiencyAv < OutGlobalEfficiency
    % OutGlobalEfficiencyAv < OutGlobalEfficiency: Average Out-Global Efficiency measure
    % OutGlobalEfficiencyAv provides the average out-global efficiency of a graph for    
    % binary directed (BD) and weighted directed (WD) graphs. It is calculated 
    % as the average of the out-global efficiency. 
    % 
    % OutGlobalEfficiencyAv methods:
    %   OutGlobalEfficiencyAv       - constructor with OutGlobalEfficiency properties.
    %
    % OutGlobalEfficiencyAv methods (Access=protected):
    %   calculate                   - calculates the average out-global efficiency of a graph.
    % 
    % OutGlobalEfficiencyAv methods (Static)
    %   getClass                    - returns the average out-global efficiency class.
    %   getName                     - returns the name of average out-global efficiency measure.
    %   getDescription              - returns the description of average out-global efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average out-global efficiency measure is global.
    %   is_nodal                    - boolean, checks if average out-global efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if average out-global efficiency measure if binodal.
    %   getMeasure                  - returns the average out-global efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, OutGlobalEfficiency, InGlobalEfficiencyAv, GlobalEfficiencyAv, LocalEfficiencyAv.
    
    methods
        function m = OutGlobalEfficiencyAv(g, varargin)  
            % OUTGLOBALEFFICIENCYAV(G) creates average out-global efficiency with default OutGlobalEfficiency properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %
            % OUTGLOBALEFFICIENCYAV(G, 'VALUE', VALUE) creates average out-global efficiency, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of  GraphBU, Graph WU).
            %   
            % See also Measure, Graph, OutGlobalEfficiency, InGlobalEfficiencyAv, GlobalEfficiencyAv, LocalEfficiencyAv.
            
            m = m@OutGlobalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_global_efficiency_av = calculate(m)           
            % CALCULATE calculates the average out-global efficiency value of a
            % graph
            %
            % OUTGLOBALEFFICIENCYAV = CALCULATE(M) returns the value of the 
            % average out-global efficiency of a graph.
            
            g = m.getGraph(); % graph from measure class 
            
            if g.is_measure_calculated('OutGlobalEfficiency')
                out_global_efficiency = g.getMeasureValue('OutGlobalEfficiency');
            else
                out_global_efficiency = calculate@OutGlobalEfficiency(m);
            end
            
            out_global_efficiency_av = mean(out_global_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()   
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average out-global efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'OutGlobalEfficiencyAv';
        end
        function name = getName()   
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average out-global efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average-Out-Global-Efficiency';
        end
        function description = getDescription()  
            % GETDESCRIPTION returns the average out-global efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-global efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average out global efficiency is the average of the' ...
                'out global efficiency ' ...
                ];
        end
        function available_settings = getAvailableSettings()   
            % GETAVAILABLESETTINGS returns the setting available to OutGlobalEfficiencyAv.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutGlobalEfficiencyAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
       function bool = is_global()
            % IS_GLOBAL checks if average out-global efficiency measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average out-global efficiency measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average out-global efficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()   
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to OutGlobalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to OutGlobalEfficiencyAv. 
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
            % graphs to OutGlobalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to OutGlobalEfficiencyAv.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutGlobalEfficiencyAv');
        end
    end
end