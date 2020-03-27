classdef LocalEfficiencyAv < LocalEfficiency
    methods
        function m = LocalEfficiencyAv(g, varargin)
            m = m@LocalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function local_efficiency_av = calculate(m)
            g = m.getGraph();
            if g.is_measure_calculated('LocalEfficiency')
                local_efficiency = g.getMeasureValue('LocalEfficiency');
            else
                local_efficiency = calculate@LocalEfficiency(m);
            end
            
            local_efficiency_av = mean(local_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'LocalEfficiencyAv';
        end
        function name = getName()
            name = 'Average-Local-Efficiency';
        end
        function description = getDescription()
            description = [ ...
                'The average local efficiency is the average of the ' ...
                'all local efficiencies.' ...
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
            n = Measure.getCompatibleGraphNumber('LocalEfficiencyAv');
        end
    end
end