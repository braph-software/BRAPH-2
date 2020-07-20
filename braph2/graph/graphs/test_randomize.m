% test Randomization

class_graph_list = {'MultiplexGraphBU'};

%% test 1 randperm
for j = 1:1:1000
    A = {
                    symmetrize(round(rand(4)))  round(diag(rand(4, 1)))     round(diag(rand(4, 1)))	
                    round(diag(rand(4, 1)))     symmetrize(round(rand(4))) 	round(diag(rand(4, 1)))	
                    round(diag(rand(4, 1)))     round(diag(rand(4, 1)))     symmetrize(round(rand(4)))   
                    };
                
    for i = 1:1:length(class_graph_list)
        class_graph = class_graph_list{i};
        g = Graph.getGraph(class_graph, A);
        try
            r_g = g.randomize();
        catch ME         
            try
                for l = 1:1:3
                    for s = 1:1:3
                        GraphBU.randomize_A(A{l,s});
                    end                    
                end                    
            catch ex
                disp(ex)
                disp(A{l, s})
            end
        end
    end
end