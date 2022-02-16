%% ¡header!
MultiplexTriangles < Measure (m, multiplex triangles) is the graph multiplex triangles.

%%% ¡description!
The multiplex triangles are calculated as the total number of a nodes neighbor 
pairs that are connected to each other between each pair of layers. 
In weighted graphs, the multiplex triangles are calculated as geometric mean 
of the weights of the edges forming the multiplex triangle.

%%% ¡seealso!
Measure

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexWU
MultiplexBU
MultiplexBUD
MultiplexBUT

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex triangles.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.) 
[l, ls] = g.layernumber();
N = g.nodenumber();

if l == 0
    value = {};
else
    multiplex_triangles = cell(length(ls), 1);
    count = 1;
    for p = 1:1:length(ls)
        multiplex_triangles_partition = zeros(N(1), 1);
        %for i=1:1:ls(p)-1
        for i = count:1:ls(p) + count - 2
            B11 = A{i, i};
            for j=i+1:1:ls(p)
                B22 = A{j, j};
                multiplex_triangles_partition = multiplex_triangles_partition + diag(B11.^(1/3)*B22.^(1/3)*B11.^(1/3) + B22.^(1/3)*B11.^(1/3)*B22.^(1/3));
            end
        end
        count = count + ls(p);
        multiplex_triangles(p) = {multiplex_triangles_partition};
    end
    value = multiplex_triangles;
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 0;
      1 0 0 0
      ];
B22 = [
      0 1 1 1;
      1 0 0 0;
      1 0 0 0;
      1 0 0 0
      ];
B = {B11 B22};

known_multiplex_triangles = {
                 [2 2 2 0]'
                 };      

g = MultiplexBU('B', B);
multiplex_triangles = MultiplexTriangles('G', g);

assert(isequal(multiplex_triangles.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexTriangles:' BRAPH2.BUG_ERR], ...
    'MultiplexTriangles is not being calculated correctly for MultiplexBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 0;
      1 0 0 0
      ];
B22 = [
      0 1 1 1;
      1 0 0 0;
      1 0 0 0;
      1 0 0 0
      ];
B = {B11 B22};

known_multiplex_triangles = {
                 [2 2 2 0]'
                 [0 0 0 0]'
                 };      

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
multiplex_triangles = MultiplexTriangles('G', g);

assert(isequal(multiplex_triangles.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexTriangles:' BRAPH2.BUG_ERR], ...
    'MultiplexTriangles is not being calculated correctly for MultiplexBUT.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
B11 = [
      0   .2  1   1;
      .2  0   1  0;
      1   1  0   0;
      1   0   0   0
      ];
B22 = [
      0   .2  1  .7;
      .2  0   0  0;
      1   0   0  0;
      .7  0   0  0
      ];
B = {B11 B22};

known_multiplex_triangles = {
                 diag(B11.^(1/3)*B22.^(1/3)*B11.^(1/3) + B22.^(1/3)*B11.^(1/3)*B22.^(1/3))
                 };      

g = MultiplexWU('B', B);
multiplex_triangles = MultiplexTriangles('G', g);

assert(isequal(multiplex_triangles.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexTriangles:' BRAPH2.BUG_ERR], ...
    'MultiplexTriangles is not being calculated correctly for MultiplexWU.')