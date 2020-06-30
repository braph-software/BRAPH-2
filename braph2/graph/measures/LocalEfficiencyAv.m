classdef LocalEfficiencyAv < LocalEfficiency
    % LocalEfficiencyAv Average local efficiency measure
    % LocalEfficiencyAv provides the average local efficiency of a graph for    
    % binary undirected (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as the average of all the local efficiencies within each layer. 
    % 
    % LocalEfficiencyAv methods:
    %   LocalEfficiencyAv           - constructor
    % 
    % LocalEfficiencyAv descriptive methods (Static)
    %   getClass                    - returns the average local efficiency class
    %   getName                     - returns the name of average local efficiency measure
    %   getDescription              - returns the description of average local efficiency measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope 
    %   getMeasure                  - returns the average local efficiency class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, LocalEfficiency, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = LocalEfficiencyAv(g, varargin)
            % LOCALEFFICIENCYAV(G) creates average local efficiency with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU, 
            % MultiplexGraphBU or MultiplexGraphWU). 
            %
            % See also Measure, LocalEfficiency, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
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
            %
            % See also Measure, LocalEfficiency, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('LocalEfficiency')
                local_efficiency = g.getMeasureValue('LocalEfficiency');
            else
                local_efficiency = calculate@LocalEfficiency(m);
            end
            
            local_efficiency_av = cell(g.layernumber(), 1);
            for li = 1:1:length(local_efficiency_av)
                local_efficiency_av(li) = {mean(local_efficiency{li})};
            end
        end
    end
    methods (Static)  % Descriptive methods
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
            
            name = 'Average local efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average local efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average local efficiency measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The average local efficiency is the average of ' ...
                'all the local efficiencies within each layer.' ...
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
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of LocalEfficiencyAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average local efficiency measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of LocalEfficiencyAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average local efficiency measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with LocalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average local efficiency. 
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
            % graphs with LocalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average local efficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('LocalEfficiencyAv');
        end
    end
end
