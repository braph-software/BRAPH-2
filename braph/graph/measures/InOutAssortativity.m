classdef InOutAssortativity < Measure
    % InOutAssortativity < Measure: In-Out-Assortativity measure
    % InOutAssortativity provides the in-out-assortativity coefficient of a graph for 
    % binary directed (BD) and weighted directed (WD) graphs. 
    % It is calculated as the correlation coefficient between the
    % degrees/strengths of all nodes on two opposite ends of an edge. The
    % corresponding coefficient for directed networks is
    % calculated by using the in-degree/in-strength and the out-degree/out-strength.
    % 
    % InOutAssortativity methods:
    %   InOutAssortativity          - constructor with Measure properties.
    %
    % InOutAssortativity methods (Access=protected):
    %   calculate                   - calculates the in-out-assortativity of a graph.
    % 
    % InOutAssortativity methods (Static)
    %   getClass                    - returns the in-out-assortativity class.
    %   getName                     - returns the name of in-out-assortativity measure.
    %   getDescription              - returns the description of in-out-assortativity measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if in-out-assortativity measure is global.
    %   is_nodal                    - boolean, checks if in-out-assortativity measure is nodal.
    %   is_binodal                  - boolean, checks if in-out-assortativity measure if binodal.
    %   getMeasure                  - returns the in-out-assortativity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Assortativity, InDegree, InStrength, OutDegree, OutStrength.
    
    methods
        function m = InOutAssortativity(g, varargin)
            % INOUTASSORTATIVITY(G) creates in-out-assortativity with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % INOUTASSORTATIVITY(G, 'VALUE', VALUE) creates in-out-assortativity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Assortativity, InDegree, InStrength, OutDegree, OutStrength.
         
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function in_out_assortativity = calculate(m)
            % CALCULATE calculates the in-out-assortativity value of a graph
            %
            % INOUTASSORTATIVITY = CALCULATE(M) returns the value of the in-out-assortativity 
            % of a graph.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix of the graph
            [i, j] = find(A ~= 0);  % nodes [i, j]
            M = length(i);  % Number of edges  
            
            if isa(g, 'GraphBD')  % Binary directed
                
                if g.is_measure_calculated('InDegree')
                    in_k = g.getMeasureValue('InDegree');
                else 
                    in_k = InDegree(g, g.getSettings()).getValue();
                end

                if g.is_measure_calculated('OutDegree')
                    out_k = g.getMeasureValue('OutDegree');
                else
                    out_k = OutDegree(g, g.getSettings()).getValue();
                end
                    
            elseif isa(g, 'GraphWD')  % Weighted directed
                
                if g.is_measure_calculated('InStrength')
                    in_k = g.getMeasureValue('InStrength');
                else 
                    in_k = InStrength(g, g.getSettings()).getValue();
                end

                if g.is_measure_calculated('OutStrength')
                    out_k = g.getMeasureValue('OutStrength');
                else
                    out_k = OutStrength(g, g.getSettings()).getValue();
                end              
            end
            % calculate out - in degrees/strengths for node i and node j
            k_i = in_k(i);
            k_j = out_k(j);
            
            % compute assortativity
            in_out_assortativity = ( sum(k_i .* k_j) / M - ...
                (sum(0.5 * (k_i + k_j)) / M)^2 ) / ...
                (sum(0.5 * (k_i.^2 + k_j.^2)) / M - (sum(0.5 * (k_i + k_j)) / M)^2);
            in_out_assortativity(isnan(in_out_assortativity)) = 0;  % Should return zeros, not NaN
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-out-assortativity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'InOutAssortativity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-out-assortativity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'In-Out-Assortativity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-out-assortativity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-in-assortativity measure.
            %
            % See also getList(), getCompatibleGraphList().
           
            description = [ ...
                'The in-out assortativity coefficient of a directed graph is ' ...
                'the correlation coefficient between the degrees/strengths ' ...
                'of all nodes on two opposite ends of an edge.' ...
                'The corresponding coefficient for directed networks '...
                'is calculated by using the out degree/strength and in degree/strength.'...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InOutAssortativity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InOutAssortativity. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if in-out-assortativity measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if in-out-assortativity measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if in-out-assortativity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InOutAssortativity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to InOutAssortativity. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD' ...
                'GraphWD', ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to InOutAssortativity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InOutAssortativity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InOutAssortativity');
        end
    end
end