classdef Transitivity < Triangles
    methods
        function m = Transitivity (g, varargin)
            
            settings = clean_varargin({'DirectedTrianglesRule'}, varargin{:});            
            
            m = m@Triangles(g, settings{:});
        end
    end
    methods (Access=protected)
        function transitivity = calculate(m)
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
                
                transitivity = 2 * sum(triangles) ./ sum((degree .* (degree - 1)));
                
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

                transitivity = sum(triangles) ./ sum(((out_degree + in_degree) .* (out_degree + in_degree - 1) - 2 * diag(A^2)));      
            end
            
            transitivity(isnan(transitivity)) = 0;  % Should return zeros, not NaN
        end
    end  
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Transitivity';
        end
        function name = getName()
            name = 'Transitivity';
        end
        function description = getDescription()
            description = [ ...
                'The transitivity of a graph is ' ...
                'the fraction of triangles to the number' ...
                'of (unordered) triplets in the graph.' ...
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
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('Transitivity');
        end
    end
    
end