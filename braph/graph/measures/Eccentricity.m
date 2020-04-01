classdef Eccentricity < Measure
    % Eccentricity < Measure: Eccentricity measure
    % Eccentricity provides the eccentricity of a node for binary undirected
    % (BU) and weighted undirected (WU) graphs. It is calculated as the 
    % maximal shortest path length between a node and any other node.
    % 
    % Eccentricity methods:
    %   Eccentricity                      - constructor with Measure properties.
    %
    % Eccentricity methods (Access=protected):
    %   calculate                   - calculates the eccentricity of a node.
    % 
    % Eccentricity methods (Static)
    %   getClass                    - returns the eccentricity class.
    %   getName                     - returns the name of eccentricity measure.
    %   getDescription              - returns the description of eccentricity measure.
    %   is_global                   - boolean, checks if eccentricity measure is global.
    %   is_nodal                    - boolean, checks if eccentricity measure is nodal.
    %   is_binodal                  - boolean, checks if eccentricity measure if binodal.
    %   getMeasure                  - returns the eccentricity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Degree.
    methods
        function m = Eccentricity(g, varargin)
            % ECCENTRICITY(G) creates eccentricity with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % ECCENTRICITY(G, 'EccentricityRule', ECCENTRICITYRULE) creates eccentricity 
            % measure and initializes the property EccentricityRule with ECCENTRICITYRULE. 
            % Admissible ECCENTRICITYRULE options are:
            % ECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            %   
            % See also Measure, Graph, Strength, Distance, Efficency.

            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function eccentricity = calculate(m)
            % CALCULATE calculates the eccentricity value of a node
            %
            % eccentricity = CALCULATE(M) returns the value of the eccentricity of a
            % node.
            
            g = m.getGraph();
            
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            ecc_rule = get_from_varargin('default', 'EccentricityRule', m.getSettings());
            switch(ecc_rule)
                case {'subgraphs'}
                    eccentricity = max(D.*(D~=Inf), [], 2); 
                otherwise  % {'default'}
                    eccentricity = max(D, [], 2);
            end           
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'Eccentricity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the eccentricity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The Eccentricity of a node is ' ...
                'the maximal shortest path length between a ' ...
                'node and any other node.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Eccentricity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Eccentricity.
            % ECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
            available_settings = {
                'EccentricityRule', Constant.STRING, 'default', {'default', 'subgraphs'};
                };
        end
        function bool = is_global()
            % IS_GLOBAL checks if eccentricity measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if eccentricity measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if eccentricity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to eccentricity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to eccentricity. 
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
            % graphs to eccentricity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to eccentricity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Eccentricity');
        end
    end
end