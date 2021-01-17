classdef InEccentricityAv < InEccentricity
    % InEccentricityAv < InEccentricity: Average in-eccentricity measure
    % InEccentricityAv provides the average in-eccentricity of a graph for binary 
    % directed (BD) and weighted directed (WD) graphs. It is calculated  
    % as the sum of the nodal in-eccentricities divided by their number.
    % 
    % InEccentricityAv methods:
    %   InEccentricityAv            - constructor with InEccentricity properties.
    %
    % InEccentricityAv methods (Access=protected):
    %   calculate                   - calculates the average in-eccentricity of a graph.
    % 
    % InEccentricityAv methods (Static)
    %   getClass                    - returns the average in-eccentricity class.
    %   getName                     - returns the name of average in-eccentricity measure.
    %   getDescription              - returns the description of average in-eccentricity measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average in-eccentricity measure is global.
    %   is_nodal                    - boolean, checks if average in-eccentricity measure is nodal.
    %   is_binodal                  - boolean, checks if average in-eccentricity measure if binodal.
    %   getMeasure                  - returns the average in-eccentricity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, InEccentricity, EccentricityAv, OutEccentricityAv.
    
    methods
        function m = InEccentricityAv(g, varargin)
            % INECCENTRICITYAV(G) creates average in-eccentricity with default
            % InEccentricity properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % INECCENTRICITYAV(G, 'InEccentricityRule', INECCENTRICITYRULE) creates average in-eccentricity 
            % measure and initializes the property InEccentricityRule with INECCENTRICITYRULE. 
            % Admissible INECCENTRICITYRULE options are:
            % INECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            %
            % INECCENTRICITYAV(G, 'VALUE', VALUE) creates average eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, InEccentricity, EccentricityAv, OutEccentricityAv.

            m = m@InEccentricity(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_eccentricity_av = calculate(m)
            % CALCULATE calculates the average in-eccentricity value of a
            % graph
            %
            % ECCENTRICITYAV = CALCULATE(M) returns the value of the average in-eccentricity 
            % of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InEccentricity')
                in_eccentricity = g.getMeasureValue('InEccentricity');
            else
                in_eccentricity = calculate@InEccentricity(m);
            end
            
            in_eccentricity_av = mean(in_eccentricity);
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average in-eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'InEccentricityAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-eccentricity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average-In-Eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average in eccentricity of a graph is the' ...
                'sum of the nodal in Eccentricities divided by their number.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % InEccentricityAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InEccentricityAv.
            % INECCENTRICITYRULE = 'default' (default) - calculates INECCENTRICITY of global graph.
            %                    'subgraphs' - calculates INECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
           
            available_settings = {
                'InEccentricityRule', Constant.STRING, 'default', {'default', 'subgraphs'};
                };
        end
       function bool = is_global()
            % IS_GLOBAL checks if average in-eccentricity measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                                            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average in-eccentricity measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
                       
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average in-eccentricity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
                       
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to InEccentricityAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to InEccentricityAv. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to InEccentricityAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to InEccentricityAv.
            % 
            % See also getCompatibleGraphList().
          
            n = Measure.getCompatibleGraphNumber('InEccentricityAv');
        end
    end
end