classdef InGlobalEfficencyAv < InGlobalEfficency
    methods
        function m = InGlobalEfficencyAv(g, varargin)
            m = m@InGlobalEfficency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function gbav = calculate(m)
            g = m.getGraph();            
            if g.is_measure_calculated('InGlobalEfficency')
                ge = g.getMeasureValue('InGlobalEfficency');
            else
                ge = calculate@InGlobalEfficency(m);
            end
            
            gbav = mean(ge);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InGlobalEfficencyAv';
        end
        function name = getName()
            name = 'Average In Global Efficency';
        end
        function description = getDescription()
            description = [ ...
                'The average in global efficiency is the average of the' ...
                'in global efficency ' ...
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
                'GraphBD', ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('InGlobalEfficencyAv');
        end
    end
end