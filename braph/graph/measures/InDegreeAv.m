classdef InDegreeAv < InDegree
    % InDegreeAv < InDegree: Average In-Degree measure
    % InDegreeAv provides the average in-degree of a graph for binary directed
    % (BD) and weighted directed (WD) graphs. It is calculated as the 
    % average of all number of edges connected to the node.
    % 
    % InDegreeAv methods:
    %   InDegreeAv                  - constructor with InDegree properties.
    %
    % InDegreeAv methods (Access=protected):
    %   calculate                   - calculates the average in-degree of a graph.
    % 
    % InDegreeAv methods (Static)
    %   getClass                    - returns the average in-degree class.
    %   getName                     - returns the name of average in-degree measure.
    %   getDescription              - returns the description of average in-degree measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average in-degree measure is global.
    %   is_nodal                    - boolean, checks if average in-degree measure is nodal.
    %   is_binodal                  - boolean, checks if average in-degree measure if binodal.
    %   getMeasure                  - returns the average in-degree class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, InDegree, Graph, DegreeAv, OutDegreeAv, Distance.
    
    methods
        function m = InDegreeAv(g, varargin)
            % INDEGREEAV(G) creates average in-degree with default InDegree properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % INDEGREEAV(G, 'VALUE', VALUE) creates average in-degree, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, InDegree, Graph, DegreeAv, OutDegreeAv, Distance.

            m = m@InDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function in_degree_av = calculate(m)
            % CALCULATE calculates the average in-degree value of a graph
            %
            % INDEGREEAV = CALCULATE(M) returns the value of the average in-degree 
            % of a graph.
            
            g = m.getGraph(); % graph from measure class

            if g.is_measure_calculated('InDegree')
                in_degree = g.getMeasureValue('InDegree');
            else
                in_degree = calculate@InDegree(m);
            end
            
            in_degree_av = mean(in_degree);
        end
    end
    methods(Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average
            % in-degree measure.
            %
            % See also getName(), getDescription(). 
             
            measure_class = 'InDegreeAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-degree measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average In Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-degree measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average of in degrees of a graph is ' ...
                'the average of all number of inward edges '...
                'connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % InDegreeAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InDegreeAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if average in-degree measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                                            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average in-degree measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
                       
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average in-degree measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
                       
            bool = false;
        end
        function list = getCompatibleGraphList() 
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InDegreeAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to InDegreeAv. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to InDegreeAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InDegreeAv.
            % 
            % See also getCompatibleGraphList().
              
            n = Measure.getCompatibleGraphNumber('InDegreeAv');
        end
    end
end
