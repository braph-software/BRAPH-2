classdef LocalEfficency < Measure
    methods
        function m = LocalEfficency(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function le = calculate(m)
            g = m.getGraph();
            A = g.getA();
            n = g.nodenumber();
            
            le = zeros(n,1);
            for i = 1:1:n
                nodes = find(A(i, :)  | A(:, i).');  % neighbours of u
                if numel(nodes) > 1
                    sub_graph = g.subgraph(nodes);
                    le(i) = mean(GlobalEfficency(sub_graph, g.getSettings()).getValue());
                end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'LocalEfficency';
        end
        function name = getName()
            name = 'Local Efficency';
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
            n = Measure.getCompatibleGraphNumber('LocalEfficency');
        end
    end
end