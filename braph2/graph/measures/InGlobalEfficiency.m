classdef InGlobalEfficiency < Measure
    % InGlobalEfficiency In-global efficiency measure
    % InGlobalEfficiency provides the in-global efficiency of a node for  
    % binary directed (BD) and weighted directed (WD) graphs. 
    %
    % It is calculated as average inverse shortest in-path length within each layer. 
    % 
    % InGlobalEfficiency methods:
    %   InGlobalEfficiency          - constructor 
    %
    % InGlobalEfficiency descriptive methods (Static)
    %   getClass                    - returns the in-global efficiency class
    %   getName                     - returns the name of in-global efficiency measure
    %   getDescription              - returns the description of in-global efficiency measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the global efficiency class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = InGlobalEfficiency(g, varargin)
            % INGLOBALEFFICIENCY(G) creates in-global efficiency with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD, 
            % MultiplexGraphBD or MultiplexGraphWD). 
            %   
            % See also Measure, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_global_efficiency = calculate(m)
            % CALCULATE calculates the in-global efficiency value of a node
            %
            % INGLOBALEFFICIENCY = CALCULATE(M) returns the value of the 
            % in-global efficiency of a node.
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
            
            in_global_efficiency = cell(L, 1);
            for li = 1:1:L
                inverse_distance = distance{li}.^-1;  % inverse distance
                inverse_distance(1:N(li)+1:end) = 0;
                in_global_efficiency_layer = (sum(inverse_distance, 1) / (N(li)-1))';
                in_global_efficiency_layer(isnan(in_global_efficiency_layer)) = 0;  % Should return zeros, not NaN
                in_global_efficiency(li) = {in_global_efficiency_layer};   
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-global efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InGlobalEfficiency';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-global efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'In-global efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-global efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-global efficiency measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The in-global efficiency is the average inverse ' ...
                'shortest in-path length within each layer. ' ...
                'It is inversely related to the characteristic in-path length.';
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the settings available to InGlobalEfficiency.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InGlobalEfficiency. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InGlobalEfficiency
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of in-global efficiency measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InGlobalEfficiency
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of in-global efficiency measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with InGlobalEfficiency 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to in-global efficiency. 
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
            % graphs with InGlobalEfficiency 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to in-global efficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InGlobalEfficiency');
        end
    end
end