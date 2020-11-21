classdef PathTransitivity < Measure
    % PathTransitivity PathTransitivity measure
    % PathTransitivity provides the density of triangles that are
    % available along the shortest-paths between pairs of nodes. 
    % 
    % PathTransitivity methods:
    %   PathTransitivity            - constructor
    % 
    % PathTransitivity descriptive methods (Static)
    %   getClass                    - returns the path transitivity class
    %   getName                     - returns the name of path transitivity measure
    %   getDescription              - returns the description of path transitivity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the path transitivity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBU, MultiplexGraphBU.
    
    methods
        function m = PathTransitivity(g, varargin)
            % DEGREE(G) creates path transitivity with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU or MultiplexGraphBU). 
            %  
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function path transitivity = calculate(m)
            % CALCULATE calculates the path transitivity value of a graph
            %
            % DEGREE = CALCULATE(M) returns the value of the path transitivity of a
            % binary undirected (BU) or weighted undirected (WU) graph or multiplex.
            %
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix (for graph) or 2D-cell array (for multiplex)
            
            path transitivity = cell(g.layernumber(), 1);
            
            for li = 1:1:g.layernumber()
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                Aii = binarize(Aii);  % binarizes the adjacency matrix
                path transitivity(li) = {sum(Aii, 2)};  % calculates the path transitivity of a node for layer li
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the path transitivity measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'PathTransitivity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the path transitivity measure.
            %
            % See also getClass, getDescription. 
            
            name = 'PathTransitivity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the path transitivity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % path transitivity measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The path transitivity of a node is the number of ' ...
                'edges connected to a node within a layer. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to PathTransitivity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to PathTransitivity. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of PathTransitivity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of path transitivity measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of PathTransitivity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of path transitivity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of PathTransitivity
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of path transitivity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with PathTransitivity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to path transitivity. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBU', ...
                'GraphWU', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with PathTransitivity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to path transitivity.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('PathTransitivity');
        end
    end
end