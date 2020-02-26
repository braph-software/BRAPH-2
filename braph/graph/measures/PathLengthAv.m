classdef PathLengthAv < PathLength
    methods
        function m = PathLengthAv(g, varargin)
           m = m@PathLength(g, varargin {:});
        end
    end
    methods (Access=protected)
        function plav = calculate(m)            
            g = m.getGraph();
            
            if g.is_measure_calculated('PathLength')
                pl = g.getMeasureValue('PathLength');
            else
                pl = calculate@PathLength(m);
            end
  
            plav = mean(pl);
        end
    end
     methods(Static)
         function measure_class = getClass()
            measure_class = 'PathLengthAv';
        end
        function name = getName()
            name = 'Average Path Length';
        end
        function description = getDescription()
            description = [ ...
                'The average path length of a graph is ' ...
                'the average of the sum of the path lengths ' ...                
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
                'GraphWU', ...
                'GraphBU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('PathLengthAv');
        end
    end
end