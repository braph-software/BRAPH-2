classdef Assortativity < Measure
    % Assortativity < Measure: Assortativity measure
    % Assortativity provides the assortativity coefficient of a graph for 
    % binary undirected (BU) and weighted undirected (WU) graphs. 
    % It is calculated as the correlation coefficient between the
    % degrees/strengths of all nodes on two opposite ends of an edge. The
    % corresponding coefficient for directed and weighted networks is
    % calculated by using the weighted and directed variants of degree/strength.
    % 
    % Assortativity methods:
    %   Assortativity               - constructor with Measure properties.
    %
    % Assortativity methods (Access=protected):
    %   calculate                   - calculates the assortativity of a graph.
    % 
    % Assortativity methods (Static)
    %   getClass                    - returns the assortativity class.
    %   getName                     - returns the name of assortativity measure.
    %   getDescription              - returns the description of assortativity measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if assortativity measure is global.
    %   is_nodal                    - boolean, checks if assortativity measure is nodal.
    %   is_binodal                  - boolean, checks if assortativity measure if binodal.
    %   getMeasure                  - returns the assortativity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Degree, Strength, Distance.
    
    methods
        function m = Assortativity(g, varargin)           
            % ASSORTATIVITY(G) creates assortativity with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % ASSORTATIVITY(G, 'VALUE', VALUE) creates assortativity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Degree, Strength, Distance. 
              
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function assortativity = calculate(m)
            % CALCULATE calculates the assortativity value of a graph
            %
            % ASSORTATIVITY = CALCULATE(M) returns the value of the assortativity of a
            % graph.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix of the graph
            [i, j] = find(triu(A) ~= 0);  % nodes [i, j] 
            M = length(i);  % Number of edges
            
            if isa(g, 'GraphBU')  % Binary undirected
                
                if g.is_measure_calculated('Degree')
                    degree = g.getMeasureValue('Degree');
                else
                    degree = Degree(g, g.getSettings()).getValue();
                end
                
                k_i = degree(i);  % degree node i
                k_j = degree(j);  % degree node j
                
            elseif isa(g, 'GraphWU')  % Weighted undirected
                
                if g.is_measure_calculated('Strength')
                    strength = g.getMeasureValue('Strength');
                else
                    strength = Strength(g, g.getSettings()).getValue();
                end
                
                k_i = strength(i);  % strength node i
                k_j = strength(j);  % strength node j
            end
            
            % compute assortativity
            assortativity = (sum(k_i .* k_j) / M - (sum(0.5 * (k_i + k_j)) / M)^2)... 
                / (sum(0.5 * (k_i.^2 + k_j.^2)) / M - (sum(0.5 * (k_i + k_j)) / M)^2);
            assortativity(isnan(assortativity)) = 0;  % Should return zeros, not NaN
        end
    end
    methods (Static)
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
                'of all nodes on two opposite ends of an edge.' ...
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
        function bool = is_global()
            % IS_GLOBAL checks if assortativity measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if assortativity measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if assortativity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to Assortativity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to Assortativity. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBU', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to Assortativity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to Assortativity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Assortativity');
        end
    end
end