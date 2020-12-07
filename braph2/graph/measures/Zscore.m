function [z,zin,zout] = zscore(g)
            % ZSCORE within module degree z-score
            %
            % [Z, ZIN, ZOUT] = ZSCORE(G) calculates the within-module degree z-score Z,
            %   in-z-score ZIN and out-z-score ZOUT of nodes included in graph G.
            %   Before the z-score can be calculated, a custom structure should be provided 
            %   as input to the graph, or alternatively the function G.structure() should be 
            %   called to calculate the optimized community structure.
            %   
            % The within-module degree z-score is a within-module version of degree
            %   centrality. It measures how well a node is connected to the other
            %   nodes in the same community.
            %
            % See also Graph, Structure.
            
            if isempty(g.z)
                W = g.A+g.A.';
                
                N = length(W);
                Ci = g.structure();
                Z = zeros(1,N);
                for i = 1:1:max(Ci)
                    Koi = sum(W(Ci==i,Ci==i),2);
                    Z(Ci==i) = (Koi-mean(Koi))./std(Koi);
                end
                
                Z(isnan(Z)) = 0;
                
                g.z = Z;
            end
            
            if nargout>1 && isempty(g.zin)
                W = g.A;
                
                N = length(W);
                Ci = g.structure();
                Z = zeros(1,N);
                for i = 1:1:max(Ci)
                    Koi = sum(W(Ci==i,Ci==i),2);
                    Z(Ci==i) = (Koi-mean(Koi))./std(Koi);
                end
                
                Z(isnan(Z)) = 0;
                
                g.zin = Z;
            end
            
            if nargout>2 && isempty(g.zout)
                W = g.A.';
                
                N = length(W);
                Ci = g.structure();
                Z = zeros(1,N);
                for i = 1:1:max(Ci)
                    Koi = sum(W(Ci==i,Ci==i),2);
                    Z(Ci==i) = (Koi-mean(Koi))./std(Koi);
                end
                
                Z(isnan(Z)) = 0;
                
                g.zout = Z;
            end
            
            z = g.z;
            zin = g.zin;
            zout = g.zout;
end