classdef InDegree < Measure
    methods
        function m = InDegree(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods(Access=protected)
        function calculate(m)
            g = m.getGraph();
            A = g.getA();
            in_degree = sum(A, 1)';  % column sum of A
            m.setValue(in_degree);
        end
    end
    methods (Static) 
        function name = getName()
            name = 'In-Degree';
        end
        function description = getDescription()
            description = [ ...
                'The in-degree of a node is ' ...
                'the number of inward edges connected to the node. ' ...
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