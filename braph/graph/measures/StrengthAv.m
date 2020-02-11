classdef StrengthAv < Strength
    methods
        function m = StrengthAv(g, varargin)
            m = m@Strength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function calculate(m)
            
            g = m.getGraph();
            
            if g.is_measure_calculated('Strength')
                strength = g.getMeasureValue('Strength');
            else
                calculate@Strength(g);
                strength = m.value;
            end
            
            strength_av = mean(strength);
            m.setValue(strength_av);
        end
    end
    methods(Static)
        function measure_class = getClass()
            measure_class = 'StrengthAv';
        end
        function name = getName()
            name = 'Average Strength';
        end
        function description = getDescription()
            description = [ ...
                'The average strength of a graph is ' ...
                'the average of the sum of the weights ' ...
                'of all edges connected to the node. ' ...
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
                'GraphWU', ...
                };
        end
    end
end