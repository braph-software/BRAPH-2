classdef EdgeOverlap < Measure
    % EdgeOverlap Edge overlap measure
    % EdgeOverlap provides the edge overlap of a multiplex. 
    %
    % It is calculated as the fraction of layers in which edge between a
    % pair of nodes exists. Connection weights are ignored in calculations.
    % 
    % EdgeOverlap methods:
    %   EdgeOverlap                 - constructor
    %
    % EdgeOverlap methods (Static)
    %   getClass                    - returns the edge overlap class
    %   getName                     - returns the name of edge overlap measure
    %   getDescription              - returns the description of edge overlap measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
    
    methods
        function m = EdgeOverlap(g, varargin)
            % EDGEOVERLAP(G) creates edge overlap with default measure properties.
            % G is a multiplex (i.e., an instance of MultiplexGraphBD,
            % MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU). 
            %
            % See also Measure, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function edge_overlap = calculate(m)
            % CALCULATE calculates the edge overlap value of a multiplex
            %
            % EDGEOVERLAP = CALCULATE(M) returns the value of the edge overlap of a
            % multiplex.
            %
            % See also Measure, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % 2D-cell array 
            
            N = g.nodenumber();
            L = g.layernumber();
            
            edge_overlap = zeros(N(1));
            for li = 1:1:L
                Aii = A{li, li};
                Aii = binarize(Aii);  % binarizes the adjacency matrix
                edge_overlap = edge_overlap + Aii;
            end
            edge_overlap = {edge_overlap / L};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the edge overlap measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'EdgeOverlap';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the edge overlap measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Edge overlap';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the edge overlap description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % edge overlap measure.
            %
            % See also getClass, getName. 
            
            description = [ ...
                'For each edge, the edge overlap of a multiplex graph is ' ...
                'the fraction of layers where that edge exists. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to EdgeOverlap
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to EdgeOverlap. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of EdgeOverlap
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of edge overlap measure (BINODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of EdgeOverlap
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of edge overlap measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with EdgeOverlap
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to edge overlap. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWD', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with EdgeOverlap
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with edge overlap.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('EdgeOverlap');
        end
    end
end