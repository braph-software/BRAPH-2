% test Degree
A = rand(randi(10));
B = {
    A   A
    A   A
    };

%% Test 1: Calculation GraphBU
g = GraphBU(A);
degree = Degree(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A = max(A, A');
A(A>0) = 1;
degree_test = {sum(A, 2)};

assert(isequal(degree.getValue(), degree_test), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for GraphBU')

%% Test 2: Calculation GraphWU
g = GraphWU(A);
degree = Degree(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A = max(A, A');
A(A>0) = 1;
degree_test = {sum(A, 2)};

assert(isequal(degree.getValue(), degree_test), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for GraphWU')

%% Test 3: Calculation MultiplexGraphBU
g = MultiplexGraphBU(B);
degree = Degree(g);

degree_test = cell(2, 1);
for i=1:1:2
    Aii = B{i, i};
    Aii(1:length(Aii)+1:end) = 0;
    Aii(Aii<0) = 0;
    Aii = max(Aii, Aii');
    Aii(Aii>0) = 1;
    degree_test(i) = {sum(Aii, 2)};
end

assert(isequal(degree.getValue(), degree_test), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for MultiplexGraphBU')

%% Test 4: Calculation MultiplexGraphWU
g = MultiplexGraphWU(B);
degree = Degree(g);

degree_test = cell(2, 1);
for i=1:1:2
    Aii = B{i, i};
    Aii(1:length(Aii)+1:end) = 0;
    Aii(Aii<0) = 0;
    Aii = max(Aii, Aii');
    Aii(Aii>0) = 1;
    degree_test(i) = {sum(Aii, 2)};
end

assert(isequal(degree.getValue(), degree_test), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for MultiplexGraphWU')