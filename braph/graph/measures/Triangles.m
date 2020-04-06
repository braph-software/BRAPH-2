classdef Triangles < Measure
    methods
        function m = Triangles(g, varargin)            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function triangles = calculate(m)
            g = m.getGraph();
            A = g.getA();
            if isa(g, 'GraphBU') || isa(g, 'GraphWU')
                triangles = diag((A.^(1/3))^3) / 2;
                triangles(isnan(triangles)) = 0;  % Should return zeros, not NaN
                
            elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')
                directed_triangles_rule = get_from_varargin('cycle', 'DirectedTrianglesRule', m.getSettings());
                switch lower(directed_triangles_rule)
                    case {'all'}  % all rule
                        triangles = diag((A.^(1/3) + transpose(A).^(1/3))^3) / 2;
                    case {'middleman'}  % middleman rule
                        triangles = diag(A.^(1/3) * transpose(A).^(1/3) * A.^(1/3));
                    case {'in'}  % in rule
                        triangles = diag(transpose(A).^(1/3) * (A.^(1/3))^2);
                    case {'out'}  % in rule
                        triangles = diag((A.^(1/3))^2 * transpose(A).^(1/3));
                    otherwise  % {'cycle'}  % cycle rule
                        triangles = diag((A.^(1/3))^3);
                end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Triangles';
        end
        function name = getName()
            name = 'Triangles';
        end
        function description = getDescription()
            description = [ ...
                'The triangles of a node are ' ...
                'the number of its neighbor pairs' ...
                'that are connected to each other. ' ...
                'In weighted graphs, the triangles are calculated' ...
                'as geometric mean of the weights of the edges' ...
                'forming the triangle.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            available_settings = {
                'DirectedTrianglesRule', Constant.STRING, 'cycle', {'cycle', 'all', 'middleman', 'in', 'out'};
                };
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
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('Triangles');
        end
    end
end
