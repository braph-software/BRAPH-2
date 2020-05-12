% test GraphWU
A = rand(randi(10));

% %% Test 1: Constructor
% g = GraphWU(A);
% 
% A = dediagonalize(A);
% A = semipositivize(A);
% A = symmetrize(A);    
% 
% assert(isequal(g.getA(), A), ...
%        'BRAPH:GraphWU:Bug', ...
%        'GraphWU is not constructing well')
