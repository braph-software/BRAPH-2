classdef OutLocalEfficencyAv < OutLocalEfficency
    methods
        function m = OutLocalEfficencyAv(g, varargin)
            m = m@OutLocalEfficency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function le_av = calculate(m)
            g = m.getGraph();
            if g.is_measure_calculated('OutLocalEfficency')
                le = g.getMeasureValue('OutLocalEfficency');
            else
                le = calculate@OutLocalEfficency(m);
            end
            
            le_av = mean(le);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutLocalEfficencyAv';
        end
        function name = getName()
            name = 'Average Out Local Efficency';
        end
        function description = getDescription()
            description = [ ...
                'The average out local efficiency is the average of the ' ...
                'all out local efficencies.' ...
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
            n = Measure.getCompatibleGraphNumber('OutLocalEfficencyAv');
        end
    end
end