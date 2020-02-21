classdef Strength < Measure
    methods
        function m = Strength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end    
    methods (Access=protected)
        function strength = calculate(m)
            g = m.getGraph();
            A = g.getA();    
            strength = sum(A, 1)';
        end
    end  
    methods (Static)
         function measure_class = getClass()
            measure_class = 'Strength';
        end
        function name = getName()
            name = 'Strength';
        end
        function description = getDescription()
            description = [ ...
                'The strength of a node is ' ...
                'the sum of the weights of ' ...
                'all the edges connected to a node. ' ...
                'For WU graphs, strengths are calculated ' ...
                'as sums over either rows or colums of ' ...
                'the weighted connectivity matrix. ' ...
                ];
        end
        function bool = is_global()
                        
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function bool = is_binodal()
            bool = false;
        end
        function list = getCompatibleGraphList()  
            list = { ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('Strength');
        end
    end
end