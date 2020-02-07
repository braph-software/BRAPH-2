classdef Degree < Measure
    methods
        function m = Degree(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function calculate(m)
            g = m.getGraph();
            A = g.getA();
            degree = sum(A, 2);
            m.setValue(degree);
        end
    end        
    methods (Static)
        function bool = is_global()
            bool = false;
        end
%         function bool = is_nodal()
%             bool = true;
%         end
        function bool = is_compatible_graph(g)
            bool = g.is_undirected();
        end
        function list = compatible_graph_list()  
            list = { ...
                'GraphBU', ...
                'GraphWU' ...
                };
        end
    end
end