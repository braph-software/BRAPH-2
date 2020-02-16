classdef OutStrength < Measure
    methods
        function m = OutStrength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end    
    methods (Access=protected)
        function out_strength = calculate(m)
            g = m.getGraph();
            A = g.getA();           
            out_strength = sum(A, 2);  % row sum of A        
        end
    end  
    methods (Static)
         function measure_class = getClass()
            measure_class = 'OutStrength';
        end
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
        function list = getCompatibleGraphList()  
            list = { ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('OutStrength');
        end
    end
end