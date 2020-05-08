classdef OutLocalEfficiencyAv < OutLocalEfficiency
    % OutLocalEfficiencyAv < OutLocalEfficiency: Average Out-Local Efficiency measure
    % OutLocalEfficiencyAv provides the average out-local efficiency of a graph for    
    % binary directed (BD) and weighted directed (WD) graphs. It is calculated 
    % as the average of all the out-local efficiencies. 
    % 
    % OutLocalEfficiencyAv methods:
    %   OutLocalEfficiencyAv        - constructor with OutLocalEfficiency properties.
    %
    % OutLocalEfficiencyAv methods (Access=protected):
    %   calculate                   - calculates the average out-local efficiency of a graph.
    % 
    % OutLocalEfficiencyAv methods (Static)
    %   getClass                    - returns the average out-local efficiency class.
    %   getName                     - returns the name of average out-local efficiency measure.
    %   getDescription              - returns the description of average out-local efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average out-local efficiency measure is global.
    %   is_nodal                    - boolean, checks if average out-local efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if average out-local efficiency measure if binodal.
    %   getMeasure                  - returns the average out-local efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, OutLocalEfficiency, InLocalEfficiencyAv, LocalEfficiencyAv, GlobalEfficiencyAv.
    
    methods
        function m = OutLocalEfficiencyAv(g, varargin)
            % OUTLOCALEFFICIENCYAV(G) creates average out-local efficiency with default OutLocalEfficiency properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %
            % OUTLOCALEFFICIENCYAV(G, 'VALUE', VALUE) creates average out-local efficiency, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of  GraphBU, Graph WU).
            %   
            % See also Measure, Graph, OutLocalEfficiency, InLocalEfficiencyAv, LocalEfficiencyAv, GlobalEfficiencyAv.
            
            m = m@OutLocalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_local_efficiency_av = calculate(m)
            % CALCULATE calculates the average out-local efficiency value of a
            % graph
            %
            % OUTLOCALEFFICIENCYAV = CALCULATE(M) returns the value of the 
            % average out-local efficiency of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutLocalEfficiency')
                out_local_efficiency = g.getMeasureValue('OutLocalEfficiency');
            else
                out_local_efficiency = calculate@OutLocalEfficiency(m);
            end
            
            out_local_efficiency_av = mean(out_local_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average out-local efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'OutLocalEfficiencyAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average out-local efficiency measure.
            %
            % See also getClass(), getDescription(). 
           
            name = 'Average-Out-Local-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-local efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-local efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average out local efficiency is the average of the ' ...
                'all out local efficiencies.' ...
                ];
        end
        function available_settings = getAvailableSettings()   
            % GETAVAILABLESETTINGS returns the setting available to OutLocalEfficiencyAv.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutLocalEfficiencyAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if average out-local efficiency measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average out-local efficiency measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average out-local efficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to OutLocalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to OutLocalEfficiencyAv. 
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
            % graphs to OutLocalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to OutLocalEfficiencyAv.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutLocalEfficiencyAv');
        end
    end
end