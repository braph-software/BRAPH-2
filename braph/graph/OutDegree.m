classdef OutDegree < Measure
    methods
        function m = OutDegree(g, varargin)
            m = m@Measure(g, varargin);
        end
    end
    methods(Access = protected)
        function calculate(m)
            g = m.getGraph();
            A = g.getA();
            out_degree = sum(A, 2);  % row sum of A
            m.setValue(out_degree);
        end
    end
    methods (Static)
        function name = getName()
            name = 'Out-Degree';
        end
        function description = getDescription()
            description = [ ...
                'The out-degree of a node is ' ...
                'the number of outward edges connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function bool = is_compatible_graph(g)
            bool = g.is_directed();
        end
        function list = compatible_graph_list()
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                };
        end
    end
end