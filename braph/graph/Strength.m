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
            
            in_strength = sum(A, 1)'; % choosed instrength, but can be
                                    % either one fo WU.

            strength = in_strength;             
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
                'For WU graphs, strengths are calculated' ...
                'as sums over either rows or colums of' ...
                'the weighted connectivity matrix.' ...
                'STRENGTH = sum(A,1)' ...
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
                };
        end
    end
end