classdef InDegree < Measure
    %Degree measure, mainly for BD / WD
    properties

        indeg

    end
    methods
        function ind = Degree(g,varargin)
           ind = m@Measure(g,varargin);
        end
    end
    methods(Access = protected)
        function calculate()
             if isempty(ind.g.deg) || isempty(ind.g.indeg) || isempty(ind.g.outdeg)
               %  matrix is already created with this properties check with
               %  giovanni
               %  A = double(d.g.A~=0);  % binarizes connection matrix
               %  A = Graph.removediagonal(A); 
                
                ind.g.indeg = sum(ind.A,1);  %  indegree = column sum of A             
             end           
          
            ind.indeg = ind.g.indeg;
           
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
                 bool = false; 
            else
                bool = true;
            end
            
            
        end
        function bool = compatible_graph_list()  
            bool = true;  % HUmm..... ?? Incomplete
        end
    end    
end