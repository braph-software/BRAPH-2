classdef InLocalEfficiencyAv < InLocalEfficiency
    methods
        function m = InLocalEfficiencyAv(g, varargin)
            m = m@InLocalEfficiency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_local_efficiency_av = calculate(m)
            g = m.getGraph();
            if g.is_measure_calculated('InLocalEfficiency')
                in_local_efficiency = g.getMeasureValue('InLocalEfficiency');
            else
                in_local_efficiency = calculate@InLocalEfficiency(m);
            end
            
            in_local_efficiency_av = mean(in_local_efficiency);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InLocalEfficiencyAv';
        end
        function name = getName()
            name = 'Average-In-Local-Efficiency';
        end
        function description = getDescription()
            description = [ ...
                'The average in local efficiency is the average of the ' ...
                'all in local efficiencies.' ...
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
            n = Measure.getCompatibleGraphNumber('InLocalEfficiencyAv');
        end
    end
end