classdef Transitivity < Triangles
    % Transitivity < Triangles: Clustering measure
    % Transitivity provides the transitivity of a graph for binary
    % undirected (BU), binary directed (BD), weighted undirected (WU) and 
    % weighted directed (WD) graphs. It is calculated as the fraction of   
    % triangles to the number of unordered triplets in the graph.
    % 
    % Transitivity methods:
    %   Transitivity                - constructor with Triangles properties.
    %
    % Transitivity methods (Access=protected):
    %   calculate                   - calculates the transitivity of a graph.
    % 
    % Transitivity methods (Static)
    %   getClass                    - returns the transitivity class.
    %   getName                     - returns the name of transitivity measure.
    %   getDescription              - returns the description of transitivity measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if transitivity measure is global.
    %   is_nodal                    - boolean, checks if transitivity measure is nodal.
    %   is_binodal                  - boolean, checks if transitivity measure if binodal.
    %   getMeasure                  - returns the transitivity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Triangles, Measure, Graph, Clustering, Strength, Degree.
       
    methods
        function m = Transitivity (g, varargin)       
            % TRANSITIVITY(G) creates transitivity with default triangles properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
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
            % GraphWD, Graph WU).
            %   
            % See also Triangles, Measure, Graph, Clustering, Strength, Degree.
                     
            m = m@Triangles(g, varargin{:});
        end
    end
    methods (Access=protected)
        function transitivity = calculate(m)
            % CALCULATE calculates the transitivity of a graph
            %
            % TRANSITIVITY = CALCULATE(M) returns the value of the transitivity 
            % of a graph.
            
            g = m.getGraph(); % graph from measure class
            A = g.getA(); % adjency matrix of the graph
            
            if g.is_measure_calculated('Triangles')
                triangles = g.getMeasureValue('Triangles');
            else
                triangles = calculate@Triangles(m);
            end
            
            if isa(g, 'GraphBU') || isa(g, 'GraphWU')
                
                if g.is_measure_calculated('Degree')
                    degree = g.getMeasureValue('Degree');                    
                else
                    degree = Degree(g, g.getSettings()).getValue();
                end
                
                transitivity = 2 * sum(triangles) ./ sum((degree .* (degree - 1)));
                
            elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')  
                
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

                transitivity = sum(triangles) ./ sum(((out_degree + in_degree) .* (out_degree + in_degree - 1) - 2 * diag(A^2)));      
            end
            
            transitivity(isnan(transitivity)) = 0;  % Should return zeros, not NaN
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
                'of (unordered) triplets in the graph.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % Transitivity
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

             available_settings = {
                'DirectedTrianglesRule', Constant.STRING, 'cycle', {'cycle', 'all', 'middleman', 'in', 'out'};
                };
        end
        function bool = is_global()
            % IS_GLOBAL checks if transitivity measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
               
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if transitivity measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal.
          
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if transitivity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to Transitivity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to Transitivity. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to Transitivity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to Transitivity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Transitivity');
        end
    end
    
end