classdef OverlappingOutDegreeAv < OverlappingOutDegree
    % OverlappingOutDegreeAv Average overlapping out-degree measure
    % OverlappingOutDegreeAv provides the average overlapping out-degree of a graph
    % for binary directed (BD) and weighted directed (WD) multiplexes. 
    %
    % It is calculated as the average of the sum of the number of outward edges 
    % connected to the node in all layers, i.e., it is the average of the sum of the 
    % out-degree of a node in all layers.
    % 
    % OverlappingOutDegreeAv methods:
    %   OverlappingOutDegreeAv      - constructor
    %
    % OverlappingOutDegreeAv methods (Static)
    %   getClass                    - returns the average overlapping out-degree class
    %   getName                     - returns the name of average overlapping out-degree measure
    %   getDescription              - returns the description of average overlapping out-degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the average overlapping out-degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OverlappingOutDegree, OutDegree, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OverlappingOutDegreeAv(g, varargin)
            % OVERLAPPINGOUTDEGREEAV(G) creates average overlapping out-degree with default properties.
            % G is a directed multiplex (i.e., an instance of
            % MultiplexGraphBD or MultiplexGraphWD).
            %
            % See also Measure, OverlappingOutDegree, OutDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@OverlappingOutDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_out_degree_av = calculate(m)
            % CALCULATE calculates the average overlapping out-degree value of a multiplex
            %
            % OVERLAPPINGOUTDEGREEAV = CALCULATE(M) returns the value of the average overlapping
            % out-degree of a multiplex.
            %
            % See also Measure, OverlappingOutDegree, OutDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OverlappingOutDegree')
                overlapping_out_degree = g.getMeasureValue('OverlappingOutDegree');
            else
                overlapping_out_degree = calculate@OverlappingOutDegree(m);
            end
            
            overlapping_out_degree_av = {mean(overlapping_out_degree{1})};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average overlapping out-degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingOutDegreeAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average overlapping out-degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average overlapping out-degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average overlapping out-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping out-degree measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average overlapping out-degree of a network is the average ' ...
                'of the sum of the outward edges connected to the node in all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingOutDegreeAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingOutDegreeAv. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingOutDegreeAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average overlapping out-degree measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingOutDegreeAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average overlapping out-degree measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OverlappingOutDegreeAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average overlapping out-degree measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingOutDegreeAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average overlapping out-degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingOutDegreeAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with average overlapping out-degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingOutDegreeAv');
        end
    end
end