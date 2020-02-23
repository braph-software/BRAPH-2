classdef PathLengthGlobal < PathLength
    methods
        function m = PathLengthGlobal(g, varargin)
            m = m@PathLength(g, varargin{:});
        end
    end
    methods (Access = protected)
        function plg =  calculate(m)
            g = m.getGraph();
            
            if g.is_measure_calculated('PathLength')
                pathLength = g.getMeasureValue('PathLength');
            else
                pathLength = calculate@PathLength(m);
            end
            
            settings = m.getSettings();
            pathLengthGlobal_rule = get_from_varargin(0, 'AveragePathLengthRule', settings{:});
            switch lower(pathLengthGlobal_rule)
                case {'subgraphs'}  % whitin connected subgraphs
                   
                case {'harmonic'}  % harmonic mean
                    cond = pathLength(1, :) == Inf;  % locates all not connected nodes
                    pathLength(:,cond ) = [];  % removes conditions
                    plg =  harmmean(pathLength);
                otherwise  % simple average
                    cond = pathLength(1, :) == Inf;  % locates all not connected nodes
                    pathLength(:,cond ) = [];  % removes conditions
                    plg =  mean(pathLength);
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'PathLengthGlobal';
        end
        function name = getName()
            name = 'PathLengthGlobal';
        end
        function description = getDescription()
            description = [ ...
                'The path length is simply the average '...
                'of the nodal path lengths for all nodes ' ...
                'in the graph. The average can be performed ' ...
                'in three ways: Simple average, Harmonic ' ...
                'average, whitin connected subgraphs.' ...
                ];
        end
        function bool = is_global()
            bool = true;
        end
        function bool = is_nodal()
            bool = false;
        end
        function bool = is_binodal()
            bool = false;
        end
        function list = getCompatibleGraphList()
            list = { ...
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('PathLengthGlobal');
        end
    end
end