classdef LocalEfficencyAv < LocalEfficency
    methods
        function m = LocalEfficencyAv(g, varargin)
            m = m@LocalEfficency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function le_av = calculate(m)
            g = m.getGraph();
            if g.is_measure_calculated('LocalEfficency')
                le = g.getMeasureValue('LocalEfficency');
            else
                le = calculate@LocalEfficency(m);
            end
            
            le_av = mean(le);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'LocalEfficencyAv';
        end
        function name = getName()
            name = 'Average Local Efficency';
        end
        function description = getDescription()
            description = [ ...
                'The average local efficiency is the average of the ' ...
                'all local efficencies.' ...
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
            n = Measure.getCompatibleGraphNumber('LocalEfficencyAv');
        end
    end
end