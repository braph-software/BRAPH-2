classdef Graph < handle & matlab.mixin.Copyable
    % Graph < handle & matlab.mixin.Copyable (Abstract): A graph
    % Graph provides the methods necessary for all graphs.
    % Instances of this class cannot be created. 
    % Use one of the subclasses (e.g., GraphBD, GraphBU, GraphWD, GraphWU). 
    % The subclasses must be created inside the folder ./braph/graph/graphs/.
    %
    % Graph properties (GetAccess=protected, SetAccess=protected):
    %   A           - adjacency matrix.
    %   settings    - structure with the constructor settings.
    %   measure_dict - dictionary with the calculated measure.
    %                  (key, value) = (measure code, measure value)
    %
    % Graph methods (Access=protected)
    %   Graph       - constructor.
    %   copyElement - deep copy community structure.
    %
    % Graph methods:
    %   tostring    - returns a string representing the graph.
    %   disp        - displays the graph.
    %   getA        - returns the adjacency matrix.
    %   nodenumber  - returns the number of nodes in a graph.
    %   getSettings - returns the settings of the graph.
    %   getMeasure  - returns the measure of the graph.
    %   is_measure_calculated - checks if the measure is calculated.
    %   getMeasureValue - returns the value of a measure of the graph.
    %   subgraph    - returns a subgraph from given nodes.
    %   nodeattack  - removes given nodes from a graph.
    %   edgeattack  - removes given edges from a graph.
    %
    % Graph methods (Static):
    %   getList     - return a list with subclasses of graph.
    %   getClass    - returns the class type of the graph.
    %   getName     - returns the name of the graph.
    %   getDescription - returns the description of the graph.
    %   is_selfconnected - checks if the graph is self connected.
    %   is_nonnegative - checks if the graph is non negative.
    %   is_weighted - checks if the graph is weighted.
    %   is_binary   - checks if the graph is binary.
    %   is_directed - checks if the graph is directed.
    %   is_undirected - checks if the graph is undirected.
    %   getGraph    - returns a graph with the given inputs.
    %   getCompatibleMeasureList - returns a list with the compatible measures.
    %   getCompatibleMeasureNumber - returns a number of the compatible measures.
    %
    % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD.
        
    properties (GetAccess=protected, SetAccess=protected)
        A  % adjacency matrix
        settings  % structure with the constructor varagin
        measure_dict  % dictionary with calculated measures
    end
    methods (Access=protected)
        function g = Graph(A, varargin)
            % Graph(A) creates a graph with the default properties.
            % A is the adjacency matrix. This method is only accessible
            % by the subclasses of Graph.
            %
            % Graph(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % creates a graph with properties and values. It initializes
            % the property settings with the properties and values.
            %
            % GRAPH(A, 'Settings', SETTINGS) ceates a graph and
            % initializes the property settings with SETTINGS.
            %
            % See also Measure, GraphBD, GraphBU, GraphWD, GraphWU.
            
            if length(varargin) == 1
                varargin = varargin{:};
            end
            
            settings = get_from_varargin(varargin, 'Settings', varargin{:});
            measure_dict = get_from_varargin(containers.Map, 'MeasureDictionary', varargin{:});
            
            g.A = A;  % initialize the property A
            g.settings = settings;  % initialize the property settings
            g.measure_dict = measure_dict;  % initialize the property measure_dict
        end
        function g_copy = copyElement(g)
            % COPYELEMENT(G) copies elements of graph
            %
            % G_COPY = COPYELEMENT(G) copues elements of the graph G.
            % Makes a deep copy of the structure of the graph.
            %
            % See also Cohort.
            
            % Make a shallow copy
            g_copy = copyElement@matlab.mixin.Copyable(g);
            
            % Make a deep copy of settings
            g_copy.settings = copy_varargin(g.settings{:});
            
            % Make a deep copy of measure_dict
            g_copy.measure_dict = containers.Map;
            measures = values(g.measure_dict);
            for i = 1:1:length(measures)
                m = measures{i};
                if m.is_value_calculated()
                    g_copy.measure_dict(m.getMeasureCode()) = Measure.getMeasure( ...
                        m.getMeasureCode(), ...
                        g_copy, ...
                        'Value', m.getValue(), ...
                        'Settings', copy_varargin(m.getSettings()) ...
                        );
                else
                    g_copy.measure_dict(m.getMeasureCode()) = Measure.getMeasure( ...
                        m.getMeasureCode(), ...
                        g_copy, ...
                        'Settings', copy_varargin(m.getSettings()) ...
                        );
                end
            end
        end
    end
    methods
        function str = tostring(g)
            % TOSTRING string with information about the graph
            %
            % STR = TOSTRING(G) returns string with the graph class and size.
            %
            % See also disp().
            
            str = [Graph.getClass(g) ' ' int2str(size(g.getA(), 1)) ' rows x ' int2str(size(g.getA(), 2)) ' columns'];
        end
        function disp(g)
            % DISP displays information about the graph
            %
            % DISP(G) displays information about the graph.
            % It provides information about graph class, size,
            % value, associated measures, and settings.
            %
            % See also tostring().
            
            disp(['<a href="matlab:help ' Graph.getClass(g) '">' Graph.getClass(g) '</a>'])
            disp([' size: ' int2str(size(g.getA(), 1)) ' rows x ' int2str(size(g.getA(), 2)) ' columns'])
            disp([' measures: ' int2str(length(g.measure_dict))]);
            disp([' settings']); %#ok<NBRAK>
            settings = g.getSettings(); %#ok<PROP>
            for i = 1:2:length(settings) %#ok<PROP>
                disp(['  ' settings{i} ' = ' tostring(settings{i+1})]); %#ok<PROP>
            end
        end
        function A = getA(g)
            % GETA returns the adjacency matrix.
            %
            % A = GETA(G) returns the adjacency matrix A associated to the
            % graph G.
            %
            % See also getSettings(), nodenumber().
            
            A = g.A;
        end
        function n = nodenumber(g)
            % NODENUMBER returns the number of nodes in the graph.
            %
            % N = NODENUMBER(G) returns the number of nodes in the graph.
            %
            % See also getA(), getSettings().
            
            n = length(g.getA());
        end
        function res = getSettings(g, setting_code)
            % GETSETTINGS returns the settings
            %
            % SETTINGS = GETSETTINGS(G) returns the settings of the graph
            %
            % SETTINGS = GETSETTINGS(G, SETTING_CODE) returns the settings
            % of the graph SETTING_CODE. 
            %
            % See also getA(), nodenumber().
            
            if nargin<2
                res = g.settings;
            else
                res = get_from_varargin([], setting_code, g.settings{:});
            end
        end
        function m = getMeasure(g, measure_class)
            % GETMEASURE returns measure
            %
            % M = GETMEASURE(G, MEASURE_CLASS) checks if the measure
            % exists in the property MDICT. If not it creates a new measure
            % M of class MEASURE_CLASS with properties defined by the graph
            % settings. The user must call getValue() for the new measure M
            % to retrieve the value of measure M.
            %
            % See also getMeasureValue(), is_measure_calculated().
            
            if isKey(g.measure_dict, measure_class)
                m = g.measure_dict(measure_class);
            else
                m = Measure.getMeasure(measure_class, g, g.settings{:});
                g.measure_dict(measure_class) = m;
            end
        end
        function bool = is_measure_calculated(g, measure_class)
            % IS_MEASURE_CALCULATED checks if a measure is calculated
            %
            % BOOL = IS_MEASURE_CALCULATED(G) returns true if a value of a
            % measure has been already calculated. If a measure M is
            % created by using the function getMeasure(), the user needs to
            % call the function getMeasureValue() to calculate the measure and
            % obtain a value.
            %
            % See also getMeasure(), getMeasureValue().
            
            if isKey(g.measure_dict, measure_class)
                bool = g.measure_dict(measure_class).is_value_calculated();
            else
                bool = false;
            end
        end
        function value = getMeasureValue(g, measure_class)
            % GETMEASUREVALUE returns the value of a measure
            %
            % VALUE = GETMEASUREVALUE(G, MEASURE_CLASS) returns the value of
            % a measure of type MEASURE_CLASS.
            %
            % See also getMeasure(), is_measure_calculated().
            
            value = g.getMeasure(measure_class).getValue();
        end
        function sg = subgraph(g, nodes)
            % SUBGRAPH creates subgraph from given nodes
            %
            % SG = SUBGRAPH(G, NODES) creates the graph SG as a subgraph of G
            % containing only the nodes specified by NODES.
            
            A = g.getA(); %#ok<PROPLC>
            sg = Graph.getGraph(Graph.getClass(g), A(nodes, nodes), g.getSettings()); %#ok<PROPLC>
        end
        function ga = nodeattack(g, nodes)
            % NODEATTACK removes given nodes from a graph
            %
            % GA = NODEATTACK(G, NODES) creates the graph GA resulting by removing
            % the nodes specified by NODES from G.
            %
            % NODES are removed by setting all the connections from and to
            % the nodes in the connection matrix to 0.
            %
            % See also edgeattack().
            
            A = g.getA(); %#ok<PROPLC>
            
            for i = 1:1:numel(nodes)
                A(nodes(i), :) = 0; %#ok<PROPLC>
                A(:, nodes(i)) = 0; %#ok<PROPLC>
            end
            
            ga = Graph.getGraph(Graph.getClass(g), A, g.getSettings()); %#ok<PROPLC>
        end
        function ga = edgeattack(g, nodes1, nodes2)
            % EDGEATTACK removes given edges from a graph
            %
            % GA = EDGEATTACK(G, NODES1, NODES2) creates the graph GA resulting
            % by removing the edges going from NODES1 to NODES2 from G.
            %
            % EDGES are removed by setting all the connections from NODES1 to
            % NODES2 in the connection matrix to 0.
            %
            % NODES1 and NODES2 must have the same dimensions.
            %
            % See also nodeattack().
            
            A = g.getA(); %#ok<PROPLC>
            A(sub2ind(size(A), nodes1, nodes2)) = 0; %#ok<PROPLC>
            ga = Graph.getGraph(Graph.getClass(g), A, g.getSettings()); %#ok<PROPLC>
        end
    end
    methods (Static)
        function graph_class_list = getList()
            % GETLIST returns the list of available graphs
            %
            % GRAPH_CLASS_LIST = GETLIST() returns the list of graphs
            % (cell array) that are subclasses of Graph.
            %
            % See also getClass(), getCompatibleMeasureList()
            
            graph_class_list = subclasses( ...
                'Graph', ...
                [fileparts(which('Graph')) filesep 'graphs'] ...
                );
        end
        function graph_class = getClass(g)
            % GETCLASS returns the class of graphs
            %
            % GRAPH_CLASS = GETCLASS(G) returns the class of the concrete
            % instance of graph G.
            %
            % GRAPH_CLASS = GETCLASS(GRAPH_CLASS) returns the class of the
            % graph whose class is the string GRAPH_CLASS.
            %
            % See also getList(), getCompatibleMeasureList().
            
            if isa(g, 'Graph')
                graph_class = class(g);
            else % g should be a string with the graph code
                graph_class = g;
            end
        end
        function name = getName(g)
            % GETNAME returns the name of the graph
            %
            % NAME = GETNAME(G) returns the name (string) of the concrete instance
            % of graph G.
            %
            % NAME = GETNAME(GRAPH_CLASS) returns the name (string) of the
            % graph whose class is the string GRAPH_CLASS.
            %
            % See also getList(), getCompatibleMeasureList().
            
            name = eval([Graph.getClass(g) '.getName()']);
        end
        function name = getDescription(g)
            % GETDESCRIPTION returns the description of the graph
            %
            % DESCRIPTION = GETDESCRIPTION(G) returns the description
            % (string) of the concrete instance of graph G.
            %
            % DESCRIPTION = GETDESCRIPTION(GRAPH_CLASS) returns the
            % description (string) of the graph whose class is GRAPH_CLASS.
            %
            % See also getList(), getCompatibleMeasureList().
            
            name = eval([Graph.getClass(g) '.getDescription()']);
        end
        function bool = is_selfconnected(g)
            % IS_SELFCONNECTED checks if graph is self-connected
            %
            % BOOL = IS_SELFCONNECTED(G) returns true if the instance of the
            % concrete graph H is self-connected and false otherwise.
            %
            % BOOL = IS_SELFCONNECTED(GRAPH_CLASS) returns true if graph
            % whose class is GRAPH_CLASS is self-connected and false otherwise.
            
            bool = eval([Graph.getClass(g) '.is_selfconnected()']);
        end
        function bool = is_nonnegative(g)
            % IS_NONNEGATIVE checks if graph is non-negative
            %
            % BOOL = IS_NONNEGATIVE(G) returns true if the concrete instance
            % of graph G is non-negative and false otherwise.
            %
            % BOOL = IS_NONNEGATIVE(GRAPH_CLASS) returns true if the graph
            % whose class is GRAPH_CLASS is non-negative and false otherwise.
            
            bool = eval([Graph.getClass(g) '.is_nonnegative()']);
        end
        function bool = is_weighted(g)
            % IS_WEIGHTED checks if graph is weighted
            %
            % BOOL = IS_WEIGHTED(G) returns true if an instance of the concrete
            % graph G is weighted and false otherwise.
            %
            % BOOL = IS_WEIGHTED(GRAPH_CLASS) returns true if a graph whose
            % class is GRAPH_CLASS is weighted and false otherwise.
            %
            % See also is_binary().
            
            bool = eval([Graph.getClass(g) '.is_weighted()']);
        end
        function bool = is_binary(g)
            % IS_BINARY checks if graph is binary
            %
            % BOOL = IS_BINARY(G) returns true if an instance of the graph G
            % is binary and false otherwise.
            %
            % BOOL = IS_BINARY(GRAPH_CLASS) returns true if a graph whose
            % class if GRAPH_CLASS is binary and false otherwise.
            %
            % See also is_weighted().
            
            bool = eval([Graph.getClass(g) '.is_binary()']);
        end
        function bool = is_directed(g)
            % IS_DIRECTED checks if graph is directed
            %
            % BOOL = IS_DIRECTED(G) returns true if the instance of concrete
            % graph G is directed and false otherwise.
            %
            % BOOL = IS_DIRECTED(GRAPH_CLASS) returns true if a graph whose
            % class is GRAPH_CLASS is directed and false otherwise.
            %
            % See also is_undirected().
            
            bool = eval([Graph.getClass(g) '.is_directed()']);
        end
        function bool = is_undirected(g)
            % IS_UNDIRECTED checks if graph is undirected
            %
            % BOOL = IS_UNDIRECTED(G) returns true if the instance of the
            % concrete graph G is undirected and false otherwise.
            %
            % BOOL = IS_UNDIRECTED(GRAPH_CLASS) returns true if a graph
            % whose class is GRAPH_CLASS is undirected and false otherwise.
            %
            % See also is_directed().
            
            bool = eval([Graph.getClass(g) '.is_undirected()']);
        end
        function g_new = getGraph(g, A, varargin) %#ok<INUSD>
            % GETGRAPH returns a graph
            %
            % G = GETGRAPH(G, A) returns an instance
            % of the class of the graph G with adjacency matrix A.
            %
            % G = GETGRAPH(GRAPH_CLASS, A) returns an instance
            % of the class whose class is GRAPH_CLASS with adjacency matrix A.
            %
            % G = GETGRAPH(G, A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % G = GETGRAPH(GRAPH_CLASS, A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % initializes he property settings with the properties and values.
            %
            % G = GETGRAPH(G, A, 'Settings', SETTINGS) 
            % G = GETGRAPH(GRAPH_CLASS, A, 'Settings', SETTINGS) 
            % initializes the property settings with SETTINGS.
            %
            % See also getList(), getCompatibleMeasureList().
            
            g_new = eval([Graph.getClass(g) '(A, varargin{:})']);
        end
        function list = getCompatibleMeasureList(g)
            % GETCOMPATIBLEMEASURELIST returns the list of measures
            %
            % CELL ARRAY = GETCOMPATIBLEMEASURELIST(G) returns a cell array of
            % compatible measures to the concrete graph G.
            %
            % CELL ARRAY = GETCOMPATIBLEMEASURELIST(GRAPH_CLASS) returns a 
            % cell array of compatible measures to a graph whose class is
            % GRAPH_CLASS.
            %
            % See also getList(), getCompatibleMeasureNumber().
            
            graph_class = Graph.getClass(g);
            
            measure_code_list = Measure.getList();
            
            list = cell(1, length(measure_code_list));
            for i = 1:1:length(measure_code_list)
                measure_code = measure_code_list{i};
                
                if are_compatible(graph_class, measure_code)
                    list{i} = measure_code;
                end
            end
            list(cellfun('isempty', list)) = [];
        end
        function n = getCompatibleMeasureNumber(g)
            % GETCOMPATIBLEMEASURENUMBER returns the number of compatible
            % measures
            %
            % N = GETCOMPATIBLEMEASURENUMBER(G) returns the number of
            % compatible measures to the concrete graph G.
            %
            % N = GETCOMPATIBLEMEASURENUMBER(GRAHP_CLASS) returns the number
            % of compatible measures to graph whose class is GRAPH_CLASS.
            %
            % See also getList(), getCompatibleMeasureList().
            
            list = Graph.getCompatibleMeasureList(g);
            n = numel(list);
        end
    end
end
