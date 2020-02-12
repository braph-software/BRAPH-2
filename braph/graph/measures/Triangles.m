classdef Triangles < Measure
    methods
        function m = Triangles(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function calculate(m)
            g = m.getGraph();
            A = g.getA();
            N = g.nodenumber();
            if isa(g, 'GraphBU') || isa(g, 'GraphWU')
                A3 = (A.^(1/3))^3;
                clustering = diag(A3)'/2;
                clustering(isnan(clustering)) = 0; % Should return zeros, not nan
                m.setValue(clustering');
            elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')
                clustering = zeros(1,N);
                W = A.^(1/3); % No imaginary numbers for negative matrix, Binary matrix won't change
                for u = 1:1:N
                    nodesout = find(W(u,:));
                    nodesin = find(W(:,u))';
                    if ~isempty(nodesout) && ~isempty(nodesin)
                        % We have a triangle if one of the out nodes goes to the one of the in nodes
                        % u--> out-node --> in-node --> u
                        temp_num = W(u,nodesout)*W(nodesout,nodesin)*W(nodesin,u);
                        clustering(u) = sum(sum(temp_num));
                    end
                end
                m.setValue(clustering');
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Triangles';
        end
        function name = getName()
            name = 'Triangles';
        end
        function description = getDescription()
            description = [ ...
                'The triangles of a node are ' ...
                'the number of its neighbor pairs' ...
                'that are connected to each other. ' ...
                'In weighted graphs, the triangles are calculated' ...
                'as geometric mean of the weights of the edges' ...
                'forming the triangle.' ...
                ];
        end
        function bool = is_global()
            
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function list = getCompatibleGraphList()
            list = { ...
                'GraphBD' ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('Triangles');
        end
    end
end
