classdef OutDegree < Measure
    %Degree measure, mainly for BD / WD
    properties

        outdeg

    end
    methods
        function outd = Degree(g,varargin)
           outd = m@Measure(g,varargin);
        end
    end
    methods(Access = protected)
        function calculate()
             if isempty(outd.g.deg) || isempty(outd.g.indeg) || isempty(outd.g.outdeg)
               %  matrix is already created with this properties check with
               %  giovanni
               %  A = double(d.g.A~=0);  % binarizes connection matrix
               %  A = Graph.removediagonal(A); 
                
               outd.g.outdeg = sum(outd.A,2)';  % outdegree = row sum of A           
             end           
          
            outd.indeg = outd.g.indeg;
           
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