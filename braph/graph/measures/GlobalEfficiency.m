classdef GlobalEfficiency < Measure
    methods
        function m = GlobalEfficiency(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function global_efficiency = calculate(m)
            g = m.getGraph();
            N = g.nodenumber();            
           
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            Di = D.^-1;  % inverse distance
            Di(1:N+1:end) = 0;            
            global_efficiency = (sum(Di, 2) / (N-1));    
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'GlobalEfficiency';
        end
        function name = getName()
            name = 'Global-Efficiency';
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
            n = Measure.getCompatibleGraphNumber('GlobalEfficiency');
        end
    end
end