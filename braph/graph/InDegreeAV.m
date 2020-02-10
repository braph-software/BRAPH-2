classdef InDegreeAv < InDegree
    methods
        function m = InDegreeAv(g, varargin)
            m = m@InDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
       function calculate(m)
            calculate@InDegree(g);
            in_degree = m.value;            
            in_degree_av = mean(in_degree);
            m.setValue(in_degree_av);
        end
    end
    methods(Static)
        function name = getName()
            name = 'Average In Degree';
        end
        function description = getDescription()
            description = [ ...
                'The average of in degrees of a graph is ' ...
                'the average of all number of inward edges '...
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
