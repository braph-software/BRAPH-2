classdef OutStrengthAv < OutStrength
    methods
        function m = OutStrengthAv(g, varargin)
            m = m@OutStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function out_strength_av = calculate(m)
            
            g = m.getGraph();
            
            if g.is_measure_calculated('OutStrength')
                out_strength = g.getMeasureValue('OutStrength');
            else
                out_strength = calculate@OutStrength(m);
            end
            
            out_strength_av = mean(out_strength);
        end
    end
    methods(Static)
         function measure_class = getClass()
            measure_class = 'OutStrengthAv';
        end
        function name = getName()
            name = 'Average Out-Strength';
        end
        function description = getDescription()
            description = [ ...
                'The average out-strength of a graph is ' ...
                'the average of the sum of the weights ' ...
                'of all outward edges connected to the node. ' ...
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
            n = Measure.getCompatibleGraphNumber('OutStrengthAv');
        end
    end
end