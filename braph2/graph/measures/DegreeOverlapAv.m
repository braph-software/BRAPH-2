classdef DegreeOverlapAv < DegreeOverlap
    % DegreeOverlapAv Average degree overlap measure
    % DegreeOverlapAv provides the average degree overlap of a graph for  
    % binary undirected (BU) and weighted undirected (WU) multiplexes. 
    % 
    % It is calculated as the average of the number of edges connected to 
    % the node in all layers.
    % 
    % DegreeOverlapAv methods:
    %   DegreeOverlapAv             - constructor
    %
    % DegreeOverlapAv methods (Static)
    %   getClass                    - returns the average degree overlap class
    %   getName                     - returns the name of average degree overlap measure
    %   getDescription              - returns the description of average degree overlap measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the average degree overlap class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, DegreeOverlap, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = DegreeOverlapAv(g, varargin)
            % DEGREEOVERLAPAV(G) creates average degree overlap with default properties.
            % G is an undirected multiplex (i.e., an instance of
            % MultiplexGraphBU or MultiplexGraphWU).
            %
            % See also Measure, DegreeOverlap, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@DegreeOverlap(g, varargin{:});
        end
    end
    methods (Access=protected)
        function degree_overlap_av = calculate(m)
            % CALCULATE calculates the average degree overlap value of a multiplex
            %
            % DEGREEOVERLAPAV = CALCULATE(M) returns the value of the average 
            % degree overlap of a multiplex.
            %
            % See also Measure, DegreeOverlap, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('DegreeOverlap')
                degree_overlap = g.getMeasureValue('DegreeOverlap');
            else
                degree_overlap = calculate@DegreeOverlap(m);
            end
            
            degree_overlap_av = {mean(degree_overlap{1})};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average degree overlap measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'DegreeOverlapAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average degree overlap measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average egree overlap';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average degree overlap description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average degree overlap measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average degree overlap of a node is ' ...
                'the average of the number of edges connected to the node in all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to DegreeOverlapAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to DegreeOverlapAv. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of DegreeOverlapAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average degree overlap measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of DegreeOverlapAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average degree overlap measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of DegreeOverlapAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average degree overlap measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with DegreeOverlapAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average degree overlap.
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with DegreeOverlapAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with average degree overlap.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('DegreeOverlapAv');
        end
    end
end