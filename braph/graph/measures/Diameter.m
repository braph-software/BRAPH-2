classdef Diameter < Measure
    methods
        function m = Diameter(g, varargin)
            
            settings = clean_varargin({'EccentricityRule'}, varargin{:});
            
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access=protected)
        function diameter = calculate(m)
            g = m.getGraph();
            
            if g.is_measure_calculated('Eccentricity')
                eccentricity = g.getMeasure('Eccentricity').getValue();
            else
                eccentricity_rule = get_from_varargin('default', 'EccentricityRule', m.getSettings());
                eccentricity = Eccentricity(g, 'EccentricityRule', eccentricity_rule).getValue();
            end
            
            diameter = max(eccentricity);
        end
    end  
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Diameter';
        end
        function name = getName()
            name = 'Diameter';
        end
        function description = getDescription()
            description = [ ...
                'The diameter is the maximum eccentricity ' ...
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
            n = Measure.getCompatibleGraphNumber('Diameter');
        end
    end  
end