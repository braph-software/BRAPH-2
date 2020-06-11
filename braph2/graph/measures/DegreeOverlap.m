classdef DegreeOverlap < EdgeOverlap
    % DegreeOverlap Edge overlap measure
    % DegreeOverlap provides the degree overlap of a node for binary 
    % undirected (BU) and weighted undirected (WU) multiplex. 
    % 
    % It is calculated as the number of edges connected to the node in all
    % layers.
    % 
    % DegreeOverlap methods:
    %   DegreeOverlap           - constructor
    %
    % DegreeOverlap methods (Static)
    %   getClass                    - returns the degree overlap class
    %   getName                     - returns the name of degree overlap measure
    %   getDescription              - returns the description of degree overlap measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, EdgeOverlap, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = DegreeOverlap(g, varargin)
            % DEGREEOVERLAP(G) creates degree overlap with default properties.
            % G is a undirected multiplex (i.e., an instance of
            % MultiplexGraphBU or MultiplexGraphWU).
            %
            % See also Measure, EdgeOverlap, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@EdgeOverlap(g, varargin{:});
        end
    end
    methods (Access=protected)
        function degree_overlap = calculate(m)
            % CALCULATE calculates the degree overlap value of a multiplex
            %
            % DEGREEOVERLAP = CALCULATE(M) returns the value of the degree
            % ovelap of a multiplex.
            %
            % See also Measure, EdgeOverlap, MultiplexGraphBU, MultiplexGraphWU.            
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('EdgeOverlap')
                edge_overlap = g.getMeasureValue('EdgeOverlap');
            else
                edge_overlap = calculate@EdgeOverlap(m);
            end
            
            degree_overlap = {sum(edge_overlap{1} == 1, 2)};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the degree overlap measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'DegreeOverlap';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the degree overlap measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Degree overlap';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the degree overlap description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % degree overlap measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The degree overlap of a node is ' ...
                'the number of edges connected to the node in all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to DegreeOverlap
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to DegreeOverlap. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of DegreeOverlap
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of degree overlap measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of DegreeOverlap
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of degree overlap measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with DegreeOverlap 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to degree overlap.
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with DegreeOverlap 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to degree overlap.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('DegreeOverlap');
        end
    end
end