classdef Strength < Measure
    methods
        function m = Strength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end    
    methods (Access=protected)
        function calculate(m)
            g = m.getGraph();
            A = g.getA();
            A = remove_diagonal(A); % enforces diagonal remove
            
            in_strength = sum(A,1)';
            out_strength = sum(A,2);
            
            if(g.is_directed())
                strength = in_strength + out_strength;
            else
                strength = in_strenth;
            end           
             
            m.setValue(strength);
        end
    end  
    methods (Static)
        function name = getName()
            name = 'Strength';
        end
        function description = getDescription()
            description = [ ...
                'The strength of a node is ' ...
                'the sum of the weights of all ' ...
                'the edges connected to a node.' ...
                'For WU graphs, strenghts are calculated' ...
                'as sums over either rows or colums of' ...
                'the weighted connectivity matrix.' ...
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