classdef OutGlobalEfficiencyAv < OutGlobalEfficiency
    % OutGlobalEfficiencyAv Average out-global efficiency measure
    % OutGlobalEfficiencyAv provides the average out-global efficiency of a graph for    
    % binary directed (BD) and weighted directed (WD) graphs. 
    %
    % It is calculated as the average of the out-global efficiency within each layer. 
    % 
    % OutGlobalEfficiencyAv methods:
    %   OutGlobalEfficiencyAv       - constructor 
    %
    % OutGlobalEfficiencyAv descriptive methods (Static)
    %   getClass                    - returns the average out-global efficiency class
    %   getName                     - returns the name of average out-global efficiency measure
    %   getDescription              - returns the description of average out-global efficiency measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the average global efficiency class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OutGlobalEfficiency, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OutGlobalEfficiencyAv(g, varargin)
            % OUTGLOBALEFFICIENCYAV(G) creates average out-global efficiency with default GlobalEfficiency properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD, 
            % MultiplexGraphBD or MultiplexGraphWD). 
            %
            % See also Measure, OutGlobalEfficiency, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@OutGlobalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function  out_global_efficiency_av = calculate(m)
            % CALCULATE calculates the average out-global efficiency value of a
            % graph
            %
            % OUTGLOBALEFFICIENCYAV = CALCULATE(M) returns the value of the 
            % average out-global efficiency of a graph.
            %
            % See also Measure, OutGlobalEfficiency, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class  
            
            if g.is_measure_calculated('OutGlobalEfficiency')
                out_global_efficiency = g.getMeasureValue('OutGlobalEfficiency');
            else
                out_global_efficiency = calculate@OutGlobalEfficiency(m);
            end
            
            out_global_efficiency_av = cell(g.layernumber(), 1);
            for li = 1:1:length(out_global_efficiency_av)
                out_global_efficiency_av(li) = {mean(out_global_efficiency{li})};
            end
        end
    end
    methods (Static)  % Descriptive methods
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
            
            name = 'Average out-global efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-global efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-global efficiency measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The average out-global efficiency is the average of the' ...
                'out-global efficiency within each layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the settings available to OutGlobalEfficiencyAv.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutGlobalEfficiencyAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutGlobalEfficiencyAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average out-global efficiency measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutGlobalEfficiencyAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average out-global efficiency measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OutGlobalEfficiencyAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average out-global efficiency measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with OutGlobalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average out-global efficiency. 
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
            % graphs with OutGlobalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average out-global efficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutGlobalEfficiencyAv');
        end
    end
end