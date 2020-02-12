classdef OutDegreeAv < OutDegree
    methods
        function m = OutDegreeAv(g, varargin)
            m = m@OutDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function calculate(m)
            
            g = m.getGraph();
            
            if g.is_measure_calculated('OutDegree')
                out_degree = g.getMeasureValue('OutDegree');
            else
                calculate@OutDegree(g);
                out_degree = m.value;
            end
            
            out_degree_av = mean(out_degree);
            m.setValue(out_degree_av);
        end
    end
    methods(Static)
         function measure_class = getClass()
            measure_class = 'OutDegreeAv';
        end
        function name = getName()
            name = 'Average Out Degree';
        end
        function description = getDescription()
            description = [ ...
                'The average of out degrees of a graph is ' ...
                'the average of all number of outward edges '...
                'connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function bool = is_global()
            bool = true;
        end
        function bool = is_nodal()
            bool = false;
        end
        function list = getCompatibleGraphList()  
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('OutDegreeAv');
        end
    end
end
