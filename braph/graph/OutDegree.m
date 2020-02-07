classdef OutDegree < Measure
    %Degree measure, mainly for BD / WD
    properties

        outdeg

    end
    methods
        function outd = OutDegree(g,varargin)
           outd = outd@Measure(g,varargin);
        end
    end
     methods
        function  val = getValue(obj)
             if isempty(obj.deg)
                obj.calculate();
            end
            
           val =  obj.deg;
        end
    end
    
    methods(Access = protected)
        function calculate(g)
             if isempty(obj.outdeg)
               %  matrix is already created with this properties check with
               %  giovanni
               %  A = double(d.g.A~=0);  % binarizes connection matrix
               %  A = Graph.removediagonal(A); 
                
               int_outdeg = sum(obj.A,2)';  % outdegree = row sum of A           
             end           
          
            obj.outd = int_outdeg;
           
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