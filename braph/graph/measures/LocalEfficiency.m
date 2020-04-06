classdef LocalEfficiency < Measure
    methods
        function m = LocalEfficiency(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function local_efficiency = calculate(m)
            g = m.getGraph();
            A = g.getA();
            n = g.nodenumber();
            
            local_efficiency = zeros(n,1);
            for i = 1:1:n
                nodes = find(A(i, :)  | A(:, i).');  % neighbours of u
                if numel(nodes) > 1
                    sub_graph = g.subgraph(nodes);
                    local_efficiency(i) = mean(GlobalEfficiency(sub_graph, g.getSettings()).getValue());
                end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'LocalEfficiency';
        end
        function name = getName()
            name = 'Local-Efficiency';
        end
        function description = getDescription()
            description = [ ...
                'The local efficiency is the average inverse ' ...
                'shortest path length with local nodes.' ...
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
            n = Measure.getCompatibleGraphNumber('LocalEfficiency');
        end
    end
end