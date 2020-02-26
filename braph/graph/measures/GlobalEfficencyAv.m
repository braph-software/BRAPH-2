classdef GlobalEfficencyAv < GlobalEfficency
    methods
        function m = GlobalEfficencyAv(g, varargin)
            m = m@GlobalEfficency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function  global_efficiency_av = calculate(m)
            g = m.getGraph();            
            if g.is_measure_calculated('GlobalEfficency')
                global_efficiency = g.getMeasureValue('GlobalEfficency');
            else
                global_efficiency = calculate@GlobalEfficency(m);
            end
            
             global_efficiency_av = mean(global_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'GlobalEfficencyAv';
        end
        function name = getName()
            name = 'Average Global Efficency';
        end
        function description = getDescription()
            description = [ ...
                'The average global efficiency is the average of the' ...
                'global efficency ' ...
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
                'GraphBU', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('GlobalEfficencyAv');
        end
    end
end