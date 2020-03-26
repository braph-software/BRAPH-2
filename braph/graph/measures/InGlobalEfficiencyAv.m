classdef InGlobalEfficiencyAv < InGlobalEfficiency
    methods
        function m = InGlobalEfficiencyAv(g, varargin)
            m = m@InGlobalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_global_efficiency_av = calculate(m)
            g = m.getGraph();    
            
            if g.is_measure_calculated('InGlobalEfficiency')
                in_global_efficiency = g.getMeasureValue('InGlobalEfficiency');
            else
                in_global_efficiency = calculate@InGlobalEfficiency(m);
            end
            
            in_global_efficiency_av = mean(in_global_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InGlobalEfficiencyAv';
        end
        function name = getName()
            name = 'Average-In-Global-Efficiency';
        end
        function description = getDescription()
            description = [ ...
                'The average in global efficiency is the average of the' ...
                'in global efficiency ' ...
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
            n = Measure.getCompatibleGraphNumber('InGlobalEfficiencyAv');
        end
    end
end