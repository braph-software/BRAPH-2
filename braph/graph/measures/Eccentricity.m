classdef Eccentricity < Measure
    methods
        function m = Eccentricity(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function ecc = calculate(m)
            g = m.getGraph();
            settings = g.getSettings();
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, settings{:}).getValue();
            end
            
            ecc = max(D.*(D~=Inf),[], 2);  
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Eccentricity';
        end
        function name = getName()
            name = 'Eccentricity';
        end
        function description = getDescription()
            description = [ ...
                'The Eccentricity of a node is ' ...
                'the maximal shortest path length between a ' ...
                'node and any other node.' ...
                ];
        end
        function bool = is_global()
            
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
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
            n = Measure.getCompatibleGraphNumber('Eccentricity');
        end
    end
end