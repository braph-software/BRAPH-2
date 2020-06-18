% test InDegreeAv
A = rand(randi(10));
B = {A A
    A A};

%% Test 1: Graph BD
g = GraphBD(A);
in_degree_av = InDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
A = max(A, A');
in_degree_test = sum(A, 2);
out_degree_test_av = {mean(in_degree_test)};

assert(isequal(in_degree_av.getValue(), out_degree_test_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for GraphBD')

%% Test 2: GraphWD
g = GraphWD(A);
in_degree_av = InDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A < 0) = 0;
A(A > 0) = 1;
A = max(A, A');
in_degree_test = sum(A, 2);
out_degree_test_av = {mean(in_degree_test)};

assert(isequal(in_degree_av.getValue(), out_degree_test_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for GraphWD')

%% Test 3: MultiplexGraphBD
g = MultiplexGraphBD(B);
in_degree_av = InDegreeAv(g);

in_degree_av_test = cell(2, 1);
for i=1:1:2
    Aii = B{i, i};
    Aii(1:length(Aii)+1:end) = 0;
    Aii(Aii<0) = 0;
    Aii = max(Aii, Aii');
    Aii(Aii>0) = 1;
    in_degree_test = sum(Aii, 2);
    in_degree_av_test(i) = {mean(in_degree_test)};
end

assert(isequal(in_degree_av.getValue(), in_degree_av_test), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultiplexGraphBU')

%% Test 4: MultiplexGraphWU
g = MultiplexGraphWD(B);
in_degree_av = InDegreeAv(g);

in_degree_av_test = cell(2, 1);
for i=1:1:2
    Aii = B{i, i};
    Aii(1:length(Aii)+1:end) = 0;
    Aii(Aii<0) = 0;
    Aii = max(Aii, Aii');
    Aii(Aii>0) = 1;
    in_degree_test = sum(Aii, 2);
    in_degree_av_test(i) = {mean(in_degree_test)};
end

assert(isequal(in_degree_av.getValue(), in_degree_av_test), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for MultiplexGraphWD')
