classdef OutEccentricityAv < OutEccentricity
    % OutEccentricityAv < OutEccentricity: Average eccentricity measure
    % OutEccentricityAv provides the average out-eccentricity of a graph for binary 
    % undirected (BU) and weighted undirected (WU) graphs. It is calculated  
    % as the sum of the nodal out-eccentricities divided by their number.
    % 
    % OutEccentricityAv methods:
    %   OutEccentricityAv           - constructor with OutEccentricity properties.
    %
    % OutEccentricityAv methods (Access=protected):
    %   calculate                   - calculates the average out-eccentricity of a graph.
    % 
    % OutEccentricityAv methods (Static)
    %   getClass                    - returns the average out-eccentricity class.
    %   getName                     - returns the name of average out-eccentricity measure.
    %   getDescription              - returns the description of average out-eccentricity measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average out-eccentricity measure is global.
    %   is_nodal                    - boolean, checks if average out-eccentricity measure is nodal.
    %   is_binodal                  - boolean, checks if average out-eccentricity measure if binodal.
    %   getMeasure                  - returns the average out-eccentricity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, OutEccentricity, EccentricityAv, InEccentricityAv.
    
    methods
        function m = OutEccentricityAv(g, varargin)
            % OUTECCENTRICITYAV(G) creates average out-eccentricity with default
            % OutEccentricity properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % OUTECCENTRICITYAV(G, 'OutEccentricityRule', OUTECCENTRICITYRULE) creates average out-eccentricity 
            % measure and initializes the property EccentricityRule with ECCENTRICITYRULE. 
            % Admissible ECCENTRICITYRULE options are:
            % OUTECCENTRICITYRULE = 'default' (default) - calculates OUTECCENTRICITY of global graph.
            %                    'subgraphs' - calculates OUTECCENTRICITY within connected subgraphs.
            %
            % OUTECCENTRICITYAV(G, 'VALUE', VALUE) creates average out-eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, OutEccentricity, EccentricityAv, InEccentricityAv.
            
            m = m@OutEccentricity(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_eccentricity_av = calculate(m)
            % CALCULATE calculates the average out-eccentricity value of a
            % graph
            %
            % ECCENTRICITYAV = CALCULATE(M) returns the value of the average out-eccentricity 
            % of a graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutEccentricity')
                out_eccentricity = g.getMeasureValue('OutEccentricity');
            else
                out_eccentricity = calculate@OutEccentricity(m);
            end
            
            out_eccentricity_av = mean(out_eccentricity);
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average out-eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'OutEccentricityAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average out-eccentricity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average-Out-Eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average out eccentricity of a graph is the' ...
                'sum of the nodal out Eccentricities divided by their number.' ...
                ];
        end
        function available_settings = getAvailableSettings()   
            % GETAVAILABLESETTINGS returns the setting available to
            % OutEccentricityAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutEccentricityAv.
            % OUTECCENTRICITYRULE = 'default' (default) - calculates OUTECCENTRICITY of global graph.
            %                    'subgraphs' - calculates OUTECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
           
            available_settings = {
                'OutEccentricityRule', Constant.STRING, 'default', {'default', 'subgraphs'};
                };
        end
       function bool = is_global()
            % IS_GLOBAL checks if average out-eccentricity measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                                            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if average out-eccentricity measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
                       
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if average out-eccentricity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
                       
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to OutEccentricityAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to OutEccentricityAv. 
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
            % graphs to OutEccentricityAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to OutEccentricityAv.
            % 
            % See also getCompatibleGraphList().
          
            n = Measure.getCompatibleGraphNumber('OutEccentricityAv');
        end
    end
end