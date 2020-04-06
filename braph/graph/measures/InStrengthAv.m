classdef InStrengthAv < InStrength
    methods
        function m = InStrengthAv(g, varargin)

            m = m@InStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function in_strength_av = calculate(m)
            
            g = m.getGraph();
            
            if g.is_measure_calculated('InStrength')
                in_strength = g.getMeasureValue('InStrength');
            else
                in_strength = calculate@InStrength(m);
            end
            
            in_strength_av = mean(in_strength);
        end
    end
    methods(Static)
         function measure_class = getClass()
            measure_class = 'InStrengthAv';
        end
        function name = getName()
            name = 'Average In-Strength';
        end
        function description = getDescription()
            description = [ ...
                'The average in-strength of a graph is ' ...
                'the average of the sum of the weights ' ...
                'of all inward edges connected to the node. ' ...
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
                'GraphWD', ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('InStrengthAv');
        end
    end
end
