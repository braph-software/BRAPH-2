classdef ClusteringAv < Clustering
    methods
        function m = ClusteringAv(g, varargin)
            m = m@Clustering(g, varargin{:});
        end
    end
    methods (Access=protected)
        function clustering_av = calculate(m)
            
            g = m.getGraph();
            
            if g.is_measure_calculated('Clustering')
                clustering = g.getMeasureValue('Clustering');
            else
                clustering = calculate@Clustering(m);
            end
            
            clustering_av = mean(clustering);
        end
    end
    methods(Static)
         function measure_class = getClass()
            measure_class = 'ClusteringAv';
        end
        function name = getName()
            name = 'Average Clustering';
        end
        function description = getDescription()
            description = [ ...
                'The average clustering of a graph is ' ...
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
        function bool = is_binodal()
            bool = false;
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
            n = Measure.getCompatibleGraphNumber('ClusteringAv');
        end
    end
end
