classdef InEccentricity < Measure
    % InEccentricity < Measure: InEccentricity measure
    % InEccentricity provides the ineccentricity of a node for binary directed
    % (BD) and weighted directed (WD) graphs. It is calculated as the 
    % maximal shortest in path length between a node and any other node.
    % 
    % InEccentricity methods:
    %   InEccentricity                      - constructor with Measure properties.
    %
    % InEccentricity methods (Access=protected):
    %   calculate                   - calculates the ineccentricity of a node.
    % 
    % InEccentricity methods (Static)
    %   getClass                    - returns the ineccentricity class.
    %   getName                     - returns the name of ineccentricity measure.
    %   getDescription              - returns the description of ineccentricity measure.
    %   is_global                   - boolean, checks if ineccentricity measure is global.
    %   is_nodal                    - boolean, checks if ineccentricity measure is nodal.
    %   is_binodal                  - boolean, checks if ineccentricity measure if binodal.
    %   getMeasure                  - returns the ineccentricity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Efficency.
    methods
        function m = InEccentricity(g, varargin)
            % INECCENTRICITY(G) creates ineccentricity with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % INECCENTRICITY(G, 'Settings', SETTINGS) ceates ineccentricity measure and
            % initializes the property settings with SETTINGS. 
            %   
            % See also Measure, Graph, Strength, Distance, Efficency.
            settings = clean_varargin({'InEccentricityRule'}, varargin{:});
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access = protected)
        function ecc = calculate(m)
            % CALCULATE calculates the ineccentricity value of a node
            %
            % ineccentricity = CALCULATE(M) returns the value of the ineccentricity of a
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
                    ecc = max(D.*(D~=Inf), [], 1)'; 
                otherwise  % {'default'}
                    ecc = max(D, [], 1)';
            end 
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the ineccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'InEccentricity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the ineccentricity measure.
            %
            % See also getClass(), getDescription().
            
            name = 'In InEccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the ineccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % ineccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The In InEccentricity of a node is ' ...
                'the maximal shortest in path length between a ' ...
                'node and any other node.' ...
                ];
        end
        function bool = is_global()
            % IS_GLOBAL checks if ineccentricity measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if ineccentricity measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if ineccentricity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to ineccentricity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to ineccentricity. 
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
            % graphs to ineccentricity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to ineccentricity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InEccentricity');
        end
    end
end