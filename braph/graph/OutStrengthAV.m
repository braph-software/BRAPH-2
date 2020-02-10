classdef OutStrengthAV < Measure
    methods
        function m = OutStrengthAV(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods
       function calculate(m)
            g = m.getGraph();          
            % get out strength measure 
            % of the graph.
            out_strength = g.getMeasure(g, 'OutStrength');

            av_out_strength = mean(out_strength);
            m.setValue(av_out_strength);
        end
    end
    methods(Static)
        function name = getName()
            name = 'Average Out-Strength';
        end
        function description = getDescription()
            description = [ ...
                'The average out-strength of a graph is ' ...
                'the average of the sum of the weights' ...
                'of all outward edges connected to the node. ' ...              
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