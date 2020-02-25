classdef InPathLengthAv < InPathLength
    methods
        function m = InPathLengthAv(g, varargin)
           m = m@InPathLength(g, varargin {:});
        end
    end
    methods (Access=protected)
        function inplav = calculate(m)            
            g = m.getGraph();
            
            if g.is_measure_calculated('InPathLength')
                inpathLength = g.getMeasureValue('InPathLength');
            else
                inpathLength = calculate@InPathLength(m);
            end
  
            inplav =mean(inpathLength(inpathLength~=Inf));
        end
    end
     methods(Static)
         function measure_class = getClass()
            measure_class = 'InPathLengthAv';
        end
        function name = getName()
            name = 'Average InPathLength';
        end
        function description = getDescription()
            description = [ ...
                'The average in path length of a graph is ' ...
                'the average of the sum of the in path lengths ' ...                
                ];
        end
        function bool = is_global()
            
            bool = true;
        end
        function bool = is_nodal()
            bool = false;
        end
        function bool = is_binodal()
            bool = false;
        end
        function list = getCompatibleGraphList()  
            list = { ...
                'GraphWD', ...
                'GraphBD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('InPathLengthAv');
        end
    end
end