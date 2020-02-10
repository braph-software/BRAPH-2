classdef InStrengthAV < Measure
    methods
        function m = InStrengthAV(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods
       function calculate(m)
            g = m.getGraph();          
            % get in strength measure 
            % of the graph.
            in_strength = g.getMeasure(g, 'InStrength');

            av_in_strength = mean(in_strength);
            m.setValue(av_in_strength);
        end
    end
    methods(Static)
        function name = getName()
            name = 'Average In-Strength';
        end
        function description = getDescription()
            description = [ ...
                'The average in-strength of a graph is ' ...
                'the average of the sum of the weights' ...
                'of all inward edges connected to the node. ' ...              
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