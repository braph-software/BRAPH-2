classdef InGlobalEfficency < Measure
    methods
        function m = InGlobalEfficency(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function ge = calculate(m)
            g = m.getGraph();
            N = g.nodenumber();
             settings = g.getSettings();
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, settings{:}).getValue();
            end
            Di = D.^-1;  % inverse distance
            Di(1:N+1:end) = 0;
            ge = (sum(Di, 1)/(N-1))';
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InGlobalEfficency';
        end
        function name = getName()
            name = 'Global In Efficency';
        end
        function description = getDescription()
            description = [ ...
                'The global in efficiency is the average inverse ' ...
                'shortest in path length in the graph. ' ...
                'It is inversely related to the characteristic in path length.';
                ];
        end
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function bool = is_binodal()
            bool = false;
        end
        function list = getCompatibleGraphList()
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('InGlobalEfficency');
        end
    end
end