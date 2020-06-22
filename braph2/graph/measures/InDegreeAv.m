classdef InDegreeAv < InDegree
    % InDegreeAv Average in-degree measure
    % InDegreeAv provides the average in-degree of a graph for binary directed
    % (BD) and weighted directed (WD) graphs. 
    %
    % It is calculated as the average of all number of inward edges connected
    % to a node within a layer, i.e., it is the mean of the in-degre within each
    % layer.
    % 
    % InDegreeAv methods:
    %   InDegreeAv                  - constructor
    %
    % InDegreeAv descriptive methods (Static)
    %   getClass                    - returns the average in-degree class
    %   getName                     - returns the name of average in-degree measure
    %   getDescription              - returns the description of average in-degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the average in-degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = InDegreeAv(g, varargin)
            % INDEGREEAV(G) creates average in-degree with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD,
            % MultiplexGraphBD or MultiplexGraphWD). 
            %   
            % See also Measure, InDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD. 

            m = m@InDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function in_degree_av = calculate(m)
            % CALCULATE calculates the average in-degree value of a graph
            %
            % INDEGREEAV = CALCULATE(M) returns the value of the average in-degree 
            % of a binary directed (BD) or weighted directed (WD) graph or multiplex.
            %
            % See also Measure, InDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InDegree')
                in_degree = g.getMeasureValue('InDegree');
            else
                in_degree = calculate@InDegree(m);
            end
            
            in_degree_av = cell(g.layernumber(), 1);
            for li = 1:1:length(in_degree_av)
                in_degree_av(li) = {mean(in_degree{li})};
            end
        end
    end
    methods(Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average
            % in-degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'InDegreeAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average In-Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-degree measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The average in-degree of a graph is the average of all ' ...
                'number of inward edges connected to a node within a layer. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % InDegreeAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InDegreeAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InDegreeAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average in-degree measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InDegreeAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average in-degree measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList() 
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with InDegreeAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average in-degree. 
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
            % graphs with InDegreeAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average in-degree.
            % 
            % See also getCompatibleGraphList.
                      
            n = Measure.getCompatibleGraphNumber('InDegreeAv');
        end
    end
end
