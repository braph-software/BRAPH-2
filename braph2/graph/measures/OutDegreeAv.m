classdef OutDegreeAv < OutDegree
    % OutDegreeAv Average out-degree measure
    % OutDegreeAv provides the average out-degree of a graph for binary directed
    % (BD) and weighted directed (WD) graphs. 
    %
    % It is calculated as the average of all number of outward edges connected
    % to a node within a layer, i.e., it is the mean of the out-degre within each
    % layer.
    % 
    % OutDegreeAv methods:
    %   OutDegreeAv                 - constructor
    %
    % OutDegreeAv descriptive methods (Static)
    %   getClass                    - returns the average out-degree class
    %   getName                     - returns the name of average out-degree measure
    %   getDescription              - returns the description of average out-degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the average out-degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OutDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OutDegreeAv(g, varargin)
            % OUTDEGREEAV(G) creates average out-degree with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD,
            % MultiplexGraphBD or MultiplexGraphWD). 
            %   
            % See also Measure, OutDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD. 

            m = m@OutDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function out_degree_av = calculate(m)
            % CALCULATE calculates the average out-degree value of a graph
            %
            % OUTDEGREEAV = CALCULATE(M) returns the value of the average out-degree 
            % of a binary directed (BD) or weighted directed (WD) graph or multiplex.
            %
            % See also Measure, OutDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutDegree')
                out_degree = g.getMeasureValue('OutDegree');
            else
                out_degree = calculate@OutDegree(m);
            end
            
            out_degree_av = cell(g.layernumber(), 1);
            for li = 1:1:length(out_degree_av)
                out_degree_av(li) = {mean(out_degree{li})};
            end
        end
    end
    methods(Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average
            % out-degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OutDegreeAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average out-degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average Out-Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-degree measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The average out-degree of a graph is the average of all ' ...
                'number of  outward edges connected to a node within a layer. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % OutDegreeAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutDegreeAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutDegreeAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average out-degree measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutDegreeAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average out-degree measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList() 
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with OutDegreeAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average out-degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...               
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with OutDegreeAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average out-degree.
            % 
            % See also getCompatibleGraphList.
                      
            n = Measure.getCompatibleGraphNumber('OutDegreeAv');
        end
    end
end
