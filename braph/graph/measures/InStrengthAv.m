classdef InStrengthAv < InStrength
    methods
        function m = InStrengthAv(g, varargin)
            m = m@InStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function calculate(m)
            
            g = m.getGraph();
            
            if g.is_measure_calculated('InStrength')
                in_strength = g.getMeasureValue('InStrength');
            else
                calculate@InStrength(g);
                in_strength = m.value;
            end
            
            in_strength_av = mean(in_strength);
            m.setValue(in_strength_av);
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
        function bool = is_global()
            
            bool = true;
        end
        function bool = is_nodal()
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
