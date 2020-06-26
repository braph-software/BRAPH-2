classdef Transitivity < Triangles
    % Transitivity Transitivity measure
    % Transitivity provides the transitivity of a graph for binary
    % undirected (BU), binary directed (BD), weighted undirected (WU) and 
    % weighted directed (WD) graphs.
    %
    % It is calculated as the fraction of triangles to the number of 
    % unordered triplets within a layer.
    % 
    % Transitivity methods:
    %   Transitivity                - constructor 
    % 
    % Transitivity methods (Static)
    %   getClass                    - returns the transitivity class
    %   getName                     - returns the name of transitivity measure
    %   getDescription              - returns the description of transitivity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope
    %   getMeasure                  - returns the clustering class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Triangles, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = Transitivity (g, varargin)
            % TRANSITIVITY(G) creates transitivity with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU, GraphWD,
            % GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU).  
            %
            % TRANSITIVITY(G, 'DirectedTrianglesRule', DIRECTEDTRIANGLESRULE) creates transitivity             
            % measure and initializes the property DirectedTrianglesRule with DIRECTEDTRIANGLESRULE. 
            % Admissible RULE options are:
            % DIRECTEDTRIANGLESRULE = 'cycle' (default) - calculates TRIANGLES of a node using the cycle rule for directed graphs.
            %                    'all' - calculates TRIANGLES of a node
            %                    using the all rule for directed graphs.
            %                    'middleman' - calculates TRIANGLES of a
            %                    node using the middleman rule for directed graphs.
            %                    'in' - calculates TRIANGLES of a node
            %                    using the in rule for directed graphs.
            %                    'out' - calculates TRIANGLES of a node
            %                    using the out rule for directed graphs.
            % 
            % TRANSITIVITY(G, 'VALUE', VALUE) creates transitivity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU). 
            %   
            % See also Measure, Triangles, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Triangles(g, varargin{:});
        end
    end
    methods (Access=protected)
        function transitivity = calculate(m)
            % CALCULATE calculates the transitivity coefficient of a graph
            %
            % TRANSITIVITY = CALCULATE(M) returns the coefficient of the transitivity 
            % of a graph.
            %
            % See also Measure, Triangles, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix of the graph
            L = g.layernumber();
            
            if g.is_measure_calculated('Triangles')
                triangles = g.getMeasureValue('Triangles');
            else
                triangles = calculate@Triangles(m);
            end
            
            transitivity = cell(g.layernumber(), 1);
            directionality_type =  g.getDirectionalityType(g.layernumber());
            for li = 1:1:L
                
                if g.is_graph(g)
                    Aii = A;
                    directionality_layer = directionality_type;
                else
                    Aii = A{li, li};
                    directionality_layer = directionality_type(li, li);
                end
                
                if directionality_layer == Graph.UNDIRECTED  % undirected graphs

                    if g.is_measure_calculated('Degree')
                        degree = g.getMeasureValue('Degree');                    
                    else
                        degree = Degree(g, g.getSettings()).getValue();
                    end

                    clustering_layer = 2 * triangles{li} ./ (degree{li} .* (degree{li} - 1));

                else  % directed graphs

                    if g.is_measure_calculated('InDegree')
                        in_degree = g.getMeasureValue('InDegree');
                    else 
                        in_degree = InDegree(g, g.getSettings()).getValue();
                    end

                    if g.is_measure_calculated('OutDegree')
                        out_degree = g.getMeasureValue('OutDegree');
                    else
                        out_degree = OutDegree(g, g.getSettings()).getValue();
                    end

                    directed_triangles_rule = get_from_varargin('cycle', 'DirectedTrianglesRule', m.getSettings());
                    switch lower(directed_triangles_rule)
                        case {'all'}  % all rule
                            clustering_layer = triangles{li} ./ ((out_degree{li} + in_degree{li}) .* (out_degree{li} + in_degree{li} - 1) - 2 * diag(Aii^2));
                        case {'middleman'}  % middleman rule
                            clustering_layer = triangles{li} ./ ((out_degree{li} .* in_degree{li}) - diag(Aii^2));
                        case {'in'}  % in rule
                            clustering_layer = triangles{li} ./ (in_degree{li} .* (in_degree{li} - 1));
                        case {'out'}  % out rule
                            clustering_layer = triangles{li} ./ (out_degree{li} .* (out_degree{li} - 1));
                        otherwise  % {'cycle'}  % cycle rule
                            clustering_layer = triangles{li} ./ ((out_degree{li} .* in_degree{li}) - diag(Aii^2));
                    end

                end
                clustering_layer(isnan(clustering_layer)) = 0;  % Should return zeros, not NaN
                transitivity(li) = {clustering_layer};
            end
        end
    end  
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the transitivity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'Transitivity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the transitivity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Transitivity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the transitivity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % transitivity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The transitivity of a graph is ' ...
                'the fraction of triangles to the number' ...
                'of (unordered) triplets within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Transitivity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Transitivity. 
            % DIRECTEDTRIANGLESRULE = 'cycle' (default) - calculates TRIANGLES of a node using the cycle rule for directed graphs.
            %                    'all' - calculates TRIANGLES of a node
            %                    using the all rule for directed graphs.
            %                    'middleman' - calculates TRIANGLES of a
            %                    node using the middleman rule for directed graphs.
            %                    'in' - calculates TRIANGLES of a node
            %                    using the in rule for directed graphs.
            %                    'out' - calculates TRIANGLES of a node
            %                    using the out rule for directed graphs.
            % 
            % See also getCompatibleGraphList()

            available_settings = getAvailableSettings@Triangles();
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Transitivity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of transitivity measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Transitivity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of transitivity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with Transitivity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to transitivity. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with Transitivity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to transitivity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Transitivity');
        end
    end  
end