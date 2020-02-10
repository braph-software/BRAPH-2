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
            
            out_strength = sum(A,2);         
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
                'OUTSTRENGTH =  out_strength = sum(A, 2)'...
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
                'GraphWD', ...
                'GraphWU' ...
                };
        end
    end
end