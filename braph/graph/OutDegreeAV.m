classdef OutDegreeAV < Measure
    methods
        function m = OutDegreeAV(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods
       function calculate(m)
            g = m.getGraph();          
            % get out_degree measure 
            % of the graph.
            out_degree = g.getMeasure(g, 'OutDegree');
            
            av_out_degree = mean(out_degree);
            m.setValue(av_out_degree);
        end
    end
    methods(Static)
        function name = getName()
            name = 'Average Out Degree';
        end
        function description = getDescription()
            description = [ ...
                'The average of out degrees of a graph is ' ...
                'the average of all number of outward edges'...
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
