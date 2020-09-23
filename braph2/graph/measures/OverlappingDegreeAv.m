classdef OverlappingDegreeAv < OverlappingDegree
    % OverlappingDegreeAv Average overlapping degree measure
    % OverlappingDegreeAv provides the average overlapping degree of a graph
    % for binary undirected (BU) and weighted undirected (WU) multiplexes. 
    %
    % It is calculated as the average of the sum of the number of edges 
    % connected to the node in all layers, i.e., it is the sum of the 
    % degrees of a node in all layers.
    % 
    % OverlappingDegreeAv methods:
    %   OverlappingDegreeAv         - constructor
    %
    % OverlappingDegreeAv methods (Static)
    %   getClass                    - returns the average overlapping degree class
    %   getName                     - returns the name of average overlapping degree measure
    %   getDescription              - returns the description of average overlapping degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the average overlapping degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OverlappingDegree, Degree, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = OverlappingDegreeAv(g, varargin)
            % OVERLAPPINGDEGREE(G) creates average overlapping degree with default properties.
            % G is an undirected multiplex (i.e., an instance of
            % MultiplexGraphBU or MultiplexGraphWU).
            %
            % See also Measure, OverlappingDegree, Degree, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@OverlappingDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_degree_av = calculate(m)
            % CALCULATE calculates the average overlapping degree value of a multiplex
            %
            % OVERLAPPINGDEGREE = CALCULATE(M) returns the value of the average overlapping
            % degree of a multiplex.
            %
            % See also Measure, OverlappingDegree, Degree, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OverlappingDegree')
                overlapping_degree = g.getMeasureValue('OverlappingDegree');
            else
                overlapping_degree = calculate@OverlappingDegree(m);
            end
            
            overlapping_degree_av = {mean(overlapping_degree{1})};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average overlapping degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingDegreeAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average overlapping degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average overlapping degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average overlapping degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping degree measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average overlapping degree of a network is the average ' ...
                'of the sum of the edges connected to the node in all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingDegreeAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingDegree. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingDegreeAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average overlapping degree measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingDegreeAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average overlapping degree measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OverlappingDegreeAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average overlapping degree measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingDegreeAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average overlapping degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingDegreeAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with average overlapping degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingDegreeAv');
        end
    end
end