classdef RichClubStrength < Strength
    % WeightedRichClubDegree Weighted richness measure
    % WeightedRichClubDegree provides the weighted richness of a node for weighted 
    % undirected (WU) and weighted directed (WD) graphs. 
    %
    % It is a parametric measure, at s level it calculates the sum of the
    % weighted edges that connect nodes of strength s or higher within a
    % layer. The values of s are set by the user (setting 'WeightedRichClubThreshold'), 
    % the default value is equal to 1.
    % 
    % WeightedRichClubDegree methods:
    %   WeightedRichClubDegree      - constructor
    %
    % WeightedRichClubDegree methods (Static)
    %   getClass                    - returns the rich-club strength class
    %   getName                     - returns the name of rich-club strength measure
    %   getDescription              - returns the description of rich-club strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the rich-club strength class
    %   getParameterName            - returns the name of rich-club strength measure's parameter
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % WeightedRichClubDegree methods 
    %   getParameterValues          - returns the values of rich-club strength measure's parameter
    %
    % See also Measure, Strength, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = RichClubStrength(g, varargin)
            % RICHCLUBSTRENGTH(G) creates rich-club strength with default properties.
            % G is a weighted graph (e.g, an instance of GraphWD, GraphWU,
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % RICHCLUBSTRENGTH(G, 'WeightedRichClubThreshold', WEIGHTEDRICHCLUBTHRESHOLD) 
            % creates rich-club strength  measure and initializes the property 
            % WeightedRichClubThreshold with WEIGHTEDRICHCLUBTHRESHOLD. 
            % Admissible THRESHOLD options are:
            % WEIGHTEDRICHCLUBTHRESHOLD = 1 (default) - RICHCLUBSTRENGTH s   
            %                           threshold is set to 1.
            %                           value - RICHCLUBSTRENGTH s threshold 
            %                           is set to the specificied values (vector).
            % 
            % RICHCLUBSTRENGTH(G, 'VALUE', VALUE) creates rich-club strength , and sets 
            % the value to VALUE. G is a graph (e.g, an instance of GraphWD, GraphWU,
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, Strength, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Strength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function rich_club_strength = calculate(m)
            % CALCULATE calculates the rich-club strength value of a graph
            %
            % RICHCLUBSTRENGTH = CALCULATE(M) returns the value of the rich-club 
            % strength of a graph.
            %
            % See also Measure, Strength, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            N = g.nodenumber();
            
            rich_club_strength = cell(g.layernumber(), 1);
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
                    
                    if g.is_measure_calculated('Strength')
                        strength = g.getMeasureValue('Strength');
                    else
                        strength = calculate@Strength(m);
                    end
                    
                    st = strength{li};
                    
                else  % directed graphs
                    
                    if g.is_measure_calculated('InStrength')
                        in_strength = g.getMeasureValue('InStrength');
                    else
                        in_strength = InStrength(g, g.getSettings()).getValue();
                    end
                    
                    if g.is_measure_calculated('OutStrength')
                        out_strength = g.getMeasureValue('OutStrength');
                    else
                        out_strength = OutStrength(g, g.getSettings()).getValue();
                    end
                    
                    st = (in_strength{li} + out_strength{li})/2;
                end
                
                weighted_rich_club_threshold = get_from_varargin(1, 'WeightedRichClubThreshold', m.getSettings());
                assert(isnumeric(weighted_rich_club_threshold) == 1, ...
                    [BRAPH2.STR ':RichClubStrength:' BRAPH2.WRONG_INPUT], ...
                    ['RichClubStrength threshold must be a positive number ' ...
                    'while it is ' tostring(weighted_rich_club_threshold)])

                s_levels = abs(weighted_rich_club_threshold);
                m.setParameter(s_levels)  % Set the parameter
                
                rich_club_strength_layer = zeros(N(1), 1, length(s_levels));
                count = 1;
                for s = s_levels
                    low_rich_nodes = find(st <= s);  % get lower rich nodes with strength <= s
                    subAii = Aii;  % extract subnetwork of nodes >s by removing nodes <=s of Aii
                    subAii(low_rich_nodes, :) = 0;  % remove rows
                    subAii(:, low_rich_nodes) = 0;  % remove columns

                    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                        rich_club_strength_layer(:, :, count) = round(sum(subAii, 1), 6)';  % strength of high rich nodes   
                    else
                        rich_club_strength_layer(:, :, count) = round((sum(subAii, 1)' + sum(subAii, 2)), 6)/2;  % strength of high rich nodes   
                    end
                    count = count + 1;
                end
                rich_club_strength(li) = {rich_club_strength_layer};  % add rich club strength of layer li
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the rich-club strength measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'RichClubStrength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the rich-club strength measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Rich-club strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the rich-club strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % rich-club strength measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The rich-club strength of a node at level s is the sum of ' ...
                'the weighted edges that connect nodes of strength s or higher within a layer. ' ...
                's is set by the user and it can be a vector containting all the strength thresholds; ' ... 
                'the default value is equal to 1 ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to RichClubStrength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to RichClubStrength.
            % WEIGHTEDRICHCLUBTHRESHOLD = 1 (default) - RICHCLUBSTRENGTH s   
            %                           threshold is set to 1.
            %                           value - RICHCLUBSTRENGTH s threshold 
            %                           is set to the specificied values (vector).
            
            available_settings = {
                'WeightedRichClubThreshold', BRAPH2.NUMERIC, 1, {};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of RichClubStrength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of rich-club strength measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of RichClubStrength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of rich-club strength measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of RichClubStrength
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of rich-club strength measure (PARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.PARAMETRIC;
        end
        function name = getParameterName()
            % GETPARAMETERNAME returns the name of RichClubStrength' parameter
            %
            % NAME = GETPARAMETERNAME() returns the name (string) of 
            % the rich-club strength' parameter.
            
            name = 'Rich-club strength thresholds';
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with RichClubStrength 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to rich-club strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with RichClubStrength
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with rich-club strength.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('RichClubStrength');
        end
    end
    methods
        function values = getParameterValues(m)
            % GETPARAMETERVALUES returns the values of the RichClubStrength' parameter
            %
            % VALUES = GETPARAMETERVALUES() returns the values of
            % the rich-club strength' parameter.
            
            values = m.getParameter();
        end
    end
end