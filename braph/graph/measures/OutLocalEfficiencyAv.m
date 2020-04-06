classdef OutLocalEfficiencyAv < OutLocalEfficiency
    methods
        function m = OutLocalEfficiencyAv(g, varargin)
            m = m@OutLocalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_local_efficiency_av = calculate(m)
            g = m.getGraph();
            if g.is_measure_calculated('OutLocalEfficiency')
                out_local_efficiency = g.getMeasureValue('OutLocalEfficiency');
            else
                out_local_efficiency = calculate@OutLocalEfficiency(m);
            end
            
            out_local_efficiency_av = mean(out_local_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutLocalEfficiencyAv';
        end
        function name = getName()
            name = 'Average-Out-Local-Efficiency';
        end
        function description = getDescription()
            description = [ ...
                'The average out local efficiency is the average of the ' ...
                'all out local efficiencies.' ...
                ];
        end
        function available_settings = getAvailableSettings()           
            available_settings = {};
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
            n = Measure.getCompatibleGraphNumber('OutLocalEfficiencyAv');
        end
    end
end