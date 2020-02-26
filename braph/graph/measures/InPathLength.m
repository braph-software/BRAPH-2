classdef InPathLength < Measure
    methods
        function m = InPathLength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_pl =  calculate(m)
            g = m.getGraph();    
            
            settings = g.getSettings();
            if g.is_measure_calculated('Distance')
                D = g.getMeasureValue('Distance');
            else
                D = Distance(g, settings{:}).getValue();
            end
            
            N = g.nodenumber();
            in_pl = zeros(N, 1);
            
            settings = m.getSettings();
            pathLength_rule = get_from_varargin(0, 'InPathLengthAvRule', settings{:});
            switch lower(pathLength_rule)
                case {'subgraphs'}                    
                    for u = 1:1:N
                        Du = D(:, u);
                        in_pl(u) = mean(Du(Du~=0 & Du~=Inf));
                    end
                case {'harmonic'}
                    for u = 1:1:N
                        Du = D(:, u);
                        in_pl(u) = harmmean(Du(Du~=0));
                    end
                otherwise
                    for u = 1:1:N
                        Du = D(:, u);
                        in_pl(u) = mean(Du(Du~=0));
                    end
            end
            in_pl(isnan(in_pl)) = Inf;
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
              'in path lengths of one node to all ' ...
              'other nodes. ' ...
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