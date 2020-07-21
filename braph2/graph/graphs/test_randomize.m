% test Randomization

class_graph_list = {'MultiplexGraphBD', 'MultiplexGraphBU'};

%% Test 1: Simple test
for j = 1:1:100
    for i = 1:1:length(class_graph_list)
        graph_class = class_graph_list{i};
        g = Graph.getGraph(graph_class, []);
        r_g = g.randomize();              
    end
end

%% Test 2 randperm message and input hunt
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
                for l = 1:1:size(A, 1)
                    for s = 1:1:size(A, 2)
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