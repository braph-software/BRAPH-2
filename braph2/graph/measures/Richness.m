classdef Richness < Degree
    % Richness Richness measure
    % Richness provides the richness of a node for binary undirected (BU),
    % binary directed (BD), weighted undirected (WU) and weighted directed (WD)  
    % graphs. 
    %
    % It is calculated as the sum of the number of edges that connect nodes
    % of degree k or higher within a layer.
    % 
    % Richness methods:
    %   Richness                    - constructor
    %
    % Richness methods (Static)
    %   getClass                    - returns the richness class
    %   getName                     - returns the name of richness measure
    %   getDescription              - returns the description of richness measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = Richness(g, varargin)
            % RICHNESS(G) creates richness with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU). 
            %
            % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Degree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function richness = calculate(m)
            % CALCULATE calculates the richness value of a multiplex
            %
            % RICHNESS = CALCULATE(M) returns the value of the richness
            % of a multiplex.
            %
            % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            
            N = g.nodenumber();
            L = g.layernumber();
            
            richness = zeros(N(1), 1);
            directionality_type =  g.getDirectionalityType(g.layernumber());
            for li = 1:1:L
                
                if g.is_graph(g)
                    Aii = A;
                    directionality_layer = directionality_type;
                else
                    Aii = A{li, li};
                    directionality_layer = directionality_type(li, li);
                end
                
                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                    
                    if g.is_measure_calculated('Degree')
                        degree = g.getMeasureValue('Degree');
                    else
                        degree = calculate@Degree(m);
                    end
                    
                else  % directed graphs
                    
                    if g.is_measure_calculated('InDegree')
                        in_degree = g.getMeasureValue('InDegree');
                    else
                        in_degree = InDegree(g, g.getSettings()).getValue();
                    end
                    
                    if g.is_measure_calculated('OutDegree')
                        out_degree = g.getMeasureValue('OutDegree');
                    else
                        out_degree = OutDegree(g, g.getSettings()).getValue();
                    end
                    
                    degree = in_degree + out_degree;
                end
                
                richness_threshold = get_from_varargin('default', 'RichnessThreshold', m.getSettings());
                if isnumeric(richness_threshold)
                    k_level = richness_threshold;
                else  % default, max degree
                    k_level = max(degree);
                end

                low_rich_nodes = find(degree <= k_level);  % get lower rich nodes with degree <=k
                subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <=k of Aii
                subAii(low_rich_nodes, :) = 0;  % remove rows
                subAii(:, low_rich_nodes) = 0;  % remove columns
                
                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                    richness = richness + sum(subAii);  % degree of high rich nodes   
                else
                    richness = richness + sum(subAii, 1) + sum(subAii, 2);  % degree of high rich nodes   
                end
            end
            richness = {richness};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the richness measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'Richness';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the richness measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Richness';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the richness description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % richness measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The richness of a node is the sum of ' ...
                'the edges that connect nodes of degree k or higher within a layer. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Richness
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Richness. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Richness
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of richness measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Richness
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of richness measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with Richness 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to richness. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBD', ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with Richness
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with richness.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('Richness');
        end
    end
end