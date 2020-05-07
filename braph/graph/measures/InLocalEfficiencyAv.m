classdef InLocalEfficiencyAv < InLocalEfficiency
    % InLocalEfficiencyAv < InLocalEfficiency: Average In-Local Efficiency measure
    % InLocalEfficiencyAv provides the average in-local efficiency of a graph for    
    % binary directed (BD) and weighted directed (WD) graphs. It is calculated 
    % as the average of all the in-local efficiencies. 
    % 
    % InLocalEfficiencyAv methods:
    %   InLocalEfficiencyAv         - constructor with InLocalEfficiency properties.
    %
    % InLocalEfficiencyAv methods (Access=protected):
    %   calculate                   - calculates the average in-local efficiency of a graph.
    % 
    % InLocalEfficiencyAv methods (Static)
    %   getClass                    - returns the average in-local efficiency class.
    %   getName                     - returns the name of average in-local efficiency measure.
    %   getDescription              - returns the description of average in-local efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average in-local efficiency measure is global.
    %   is_nodal                    - boolean, checks if average in-local efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if average in-local efficiency measure if binodal.
    %   getMeasure                  - returns the average in-local efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, InLocalEfficiency, LocalEfficiencyAv, OutLocalEfficiencyAv, GlobalEfficiencyAv.
    
    methods
        function m = InLocalEfficiencyAv(g, varargin)
            % INLOCALEFFICIENCYAV(G) creates average in-local efficiency with default InLocalEfficiency properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %
            % INLOCALEFFICIENCYAV(G, 'VALUE', VALUE) creates average in-local efficiency, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of  GraphBU, Graph WU).
            %   
            % See also Measure, Graph, InLocalEfficiency, LocalEfficiencyAv, OutLocalEfficiencyAv, GlobalEfficiencyAv.
            
            m = m@InLocalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_local_efficiency_av = calculate(m)
            % CALCULATE calculates the average in-local efficiency value of a
            % graph
            %
            % INLOCALEFFICIENCYAV = CALCULATE(M) returns the value of the 
            % average in-local efficiency of a graph.
            
            g = m.getGraph(); % graph from measure class
            
            if g.is_measure_calculated('InLocalEfficiency')
                in_local_efficiency = g.getMeasureValue('InLocalEfficiency');
            else
                in_local_efficiency = calculate@InLocalEfficiency(m);
            end
            
            in_local_efficiency_av = mean(in_local_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average in-local efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InLocalEfficiencyAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-local efficiency measure.
            %
            % See also getClass(), getDescription(). 
           
            name = 'Average-In-Local-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-local efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-local efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average in local efficiency is the average of the ' ...
                'all in local efficiencies.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InLocalEfficiencyAv.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InLocalEfficiencyAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if average in-local efficiency measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average in-local efficiency measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average in-local efficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InLocalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to InLocalEfficiencyAv. 
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
            % graphs to InLocalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InLocalEfficiencyAv.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InLocalEfficiencyAv');
        end
    end
end