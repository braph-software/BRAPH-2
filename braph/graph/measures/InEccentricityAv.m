classdef InEccentricityAv < InEccentricity
    methods
        function m = InEccentricityAv(g, varargin)
            settings = clean_varargin({'InEccentricityRule'}, varargin{:});
            m = m@InEccentricity(g, settings{:});
        end
    end
    methods (Access = protected)
        function in_ecc_av = calculate(m)
            g = m.getGraph();
            
            if g.is_measure_calculated('InEccentricity')
                in_ecc = g.getMeasureValue('InEccentricity');
            else
                in_ecc = calculate@InEccentricity(m);
            end
            
            in_ecc_av = mean(in_ecc);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InEccentricityAv';
        end
        function name = getName()
            name = 'Average In Eccentricity';
        end
        function description = getDescription()
            description = [ ...
                'The avearge in Eccentricity of a node is ' ...
                'sum of the nodal in Eccentricities divided by their number.' ...
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
            n = Measure.getCompatibleGraphNumber('InEccentricityAv');
        end
    end
end