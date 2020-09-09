classdef RichClub < Degree
    % RichClub Rich-club measure
    % RichClub provides the rich club of a node for binary undirected (BU),
    % binary directed (BD), weighted undirected (WU) and weighted directed (WD)  
    % graphs. 
    %
    % It is a parametric measure, at k level it calculates the fraction of 
    % edges that connect nodes of degree k or higher out of the maximum 
    % number of edges that such nodes might share within a layer. 
    % The value of k is set by the user (setting 'RichClubThreshold'), 
    % the default value is equal to 1.
    % 
    % RichClub methods:
    %   RichClub                    - constructor
    %
    % RichClub methods (Static)
    %   getClass                    - returns the rich-club class
    %   getName                     - returns the name of rich-club measure
    %   getDescription              - returns the description of rich-club measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of rich-club measure
    %   getMeasure                  - returns the rich-club class
    %   getParameterName            - returns the name of rich-club's parameter
    %   getParameterHandle          - returns the handle of the parameter
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % RichClub methods 
    %   getParameterValues          - returns the values of rich-club's parameter
    %
    % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = RichClub(g, varargin)
            % RICHCLUB(G) creates rich-club with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU). 
            %
            % RICHCLUB(G, 'RichClubThreshold', RICHCLUBTHRESHOLD) creates
            % rich-club measure and initializes the property 
            % RichClubThreshold with RICHCLUBTHRESHOLD. 
            % Admissible THRESHOLD options are:
            % RICHCLUBTHRESHOLD = 1 (default) - RICHCLUB k threshold 
            %                    is set to 1.
            %                    value - RICHCLUB k threshold is set 
            %                    to the specificied value.
            % 
            % RICHCLUB(G, 'VALUE', VALUE) creates rich-club, and 
            % sets the value to VALUE. G is a graph (e.g, an instance of GraphBD, 
            % GraphBU, GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, 
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Degree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function rich_club = calculate(m)
            % CALCULATE calculates the rich-club value of a graph
            %
            % RICHCLUB = CALCULATE(M) returns the value of the 
            % rich-club of a graph.
            %
            % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            
            rich_club = cell(L, 1);
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
                    [BRAPH2.STR ':RichClub:' BRAPH2.WRONG_INPUT], ...
                    ['RichClub threshold must be an integer value ' ...
                    'while it is ' tostring(richclub_threshold)])

                k_level = abs(richclub_threshold);  
                m.setParameter(k_level)  % Set the parameter
            
                richclub_layer = zeros(1, 1, k_level);
                Nk = zeros(1, k_level);
                Ek = zeros(1, k_level);
                for k = 1:1:k_level
                    low_rich_nodes = find(deg <= k);  % get lower rich nodes with degree <= k
                    Aii = binarize(Aii);  % binarizes the adjacency matrix
                    subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <= k of Aii
                    subAii(low_rich_nodes, :) = 0;  % remove rows
                    subAii(:, low_rich_nodes) = 0;  % remove columns
                    Nk(k) = size(subAii, 2);  % number of nodes with degree > k
                    Ek(k) = sum(subAii(:));  % total number of connections in subgraph
                    richclub_layer(1, 1, k) = Ek(k)/(Nk(k)*(Nk(k)-1));  % unweighted rich-club coefficient
                end
                richclub_layer(isnan(richclub_layer)) = 0;  % Should return zeros, not NaN
                rich_club(li) = {richclub_layer};  % add rich club degree of layer li          
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the rich-club measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'RichClub';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the rich-club measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Rich-club';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the rich-club description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % rich-club measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The rich-club of a node at level k is the fraction of the ' ...
                'edges that connect nodes of degree k or higher out of the ' ...
                'maxium number of edges that such nodes might share within a' ...
                'layer. k is set by the user; the default value is equal to 1. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to RichClub
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to RichClub.
            % RICHCLUBTHRESHOLD = 1 (default) - RICHCLUB k threshold 
            %                    is set to 1.
            %                    value - RICHCLUB k threshold is set 
            %                    to the specificied value.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of RichClub
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of rich-club measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of RichClub
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of rich-club measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of RichClub
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of rich-club measure (PARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.PARAMETRIC;
        end
        function name = getParameterName()
            % GETPARAMETERNAME returns the name of the RichClub' parameter
            %
            % NAME = GETPARAMETERNAME() returns the name (string) of 
            % the rich-club's parameter.
            
            name = 'Rich-club threshold';
        end
        function h = getParameterHandle()
            % GETPARAMETERHANDLE returns the measures's parameter handle
            %
            % H = GETPARAMETERHANDLE(MEASURE)returns the measure's
            % parameter handle.
            %
            % See also getParameterName, getParameter
            
            h = {'RichClub.Parameter', 1};
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with RichClub 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to rich-club. 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with RichClub
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with rich-club.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('RichClub');
        end
    end
    methods 
        function values = getParameterValues(m)
            % GETPARAMETERVALUES returns the values of the RichClub' parameter
            %
            % VALUES = GETPARAMETERVALUES() returns the values of
            % the rich-club' parameter.
            
            values = 1:1:m.getParameter();
        end
    end
end