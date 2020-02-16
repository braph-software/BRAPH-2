% test OutDegreeAv
A = rand(randi(10));

%% Test 1: Calculation GraphBD
g = GraphBD(A);
out_degree_av = OutDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
out_degree_test =  sum(A, 2);
out_degree_av_test = mean(out_degree_test);

assert(isequal(out_degree_av.getValue(), out_degree_av_test), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not beeing calculated correctly for GraphBD')

%% Test 2: Calculation GraphWD
g = GraphWD(A);
out_degree_av = OutDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
out_degree_test =  sum(A, 2);
out_degree_av_test = mean(out_degree_test);

assert(isequal(out_degree_av.getValue(), out_degree_av_test), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not beeing calculated correctly for GraphWD')
