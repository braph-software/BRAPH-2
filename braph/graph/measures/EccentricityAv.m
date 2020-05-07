classdef EccentricityAv < Eccentricity
    % EccentricityAv < Eccentricity: Average eccentricity measure
    % EccentricityAv provides the average eccentricity of a graph for binary 
    % undirected (BU) and weighted undirected (WU) graphs. It is calculated  
    % as the sum of the nodal eccentricities divided by their number.
    % 
    % EccentricityAv methods:
    %   EccentricityAv              - constructor with Eccentricity properties.
    %
    % EccentricityAv methods (Access=protected):
    %   calculate                   - calculates the average eccentricity of a graph.
    % 
    % EccentricityAv methods (Static)
    %   getClass                    - returns the average eccentricity class.
    %   getName                     - returns the name of average eccentricity measure.
    %   getDescription              - returns the description of average eccentricity measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average eccentricity measure is global.
    %   is_nodal                    - boolean, checks if average eccentricity measure is nodal.
    %   is_binodal                  - boolean, checks if average eccentricity measure if binodal.
    %   getMeasure                  - returns the average eccentricity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Eccentricity, Distance.
    
    methods
        function m = EccentricityAv(g, varargin)
            % ECCENTRICITYAV(G) creates average eccentricity with default
            % Eccentricity properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % ECCENTRICITYAV(G, 'EccentricityRule', ECCENTRICITYRULE) creates average eccentricity 
            % measure and initializes the property EccentricityRule with ECCENTRICITYRULE. 
            % Admissible ECCENTRICITYRULE options are:
            % ECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            %
            % ECCENTRICITYAV(G, 'VALUE', VALUE) creates average eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Eccentricity, Distance.

            m = m@Eccentricity(g, varargin{:});
        end
    end
    methods (Access = protected)
        function eccentricity_av = calculate(m)
            % CALCULATE calculates the average eccentricity value of a
            % graph
            %
            % ECCENTRICITYAV = CALCULATE(M) returns the value of the average eccentricity 
            % of a graph.
            
            g = m.getGraph(); % graph from measure class
            
            if g.is_measure_calculated('Eccentricity')
                ecc = g.getMeasureValue('Eccentricity');
            else
                ecc = calculate@Eccentricity(m);
            end
            
            eccentricity_av = mean(ecc);
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'EccentricityAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average eccentricity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average-Eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average eccentricity of a graph is ' ...
                'sum of the nodal eccentricities divided by their number.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % EccentricityAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to EccentricityAv.
            % ECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'EccentricityRule', Constant.STRING, 'default', {'default', 'subgraphs'};
                };
        end
       function bool = is_global()
            % IS_GLOBAL checks if average eccentricity measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                                            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average eccentricity measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
                       
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average eccentricity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
                       
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to EccentricityAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to EccentricityAv. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBU', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to EccentricityAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to EccentricityAv.
            % 
            % See also getCompatibleGraphList().
          
            n = Measure.getCompatibleGraphNumber('EccentricityAv');
        end
    end
end