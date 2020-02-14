classdef InStrength < Measure
    methods
        function m = InStrength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end    
    methods (Access=protected)
        function in_strength = calculate(m)
            g = m.getGraph();
            A = g.getA();
            in_strength = sum(A, 1)';  % column sum of A        
        end
    end  
    methods (Static)
         function measure_class = getClass()
            measure_class = 'InStrength';
        end
        function name = getName()
            name = 'In-Strength';
        end
        function description = getDescription()
            description = [ ...
                'The in-strength of a node is ' ...
                'the sum of the weights of all ' ...
                'the inward edges connected to a node.' ...
                'For WD graphs, out-strengths are calculated ' ...
                'as sums over columns of ' ...
                'the weighted connectivity matrix. ' ...
                ];
        end
        function bool = is_global()                        
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function list = getCompatibleGraphList()  
            list = { ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('InStrength');
        end
    end
end