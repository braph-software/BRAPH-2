% test DegreeAv
A = rand(randi(10));
B = {A, A; A, A};

%% Test 1: Calculation GraphBU
g = GraphBU(A);
degree_av = DegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
A = max(A, A');
degree_test = sum(A, 2);
degree_av_test = {mean(degree_test)};

assert(isequal(degree_av.getValue(), degree_av_test), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for GraphBU')

%% Test 2: Calculation GraphWU
g = GraphWU(A);
degree_av = DegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
A = max(A, A');
degree_test = sum(A, 2);
degree_av_test = {mean(degree_test)};

assert(isequal(degree_av.getValue(), degree_av_test), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for GraphWU')

%% Test 3: Calculation MultiplexGraphBU
g = MultiplexGraphBU(B);
degree_av = DegreeAv(g);

degree_av_test = cell(2, 1);
for i=1:1:2
    Aii = B{i, i};
    Aii(1:length(Aii)+1:end) = 0;
    Aii(Aii<0) = 0;
    Aii = max(Aii, Aii');
    Aii(Aii>0) = 1;
    degree_test = sum(Aii, 2);
    degree_av_test(i) = {mean(degree_test)};
end

assert(isequal(degree_av.getValue(), degree_av_test), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultiplexGraphBU')

%% Test 4: Calculation MultiplexGraphWU
g = MultiplexGraphWU(B);
degree_av = DegreeAv(g);

degree_av_test = cell(2, 1);
for i=1:1:2
    Aii = B{i, i};
    Aii(1:length(Aii)+1:end) = 0;
    Aii(Aii<0) = 0;
    Aii = max(Aii, Aii');
    Aii(Aii>0) = 1;
    degree_test = sum(Aii, 2);
    degree_av_test(i) = {mean(degree_test)};
end

assert(isequal(degree_av.getValue(), degree_av_test), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultiplexGraphWU')
