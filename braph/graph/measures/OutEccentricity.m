classdef OutEccentricity < Measure
    % OutEccentricity < Measure: OutEccentricity measure
    % OutEccentricity provides the outeccentricity of a node for binary directed
    % (BD) and weighted directed (WD) graphs. It is calculated as the 
    % maximal shortest out path length between a node and any other node.
    % 
    % OutEccentricity methods:
    %   OutEccentricity                      - constructor with Measure properties.
    %
    % OutEccentricity methods (Access=protected):
    %   calculate                   - calculates the outeccentricity of a node.
    % 
    % OutEccentricity methods (Static)
    %   getClass                    - returns the outeccentricity class.
    %   getName                     - returns the name of outeccentricity measure.
    %   getDescription              - returns the description of outeccentricity measure.
    %   is_global                   - boolean, checks if outeccentricity measure is global.
    %   is_nodal                    - boolean, checks if outeccentricity measure is nodal.
    %   is_binodal                  - boolean, checks if outeccentricity measure if binodal.
    %   getMeasure                  - returns the outeccentricity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Efficency.
    methods
        function m = OutEccentricity(g, varargin)
            % OUTECCENTRICITY(G) creates outeccentricity with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % OUTECCENTRICITY(G, 'Settings', SETTINGS) ceates outeccentricity measure and
            % initializes the property settings with SETTINGS. 
            %   
            % See also Measure, Graph, Strength, Distance, Efficency.
            settings = clean_varargin({'OutEccentricityRule'}, varargin{:});
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access = protected)
        function ecc = calculate(m)
            % CALCULATE calculates the outeccentricity value of a node
            %
            % outeccentricity = CALCULATE(M) returns the value of the outeccentricity of a
            % node.
            g = m.getGraph();

            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            ecc_rule = get_from_varargin('default', 'OutEccentricityRule', m.getSettings());
            switch(ecc_rule)
                case {'subgraphs'}
                    ecc = max(D.*(D~=Inf), [], 2); 
                otherwise  % {'default'}
                    ecc = max(D, [], 2);
            end 
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the outeccentricity measure.
            %
            % See also getName(), getDescription(). 
            measure_class = 'OutEccentricity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the outeccentricity measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Out Eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the outeccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % outeccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The Out Eccentricity of a node is ' ...
                'the maximal shortest out path length between a ' ...
                'node and any other node.' ...
                ];
        end
        function bool = is_global()
            % IS_GLOBAL checks if outeccentricity measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if outeccentricity measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if outeccentricity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to outeccentricity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to outeccentricity. 
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
            % graphs to outeccentricity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to outeccentricity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutEccentricity');
        end
    end
end