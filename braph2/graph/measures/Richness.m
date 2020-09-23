classdef Richness < Degree
    % Richness Richness measure
    % Richness provides the richness of a node for binary undirected (BU),
    % binary directed (BD), weighted undirected (WU) and weighted directed (WD)  
    % graphs. 
    %
    % It is calculated as the sum of the number of edges that connect nodes 
    % of higher degree within a layer. 
    % 
    % Richness methods:
    %   Richness                    - constructor
    %
    % Richness methods (Static)
    %   getClass                    - returns the richness class
    %   getName                     - returns the name of richness measure
    %   getDescription              - returns the description of richness measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of richness measure
    %   getMeasure                  - returns the degree class
    %   getParameterName            - returns the name of richness measure's parameter
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % Richness methods 
    %   getParameterValues          - returns the values of richness measure's parameter
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
            % CALCULATE calculates the richness value of a graph
            %
            % RICHNESS = CALCULATE(M) returns the value of the richness
            % of a graph.
            %
            % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            N = g.nodenumber();
            
            richness = cell(L, 1);
            directionality_type =  g.getDirectionalityType(L);
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
                    
                    k = degree{li};
                    
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
                    
                    k = in_degree{li} + out_degree{li};
                end
                          
                kMinus = zeros(size(k));
                kPlus = zeros(size(k));

                for i = 1:N(li)
                    lrInd = k <= k(i); % Indices of nodes with Lower Richness (LR)
                    hrInd = k > k(i); % Indices of nodes with Higher Richness (HR)                
                    lrA = Aii; 
                    lrA(i, hrInd) = 0; 
                    lrA(hrInd, i) = 0;
                    hrA = Aii; 
                    hrA(i, lrInd) = 0; 
                    hrA(lrInd, i) = 0;
                    
                    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                        kMinusForI = sum(lrA, 1)';
                        kPlusForI = sum(hrA, 1)';
                    else
                        kMinusForI = (sum(lrA, 1)' + sum(lrA, 2))/2;
                        kPlusForI = (sum(hrA, 1)' + sum(hrA, 2))/2;
                    end       
                    kMinus(i) = kMinusForI(i);
                    kPlus(i) = kPlusForI(i);
                end
                richness(li) = {kPlus};  % add richness of layer li          
            end
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
                'the edges that connect nodes of higher degree within a layer. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Richness
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Richness. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
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
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of Richness
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of richness measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
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