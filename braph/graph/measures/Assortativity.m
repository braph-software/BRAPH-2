classdef Assortativity < Measure
    methods
        function m = Assortativity(g, varargin)
            
            settings = clean_varargin({}, varargin{:});
            
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access=protected)
        function assortativity = calculate(m)
            g = m.getGraph();
            A = g.getA();
            [i, j] = find(triu(A) ~= 0); % nodes [i, j] 
            M = length(i); % Number of edges
            
            if isa(g, 'GraphBU') % Binary undirected
                
                if g.is_measure_calculated('Degree')
                    degree = g.getMeasureValue('Degree');
                else
                    degree = Degree(g, g.getSettings()).getValue();
                end
                
                k_i = degree(i); % degree node i
                k_j = degree(j); % degree node j
                
            elseif isa(g, 'GraphWU') % Weighted undirected
                
                if g.is_measure_calculated('Strength')
                    strength = g.getMeasureValue('Strength');
                else
                    strength = Strength(g, g.getSettings()).getValue();
                end
                
                k_i = strength(i); % strength node i
                k_j = strength(j); % strength node j
            end
            
            % compute assortativity
            assortativity = (sum(k_i.*k_j) / M - (sum(0.5*(k_i+k_j)) / M)^2)... 
                / (sum(0.5*(k_i.^2+k_j.^2)) / M - (sum(0.5*(k_i+k_j)) / M)^2);
            assortativity(isnan(assortativity)) = 0;  % Should return zeros, not NaN
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Assortativity';
        end
        function name = getName()
            name = 'Assortativity';
        end
        function description = getDescription()
            description = [ ...
                'The assortativity coefficient of a graph is ' ...
                'the correlation coefficient between the degrees/strengths ' ...
                'of all nodes on two opposite ends of an edge.' ...
                'The corresponding coefficient for directed and '...
                'weighted networks is calculated by using the weighted '...
                'and directed variants of degree/strength.'...
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
            n = Measure.getCompatibleGraphNumber('Assortativity');
        end
    end
end