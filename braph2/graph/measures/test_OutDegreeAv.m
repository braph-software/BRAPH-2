% test OutDegreeAv
A = rand(randi(10));
B = {A A
    A A};

%% Test 1: Graph BD
g = GraphBD(A);
out_degree_av = OutDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
A = max(A, A');
out_degree_test = sum(A, 2);
out_degree_test_av = {mean(out_degree_test)};

assert(isequal(out_degree_av.getValue(), out_degree_test_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for GraphBD')

%% Test 2: GraphWD
g = GraphWD(A);
out_degree_av = OutDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A < 0) = 0;
A(A > 0) = 1;
A = max(A, A');
out_degree_test = sum(A, 2);
out_degree_test_av = {mean(out_degree_test)};

assert(isequal(out_degree_av.getValue(), out_degree_test_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for GraphWD')

%% Test 3: MultiplexGraphBD
g = MultiplexGraphBD(B);
out_degree_av = OutDegreeAv(g);

out_degree_av_test = cell(2, 1);
for i=1:1:2
    Aii = B{i, i};
    Aii(1:length(Aii)+1:end) = 0;
    Aii(Aii<0) = 0;
    Aii = max(Aii, Aii');
    Aii(Aii>0) = 1;
    out_degree_test = sum(Aii, 2);
    out_degree_av_test(i) = {mean(out_degree_test)};
end

assert(isequal(out_degree_av.getValue(), out_degree_av_test), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultiplexGraphBU')

%% Test 4: MultiplexGraphWU
g = MultiplexGraphWD(B);
out_degree_av = OutDegreeAv(g);

out_degree_av_test = cell(2, 1);
for i=1:1:2
    Aii = B{i, i};
    Aii(1:length(Aii)+1:end) = 0;
    Aii(Aii<0) = 0;
    Aii = max(Aii, Aii');
    Aii(Aii>0) = 1;
    out_degree_test = sum(Aii, 2);
    out_degree_av_test(i) = {mean(out_degree_test)};
end

assert(isequal(out_degree_av.getValue(), out_degree_av_test), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for MultiplexGraphWD')
