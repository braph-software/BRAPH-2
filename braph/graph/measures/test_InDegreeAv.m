% test InDegreeAv
A = rand(randi(10));

%% Test 1: InDegreeAv calculates correctly for GraphBD
g = GraphBD(A);
in_degree_av = InDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
in_degree_test =  sum(A, 1)';
in_degree_av_test = mean(in_degree_test);

assert(isequal(in_degree_av.getValue(), in_degree_av_test), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not beeing calculated correctly for GraphBD')

%% Test 2: InDegreeAv calculates correctly for GraphWD
g = GraphWD(A);
in_degree_av = InDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
in_degree_test =  sum(A, 1)';
in_degree_av_test = mean(in_degree_test);

assert(isequal(in_degree_av.getValue(), in_degree_av_test), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not beeing calculated correctly for GraphWD')
