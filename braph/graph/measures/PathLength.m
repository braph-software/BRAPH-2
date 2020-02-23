classdef PathLength < Measure
    properties
        pathLengthOut
        pathLengthIn
    end
    methods
        function m = PathLength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function P =  calculate(m)
            g = m.getGraph();
            D = g.getMeasure('Distance').getValue();
            D = dediagonalize(D);            
            N = g.nodenumber();
            Dout = D;
            
            m.pathLengthIn = zeros(1, N);
            
            in_cond1 = D(:,1)==Inf;  % locates all not connected nodes           
            D(in_cond1,:) = [];  % removes conditions          
            m.pathLengthIn= mean(D,1);
            
            out_cond1 = Dout(1, :) == Inf;  % locates all not connected nodes      
            Dout(:,out_cond1 ) = [];  % removes conditions
            m.pathLengthOut =mean(Dout,2)';           
            
            P = mean([m.pathLengthIn; m.pathLengthOut], 1);
        end
    end
     methods (Static)
        function measure_class = getClass()
            measure_class = 'PathLength';
        end
        function name = getName()
            name = 'PathLength';
        end
        function description = getDescription()
            description = [ ...                
              'The path length is the average shortest path lengths of one node to all ' ...
              'other nodes. The path length of a node is the average of the in-path ' ...
              'and out-path length of that node. ' ...
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
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('PathLength');
        end
    end
end