classdef OutGlobalEfficiencyAv < OutGlobalEfficiency
    % OutGlobalEfficiency < Measure: OutGlobalEfficiency measure
    % OutGlobalEfficiency provides the out-global efficiency of a node for binary directed (BD) and 
    % weighted directed (WD) graphs. It is calculated as average inverse
    % shortest out-path length in the graph. 
    % 
    % OutGlobalEfficiency methods:
    %   OutGlobalEfficiency         - constructor with Measure properties.
    %
    % OutGlobalEfficiency methods (Access=protected):
    %   calculate                   - calculates the out-globalefficiency of a node.
    % 
    % OutGlobalEfficiency methods (Static)
    %   getClass                    - returns the out-globalefficiency class.
    %   getName                     - returns the name of out-globalefficiency measure.
    %   getDescription              - returns the description of out-globalefficiency measure.
    %   is_global                   - boolean, checks if out-globalefficiency measure is global.
    %   is_nodal                    - boolean, checks if out-globalefficiency measure is nodal.
    %   is_binodal                  - boolean, checks if out-globalefficiency measure if binodal.
    %   getMeasure                  - returns the out-globalefficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Degree, InGlobalEfficiency, LocalEfficiency,
    methods
        function m = OutGlobalEfficiencyAv(g, varargin)
            % OUTGLOBALEFFICIENCY(G) creates out-globalefficiency with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD). 
            %   
            % OUTGLOBALEFFICIENCY(G, 'Settings', SETTINGS) creates out-globalefficiency measure and
            % initializes the property settings with SETTINGS. 
            % Currently OUTGLOBALEFFICIENCY does not utilize SETTINGS.
            %   
            % See also Measure, Graph, Strength, Distance, InGlobalEfficiency. 
            
            m = m@OutGlobalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_global_efficiency_av = calculate(m)
            % CALCULATE calculates the out-global efficiency value of a node
            %
            % OUTGLOBALEFFICIENCY = CALCULATE(M) returns the value of the
            % out_global_efficiency of a node.
            
            g = m.getGraph();   
            
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
            % MEASURE_CLASS = GETCLASS() returns the class of the out-globalefficiency measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'OutGlobalEfficiencyAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-globalefficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average-Out-Global-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-globalefficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-globalefficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average out global efficiency is the average of the' ...
                'out global efficiency ' ...
                ];
        end
        function bool = is_global()
            % IS_GLOBAL checks if out-globalefficiency measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if out-globalefficiency measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal.
            
            bool = false;
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
            
            n = Measure.getCompatibleGraphNumber('OutGlobalEfficiencyAv');
        end
    end
end