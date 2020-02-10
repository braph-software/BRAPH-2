classdef InStrengthAv < InStrength
    methods
        function m = InStrengthAv(g, varargin)
            m = m@InStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
       function calculate(m)
            calculate@InStrength(g);
            in_strength = m.value;
            in_strength_av = mean(in_strength);
            m.setValue(in_strength_av);
        end
    end
    methods(Static)
        function name = getName()
            name = 'Average In-Strength';
        end
        function description = getDescription()
            description = [ ...
                'The average in-strength of a graph is ' ...
                'the average of the sum of the weights ' ...
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