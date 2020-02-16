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
                triangles = diag((A.^(1/3))^3)/2;
                triangles(isnan(triangles)) = 0; % Should return zeros, not nan
            elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')
                
                settings = m.getSettings();
                directed_triangles_rule = get_from_varargin(0, 'DirectedTrianglesRule', settings{:});
                
                switch lower(directed_triangles_rule)
                    case {'all'}  % all rule
                        A = double(A);
                        triangles = diag((A + transpose(A))^3)/2;
                    case {'middleman'}  % middleman rule
                        A = double(A);
                        triangles = diag(A * transpose(A) * A);
                    case {'in'}  % in rule
                        A = double(A);
                        triangles = diag(transpose(A)*A^2);
                    case {'out'}  % in rule
                        A = double(A);
                        triangles = diag(A^2*transpose(A));
                    otherwise  % {'cycle'}  % cycle rule
                        A = double(A);
                        triangles = diag(A^3);
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
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
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
