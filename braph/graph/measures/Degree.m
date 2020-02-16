classdef Degree < Measure
    methods
        function m = Degree(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function degree = calculate(m)
            g = m.getGraph();
            A = g.getA();
            A = binarize(A);
            degree = sum(A, 2);
        end
    end        
    methods (Static)
         function measure_class = getClass()
            measure_class = 'Degree';
        end
        function name = getName()
            name = 'Degree';
        end
        function description = getDescription()
            description = [ ...
                'The degree of a node is ' ...
                'the number of edges connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
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
                'GraphBU', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('Degree');
        end
    end
end