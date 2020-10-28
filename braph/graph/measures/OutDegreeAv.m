classdef OutDegreeAv < OutDegree
    % OutDegreeAv < OutDegree: Average Out-Degree measure
    % OutDegreeAv provides the average out-degree of a graph for binary directed
    % (BD) and weighted directed (WD) graphs. It is calculated as the 
    % average of all number of edges connected to the node.
    % 
    % OutDegreeAv methods:
    %   OutDegreeAv                 - constructor with OutDegree properties.
    %
    % OutDegreeAv methods (Access=protected):
    %   calculate                   - calculates the average out-degree of a graph.
    % 
    % OutDegreeAv methods (Static)
    %   getClass                    - returns the average out-degree class.
    %   getName                     - returns the name of average out-degree measure.
    %   getDescription              - returns the description of average out-degree measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average out-degree measure is global.
    %   is_nodal                    - boolean, checks if average out-degree measure is nodal.
    %   is_binodal                  - boolean, checks if average out-degree measure if binodal.
    %   getMeasure                  - returns the average out-degree class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, OutDegree, Graph, DegreeAv, InDegreeAv, Distance.
    
    methods
        function m = OutDegreeAv(g, varargin)
            % OUTDEGREEAV(G) creates average out-degree with default OutDegree properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % OUTDEGREEAV(G, 'VALUE', VALUE) creates average out-degree, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, OutDegree, Graph, DegreeAv, InDegreeAv, Distance.

            m = m@OutDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function out_degree_av = calculate(m)
            % CALCULATE calculates the average out-degree value of a graph
            %
            % OUTDEGREEAV = CALCULATE(M) returns the value of the average out-degree 
            % of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutDegree')
                out_degree = g.getMeasureValue('OutDegree');
            else
                out_degree = calculate@OutDegree(m);
            end
            
            out_degree_av = mean(out_degree);
        end
    end
    methods(Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average
            % out-degree measure.
            %
            % See also getName(), getDescription(). 
             
            measure_class = 'OutDegreeAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average out-degree measure.
            %
            % See also getClass(), getDescription(). 
           
            name = 'Average Out Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-degree measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average of out degrees of a graph is ' ...
                'the average of all number of outward edges '...
                'connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % OutDegreeAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutDegreeAv. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
       function bool = is_global()
            % IS_GLOBAL checks if average out-degree measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                                            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average out-degree measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
                       
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average out-degree measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
                       
            bool = false;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to OutDegreeAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to OutDegreeAv. 
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
            % graphs to OutDegreeAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to OutDegreeAv.
            % 
            % See also getCompatibleGraphList().
              
            n = Measure.getCompatibleGraphNumber('OutDegreeAv');
        end
    end
end
