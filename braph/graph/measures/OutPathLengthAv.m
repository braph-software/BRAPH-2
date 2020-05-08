classdef OutPathLengthAv < OutPathLength
    % OutPathLengthAv < OutPathLength: Average Out-Path Length measure
    % OutPathLengthAv provides the average out-path length of a graph for binary 
    % directed (BD) and weighted directed (WD) graphs. It is calculated as the 
    % average of the sum of the out-path lengths.
    % 
    % OutPathLengthAv methods:
    %   OutPathLengthAv             - constructor with OutPathLength properties.
    %
    % OutPathLengthAv methods (Access=protected):
    %   calculate                   - calculates the average out-path length of a graph.
    % 
    % OutPathLengthAv methods (Static)
    %   getClass                    - returns the average out-path length class.
    %   getName                     - returns the name of average out-path length measure.
    %   getDescription              - returns the description of average out-path length measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average out-path length measure is global.
    %   is_nodal                    - boolean, checks if average out-path length measure is nodal.
    %   is_binodal                  - boolean, checks if average out-path length measure if binodal.
    %   getMeasure                  - returns the average out-path length class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, InPathLength, Graph, PathLengthAv, InPathLengthAv.
    
    methods
        function m = OutPathLengthAv(g, varargin)
            % OUTPATHLENGTHAV(G) creates average out-path length with default OutPathLength properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %   
            % OUTPATHLENGTHAV(G, 'Settings', SETTINGS) creates average out-path length measure 
            % and initializes the property settings with SETTINGS.
            % OutPathLengthAv available SETTINGS are: 
            % subgraphs     -   Calculates PATHLENGTH of all subgraphs
            % harmonic      -   Calculates PATHLENGTH with harmonic average
            % default       -   Calculates PATHLENGTH with normal average
            %
            % OUTPATHLENGTHAV(G, 'VALUE', VALUE) creates average out-path length, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of GraphBU, Graph WU).
            %   
            % See also Measure, InPathLength, Graph, PathLengthAv, InPathLengthAv.
            
           m = m@OutPathLength(g, varargin {:});
        end
    end
    methods (Access=protected)
        function out_path_length_av = calculate(m)            
            % CALCULATE calculates the average out-path length value of a graph
            %
            % OUTPATHLENGTHAV = CALCULATE(M) returns the value of the average 
            % out-path_length of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutPathLength')
                out_path_length = g.getMeasureValue('OutPathLength');
            else
                out_path_length = calculate@OutPathLength(m);
            end
  
            out_path_length_av = mean(out_path_length);
        end
    end
     methods(Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average out-path length measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'OutPathLengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average out-path length measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Average Out Path Length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-path length measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average out path length of a graph is ' ...
                'the average of the sum of the out path lengths ' ...                
                ];
        end
        function available_settings = getAvailableSettings()   
            % GETAVAILABLESETTINGS returns the setting available to
            % OutPathLengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutPathLengthAv. 
            % OUTPATHLENGTHAVRULE = 'default' (default) - calculates path length of nodal graph.
            %                    'subgraphs' - calculates path length of each subgraph.
            %                    'harmonic'  - calculates the path length using harmonic mean.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'OutPathLengthAvRule', Constant.STRING, 'default', {'default', 'subgraphs', 'harmonic'};
                };
        end
 function bool = is_global()
            % IS_GLOBAL checks if average out-path length measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                                            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average out-path length measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
                       
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average out-path length measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
                       
            bool = false;
        end
        function list = getCompatibleGraphList() 
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to OutPathLengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to OutPathLengthAv. 
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
            % graphs to OutPathLengthAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to OutPathLengthAv.
            % 
            % See also getCompatibleGraphList().
           
            n = Measure.getCompatibleGraphNumber('OutPathLengthAv');
        end
    end
end