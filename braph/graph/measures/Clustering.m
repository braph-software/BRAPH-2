classdef Clustering < Triangles
    methods
        function m = Clustering (g, varargin)

            settings = clean_varargin({'DirectedTrianglesRule'}, varargin{:});
            
            m = m@Triangles(g, settings{:});
        end
    end
    methods (Access=protected)
        function clustering = calculate(m)
            g = m.getGraph(); 
            A = g.getA();
            
            if g.is_measure_calculated('Triangles')
                triangles = g.getMeasureValue('Triangles');
            else
                triangles = calculate@Triangles(m);
            end
            
            if isa(g, 'GraphBU') || isa(g, 'GraphWU')
                
                
                if g.is_measure_calculated('Degree')
                    degree = g.getMeasureValue('Degree');                    
                else
                    degree = Degree(g, g.getSettings()).getValue();
                end
                
                clustering = 2 * triangles ./ (degree .* (degree - 1));
                
            elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')  
                
                if g.is_measure_calculated('InDegree')
                    in_degree = g.getMeasureValue('InDegree');
                else 
                    in_degree = InDegree(g, g.getSettings()).getValue();
                end
                
                if g.is_measure_calculated('OutDegree')
                    out_degree = g.getMeasureValue('OutDegree');
                else
                    out_degree = OutDegree(g, g.getSettings()).getValue();
                end
                
                directed_triangles_rule = get_from_varargin('cycle', 'DirectedTrianglesRule', m.getSettings());
                switch lower(directed_triangles_rule)
                    case {'all'}  % all rule
                        clustering = triangles ./ ((out_degree + in_degree) .* (out_degree + in_degree - 1) - 2 * diag(A^2));
                    case {'middleman'}  % middleman rule
                        clustering = triangles ./ ((out_degree .* in_degree) - diag(A^2));
                    case {'in'}  % in rule
                        clustering = triangles ./ (in_degree .* (in_degree - 1));
                    case {'out'}  % out rule
                        clustering = triangles ./ (out_degree .* (out_degree - 1));
                    otherwise  % {'cycle'}  % cycle rule
                        clustering = triangles ./ ((out_degree .* in_degree) - diag(A^2));
                end
                
            end
            
            clustering(isnan(clustering)) = 0;  % Should return zeros, not NaN
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
            n = Measure.getCompatibleGraphNumber('Clustering');
        end
    end  
end