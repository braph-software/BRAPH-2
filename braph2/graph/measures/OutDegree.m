classdef OutDegree < Measure
    % OutDegree Out-degree measure
    % OutDegree provides the out-degree of a node for binary directed (BD) and 
    % weighted directed (WD) graphs. 
    %
    % It is calculated as the number of outward edges connected to a node
    % within a layer. Self-connections are excluded (i.e. the diagonal of the  
    % connection matrix is removed).
    % 
    % OutDegree methods:
    %   OutDegree                   - constructor
    %
    % OutDegree descriptive methods (Static)
    %   getClass                    - returns the out-degree class
    %   getName                     - returns the name of out-degree measure
    %   getDescription              - returns the description of out-degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OutDegree(g, varargin)
            % OUTDEGREE(G) creates out-degree with default properties.
            % G is a directed graph (e.g, an instance of GraphBD, GraphWD,
            % MultiplexGraphBD, MultiplexGraphWD). 
            %
            % See also Measure, InDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function out_degree = calculate(m)
            % CALCULATE calculates the out-degree value of a node
            %
            % OUTDEGREE = CALCULATE(M) returns the value of the out-degree of a
            % node.
            %
            % See also Measure, InDegree, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            
            out_degree = cell(g.layernumber(), 1);
            for li = 1:1:g.layernumber()
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                Aii = binarize(Aii);  % binarizes the adjacency matrix
                out_degree(li) = {sum(Aii, 2)};  % calculates the out-degree of a node for layer li
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the out-degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OutDegree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Out-degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-degree measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The out-degree of a node is the number of ' ...
                'outward edges connected to the node within a layer. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OutDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutDegree. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutDegree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of out-degree measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutDegree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of out-degree measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OutDegree
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of out-degree measure (UNILAYER).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OutDegree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to out-degree. 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OutDegree 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to out-degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OutDegree');
        end
    end
end