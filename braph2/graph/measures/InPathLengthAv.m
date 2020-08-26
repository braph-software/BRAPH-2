classdef InPathLengthAv < InPathLength
    % InPathLengthAv Average in-path length measure
    % InPathLengthAv provides the average in-path length of a graph for binary 
    % undirected (BD) and weighted undirected (WD) graphs. 
    %
    % It is calculated as the average of the sum of the in-path lengths within 
    % each layer. The calculation of in-path length is controlled by the in-path
    % length rule (setting 'InPathLengthRule'), the default option calculates
    % the measure with normal average. 
    % 
    % InPathLengthAv methods:
    %   InPathLengthAv              - constructor
    %
    % InPathLengthAv methods (Static)
    %   getClass                    - returns the average in-path length class
    %   getName                     - returns the name of average in-path length measure
    %   getDescription              - returns the description of average in-path length measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the average path length class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Distance, InPathLength, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = InPathLengthAv(g, varargin)
            % INPATHLENGTHAV(G) creates average in-path length with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD, 
            % MultiplexGraphBD or MultiplexGraphWD).
            %   
            % INPATHLENGTHAV(G, 'InPathLengthRule', INPATHLENGTHRULE) creates average 
            % in-path length measure and initializes the property InPathLengthRule 
            % with INPATHLENGTHRULE. 
            % Admissible INPATHLENGTHRULE options are:
            % INPATHLENGTHRULE = 'default' (default) - calculates INPATHLENGTH 
            %                    with normal average
            %                    'subgraphs' - calculates INPATHLENGTH of all
            %                    subgraphs.
            %                    'harmonic' - calculates INPATHLENGTH with
            %                    harmonic average.
            %
            % INPATHLENGTHAV(G, 'VALUE', VALUE) creates average in-path length, 
            % and sets the value to VALUE. G is a graph (e.g, an instance 
            % of GraphBD, GraphWD, MultiplexGraphBD or MultiplexGraphWD).
            %   
            % See also Measure, Distance, InPathLength, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
           m = m@InPathLength(g, varargin {:});
        end
    end
    methods (Access=protected)
        function in_path_length_av = calculate(m)            
            % CALCULATE calculates the average in-path length value of a graph
            %
            % INPATHLENGTHAV = CALCULATE(M) returns the value of the average in-path length
            % of a graph.
            %
            % See also Measure, Distance, InPathLength, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InPathLength')
                in_path_length = g.getMeasureValue('InPathLength');
            else
                in_path_length = calculate@InPathLength(m);
            end
  
            in_path_length_av = cell(g.layernumber(), 1);
            for li = 1:1:length(in_path_length_av)
                in_path_length_av(li) = {mean(in_path_length{li})};
            end
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
            
            name = 'Average in-path length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-path length measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average in-path length of a graph is ' ...
                'the average of the sum of the in-path lengths within each layer. ' ...                
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % InPathLengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InPathLengthAv. 
            % INPATHLENGTHRULE = 'default' (default) - calculates INPATHLENGTH 
            %                    with normal average
            %                    'subgraphs' - calculates INPATHLENGTH of all
            %                    subgraphs.
            %                    'harmonic' - calculates INPATHLENGTH with
            %                    harmonic average.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = getAvailableSettings@InPathLength();
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InPathLengthAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average in-path length measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InPathLengthAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average in-path length measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of InPathLengthAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average in-path length  measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with InPathLengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average in-path length. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphWD', ...
                'GraphBD' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with InPathLengthAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average in-path length.
            % 
            % See also getCompatibleGraphList().
           
            n = Measure.getCompatibleGraphNumber('InPathLengthAv');
        end
    end
end