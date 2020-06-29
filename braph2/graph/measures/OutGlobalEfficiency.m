classdef OutGlobalEfficiency < Measure
    % OutGlobalEfficiency Out-global efficiency measure
    % OutGlobalEfficiency provides the out-global efficiency of a node for  
    % binary directed (BD) and weighted directed (WD) graphs. 
    %
    % It is calculated as average inverse shortest out-path length within each layer. 
    % 
    % OutGlobalEfficiency methods:
    %   OutGlobalEfficiency         - constructor 
    %
    % OutGlobalEfficiency descriptive methods (Static)
    %   getClass                    - returns the out-global efficiency class
    %   getName                     - returns the name of out-global efficiency measure
    %   getDescription              - returns the description of out-global efficiency measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the global efficiency class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OutGlobalEfficiency(g, varargin)
            % OUTGLOBALEFFICIENCY(G) creates out-global efficiency with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD, 
            % MultiplexGraphBD or MultiplexGraphWD). 
            %   
            % See also Measure, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_global_efficiency = calculate(m)
            % CALCULATE calculates the out-global efficiency value of a node
            %
            % OUTGLOBALEFFICIENCY = CALCULATE(M) returns the value of the 
            % out-global efficiency of a node.
            %
            % See also Measure, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            N = g.nodenumber();            
            L = g.layernumber();
            
            if g.is_measure_calculated('Distance')
                distance = g.getMeasure('Distance').getValue();
            else
                distance = Distance(g, g.getSettings()).getValue();
            end
            
            out_global_efficiency = cell(L, 1);
            for li = 1:1:L
                inverse_distance = distance{li}.^-1;  % inverse distance
                inverse_distance(1:N(li)+1:end) = 0;            
                out_global_efficiency(li) = {(sum(inverse_distance, 2) / (N(li)-1))};   
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the out-global efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'OutGlobalEfficiency';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-global efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Out-global efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-global efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-global efficiency measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The out-global efficiency is the average inverse ' ...
                'shortest out-path length within each layer. ' ...
                'It is inversely related to the characteristic out-path length.';
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the settings available to OutGlobalEfficiency.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutGlobalEfficiency. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutGlobalEfficiency
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of out-global efficiency measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutGlobalEfficiency
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of out-global efficiency measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with OutGlobalEfficiency 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to out-global efficiency. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...               
                'GraphBD', ...           
                'GraphWD' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with OutGlobalEfficiency 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to out-global efficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutGlobalEfficiency');
        end
    end
end