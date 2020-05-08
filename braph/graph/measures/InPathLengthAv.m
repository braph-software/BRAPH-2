classdef InPathLengthAv < InPathLength
    % InPathLengthAv < InPathLength: Average In-Path Length measure
    % InPathLengthAv provides the average in-path length of a graph for binary 
    % directed (BD) and weighted directed (WD) graphs. It is calculated as the 
    % average of the sum of the in-path lengths.
    % 
    % InPathLengthAv methods:
    %   InPathLengthAv              - constructor with InPathLength properties.
    %
    % InPathLengthAv methods (Access=protected):
    %   calculate                   - calculates the average in-path length of a graph.
    % 
    % InPathLengthAv methods (Static)
    %   getClass                    - returns the average in-path length class.
    %   getName                     - returns the name of average in-path length measure.
    %   getDescription              - returns the description of average in-path length measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average in-path length measure is global.
    %   is_nodal                    - boolean, checks if average in-path length measure is nodal.
    %   is_binodal                  - boolean, checks if average in-path length measure if binodal.
    %   getMeasure                  - returns the average in-path length class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, InPathLength, Graph, PathLengthAv, OutPathLengthAv.
    
    methods
        function m = InPathLengthAv(g, varargin)
            % INPATHLENGTHAV(G) creates average in-path length with default InPathLength properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %   
            % INPATHLENGTHAV(G, 'Settings', SETTINGS) creates average in-path length measure 
            % and initializes the property settings with SETTINGS.
            % InPathLengthAv available SETTINGS are: 
            % subgraphs     -   Calculates PATHLENGTH of all subgraphs
            % harmonic      -   Calculates PATHLENGTH with harmonic average
            % default       -   Calculates PATHLENGTH with normal average
            %
            % INPATHLENGTHAV(G, 'VALUE', VALUE) creates average in-path length, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of GraphBU, Graph WU).
            %   
            % See also Measure, InPathLength, Graph, PathLengthAv, OutPathLengthAv.
            
           m = m@InPathLength(g, varargin {:});
        end
    end
    methods (Access=protected)
        function in_path_length_av = calculate(m)            
            % CALCULATE calculates the average in-path length value of a graph
            %
            % INPATHLENGTHAV = CALCULATE(M) returns the value of the average 
            % in-path_length of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InPathLength')
                in_path_length = g.getMeasureValue('InPathLength');
            else
                in_path_length = calculate@InPathLength(m);
            end
  
            in_path_length_av = mean(in_path_length);
        end
    end
     methods(Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average in-path length measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'InPathLengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-path length measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Average In Path Length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-path length measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average in path length of a graph is ' ...
                'the average of the sum of the in path lengths ' ...                
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % InPathLengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InPathLengthAv. 
            % INPATHLENGTHAVRULE = 'default' (default) - calculates path length of nodal graph.
            %                    'subgraphs' - calculates path length of each subgraph.
            %                    'harmonic'  - calculates the path length using harmonic mean.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'InPathLengthAvRule', Constant.STRING, 'default', {'default', 'subgraphs', 'harmonic'};
                };
        end
 function bool = is_global()
            % IS_GLOBAL checks if average in-path length measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                                            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average in-path length measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
                       
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average in-path length measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
                       
            bool = false;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InPathLengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to InPathLengthAv. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphWD', ...
                'GraphBD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to InPathLengthAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InPathLengthAv.
            % 
            % See also getCompatibleGraphList().
           
            n = Measure.getCompatibleGraphNumber('InPathLengthAv');
        end
    end
end