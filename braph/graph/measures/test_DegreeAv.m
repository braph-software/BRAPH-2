% test DegreeAv
A = rand(randi(10));

%% Test 1: Calculation GraphBU
g = GraphBU(A);
degree_av = DegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
A = max(A, A');
degree_test = sum(A, 2);
degree_av_test = mean(degree_test);

assert(isequal(degree_av.getValue(), degree_av_test), ...
    'BRAPH:DegreeAv:Bug', ...
    'DegreeAv is not beeing calculated correctly for GraphBU')

%% Test 2: Calculation GraphWU
g = GraphWU(A);
degree_av = DegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
A = max(A, A');
degree_test = sum(A, 2);
degree_av_test = mean(degree_test);

assert(isequal(degree_av.getValue(), degree_av_test), ...
    'BRAPH:DegreeAv:Bug', ...
    'DegreeAv is not beeing calculated correctly for GraphWU')
