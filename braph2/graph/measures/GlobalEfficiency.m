classdef GlobalEfficiency < Measure
    % GlobalEfficiency Global efficiency measure
    % GlobalEfficiency provides the global efficiency of a node for binary 
    % undirected (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as average inverse shortest path length within each layer. 
    % 
    % GlobalEfficiency methods:
    %   GlobalEfficiency            - constructor 
    %
    % GlobalEfficiency methods (Static)
    %   getClass                    - returns the global efficiency class
    %   getName                     - returns the name of global efficiency measure
    %   getDescription              - returns the description of global efficiency measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the global efficiency class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = GlobalEfficiency(g, varargin)
            % GLOBALEFFICIENCY(G) creates global efficiency with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU, 
            % MultiplexGraphBU or MultiplexGraphWU). 
            %   
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function global_efficiency = calculate(m)
            % CALCULATE calculates the global efficiency value of a node
            %
            % GLOBALEFFICIENCY = CALCULATE(M) returns the value of the global efficiency of a
            % node.
            %
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            N = g.nodenumber();            
            L = g.layernumber();
            
            if g.is_measure_calculated('Distance')
                distance = g.getMeasure('Distance').getValue();
            else
                distance = Distance(g, g.getSettings()).getValue();
            end
            
            global_efficiency = cell(L, 1);
            for li = 1:1:L
                inverse_distance = distance{li}.^-1;  % inverse distance
                inverse_distance(1:N(li)+1:end) = 0;            
                global_efficiency(li) = {(sum(inverse_distance, 2) / (N(li)-1))};   
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the global efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'GlobalEfficiency';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the global efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Global efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the global efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % global efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The global efficiency is the average inverse ' ...
                'shortest path length within each layer. ' ...
                'It is inversely related to the characteristic path length.';
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the settings available to GlobalEfficiency.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to GlobalEfficiency. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of GlobalEfficiency
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of global efficiency measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of GlobalEfficiency
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of global efficiency measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with GlobalEfficiency 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to GlobalEfficiency. 
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
            % graphs with GlobalEfficiency 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to GlobalEfficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('GlobalEfficiency');
        end
    end
end