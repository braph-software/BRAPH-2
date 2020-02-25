classdef GlobalEfficency < Measure
    methods
        function m = GlobalEfficency(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function ge = calculate(m)
            g = m.getGraph();
            N = g.nodenumber();
            D = g.getMeasure('Distance').getValue();
            Di = D.^-1;  % inverse distance
            Di(1:N+1:end) = 0;            
            ge = (sum(Di,1)/(N-1))';    
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'GlobalEfficency';
        end
        function name = getName()
            name = 'Global Efficency';
        end
        function description = getDescription()
            description = [ ...
                'The global efficiency is the average inverse ' ...
                'shortest path length in the graph. ' ...
                'It is inversely related to the characteristic path length.';
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
                'GraphBU', ...           
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('GlobalEfficency');
        end
    end
end