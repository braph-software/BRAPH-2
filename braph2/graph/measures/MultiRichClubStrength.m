classdef MultiRichClubStrength < RichClubStrength
    % MultiRichClubStrength Multi rich-club strength measure
    % MultiRichClubStrength provides the multi rich-club strength of a node for
    % weighted undirected (WU) and weighted directed (WD) multiplexes. 
    %
    % It is a parametric measure, at s level it calculates the sum of the
    % weighted edges that connect nodes of strength s or higher in all
    % layers. The values of s are set by the user (setting 'WeightedRichClubThreshold'), 
    % the default value is equal to 1. The relevance of each layer is controlled 
    % by the coefficients c (setting 'MultiRichClubCoefficients') that are 
    % between 0 and 1, and add up to one; the default coefficients are
    % (1/layernumber).    
    % 
    % MultiRichClubStrength methods:
    %   MultiRichClubStrength       - constructor
    %
    % MultiRichClubStrength methods (Static)
    %   getClass                    - returns the multi rich-club strength class
    %   getName                     - returns the name of multi rich-club strength measure
    %   getDescription              - returns the description of multi rich-club strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the multi rich-club strength class
    %   getParameterName            - returns the name of multi rich-club strength measure's parameter
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % MultiRichClubStrength methods 
    %   getParameterValues          - returns the values of multi rich-club strength measure's parameter
    %
    % See also Measure, RichClubStrength, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = MultiRichClubStrength(g, varargin)
            % MULTIRICHCLUBSTRENGTH(G) creates multi rich-club strength with default properties.
            % G is a weighted multiplex (e.g, an instance of MultiplexGraphWD
            % or MultiplexGraphWU). 
            % 
            % MULTIRICHCLUBSTRENGTH(G, 'WeightedRichClubThreshold', WEIGHTEDRICHCLUBTHRESHOLD, 
            % 'WeightedMultiRichClubCoefficients', WEIGHTEDMULTIRICHCLUBCOEFFICIENTS) 
            % creates multi rich-club strength measure and initializes the property 
            % WeightedRichnessThreshold with WEIGHTEDRICHNESSTHRESHOLD and the property
            % WeightedMultiRichClubCoefficients with WEIGHTEDMULTIRICHCLUBCOEFFICIENTS. 
            % Admissible THRESHOLD and COEFFICIENTS options are:
            % WEIGHTEDRICHCLUBTHRESHOLD = 1 (default) - RICHCLUBSTRENGTH s   
            %                           threshold is set to 1.
            %                           value - RICHCLUBSTRENGTH s threshold 
            %                           is set to the specificied values (vector).
            % WEIGHTEDMULTIRICHCLUBCOEFFICIENTS = 0 (default) - MULTIRICHCLUBSTRENGTH c coefficients
            %                                   will be set to (1/layernumber) per each layer.
            %                                   values - MULTIRICHCLUBSTRENGTH c coefficients
            %                                   will be set to the values specified per
            %                                   each layer if the length of values is
            %                                   equal to the number of layers.
            %
            % MULTIRICHCLUBSTRENGTH(G, 'VALUE1', VALUE1, 'VALUE2', VALUE2) creates
            % multi rich-club strength, and sets the value1 to VALUE1 and value2 to
            % VALUE2. G is a graph (e.g, an instance of MultiplexGraphWD
            % or MultiplexGraphWU). 
            %
            % See also Measure, RichClubStrength, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@RichClubStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multi_rich_club_strength = calculate(m)
            % CALCULATE calculates the multi rich-club strength value of a multiplex
            %
            % MULTIRICHCLUBSTRENGTH = CALCULATE(M) returns the value of the  
            % multi rich-club strengthof a multiplex.
            %
            % See also Measure, RichClubStrength, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('RichClubStrength')
                rich_club_strength = g.getMeasureValue('RichClubStrength');
            else
                rich_club_strength = calculate@RichClubStrength(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            weighted_multi_rich_club_coefficients = get_from_varargin(0, 'WeightedMultiRichClubCoefficients', m.getSettings());
            assert(length(weighted_multi_rich_club_coefficients) == L || all(weighted_multi_rich_club_coefficients == 0), ...
                [BRAPH2.STR ':WeightedMultiRichClubCoefficients:' BRAPH2.WRONG_INPUT], ...
                ['WeightedMultiRichClubCoefficients coefficients must have the same length than the ' ...
                'number of layers (' tostring(L) ') while its length is ' tostring(length(weighted_multi_rich_club_coefficients))])

            if length(weighted_multi_rich_club_coefficients) == L
                assert(all(weighted_multi_rich_club_coefficients <= 1) && all(weighted_multi_rich_club_coefficients >= 0), ...
                    [BRAPH2.STR ':WeightedMultiRichClubCoefficients:' BRAPH2.WRONG_INPUT], ...
                    ['WeightedMultiRichClubCoefficients coefficients must be between 0 and 1 ' ...
                    'while they are ' tostring(weighted_multi_rich_club_coefficients)])
                c = weighted_multi_rich_club_coefficients;
            else  % same relevance for each layer
                c = ones(1, L)/L;
            end
            
            weighted_rich_club_threshold = get_from_varargin(1, 'WeightedRichClubThreshold', m.getSettings());
            s_levels = abs(weighted_rich_club_threshold);
            m.setParameter(s_levels)  % Set the parameter
                            
            multi_rich_club_strength = zeros(N(1), 1, length(s_levels));
            for li = 1:1:L
                wrich = rich_club_strength{li};
                % loop over the 3rd dimension of richness (k_level)
                for s = 1:1:length(s_levels)
                    multi_rich_club_strength(:, :, s) = multi_rich_club_strength(:, :, s) + c(li)*wrich(:, :, s);
                end
            end
            multi_rich_club_strength = {multi_rich_club_strength};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multi rich-club strength measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'MultiRichClubStrength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multi rich-club strength measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Multi rich-club strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multi rich-club strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multi rich-club strength measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The multi rich-club strength of a node at level s is the sum of ' ...
                'the weighted edges that connect nodes of strength s or higher in all layers. ' ...
                'The relevance of each layer is controlled by the coefficients c ' ...
                'that are between 0 and 1; the default coefficients are (1/layernumber). ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultiRichClubStrength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultiRichClubStrength.
            % WEIGHTEDRICHCLUBTHRESHOLD = 1 (default) - RICHCLUBSTRENGTH s   
            %                           threshold is set to 1.
            %                           value - RICHCLUBSTRENGTH s threshold 
            %                           is set to the specificied values (vector).
            % WEIGHTEDMULTIRICHCLUBCOEFFICIENTS = 0 (default) - MULTIRICHCLUBSTRENGTH c coefficients
            %                                   will be set to (1/layernumber) per each layer.
            %                                   values - MULTIRICHCLUBSTRENGTH c coefficients
            %                                   will be set to the values specified per
            %                                   each layer if the length of values is
            %                                   equal to the number of layers.
            
            available_settings = getAvailableSettings@RichClubStrength();

            available_settings(end+1, :) = {
                 'WeightedMultiRichClubCoefficients', BRAPH2.NUMERIC, 0, {};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultiRichClubStrength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multi rich-club strength measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultiRichClubStrength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multi rich-club strength measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of MultiRichClubStrength
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of multi rich-club strength measure (PARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.PARAMETRIC;
        end
        function name = getParameterName()
            % GETPARAMETERNAME returns the name of the MultiRichClubStrength' parameter
            %
            % NAME = GETPARAMETERNAME() returns the name (string) of 
            % the multi rich-club strength' parameter.
            
            name = 'Multi rich-club strength thresholds';
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with MultiRichClubStrength 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multi rich-club strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with MultiRichClubStrength
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with multi rich-club strength.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('MultiRichClubStrength');
        end
    end
    methods
        function values = getParameterValues(m)
            % GETPARAMETERVALUES returns the values of the MultiRichClubStrength' parameter
            %
            % VALUES = GETPARAMETERVALUES() returns the values of
            % the multi rich-club strength' parameter.
            
            values = m.getParameter();
        end
    end
end