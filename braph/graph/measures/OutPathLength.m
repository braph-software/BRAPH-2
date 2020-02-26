classdef OutPathLength < Measure
    methods
        function m = OutPathLength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_pl =  calculate(m)
            g = m.getGraph();
            D = g.getMeasure('Distance').getValue();
            N = g.nodenumber();
            out_pl = zeros(N, 1);
            
            settings = m.getSettings();
            pathLength_rule = get_from_varargin(0, 'OutPathLengthAvRule', settings{:});
            switch lower(pathLength_rule)
                case {'subgraphs'}
                    for u = 1:1:N
                        Du = D(u, :);
                        out_pl(u) = mean(Du(Du~=0 & Du~=Inf));
                    end
                case {'harmonic'}
                    for u = 1:1:N
                        Du = D(u, :);
                        out_pl(u) = harmmean(Du(Du~=0));
                    end
                otherwise
                    for u = 1:1:N
                        Du = D(u, :);
                        out_pl(u) = mean(Du(Du~=0));
                    end
            end
            out_pl(isnan(out_pl))=Inf;
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutPathLength';
        end
        function name = getName()
            name = 'OutPathLength';
        end
        function description = getDescription()
            description = [ ...
                'The out path length is the average shortest ' ...
                'out path lengths of one node to all ' ...
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
            n = Measure.getCompatibleGraphNumber('OutPathLength');
        end
    end
end