classdef OutPathLengthAv < OutPathLength
    % OutPathLengthAv Average out-path length measure
    % OutPathLengthAv provides the average out-path length of a graph for binary 
    % undirected (BD) and weighted undirected (WD) graphs. 
    %
    % It is calculated as the average of the sum of the out-path lengths within 
    % each layer. The calculation of out-path length is controlled by the out-path
    % length rule (setting 'OutPathLengthRule'), the default option calculates
    % the measure with normal average. 
    % 
    % OutPathLengthAv methods:
    %   OutPathLengthAv             - constructor
    %
    % OutPathLengthAv methods (Static)
    %   getClass                    - returns the average out-path length class
    %   getName                     - returns the name of average out-path length measure
    %   getDescription              - returns the description of average out-path length measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the average path length class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Distance, OutPathLength, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OutPathLengthAv(g, varargin)
            % OUTPATHLENGTHAV(G) creates average out-path length with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphWD, 
            % MultiplexGraphBD or MultiplexGraphWD).
            %   
            % OUTPATHLENGTHAV(G, 'OutPathLengthRule', OUTPATHLENGTHRULE) creates average 
            % out-path length measure and initializes the property OutPathLengthRule 
            % with OUTPATHLENGTHRULE. 
            % Admissible OUTPATHLENGTHRULE options are:
            % OUTPATHLENGTHRULE = 'default' (default) - calculates OUTPATHLENGTH 
            %                    with normal average
            %                    'subgraphs' - calculates OUTPATHLENGTH of all
            %                    subgraphs.
            %                    'harmonic' - calculates OUTPATHLENGTH with
            %                    harmonic average.
            %
            % OUTPATHLENGTHAV(G, 'VALUE', VALUE) creates average out-path length, 
            % and sets the value to VALUE. G is a graph (e.g, an instance 
            % of GraphBD, GraphWD, MultiplexGraphBD or MultiplexGraphWD).
            %   
            % See also Measure, Distance, OutPathLength, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
           m = m@OutPathLength(g, varargin {:});
        end
    end
    methods (Access=protected)
        function out_path_length_av = calculate(m)            
            % CALCULATE calculates the average out-path length value of a graph
            %
            % OUTPATHLENGTHAV = CALCULATE(M) returns the value of the average out-path length
            % of a graph.
            %
            % See also Measure, Distance, OutPathLength, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutPathLength')
                out_path_length = g.getMeasureValue('OutPathLength');
            else
                out_path_length = calculate@OutPathLength(m);
            end
  
            out_path_length_av = cell(g.layernumber(), 1);
            for li = 1:1:length(out_path_length_av)
                out_path_length_av(li) = {mean(out_path_length{li})};
            end
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
            
            name = 'Average out-path length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-path length description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-path length measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average out-path length of a graph is ' ...
                'the average of the sum of the out-path lengths within each layer. ' ...                
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % OutPathLengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutPathLengthAv. 
            % OUTPATHLENGTHRULE = 'default' (default) - calculates OUTPATHLENGTH 
            %                    with normal average
            %                    'subgraphs' - calculates OUTPATHLENGTH of all
            %                    subgraphs.
            %                    'harmonic' - calculates OUTPATHLENGTH with
            %                    harmonic average.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = getAvailableSettings@OutPathLength();
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutPathLengthAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average out-path length measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutPathLengthAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average out-path length measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OutPathLengthAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average out-path length measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with OutPathLengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average out-path length. 
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
            % graphs with OutPathLengthAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average out-path length.
            % 
            % See also getCompatibleGraphList().
           
            n = Measure.getCompatibleGraphNumber('OutPathLengthAv');
        end
    end
end