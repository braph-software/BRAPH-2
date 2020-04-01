classdef GlobalEfficiencyAv < GlobalEfficiency
    methods
        function m = GlobalEfficiencyAv(g, varargin)
            m = m@GlobalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function  global_efficiency_av = calculate(m)
            g = m.getGraph();    
            
            if g.is_measure_calculated('GlobalEfficiency')
                global_efficiency = g.getMeasureValue('GlobalEfficiency');
            else
                global_efficiency = calculate@GlobalEfficiency(m);
            end
            
             global_efficiency_av = mean(global_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'GlobalEfficiencyAv';
        end
        function name = getName()
            name = 'Average-Global-Efficiency';
        end
        function description = getDescription()
            description = [ ...
                'The average global efficiency is the average of the' ...
                'global efficiency ' ...
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
                'GraphBU', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('GlobalEfficiencyAv');
        end
    end
end