classdef EccentricityAv < Eccentricity
    methods
        function m = EccentricityAv(g, varargin)
            m = m@Eccentricity(g, varargin{:});
        end
    end
    methods (Access = protected)
        function ecc_av = calculate(m)
            g = m.getGraph();
            
            if g.is_measure_calculated('Eccentricity')
                ecc = g.getMeasureValue('Eccentricity');
            else
                ecc = calculate@Eccentricity(m);
            end
            
            ecc_av = mean(ecc);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'EccentricityAv';
        end
        function name = getName()
            name = 'Average Eccentricity';
        end
        function description = getDescription()
            description = [ ...
                'The avearge Eccentricity of a graph is ' ...
                'sum of the nodal Eccentricities divided by their number.' ...
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
                'GraphBU', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('EccentricityAv');
        end
    end
end