classdef InDegreeAV < Measure
    methods
        function m = InDegreeAV(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
       function calculate(m)
            g = m.getGraph();          
            % get in_degree measure 
            % of the graph.
            in_degree = g.getMeasure('InDegree');
            
            av_in_degree = mean(in_degree.value, 'all');
            m.setValue(av_in_degree);
        end
    end
    methods(Static)
        function name = getName()
            name = 'Average In Degree';
        end
        function description = getDescription()
            description = [ ...
                'The average of in degrees of a graph is ' ...
                'the average of all number of inward edges'...
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
