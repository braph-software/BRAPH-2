classdef OutGlobalEfficency < Measure
    methods
        function m = OutGlobalEfficency(g, varargin)
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
            ge = (sum(Di,2)'/(N-1))';               
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutGlobalEfficency';
        end
        function name = getName()
            name = 'Global Out Efficency';
        end
        function description = getDescription()
            description = [ ...
                'The global out efficiency is the average inverse ' ...
                'shortest out path length in the graph. ' ...
                'It is inversely related to the characteristic out path length.';
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
                'GraphBD', ...           
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('OutGlobalEfficency');
        end
    end
end