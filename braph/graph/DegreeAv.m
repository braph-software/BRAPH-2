classdef DegreeAv < Degree
    methods
        function m = DegreeAv(g, varargin)
            m = m@Degree(g, varargin{:});
        end
    end
    methods (Access=protected)
       function calculate(m)
            calculate@Degree(g);
            degree = m.value;            
            degree_av = mean(degree);
            m.setValue(degree_av);
        end
    end
    methods(Static)
        function name = getName()
            name = 'Average Degree';
        end
        function description = getDescription()
            description = [ ...
                'The average degree of a graph is ' ...
                'the average of all number of edges connected to the node. ' ...
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
                'GraphBU', ...
                'GraphWU' ...
                };
        end
    end
end
