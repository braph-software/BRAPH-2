classdef StrengthAV < Measure
    methods
        function m = StrengthAV(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
       function calculate(m)
            g = m.getGraph();          
            % get strength measure 
            % of the graph.
            strength = g.getMeasure('Strength');

            av_strength = mean(strength.value, 'all');
            m.setValue(av_strength);
        end
    end
    methods(Static)
        function name = getName()
            name = 'Average Strength';
        end
        function description = getDescription()
            description = [ ...
                'The average strength of a graph is ' ...
                'the average of the sum of the weights' ...
                'of all edges connected to the node. ' ...              
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
                'GraphWD', ...               
                };
        end
    end
end