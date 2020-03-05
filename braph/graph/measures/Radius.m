classdef Radius < Eccentricity
    methods
        function m = Radius(g, varargin)
            settings = clean_varargin({'RadiusRule'}, varargin{:});           
            m = m@Eccentricity(g, settings{:});
        end
    end
    methods (Access=protected)
        function radius = calculate(m)
            g = m.getGraph();
            
            if g.is_measure_calculated('Eccentricity')
                eccentricity = g.getMeasure('Eccentricity').getValue();
            else
                eccentricity = Eccentricity(g, g.getSettings()).getValue();
            end
            radius = min(eccentricity);
        end
    end  
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Radius';
        end
        function name = getName()
            name = 'Radius';
        end
        function description = getDescription()
            description = [ ...
                'The radius is the minimum eccentricity' ...
                'among the vertice.'
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
            n = Measure.getCompatibleGraphNumber('Radius');
        end
    end  
end