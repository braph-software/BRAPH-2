classdef RichClubDegree < Degree
    % RichClubDegree Rich-club degree measure
    % RichClubDegree provides the rich club degree of a node for binary undirected (BU),
    % binary directed (BD), weighted undirected (WU) and weighted directed (WD)  
    % graphs. 
    %
    % It is a parametric measure, at k level it calculates the sum of the
    % number of edges that connect nodes of degree k or higher within a
    % layer. The value of k is set by the user (setting 'RichClubThreshold'), 
    % the default value is equal to 1.
    % 
    % RichClubDegree methods:
    %   RichClubDegree              - constructor
    %
    % RichClubDegree methods (Static)
    %   getClass                    - returns the rich-club degree class
    %   getName                     - returns the name of rich-club degree measure
    %   getDescription              - returns the description of rich-club degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of rich-club degree measure
    %   getMeasure                  - returns the rich-club degree class
    %   getParameterName            - returns the name of rich-club degree's parameter
    %   getParameterHandle          - returns the handle of the parameter
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % RichClubDegree methods 
    %   getParameterValues          - returns the values of rich-club degree's parameter
    %
    % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = RichClubDegree(g, varargin)
            % RICHCLUBDEGREE(G) creates rich-club degree with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU). 
            %
            % RICHCLUBDEGREE(G, 'RichClubThreshold', RICHCLUBTHRESHOLD) creates
            % rich-club degree measure and initializes the property 
            % RichClubThreshold with RICHCLUBTHRESHOLD. 
            % Admissible THRESHOLD options are:
            % RICHCLUBTHRESHOLD = 1 (default) - RICHCLUBDEGREE k threshold 
            %                    is set to 1.
            %                    value - RICHCLUBDEGREE k threshold is set 
            %                    to the specificied value.
            % 
            % RICHCLUBDEGREE(G, 'VALUE', VALUE) creates rich-club degree, and 
            % sets the value to VALUE. G is a graph (e.g, an instance of GraphBD, 
            % GraphBU, GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, 
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Degree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function rich_club_degree = calculate(m)
            % CALCULATE calculates the rich-club degree value of a graph
            %
            % RICHCLUBDEGREE = CALCULATE(M) returns the value of the 
            % rich-club degree of a graph.
            %
            % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            N = g.nodenumber();
            
            rich_club_degree = cell(L, 1);
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
                    
                    deg = degree{li};
                    
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
                    
                    deg = (in_degree{li} + out_degree{li})/2;
                end
                
                richclub_threshold = m.getParameter();
                assert(mod(richclub_threshold, 1) == 0, ...
                    [BRAPH2.STR ':RichClubDegree:' BRAPH2.WRONG_INPUT], ...
                    ['RichClubDegree threshold must be an integer value ' ...
                    'while it is ' tostring(richclub_threshold)])

                k_level = abs(richclub_threshold);  
                m.setParameter(k_level)  % Set the parameter
            
                richclub_layer = zeros(N(1), 1, k_level);
                for k = 1:1:k_level
                    low_rich_nodes = find(deg <= k);  % get lower rich nodes with degree <= k
                    Aii = binarize(Aii);  % binarizes the adjacency matrix
                    subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <= k of Aii
                    subAii(low_rich_nodes, :) = 0;  % remove rows
                    subAii(:, low_rich_nodes) = 0;  % remove columns
                    
                    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                        richclub_layer(:, :, k) = sum(subAii, 1)';  % degree of high rich nodes
                    else
                        richclub_layer(:, :, k) = (sum(subAii, 1)' + sum(subAii, 2))/2;  % degree of high rich nodes
                    end

                end
                rich_club_degree(li) = {richclub_layer};  % add rich club degree of layer li          
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the rich-club degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'RichClubDegree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the rich-club degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Rich-club degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the rich-club degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % rich-club degree measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The rich-club degree of a node at level k is the sum of ' ...
                'the edges that connect nodes of degree k or higher within a layer. ' ...
                'k is set by the user; the default value is equal to 1. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to RichClubDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to RichClubDegree.
            % RICHCLUBTHRESHOLD = 1 (default) - RICHCLUBDEGREE k threshold 
            %                    is set to 1.
            %                    value - RICHCLUBDEGREE k threshold is set 
            %                    to the specificied value.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of RichClubDegree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of rich-club degree measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of RichClubDegree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of rich-club degree measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of RichClubDegree
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of rich-club degree measure (PARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.PARAMETRIC;
        end
        function name = getParameterName()
            % GETPARAMETERNAME returns the name of the RichClubDegree' parameter
            %
            % NAME = GETPARAMETERNAME() returns the name (string) of 
            % the rich-club degree's parameter.
            
            name = 'Rich-club threshold';
        end
        function h = getParameterHandle()
            % GETPARAMETERHANDLE returns the measures's parameter handle
            %
            % H = GETPARAMETERHANDLE(MEASURE)returns the measure's
            % parameter handle.
            %
            % See also getParameterName, getParameter
            
            h = {'RichClubDegree.Parameter', 1, BRAPH2.NUMERIC};
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with RichClubDegree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to rich-club degree. 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with RichClubDegree
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with rich-club degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('RichClubDegree');
        end
    end
    methods 
        function values = getParameterValues(m)
            % GETPARAMETERVALUES returns the values of the RichClubDegree' parameter
            %
            % VALUES = GETPARAMETERVALUES() returns the values of
            % the rich-club degree' parameter.
            
            values = 1:1:m.getParameter();
        end
    end
end