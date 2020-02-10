classdef DegreeAV < Measure
    methods
        function m = DegreeAV(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods
       function calculate(m)
            g = m.getGraph();          
            % get degree measure 
            % of the graph.
            degree = g.getMeasure(g, 'Degree');
            
            av_degree = mean(degree);
            m.setValue(av_degree);
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
