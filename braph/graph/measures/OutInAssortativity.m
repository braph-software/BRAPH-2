classdef OutInAssortativity < Measure
    methods
        function m = OutInAssortativity(g, varargin)
            
            settings = clean_varargin({}, varargin{:});
            
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access=protected)
        function out_in_assortativity = calculate(m)
            g = m.getGraph();
            A = g.getA();
            [i,j] = find(A ~= 0); % nodes [i , j]
            M = length(i); % Number of edges  
            
            % binary 
            if isa(g, 'GraphBD')
                
                if g.is_measure_calculated('InDegree')
                    in_k = g.getMeasureValue('InDegree');
                else 
                    in_k = InDegree(g, g.getSettings()).getValue();
                end

                if g.is_measure_calculated('OutDegree')
                    out_k = g.getMeasureValue('OutDegree');
                else
                    out_k = OutDegree(g, g.getSettings()).getValue();
                end
                
            % weighted  
            elseif isa(g, 'GraphWD')
                
                if g.is_measure_calculated('InStrength')
                    in_k = g.getMeasureValue('InStrength');
                else 
                    in_k = InStrength(g, g.getSettings()).getValue();
                end

                if g.is_measure_calculated('OutStrength')
                    out_k = g.getMeasureValue('OutStrength');
                else
                    out_k = OutStrength(g, g.getSettings()).getValue();
                end              
            end
            % calculate out - in degrees/strengths for node i and node j
            k_i = out_k(i);
            k_j = in_k(j);
            
            % compute assortativity
            out_in_assortativity = ( sum(k_i.*k_j)/M - (sum(0.5*(k_i+k_j))/M)^2 ) / ( sum(0.5*(k_i.^2+k_j.^2))/M - (sum(0.5*(k_i+k_j))/M)^2 );
            out_in_assortativity(isnan(out_in_assortativity)) = 0;  % Should return zeros, not NaN
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutInAssortativity';
        end
        function name = getName()
            name = 'Out-In-Assortativity';
        end
        function description = getDescription()
            description = [ ...
                'The out-in assortativity coefficient of a directed graph is ' ...
                'the correlation coefficient between the degrees/strengths ' ...
                'of all nodes on two opposite ends of an edge.' ...
                'The corresponding coefficient for directed networks '...
                'is calculated by using the out degree/strength and in degree/strength.'...
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
                'GraphWD', ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('OutInAssortativity');
        end
    end
end