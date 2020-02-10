classdef OutStrength < Measure
    methods
        function m = OutStrength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end    
    methods (Access=protected)
        function calculate(m)
            g = m.getGraph();
            A = g.getA();           
            out_strength = sum(A, 2);  % row sum of A        
            m.setValue(out_strength);
        end
    end  
    methods (Static)
        function name = getName()
            name = 'Out-Strength';
        end
        function description = getDescription()
            description = [ ...
                'The out-strength of a node is ' ...
                'the sum of the weights of all ' ...
                'the outward edges connected to a node.' ...
                'For WD graphs, out-strengths are calculated ' ...
                'as sums over rows of ' ...
                'the weighted connectivity matrix. ' ...
                ];
        end
        function bool = is_global()                        
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function list = compatible_graph_list()  
            list = { ...
                'GraphWD' ...
                };
        end
    end
end