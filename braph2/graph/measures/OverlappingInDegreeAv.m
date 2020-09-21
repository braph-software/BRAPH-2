classdef OverlappingInDegreeAv < OverlappingInDegree
    % OverlappingInDegreeAv Average overlapping in-degree measure
    % OverlappingInDegreeAv provides the average overlapping in-degree of a graph
    % for binary directed (BD) and weighted directed (WD) multiplexes. 
    %
    % It is calculated as the average of the sum of the number of inward edges 
    % connected to the node in all layers, i.e., it is the sum of the 
    % in-degree of a node in all layers.
    % 
    % OverlappingInDegreeAv methods:
    %   OverlappingInDegreeAv       - constructor
    %
    % OverlappingInDegreeAv methods (Static)
    %   getClass                    - returns the average overlapping in-degree class
    %   getName                     - returns the name of average overlapping in-degree measure
    %   getDescription              - returns the description of average overlapping in-degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the average overlapping in-degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OverlappingInDegree, InDegree, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OverlappingInDegreeAv(g, varargin)
            % OVERLAPPINGINDEGREE(G) creates average overlapping in-degree with default properties.
            % G is a directed multiplex (i.e., an instance of
            % MultiplexGraphBD or MultiplexGraphWD).
            %
            % See also Measure, OverlappingInDegree, InDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@OverlappingInDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_in_degree_av = calculate(m)
            % CALCULATE calculates the average overlapping in-degree value of a multiplex
            %
            % OVERLAPPINGin-degree = CALCULATE(M) returns the value of the average overlapping
            % in-degree of a multiplex.
            %
            % See also Measure, Overlappingin-degree, in-degree, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OverlappingInDegree')
                overlapping_in_degree = g.getMeasureValue('OverlappingInDegree');
            else
                overlapping_in_degree = calculate@OverlappingInDegree(m);
            end
            
            overlapping_in_degree_av = {mean(overlapping_in_degree{1})};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average overlapping in-degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingInDegreeAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average overlapping in-degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average overlapping in-degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average overlapping in-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping in-degree measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average overlapping in-degree of a network is the average ' ...
                'of the sum of the inward edges connected to the node in all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingInDegreeAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingInDegree. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingInDegreeAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average overlapping in-degree measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingInDegreeAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average overlapping in-degree measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OverlappingInDegreeAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average overlapping in-degree measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingInDegreeAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average overlapping in-degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingInDegreeAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with average overlapping in-degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingInDegreeAv');
        end
    end
end