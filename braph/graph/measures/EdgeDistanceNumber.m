classdef EdgeDistanceNumber < Distance
    methods
        function m = EdgeDistanceNumber(g, varargin)
            m = m@Distance(g, varargin{:});
        end
    end
    methods (Access=protected)
        function EDN = calculate(m)            
            if ~isempty(m.B)
              EDN = m.B;
            else
                d =  calculate@Distance(m);
            end
            
            EDN = m.B;
        end        
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'EdgeDistanceNumber';
        end
        function name = getName()
            name = 'EdgeDistanceNumber';
        end
        function description = getDescription()
            description = [ ...
                'The edge distance number of a graph is ' ...
                'number of edges in shortest weighted path matrix (Distance). ' ...
                ];
        end
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = false;
        end
        function bool = is_binodal()
            bool = true;
        end
        function list = getCompatibleGraphList()
            list = { ...              
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('EdgeDistanceNumber');
        end
    end
end