classdef DegreeAv < Degree
    methods
        function m = DegreeAv(g, varargin)
            m = m@Degree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function calculate(m)
            
            g = m.getGraph();
            
            if g.is_measure_calculated('Degree')
                degree = g.getMeasureValue('Degree');
            else
                calculate@Degree(g);
                degree = m.value;
            end
            
            degree_av = mean(degree);
            m.setValue(degree_av);
        end
    end
    methods(Static)
         function measure_class = getClass()
            measure_class = 'DegreeAv';
        end
        function name = getName()
            name = 'Average Degree';
        end
        function description = getDescription()
            description = [ ...
                'The average degree of a graph is ' ...
                'the average of all number of edges connected to the node. ' ...
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
                'GraphBU', ...
                'GraphWU' ...
                };
        end
    end
end
