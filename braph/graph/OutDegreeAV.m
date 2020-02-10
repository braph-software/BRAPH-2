classdef OutDegreeAv < OutDegree
    methods
        function m = OutDegreeAv(g, varargin)
            m = m@OutDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
       function calculate(m)
            calculate@OutDegree(g);
            out_degree = m.value;            
            out_degree_av = mean(out_degree);
            m.setValue(out_degree_av);
        end
    end
    methods(Static)
        function name = getName()
            name = 'Average Out Degree';
        end
        function description = getDescription()
            description = [ ...
                'The average of out degrees of a graph is ' ...
                'the average of all number of outward edges '...
                'connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function bool = is_global()
            bool = true;
        end
        function bool = is_nodal()
            bool = false;
        end
        function list = compatible_graph_list()  
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                };
        end
    end
end
