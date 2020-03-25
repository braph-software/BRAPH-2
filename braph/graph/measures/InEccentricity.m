classdef InEccentricity < Measure
    % InEccentricity < Measure: InEccentricity measure
    % InEccentricity provides the in-eccentricity of a node for binary directed
    % (BD) and weighted directed (WD) graphs. It is calculated as the 
    % maximal shortest in path length between a node and any other node.
    % 
    % InEccentricity methods:
    %   InEccentricity              - constructor with Measure properties.
    %
    % InEccentricity methods (Access=protected):
    %   calculate                   - calculates the in-eccentricity of a node.
    % 
    % InEccentricity methods (Static)
    %   getClass                    - returns the in-eccentricity class.
    %   getName                     - returns the name of in-eccentricity measure.
    %   getDescription              - returns the description of in-eccentricity measure.
    %   is_global                   - boolean, checks if in-eccentricity measure is global.
    %   is_nodal                    - boolean, checks if in-eccentricity measure is nodal.
    %   is_binodal                  - boolean, checks if in-eccentricity measure if binodal.
    %   getMeasure                  - returns the in-eccentricity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Efficency.
    methods
        function m = InEccentricity(g, varargin)
            % INECCENTRICITY(G) creates in-eccentricity with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % INECCENTRICITY(G, 'Settings', SETTINGS) creates in-eccentricity measure and
            % initializes the property settings with SETTINGS. 
            %   
            % See also Measure, Graph, Strength, Distance, Efficency.
            settings = clean_varargin({'InEccentricityRule'}, varargin{:});
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access = protected)
        function in_eccentricity = calculate(m)
            % CALCULATE calculates the in-eccentricity value of a node
            %
            % in-eccentricity = CALCULATE(M) returns the value of the in-eccentricity of a
            % node.
            
            g = m.getGraph();
            
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            ecc_rule = get_from_varargin('default', 'InEccentricityRule', m.getSettings());
            switch(ecc_rule)
                case {'subgraphs'}
                    in_eccentricity = max(D.*(D~=Inf), [], 1)'; 
                otherwise  % {'default'}
                    in_eccentricity = max(D, [], 1)';
            end 
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the in-eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'InEccentricity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the in-eccentricity measure.
            %
            % See also getClass(), getDescription().
            
            name = 'In Eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the in-eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % in-eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The In Eccentricity of a node is ' ...
                'the maximal shortest in path length between a ' ...
                'node and any other node.' ...
                ];
        end
        function bool = is_global()
            % IS_GLOBAL checks if in-eccentricity measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if in-eccentricity measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if in-eccentricity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to in-eccentricity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to in-eccentricity. 
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
            % graphs to in-eccentricity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to in-eccentricity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InEccentricity');
        end
    end
end