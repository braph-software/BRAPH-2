classdef Clustering < Triangles
    methods
        function m = Clustering (g, varargin)
            m = m@Triangles(g, varargin{:});
        end
    end
    methods (Access=protected)
        function clustering_coef = calculate(m)
            g = m.getGraph(); 
            A = g.getA();
            if g.is_measure_calculated('Triangles')
                triangles = g.getMeasureValue('Triangles');
            else
                triangles = calculate@Triangles(m);
            end
            settings = g.getSettings();
            if isa(g, 'GraphBU') || isa(g, 'GraphWU')
                degree = Degree(g, settings{:}).getValue();
                clustering_coef = 2*triangles./(degree.*(degree-1));
                
            elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')     
                inDegree = InDegree(g, settings{:}).getValue();
                outDegree = OutDegree(g, settings{:}).getValue();
                settings = m.getSettings();
                directed_triangles_rule = get_from_varargin(0, 'DirectedTrianglesRule', settings{:});
                switch lower(directed_triangles_rule)
                    case {'all'}  % all rule
                        clustering_coef = triangles./((outDegree+inDegree).*(outDegree+inDegree-1)- 2*diag(A^2));
                    case {'middleman'}  % middleman rule
                        clustering_coef = triangles./((outDegree.*inDegree)- diag(A^2));
                    case {'in'}  % in rule
                        clustering_coef = triangles./(inDegree.*(inDegree-1));
                    case {'out'}  % out rule
                        clustering_coef = triangles./(outDegree.*(outDegree-1));
                    otherwise  % {'cycle'}  % cycle rule
                        clustering_coef = triangles./((outDegree.*inDegree)- diag(A^2));
                end
                
            end
            clustering_coef(isnan(clustering_coef)) = 0; % Should return zeros, not nan
        end
    end  
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Clustering';
        end
        function name = getName()
            name = 'Clustering';
        end
        function description = getDescription()
            description = [ ...
                'The clustering coefficient of a node is ' ...
                'the fraction of triangles present around a node.' ...
                'The clustering coefficient is calculated as the ratio between' ...
                'the number of triangles present around a node and' ...
                'the maximum number of triangles that could possibly' ...
                'be formed around that node.' ...
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
            n = Measure.getCompatibleGraphNumber('Clustering');
        end
    end
    
end