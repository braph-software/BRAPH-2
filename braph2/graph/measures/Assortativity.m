classdef Assortativity < Measure
    % Assortativity Assortativity measure
    % Assortativity provides the assortativity coefficient of a graph for
    % binary undirected (BU) and weighted undirected (WU) graphs.
    %
    % It is calculated as the correlation coefficient between the
    % degrees/strengths of all nodes on two opposite ends of an edge
    % within a layer. The corresponding coefficient for directed and
    % weighted networks is calculated by using the weighted and directed
    % variants of degree/strength.
    %
    % Assortativity methods:
    %   Assortativity               - constructor
    %
    % Assortativity descriptive methods (Static)
    %   getClass                    - returns the assortativity class
    %   getName                     - returns the name of assortativity measure
    %   getDescription              - returns the description of assortativity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the assortativity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Degree, Strength, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = Assortativity(g, varargin)
            % ASSORTATIVITY(G) creates assortativity with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU, MultiplexGraphWU).
            %
            % See also Measure, Degree, Strength, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function assortativity = calculate(m)
            % CALCULATE calculates the assortativity value of a graph
            %
            % ASSORTATIVITY = CALCULATE(M) returns the value of the assortativity of a
            % graph.
            %
            % See also Measure, Degree, Strength, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            
            assortativity = cell(L, 1);
            connectivity_type =  g.getConnectivityType(g.layernumber());
            for li = 1:1:L
                
                if g.is_graph(g)
                    Aii = A;
                    connectivity_layer = connectivity_type;
                else
                    Aii = A{li, li};
                    connectivity_layer = connectivity_type(li, li);
                end
                
                [i, j] = find(triu(Aii) ~= 0);  % nodes [i, j]
                M = length(i);  % Number of edges
                k_i = zeros(M, L);
                k_j = zeros(length(j), L);
                
                if connectivity_layer == Graph.WEIGHTED  % weighted graphs
                    
                    if g.is_measure_calculated('Strength')
                        strength = g.getMeasureValue('Strength');
                    else
                        strength = Strength(g, g.getSettings()).getValue();
                    end
                    d = strength{li};
                    
                    
                else  % binary graphs
                    
                    if g.is_measure_calculated('Degree')
                        degree = g.getMeasureValue('Degree');
                    else
                        degree = Degree(g, g.getSettings()).getValue();
                    end
                    d = degree{li};
                    
                end
                k_i(:, li) = d(i);  % degree/strength node i
                k_j(:, li) = d(j);  % degree/strength node j
                % compute assortativity
                assortativity_layer = (sum(k_i(:, li) .* k_j(:, li)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2)...
                    / (sum(0.5 * (k_i(:, li).^2 + k_j(:, li).^2)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2);
                assortativity_layer(isnan(assortativity_layer)) = 0;  % Should return zeros, not NaN
                assortativity(li) = {assortativity_layer};
            end
        end
    end
    methods (Static)  % descriptive
        function measure_class = getClass()
            % GETCLASS returns the measure class
            %
            % MEASURE_CLASS = GETCLASS() returns the class of the assortativity measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'Assortativity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the assortativity measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Assortativity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the assortativity description
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % assortativity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The assortativity coefficient of a graph is ' ...
                'the correlation coefficient between the degrees/strengths ' ...
                'of all nodes on two opposite ends of an edge within a layer.' ...
                'The corresponding coefficient for directed and '...
                'weighted networks is calculated by using the weighted '...
                'and directed variants of degree/strength.'...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Assortativity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Assortativity. Empty Array in this case.
            %
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Assortativity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of assortativity measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Assortativity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of assortativity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of Assortativity
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of assortativity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with Assortativity
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array
            % of compatible graph classes to assortativity.
            % The measure will not work if the graph is not compatible.
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphBU', ...
                'GraphWU', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with Assortativity
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to assortativity.
            %
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Assortativity');
        end
    end
end