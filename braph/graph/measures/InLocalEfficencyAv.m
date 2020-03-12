classdef InLocalEfficencyAv < InLocalEfficency
    methods
        function m = InLocalEfficencyAv(g, varargin)
            m = m@InLocalEfficency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function le_av = calculate(m)
            g = m.getGraph();
            if g.is_measure_calculated('InLocalEfficency')
                le = g.getMeasureValue('InLocalEfficency');
            else
                le = calculate@InLocalEfficency(m);
            end
            
            le_av = mean(le);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InLocalEfficencyAv';
        end
        function name = getName()
            name = 'Average In Local Efficency';
        end
        function description = getDescription()
            description = [ ...
                'The average in local efficiency is the average of the ' ...
                'all in local efficencies.' ...
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
            n = Measure.getCompatibleGraphNumber('InLocalEfficencyAv');
        end
    end
end