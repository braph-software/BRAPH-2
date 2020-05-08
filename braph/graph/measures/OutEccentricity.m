classdef OutEccentricity < Measure
    % OutEccentricity < Measure: Out-Eccentricity measure
    % OutEccentricity provides the out-eccentricity of a node for binary directed
    % (BD) and weighted directed (WD) graphs. It is calculated as the 
    % maximal shortest out path length between a node and any other node.
    % 
    % OutEccentricity methods:
    %   OutEccentricity             - constructor with Measure properties.
    %
    % OutEccentricity methods (Access=protected):
    %   calculate                   - calculates the out-eccentricity of a node.
    % 
    % OutEccentricity methods (Static)
    %   getClass                    - returns the out-eccentricity class.
    %   getName                     - returns the name of out-eccentricity measure.
    %   getDescription              - returns the description of out-eccentricity measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if out-eccentricity measure is global.
    %   is_nodal                    - boolean, checks if out-eccentricity measure is nodal.
    %   is_binodal                  - boolean, checks if out-eccentricity measure if binodal.
    %   getMeasure                  - returns the out-eccentricity class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Efficency.
    methods
        function m = OutEccentricity(g, varargin)
            % OUTECCENTRICITY(G) creates out-eccentricity with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % OUTECCENTRICITY(G, 'OutEccentricityRule', OUTECCENTRICITIRULE) creates out-eccentricity 
            % measure and initializes the property OutEccentricityRule with OUTECCENTRICITYRULE. 
            % Admissible OUTECCENTRICITYRULE options are:
            % OUTECCENTRICITYRULE = 'default' (default) - calculates OUTECCENTRICITY of global graph.
            %                       'subgraphs' - calculates OUTECCENTRICITY within connected subgraphs.
            %
            % OUTECCENTRICITY(G, 'VALUE', VALUE) creates out-eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Strength, Distance, Efficency.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_eccentricity = calculate(m)
            % CALCULATE calculates the out-eccentricity value of a node
            %
            % out-eccentricity = CALCULATE(M) returns the value of the out-eccentricity of a
            % node.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            ecc_rule = get_from_varargin('default', 'OutEccentricityRule', m.getSettings());
            switch(ecc_rule)
                case {'subgraphs'}
                    out_eccentricity = max(D.*(D~=Inf), [], 2); 
                otherwise  % {'default'}
                    out_eccentricity = max(D, [], 2);
            end 
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the out-eccentricity measure.
            %
            % See also getName(), getDescription(). 
            measure_class = 'OutEccentricity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-eccentricity measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Out-Eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The Out Eccentricity of a node is ' ...
                'the maximal shortest out path length between a ' ...
                'node and any other node.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OutEccentricity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutEccentricityRule. 
            % OUTECCENTRICITYRULE = 'default' (default) - calculates OUTECCENTRICITY of global graph.
            %                       'subgraphs' - calculates OUTECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
            available_settings = {
                'OutEccentricityRule', Constant.STRING, 'default', {'default', 'subgraphs'};
                };
        end
        function bool = is_global()
            % IS_GLOBAL checks if out-eccentricity measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if out-eccentricity measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if out-eccentricity measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to out-eccentricity 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to out-eccentricity. 
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
            % graphs to out-eccentricity 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to out-eccentricity.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutEccentricity');
        end
    end
end