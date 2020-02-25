classdef OutPathLengthAv < OutPathLength
    methods
        function m = OutPathLengthAv(g, varargin)
           m = m@OutPathLength(g, varargin {:});
        end
    end
    methods (Access=protected)
        function outplav = calculate(m)            
            g = m.getGraph();
            
            if g.is_measure_calculated('OutPathLength')
                outpathLength = g.getMeasureValue('OutPathLength');
            else
                outpathLength = calculate@OutPathLength(m);
            end
  
            outplav =mean(outpathLength(outpathLength~=Inf));
        end
    end
     methods(Static)
         function measure_class = getClass()
            measure_class = 'OutPathLengthAv';
        end
        function name = getName()
            name = 'Average OutPathLength';
        end
        function description = getDescription()
            description = [ ...
                'The average out path length of a graph is ' ...
                'the average of the sum of the out path lengths ' ...                
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
            n = Measure.getCompatibleGraphNumber('OutPathLengthAv');
        end
    end
end