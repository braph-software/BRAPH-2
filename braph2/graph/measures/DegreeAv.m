classdef DegreeAv < Degree
    % DegreeAv < Measure: Average Degree measure
    % DegreeAv provides the average degree of a graph for binary undirected
    % (BU) and weighted undirected (WU) graphs. It is calculated as the 
    % average of all number of edges connected to the node.
    % 
    % DegreeAv methods:
    %   DegreeAv                    - constructor
    %
    % DegreeAv methods (Access=protected):
    %   calculate                   - calculates the average degree of a graph
    % 
    % DegreeAv methods (Static)
    %   getClass                    - returns the average degree class
    %   getName                     - returns the name of average degree measure
    %   getDescription              - returns the description of average degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the average degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Degree, Graph, Strength, Distance, Efficency.
    
    methods
        function m = DegreeAv(g, varargin)
            % DEGREEAV(G) creates average degree with default Degree properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % DEGREEAV(G, 'VALUE', VALUE) creates average degree, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Degree, Measure, Graph, StrengthAv, PathLengthAv. 

            m = m@Degree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function degree_av = calculate(m)
            % CALCULATE calculates the average degree value of a graph
            %
            % DEGREEAV = CALCULATE(M) returns the value of the average degree 
            % of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Degree')
                degree = g.getMeasureValue('Degree');
            else
                degree = calculate@Degree(m);
            end
            
            degree_av = cell(g.layernumber(), 1);
            for li = 1:1:length(degree_av)
                degree_av(li) = {mean(degree{li})};
            end
        end
    end
    methods(Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average
            % degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'DegreeAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average degree measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The average degree of a graph is ' ...
                'the average of all number of edges connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % DegreeAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to DegreeAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of average degree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average degree measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of average degree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average degree measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList() 
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to DegreeAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to DegreeAv. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBU', ...
                'GraphWU' ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...               
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to DegreeAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to DegreeAv.
            % 
            % See also getCompatibleGraphList.
                      
            n = Measure.getCompatibleGraphNumber('DegreeAv');
        end
    end
end
