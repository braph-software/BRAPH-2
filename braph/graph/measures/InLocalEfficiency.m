classdef InLocalEfficiency < Measure
    methods
        function m = InLocalEfficiency(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_local_efficiency = calculate(m)
            g = m.getGraph();
            A = g.getA();
            n = g.nodenumber();
            
            in_local_efficiency = zeros(n,1);
            for i = 1:1:n
                nodes = find(A(i, :)  | A(:, i).');  % neighbours of u
                if numel(nodes) > 1
                    sub_graph = g.subgraph(nodes);
                    in_local_efficiency(i) = mean(InGlobalEfficiency(sub_graph, g.getSettings()).getValue());
                end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InLocalEfficiency';
        end
        function name = getName()
            name = 'In-Local-Efficiency';
        end
        function description = getDescription()
            description = [ ...
                'The in local efficiency is the average inverse ' ...
                'shortest in path length with local nodes.' ...
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
            n = Measure.getCompatibleGraphNumber('InLocalEfficiency');
        end
    end
end