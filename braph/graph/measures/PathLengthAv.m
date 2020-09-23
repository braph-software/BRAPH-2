classdef PathLengthAv < PathLength
    % PathLengthAv < PathLength: Average Path Length measure
    % PathLengthAv provides the average path length of a graph for binary undirected
    % (BU) and weighted undirected (WU) graphs. It is calculated as the 
    % average of the sum of the path lengths.
    % 
    % PathLengthAv methods:
    %   PathLengthAv                - constructor with PathLength properties.
    %
    % PathLengthAv methods (Access=protected):
    %   calculate                   - calculates the average path length of a graph.
    % 
    % PathLengthAv methods (Static)
    %   getClass                    - returns the average path length class.
    %   getName                     - returns the name of average path length measure.
    %   getDescription              - returns the description of average path length measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average path length measure is global.
    %   is_nodal                    - boolean, checks if average path length measure is nodal.
    %   is_binodal                  - boolean, checks if average path length measure if binodal.
    %   getMeasure                  - returns the average path length class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, PathLength, Graph, Strength, Distance.
    
    methods
        function m = PathLengthAv(g, varargin)
            % PATHLENGTHAV(G) creates average path length with default PathLength properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %   
            % PATHLENGTHAV(G, 'Settings', SETTINGS) creates average path length measure 
            % and initializes the property settings with SETTINGS.
            % PathLengthAv available SETTINGS are: 
            % subgraphs     -   Calculates PATHLENGTH of all subgraphs
            % harmonic      -   Calculates PATHLENGTH with harmonic average
            % default       -   Calculates PATHLENGTH with normal average
            %
            % PATHLENGTHAV(G, 'VALUE', VALUE) creates average path length, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of GraphBU, Graph WU).
            %   
            % See also Measure, PathLength, Graph, Strength, Distance.
            
           m = m@PathLength(g, varargin {:});
        end
    end
    methods (Access=protected)
        function path_length_av = calculate(m)            
            % CALCULATE calculates the average path length value of a graph
            %
            % PATHLENGTHAV = CALCULATE(M) returns the value of the average path_length
            % of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('PathLength')
                path_length = g.getMeasureValue('PathLength');
            else
                path_length = calculate@PathLength(m);
            end
  
            path_length_av = mean(path_length);
        end
    end
     methods(Static)
         function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average path length measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'PathLengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average path length measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Average-Path-Length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average path length measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average path length of a graph is ' ...
                'the average of the sum of the path lengths ' ...                
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % PathLengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to PathLengthAv. 
            % PATHLENGTHAVRULE = 'default' (default) - calculates path length of nodal graph.
            %                    'subgraphs' - calculates path length of each subgraph.
            %                    'harmonic'  - calculates the path length using harmonic mean.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'PathLengthAvRule', Constant.STRING, 'default', {'default', 'subgraphs', 'harmonic'};
                };
        end
       function bool = is_global()
            % IS_GLOBAL checks if average path length measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                                            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average path length measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
                       
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average path length measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
                       
            bool = false;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to PathLengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to PathLengthAv. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphWU', ...
                'GraphBU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to PathLengthAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to PathLengthAv.
            % 
            % See also getCompatibleGraphList().
           
            n = Measure.getCompatibleGraphNumber('PathLengthAv');
        end
    end
end