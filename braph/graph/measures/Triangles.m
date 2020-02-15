classdef Triangles < Measure
    methods
        function m = Triangles(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function calculate(m)
            g = m.getGraph();
            A = g.getA();
            if isa(g, 'GraphBU') || isa(g, 'GraphWU')
                triangles = diag((A.^(1/3))^3)/2;
                triangles(isnan(triangles)) = 0; % Should return zeros, not nan
                m.setValue(triangles);
            elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')
                if ~isempty(m.getSettings()) % if parameter is passed as Settings
                    directedtriangles_rule = m.getSettings();
                    switch lower(directedtriangles_rule)
                        case {'all'}  % all rule
                            A = double(A);
                            triangles = diag((A + transpose(A))^3)/2;
                            m.setValue(triangles);
                        case {'middleman'}  % middleman rule
                            A = double(A);
                            triangles = diag(A * transpose(A) * A);
                            m.setValue(triangles);
                        case {'in'}  % in rule
                            A = double(A);
                            triangles = diag(transpose(A)*A^2);
                            m.setValue(triangles);
                        case {'out'}  % in rule
                            A = double(A);
                            triangles = diag(A^2*transpose(A));
                            m.setValue(triangles);
                        otherwise  % {'cycle'}  % cycle rule
                            A = double(A);
                            triangles = diag(A^3);
                            m.setValue(triangles);
                    end
                elseif isempty(m.getSettings()) % if no parameter is passed as Settings
                    A = double(A);
                    triangles = diag(A^3);
                    m.setValue(triangles);
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
