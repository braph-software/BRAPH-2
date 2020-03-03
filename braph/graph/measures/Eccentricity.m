classdef Eccentricity < Measure
    methods
        function m = Eccentricity(g, varargin)
            settings = clean_varargin({'EccentricityRule'}, varargin{:}); 
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access = protected)
        function ecc = calculate(m)
            g = m.getGraph();
            
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            ecc_rule = get_from_varargin('default', 'EccentricityRule', m.getSettings());
            switch(ecc_rule)
                case {'subgraphs'}
                    ecc = max(D.*(D~=Inf), [], 2); 
                otherwise 
                    ecc = max(D, [], 2);
            end           
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