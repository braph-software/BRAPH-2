classdef MultiRichClubDegree < RichClubDegree
    % MultiRichClubDegree Multi rich-club degree measure
    % MultiRichClubDegree provides the multi rich-club degree of a node for 
    % binary undirected (BU), binary directed (BD), weighted undirected (WU) 
    % and weighted directed (WD) multiplexes. 
    %
    % It is a parametric measure, at k level it is calculated as the sum of 
    % the number of edges that connect nodes of degree k or higher in all 
    % layers. The value of k is set by the user (setting 'RichClubThreshold'), 
    % the default value is equal to 1.
    % The relevance of each layer is controlled by the coefficients c 
    % (setting 'MultiRichClubCoefficients') that are between 0 and 1,
    % and add up to one; the default coefficients are (1/layernumber).   
    % 
    % MultiRichClubDegree methods:
    %   MultiRichClubDegree         - constructor
    %
    % MultiRichClubDegree methods (Static)
    %   getClass                    - returns the multi rich-club degree class
    %   getName                     - returns the name of multi rich-club degree measure
    %   getDescription              - returns the description of multi rich-club degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the multi rich-club degree class
    %   getParameterName            - returns the name of multi rich-club degree measure's parameter
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % MultiRichClubDegree methods 
    %   getParameterValues          - returns the values of multi rich-club degree measure's parameter
    %
    % See also Measure, RichClubDegree, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = MultiRichClubDegree(g, varargin)
            % MULTIRICHCLUBDEGREE(G) creates multi rich-club degree with default properties.
            % G is a multiplex (e.g, an instance of MultiplexGraphBD,
            % MultiplexGraphBU, MultiplexGraphWD or MultiplexGraphWU). 
            % 
            % MULTIRICHCLUBDEGREE(G, 'RichClubThreshold', RICHCLUBTHRESHOLD,
            % 'MultiRichClubCoefficients', MULTIRICHCLUBCOEFFICIENTS)  
            % creates multi rich-club degree measure and initializes the property
            % RichClubThreshold with RICHCLUBTHRESHOLD and the property
            % MultiRichClubCoefficients with MULTIRICHCLUBCOEFFICIENTS.
            % Admissible THRESHOLD and COEFFICIENTS options are:
            % RICHCLUBTHRESHOLD = 1 (default) - RICHCLUBDEGREE k threshold 
            %                    is set to 1.
            %                    value - RICHCLUBDEGREE k threshold is set 
            %                    to the specificied value.
            % MULTIRICHCLUBCOEFFICIENTS = 0 (default) - MULTIRICHCLUBDEGREE
            %                    c coefficients will be set to (1/layernumber)
            %                    per each layer.
            %                    values - MULTIRICHCLUBDEGREE c coefficients
            %                    will be set to the values specified per
            %                    each layer if the length of values is
            %                    equal to the number of layers.
            %
            % MULTIRICHCLUBDEGREE(G, 'VALUE1', VALUE1, 'VALUE2', VALUE2) creates
            % multi rich-club degree, and sets the value1 to VALUE1 and value2 to
            % VALUE2. G is a graph (e.g, an instance of MultiplexGraphBD,
            % MultiplexGraphBU, MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, RichClubDegree, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@RichClubDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function multi_rich_club_degree = calculate(m)
            % CALCULATE calculates the multi rich-club degree value of a multiplex
            %
            % MULTIRICHCLUBDEGREE = CALCULATE(M) returns the value of the multi 
            % rich-club degree of a multiplex.
            %
            % See also Measure, RichClubDegree, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('RichClubDegree')
                rich_club_degree = g.getMeasureValue('RichClubDegree');
            else
                rich_club_degree = calculate@RichClubDegree(m);
            end
            
            k_level = size(rich_club_degree{1}, 3);  % Get the rich club degree threshold
            m.setParameter(k_level)  % Set the multi rich club degree' parameter (based on rich club degree's parameter)
            N = g.nodenumber();
            L = g.layernumber();
            
            multirichclub_coefficients = get_from_varargin(0, 'MultiRichClubCoefficients', m.getSettings());
            assert(length(multirichclub_coefficients) == L || all(multirichclub_coefficients == 0), ...
                [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT], ...
                ['MultiRichClubDegree coefficients must have the same length than the ' ...
                'number of layers (' tostring(L) ') while its length is ' tostring(length(multirichclub_coefficients))])

            if length(multirichclub_coefficients) == L
                assert(all(multirichclub_coefficients <= 1) && all(multirichclub_coefficients >= 0), ...
                    [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT], ...
                    ['MultiRichClubDegree coefficients must be between 0 and 1 ' ...
                    'while they are ' tostring(multirichclub_coefficients)])
                c = multirichclub_coefficients;
                
            else  % same relevance for each layer
                c = ones(1, L)/L;
            end
            
            multi_rich_club_degree = zeros(N(1), 1, k_level);
            for li = 1:1:L
                ri = rich_club_degree{li};  % to fix when making this measure also parametric
                % loop over the 3rd dimension of rich club degree (k_level)
                for k = 1:1:k_level
                    multi_rich_club_degree(:, :, k) = multi_rich_club_degree(:, :, k) + c(li)*ri(:, :, k);  
                end
            end
            multi_rich_club_degree = {multi_rich_club_degree};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multi rich-club degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'MultiRichClubDegree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multi rich-club degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Multi rich-club degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multi rich-club degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multi rich-club degree measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The multi rich-club degree of a node at level k is the sum of ' ...
                'the edges that connect nodes of degree k or higher in all layers. ' ...
                'The relevance of each layer is controlled by the coefficients c ' ...
                'that are between 0 and 1; the default coefficients are (1/layernumber). ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultiRichClubDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultiRichClubDegree.
            % RICHCLUBTHRESHOLD = 1 (default) - RICHCLUBDEGREE k threshold 
            %                    is set to 1.
            %                    value - RICHCLUBDEGREE k threshold is set 
            %                    to the specificied value.
            % MULTIRICHCLUBCOEFFICIENTS = 0 (default) - MULTIRICHCLUBDEGREE
            %                    c coefficients will be set to (1/layernumber)
            %                    per each layer.
            %                    values - MULTIRICHCLUBDEGREE c coefficients
            %                    will be set to the values specified per
            %                    each layer if the length of values is
            %                    equal to the number of layers.
            
            available_settings = getAvailableSettings@RichClubDegree();

            available_settings(end+1, :) = {
                 'MultiRichClubCoefficients', BRAPH2.NUMERIC, 0, {};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultiRichClubDegree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multi rich-club degree measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultiRichClubDegree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multi rich-club degree measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of MultiRichClubDegree
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of multi rich-club degree measure (PARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.PARAMETRIC;
        end
        function name = getParameterName()
            % GETPARAMETERNAME returns the name of the MultiRichClubDegree' parameter
            %
            % NAME = GETPARAMETERNAME() returns the name (string) of 
            % the multi rich-club degree' parameter.
            
            name = 'Multi rich-club degree threshold';
        end       
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with MultiRichClubDegree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multi rich-club degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with MultiRichClubDegree
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with multi rich-club degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('MultiRichClubDegree');
        end
    end
    methods
        function values = getParameterValues(m)
            % GETPARAMETERVALUES returns the values of the MultiRichClubDegree' parameter
            %
            % VALUES = GETPARAMETERVALUES() returns the values of
            % the multi rich-club degree' parameter.
            
            values = 1:1:m.getParameter();
        end
    end
end