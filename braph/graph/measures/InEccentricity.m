classdef InEccentricity < Measure
    methods
        function m = InEccentricity(g, varargin)
            settings = clean_varargin({'InEccentricityRule'}, varargin{:});
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
            
            ecc_rule = get_from_varargin('standard', 'InEccentricityRule', m.getSettings());
            switch(ecc_rule)
                case {'subgraphs'}
                    ecc = max(D.*(D~=Inf), [], 1)'; 
                case {'standard'}
                    ecc = max(D, [], 1)';
            end 
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InEccentricity';
        end
        function name = getName()
            name = 'In Eccentricity';
        end
        function description = getDescription()
            description = [ ...
                'The In Eccentricity of a node is ' ...
                'the maximal shortest in path length between a ' ...
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
                'GraphBD', ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('InEccentricity');
        end
    end
end