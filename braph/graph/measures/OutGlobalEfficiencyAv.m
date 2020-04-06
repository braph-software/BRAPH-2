classdef OutGlobalEfficiencyAv < OutGlobalEfficiency
    methods
        function m = OutGlobalEfficiencyAv(g, varargin)
            m = m@OutGlobalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_global_efficiency_av = calculate(m)
            g = m.getGraph();   
            
            if g.is_measure_calculated('OutGlobalEfficiency')
                out_global_efficiency = g.getMeasureValue('OutGlobalEfficiency');
            else
                out_global_efficiency = calculate@OutGlobalEfficiency(m);
            end
            
            out_global_efficiency_av = mean(out_global_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutGlobalEfficiencyAv';
        end
        function name = getName()
            name = 'Average-Out-Global-Efficiency';
        end
        function description = getDescription()
            description = [ ...
                'The average out global efficiency is the average of the' ...
                'out global efficiency ' ...
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
            n = Measure.getCompatibleGraphNumber('OutGlobalEfficiencyAv');
        end
    end
end