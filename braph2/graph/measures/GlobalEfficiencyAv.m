classdef GlobalEfficiencyAv < GlobalEfficiency
    % GlobalEfficiencyAv Average global efficiency measure
    % GlobalEfficiencyAv provides the average global efficiency of a graph for    
    % binary undirected (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as the average of the global efficiency within each layer. 
    % 
    % GlobalEfficiencyAv methods:
    %   GlobalEfficiencyAv          - constructor 
    %
    % GlobalEfficiencyAv descriptive methods (Static)
    %   getClass                    - returns the average global efficiency class
    %   getName                     - returns the name of average global efficiency measure
    %   getDescription              - returns the description of average global efficiency measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope 
    %   getMeasure                  - returns the average global efficiency class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GlobalEfficiency, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = GlobalEfficiencyAv(g, varargin)
            % GLOBALEFFICIENCYAV(G) creates average global efficiency with default GlobalEfficiency properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU, 
            % MultiplexGraphBU or MultiplexGraphWU). 
            %
            % See also Measure, GlobalEfficiency, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
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
            %
            % See also Measure, GlobalEfficiency, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class  
            
            if g.is_measure_calculated('GlobalEfficiency')
                global_efficiency = g.getMeasureValue('GlobalEfficiency');
            else
                global_efficiency = calculate@GlobalEfficiency(m);
            end
            
            global_efficiency_av = cell(g.layernumber(), 1);
            for li = 1:1:length(global_efficiency_av)
                global_efficiency_av(li) = {mean(global_efficiency{li})};
            end
        end
    end
    methods (Static)  % Descriptive methods
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
            
            name = 'Average global efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average global efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average global efficiency measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The average global efficiency is the average of the' ...
                'global efficiency within each layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the settings available to GlobalEfficiencyAv.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to GlobalEfficiencyAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of GlobalEfficiencyAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average global efficiency measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of GlobalEfficiencyAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average global efficiency measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with GlobalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average global efficiency. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
           
            list = { ...
                'GraphBU', ...
                'GraphWU' ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with GlobalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average global efficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('GlobalEfficiencyAv');
        end
    end
end