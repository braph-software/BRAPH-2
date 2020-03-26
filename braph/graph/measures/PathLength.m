classdef PathLength < Measure
    % PathLength < Measure: PathLength measure
    % PathLength provides the pathlength of a node for binary undirected (BU) and 
    % weighted undirected (WU) graphs. It is calculated as average shortest
    % path length from one node to another node.
    % 
    % PathLength methods:
    %   PathLength                  - constructor with Measure properties.
    %
    % PathLength methods (Access=protected):
    %   calculate                   - calculates the pathlength of a node.
    % 
    % PathLength methods (Static)
    %   getClass                    - returns the pathlength class.
    %   getName                     - returns the name of pathlength measure.
    %   getDescription              - returns the description of pathlength measure.
    %   is_global                   - boolean, checks if pathlength measure is global.
    %   is_nodal                    - boolean, checks if pathlength measure is nodal.
    %   is_binodal                  - boolean, checks if pathlength measure if binodal.
    %   getMeasure                  - returns the pathlength class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Degree.
    methods
        function m = PathLength(g, varargin)
            % PATHLENGTH(G) creates pathlength with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %   
            % PATHLENGTH(G, 'Settings', SETTINGS) creates pathlength measure and
            % initializes the property settings with SETTINGS. PathLength
            % available SETTINGS are: 
            % subgraphs     -   Calculates PATHLENGTH of all subgraphs
            % harmonic      -   Calculates PATHLENGTH with harmonic average
            % default       -   Calculates PATHLENGTH with normal average
            %   
            % See also Measure, Graph, Strength, Distance, GlobalEfficiency. 
            
            settings = clean_varargin({'PathLengthAvRule'}, varargin{:});
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access = protected)
        function path_length =  calculate(m)
            % CALCULATE calculates the pathlength value of a node
            %
            % PATHLENGTH = CALCULATE(M) returns the value of the path_length
            % of a node.
            g = m.getGraph();

            if g.is_measure_calculated('Distance')
                distance = g.getMeasureValue('Distance');
            else
                distance = Distance(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            path_length = zeros(N, 1);            
          
            pathLength_rule = get_from_varargin('default', 'PathLengthAvRule', m.getSettings());
            switch lower(pathLength_rule)
                case {'subgraphs'}
                    for u = 1:1:N
                        Du = distance(:, u);
                        path_length(u) = mean(Du(Du~=Inf & Du~=0));                        
                    end
                     path_length(isnan(path_length)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
                case {'harmonic'}
                    for u = 1:1:N
                        Du = distance(:, u);
                        path_length(u) = harmmean(Du(Du~=0));
                    end
                otherwise
                    for u = 1:1:N
                        Du = distance(:, u);
                        path_length(u) = mean(Du(Du~=0));
                    end
            end           
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the pathlength measure.
            %
            % See also getName(), getDescription(). 
            measure_class = 'PathLength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the pathlength measure.
            %
            % See also getClass(), getDescription().
            name = 'Path Length';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the pathlength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % pathlength measure.
            %
            % See also getList(), getCompatibleGraphList().
            description = [ ...
                'The path length is the average shortest ' ...
                'path lengths of one node to all other nodes.' ...
                ];
        end
        function bool = is_global()
            % IS_GLOBAL checks if pathlength measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if pathlength measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if pathlength measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to pathlength 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to pathlength. 
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
            % graphs to pathlength 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to pathlength.
            % 
            % See also getCompatibleGraphList().
            n = Measure.getCompatibleGraphNumber('PathLength');
        end
    end
end