classdef OverlappingOutDegree < OutDegree
    % OverlappingOutDegree Overlapping out-degree measure
    % OverlappingOutDegree provides the overlapping out-degree of a node for  
    % binary directed (BD) and weighted directed (WD) multiplexes. 
    %
    % It is calculated as the sum of the number of outward edges connected to the
    % node in all layers, i.e., it is the sum of the out-degrees of a node in
    % all layers.
    % 
    % OverlappingOutDegree methods:
    %   OverlappingOutDegree        - constructor
    %
    % OverlappingOutDegree methods (Static)
    %   getClass                    - returns the overlapping out-degree class
    %   getName                     - returns the name of overlapping out-degree measure
    %   getDescription              - returns the description of overlapping out-degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OutDegree, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OverlappingOutDegree(g, varargin)
            % OVERLAPPINGOUTDEGREE(G) creates overlapping out-degree with default properties.
            % G is an directed multiplex (i.e., an instance of
            % MultiplexGraphBD or MultiplexGraphWD).
            %
            % See also Measure, OutDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@OutDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_out_degree = calculate(m)
            % CALCULATE calculates the overlapping out-degree value of a multiplex
            %
            % OVERLAPPINGOUTDEGREE = CALCULATE(M) returns the value of the overlapping
            % out-degree of a multiplex.
            %
            % See also Measure, OutDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutDegree')
                out_degree = g.getMeasureValue('OutDegree');
            else
                out_degree = calculate@OutDegree(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            overlapping_out_degree = zeros(N(1), 1);
            for li = 1:1:L
                overlapping_out_degree = overlapping_out_degree + out_degree{li};
            end
            overlapping_out_degree = {overlapping_out_degree};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the overlapping out-degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingOutDegree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the overlapping out-degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Overlapping out-degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the overlapping out-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping out-degree measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The overlapping out-degree of a node is the sum of ' ...
                'the outward edges connected to the node in all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingOutDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingOutDegree. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingOutDegree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of overlapping out-degree measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingOutDegree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of overlapping out-degree measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OverlappingOutDegree
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of overlapping out-degree measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingOutDegree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to overlapping out-degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingOutDegree
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with overlapping out-degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingOutDegree');
        end
    end
end