% test InDegreeAv

%% Test 1: Graph BD
A = rand(3);
known_indegree_av = {mean([2 2 2])};
g = GraphBD(A);
in_degree_av = InDegreeAv(g);


assert(isequal(in_degree_av.getValue(), known_indegree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for GraphBD')

%% Test 2: GraphWD
A = rand(3);
known_indegree_av = {mean([2 2 2])};
g = GraphWD(A);
in_degree_av = InDegreeAv(g);

assert(isequal(in_degree_av.getValue(), known_indegree_av), ...
    [BRAPH2.STR ':InDegreeAv:' BRAPH2.BUG_ERR], ...
    'InDegreeAv is not being calculated correctly for GraphWD')

%% Test 3: MultiplexGraphBD
A = rand(3);
B = eye(3);
C = [A B
     B A];
 
known_indegree_av = {
    mean([2 2 2])
    mean([2 2 2])
    };

g = MultiplexGraphBD(C);
in_degree_av = InDegreeAv(g);


assert(isequal(in_degree_av.getValue(), known_indegree_av), ...
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
