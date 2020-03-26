classdef OutGlobalEfficiency < Measure
    methods
        function m = OutGlobalEfficiency(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_global_efficiency = calculate(m)
            g = m.getGraph();
            N = g.nodenumber();
            
            if g.is_measure_calculated('Distance')
                D = g.getMeasure('Distance').getValue();
            else
                D = Distance(g, g.getSettings()).getValue();
            end
            
            Di = D.^-1;  % inverse distance
            Di(1:N+1:end) = 0;   
            out_global_efficiency = (sum(Di, 2) / (N-1));
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutGlobalEfficiency';
        end
        function name = getName()
            name = 'Global-Out-Efficiency';
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
            n = Measure.getCompatibleGraphNumber('OutGlobalEfficiency');
        end
    end
end