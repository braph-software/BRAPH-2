classdef OutEccentricityAv < OutEccentricity
    methods
        function m = OutEccentricityAv(g, varargin)
          
            m = m@OutEccentricity(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_ecc_av = calculate(m)
            g = m.getGraph();
            
            if g.is_measure_calculated('OutEccentricity')
                out_ecc = g.getMeasureValue('OutEccentricity');
            else
                out_ecc = calculate@OutEccentricity(m);
            end
            
            out_ecc_av = mean(out_ecc);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutEccentricityAv';
        end
        function name = getName()
            name = 'Average Out Eccentricity';
        end
        function description = getDescription()
            description = [ ...
                'The avearge out Eccentricity of a node is ' ...
                'sum of the nodal out Eccentricities divided by their number.' ...
                ];
        end
        function available_settings = getAvailableSettings()           
            available_settings = {
                'OutEccentricityRule', Constant.STRING, 'default', {'default', 'subgraphs'};
                };
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
            n = Measure.getCompatibleGraphNumber('OutEccentricityAv');
        end
    end
end