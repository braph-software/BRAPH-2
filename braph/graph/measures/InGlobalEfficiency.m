classdef InGlobalEfficiency < Measure
    methods
        function m = InGlobalEfficiency(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_global_efficiency = calculate(m)
            g = m.getGraph();
            N = g.nodenumber();

            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            Di = D.^-1;  % inverse distance
            Di(1:N+1:end) = 0;
            in_global_efficiency = (sum(Di, 1) / (N-1))';
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InGlobalEfficiency';
        end
        function name = getName()
            name = 'Global-In-Efficiency';
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
            n = Measure.getCompatibleGraphNumber('InGlobalEfficiency');
        end
    end
end