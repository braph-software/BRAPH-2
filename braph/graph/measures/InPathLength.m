classdef InPathLength < Measure
    methods
        function m = InPathLength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_path_length =  calculate(m)
            g = m.getGraph();    

            if g.is_measure_calculated('Distance')
                distance = g.getMeasureValue('Distance');
            else
                distance = Distance(g, g.getSettings()).getValue();
            end
            
            N = g.nodenumber();
            in_path_length = zeros(N, 1);

            pathLength_rule = get_from_varargin(0, 'InPathLengthAvRule', g.getSettings());
            switch lower(pathLength_rule)
                case {'subgraphs'}                    
                    for u = 1:1:N
                        Du = distance(:, u);
                        in_path_length(u) = mean(Du(Du~=0 & Du~=Inf));
                    end
                    in_path_length(isnan(in_path_length)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
                case {'harmonic'}
                    for u = 1:1:N
                        Du = distance(:, u);
                        in_path_length(u) = harmmean(Du(Du~=0));
                    end
                otherwise
                    for u = 1:1:N
                        Du = distance(:, u);
                        in_path_length(u) = mean(Du(Du~=0));
                    end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'InPathLength';
        end
        function name = getName()
            name = 'In Path Length';
        end
        function description = getDescription()
            description = [ ...                
              'The in path length is the average shortest ' ...
              'in path lengths of one node to all other nodes.' ...
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
            n = Measure.getCompatibleGraphNumber('InPathLength');
        end
    end
end