classdef InGlobalEfficiencyAv < InGlobalEfficiency
    % InGlobalEfficiencyAv Average in-global efficiency measure
    % InGlobalEfficiencyAv provides the average in-global efficiency of a graph for    
    % binary directed (BD) and weighted directed (WD) graphs. 
    %
    % It is calculated as the average of the in-global efficiency within each layer. 
    % 
    % InGlobalEfficiencyAv methods:
    %   InGlobalEfficiencyAv        - constructor 
    %
    % InGlobalEfficiencyAv descriptive methods (Static)
    %   getClass                    - returns the average in-global efficiency class
    %   getName                     - returns the name of average in-global efficiency measure
    %   getDescription              - returns the description of average in-global efficiency measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the average global efficiency class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InGlobalEfficiency, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = InGlobalEfficiencyAv(g, varargin)
            % INGLOBALEFFICIENCYAV(G) creates average in-global efficiency with default GlobalEfficiency properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD, 
            % MultiplexGraphBD or MultiplexGraphWD). 
            %
            % See also Measure, InGlobalEfficiency, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@InGlobalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function  in_global_efficiency_av = calculate(m)
            % CALCULATE calculates the average in-global efficiency value of a
            % graph
            %
            % INGLOBALEFFICIENCYAV = CALCULATE(M) returns the value of the 
            % average in-global efficiency of a graph.
            %
            % See also Measure, InGlobalEfficiency, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class  
            
            if g.is_measure_calculated('InGlobalEfficiency')
                in_global_efficiency = g.getMeasureValue('InGlobalEfficiency');
            else
                in_global_efficiency = calculate@InGlobalEfficiency(m);
            end
            
            in_global_efficiency_av = cell(g.layernumber(), 1);
            for li = 1:1:length(in_global_efficiency_av)
                in_global_efficiency_av(li) = {mean(in_global_efficiency{li})};
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average in-global efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InGlobalEfficiencyAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-global efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average in-global efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-global efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-global efficiency measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The average in-global efficiency is the average of the' ...
                'in-global efficiency within each layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the settings available to InGlobalEfficiencyAv.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InGlobalEfficiencyAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InGlobalEfficiencyAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average in-global efficiency measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InGlobalEfficiencyAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average in-global efficiency measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of InGlobalEfficiencyAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average in-global efficiency measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with InGlobalEfficiencyAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average in-global efficiency. 
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
            % graphs with InGlobalEfficiencyAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average in-global efficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InGlobalEfficiencyAv');
        end
    end
end