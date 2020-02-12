classdef InDegreeAv < InDegree
    methods
        function m = InDegreeAv(g, varargin)
            m = m@InDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function calculate(m)

            g = m.getGraph();

            if g.is_measure_calculated('InDegree')
                in_degree = g.getMeasureValue('InDegree');
            else
                calculate@InDegree(g);
                in_degree = m.value;
            end
            
            in_degree_av = mean(in_degree);
            m.setValue(in_degree_av);
        end
    end
    methods(Static)
         function measure_class = getClass()
            measure_class = 'InDegreeAv';
        end
        function name = getName()
            name = 'Average In Degree';
        end
        function description = getDescription()
            description = [ ...
                'The average of in degrees of a graph is ' ...
                'the average of all number of inward edges '...
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
            n = Measure.getCompatibleGraphNumber('InDegreeAv');
        end
    end
end
