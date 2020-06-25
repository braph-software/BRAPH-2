classdef PathLengthAv < PathLength
    % PathLengthAv Average path length measure
    % PathLengthAv provides the average path length of a graph for binary 
    % undirected (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as the average of the sum of the path lengths within 
    % each layer.
    % 
    % PathLengthAv methods:
    %   PathLengthAv                - constructor
    %
    % PathLengthAv methods (Static)
    %   getClass                    - returns the average path length class
    %   getName                     - returns the name of average path length measure
    %   getDescription              - returns the description of average path length measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope   
    %   getMeasure                  - returns the average path length class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Distance, PathLength, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = PathLengthAv(g, varargin)
            % PATHLENGTHAV(G) creates average path length with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU, 
            % MultiplexGraphBU or MultiplexGraphWU).
            %   
            % PATHLENGTHAV(G, 'PathLengthRule', PATHLENGTHRULE) creates average 
            % path length measure and initializes the property PathLengthRule 
            % with PATHLENGTHRULE. 
            % Admissible PATHLENGTHRULE options are:
            % PATHLENGTHRULE = 'default' (default) - calculates PATHLENGTH 
            %                  with normal average
            %                  'subgraphs' - calculates PATHLENGTH of all
            %                  subgraphs.
            %                  'harmonic' - calculates PATHLENGTH with
            %                  harmonic average.
            %
            % PATHLENGTHAV(G, 'VALUE', VALUE) creates average path length, 
            % and sets the value to VALUE. G is a graph (e.g, an instance 
            % of GraphBU, GraphWU, MultiplexGraphBU or MultiplexGraphWU).
            %   
            % See also Measure, Distance, PathLength, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
           m = m@PathLength(g, varargin {:});
        end
    end
    methods (Access=protected)
        function path_length_av = calculate(m)            
            % CALCULATE calculates the average path length value of a graph
            %
            % PATHLENGTHAV = CALCULATE(M) returns the value of the average path_length
            % of a graph.
            %
            % See also Measure, Distance, PathLength, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('PathLength')
                path_length = g.getMeasureValue('PathLength');
            else
                path_length = calculate@PathLength(m);
            end
  
            path_length_av = cell(g.layernumber(), 1);
            for li = 1:1:length(path_length_av)
                path_length_av(li) = {mean(path_length{li})};
            end
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
            
            name = 'Average path length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average path length measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average path length of a graph is ' ...
                'the average of the sum of the path lengths within each layer. ' ...                
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % PathLengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to PathLengthAv. 
            % PATHLENGTHRULE = 'default' (default) - calculates PATHLENGTH 
            %                  with normal average
            %                  'subgraphs' - calculates PATHLENGTH of all
            %                  subgraphs.
            %                  'harmonic' - calculates PATHLENGTH with
            %                  harmonic average.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'PathLengthRule', BRAPH2.STRING, 'default', {'default', 'subgraphs', 'harmonic'};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of PathLengthAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average path length measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of PathLengthAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average path length measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with PathLengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average path length. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphWU', ...
                'GraphBU' ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with PathLengthAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average path length.
            % 
            % See also getCompatibleGraphList().
           
            n = Measure.getCompatibleGraphNumber('PathLengthAv');
        end
    end
end