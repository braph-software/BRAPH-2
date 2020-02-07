classdef Degree < Measure
    %Degree measure, mainly for BU / WU
    properties
        deg
        indeg
        outdeg
    end
    methods
        function d = Degree(g,varargin)
           d = m@Measure(g,varargin);
        end
    end
    methods(Access = protected)
        function calculate()
             if isempty(d.g.deg) || isempty(d.g.indeg) || isempty(d.g.outdeg)
               % matrix is already created with this properties check with
               % giovanni
                 % A = double(d.g.A~=0);  % binarizes connection matrix
               % A = Graph.removediagonal(A); 
                
                d.g.indeg = sum(d.A,1);  % indegree = column sum of A
                d.g.outdeg = sum(d.A,2)';  % outdegree = row sum of A
                d.g.deg = d.g.indeg + d.g.outdeg;  % degree = indegree + outdegree
            end
            
            d.deg = d.g.deg / 2; %  As braph 1
            d.indeg = d.g.indeg;
            d.outdeg = d.g.outdeg;
        end
    end
    methods (Static)
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end

        function bool = is_compatible_graph()
            if d.g.is_undirected()
                 bool = true; 
            else
                bool = false;
            end
            
            
        end
        function bool = compatible_graph_list()  
            bool = true;  % HUmm..... ?? Incomplete
        end
    end    
end