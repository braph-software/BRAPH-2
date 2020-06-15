classdef InDegree < Measure
    % InDegree In-degree measure
    % InDegree provides the in-degree of a node for binary directed (BD) and 
    % weighted directed (WD) graphs. 
    %
    % It is calculated as the number of inward edges connected to the node. 
    % Self-connections are excluded (i.e. the diagonal of the connection 
    % matrix is removed).
    % 
    % InDegree methods:
    %   InDegree                    - constructor
    %
    % InDegree descriptive methods (Static)
    %   getClass                    - returns the in-degree class
    %   getName                     - returns the name of in-degree measure
    %   getDescription              - returns the description of in-degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OutDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = InDegree(g, varargin)
            % INDEGREE(G) creates in-degree with default properties.
            % G is a directed graph (e.g, an instance of GraphBD, GraphWD,
            % MultiplexGraphBD, MultiplexGraphWD). 
            %
            % See also Measure, OutDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function in_degree = calculate(m)
            % CALCULATE calculates the in-degree value of a node
            %
            % INDEGREE = CALCULATE(M) returns the value of the in-degree of a
            % node.
            %
            % See also Measure, OutDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix or 2D-cell array 
            
            in_degree = cell(g.layernumber(), 1);         
            for li = 1:1:g.layernumber()
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                Aii = binarize(Aii);  % binarizes the adjacency matrix
                in_degree(li) = {sum(Aii, 1)'};  % calculates the in-degree of a node for layer li
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'InDegree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'In-degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-degree measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The in-degree of a node is ' ...
                'the number of inward edges connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InDegree. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InDegree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of in-degree measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InDegree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of in-degree measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with InDegree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to in-degree. 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with InDegree 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to in-degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('InDegree');
        end
    end
end