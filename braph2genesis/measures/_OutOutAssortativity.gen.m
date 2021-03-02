%% ¡header!
OutOutAssortativity < Measure (m, out-out-assortativity) is the graph out-out-assortativity.

%%% ¡description!
The out-out-assortativity coefficient of a graph is the correlation coefficient between
the degrees/strengths of all nodes on two opposite ends of an edge within a layer.
The corresponding coefficient for directed and weighted networks is calculated by using
the weighted and directed variants of out-degree/out-strength.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphWD
MultiplexBD
MultiplexWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the out-out-assortativity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = g.nodenumber();
out_out_assortativity = cell(L, 1);
connectivity_types = g.getConnectivityType(L);    
for li = 1:1:L
    
    Aii = A{li, li};
    connectivity_type = connectivity_types(li, li);
    [i, j] = find(Aii ~= 0);  % nodes [i, j]
    M = length(i);  % Number of edges
    k_i = zeros(M, L);
    k_j = zeros(length(j), L);
    
    if connectivity_type == Graph.WEIGHTED  % weighted graphs
        out_strength = OutStrength('G', g).get('M');
        d = out_strength{li};
    else  % binary graphs
        out_degree = OutDegree('G', g).get('M');
        d= out_degree{li};
    end
    
    k_i(:, li) = d(i);  % in-degree/in-strength node i
    k_j(:, li) = d(j);  % in-degree/in-strength node j
    % compute assortativity
    assortativity_layer = (sum(k_i(:, li) .* k_j(:, li)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2)...
        / (sum(0.5 * (k_i(:, li).^2 + k_j(:, li).^2)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2);
    assortativity_layer(isnan(assortativity_layer)) = 0;  % Should return zeros, not NaN
    
    out_out_assortativity(li) = {assortativity_layer};
end

value = out_out_assortativity;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
A = [
    0  1  0  0  0;
    0  0  1  0  0;
    0  0  0  1  0;
    0  1  0  0  1;
    1  0  0  1  0
    ];

known_out_out_assortativity = {(16/7-(21/14)^2)/(35/14-(21/14)^2)};

g = GraphBD('B', A);
out_out_assortativity = OutOutAssortativity('G', g).get('M');

assert(isequal(out_out_assortativity, known_out_out_assortativity), ...
    [BRAPH2.STR ':OutOutAssortativity:' BRAPH2.BUG_ERR], ...
    'OutOutAssortativity is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
A = [
    0  2  0  0  0;
    0  0  3  0  0;
    0  0  0  1  0;
    0  2  0  0  2;
    1  0  0  2  0
    ];

known_out_out_assortativity = {(16/7-(21/14)^2)/(35/14-(21/14)^2)};

g = GraphWD('B', A);
out_out_assortativity = OutOutAssortativity('G', g).get('M');

assert(isequal(out_out_assortativity, known_out_out_assortativity), ...
    [BRAPH2.STR ':OutOutAssortativity:' BRAPH2.BUG_ERR], ...
    'OutOutAssortativity is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
A11 = [
      0  1  0  0  0;
      0  0  1  0  0;
      0  0  0  1  0;
      0  1  0  0  1;
      1  0  0  1  0
    ];

A22 = [
      0  1  0  0  0;
      0  0  1  0  0;
      0  0  0  1  0;
      0  1  0  0  1;
      1  0  0  1  0
    ];
A = {A11 A22};
             
known_out_out_assortativity = {
                    (16/7-(21/14)^2)/(35/14-(21/14)^2)
                    (16/7-(21/14)^2)/(35/14-(21/14)^2)
                    };    

g = MultiplexBD('B', A);
out_out_assortativity = OutOutAssortativity('G', g).get('M');

assert(isequal(out_out_assortativity, known_out_out_assortativity), ...
    [BRAPH2.STR ':OutOutAssortativity:' BRAPH2.BUG_ERR], ...
    'OutOutAssortativity is not being calculated correctly for MultiplexBD.')


%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
A11 = [
       0  2  0  0  0;
       0  0  3  0  0;
       0  0  0  1  0;
       0  2  0  0  2;
       1  0  0  2  0
    ];
A22 = [
       0  2  0  0  0;
       0  0  3  0  0;
       0  0  0  1  0;
       0  2  0  0  2;
       1  0  0  2  0
    ];
A = {A11 A22};

known_out_out_assortativity = {
                    (16/7-(21/14)^2)/(35/14-(21/14)^2)
                    (16/7-(21/14)^2)/(35/14-(21/14)^2)
                    };   

g = MultiplexWD('B', A);
out_out_assortativity = OutOutAssortativity('G', g).get('M');

assert(isequal(out_out_assortativity, known_out_out_assortativity), ...
    [BRAPH2.STR ':OutOutAssortativity:' BRAPH2.BUG_ERR], ...
    'OutOutAssortativity is not being calculated correctly for MultiplexWD.')


%%% ¡test!
%%%% ¡name!
Comparison with standard method for BD graphs
%%%% ¡code!
A = rand(randi(10));
g = GraphBD('B', A);

out_out_assortativity = OutOutAssortativity('G', g).get('M');
known_out_out_assortativity = {assortativity_standard_BD(cell2mat(g.get('A')))};  

assert(isequal(out_out_assortativity, known_out_out_assortativity), ...
    [BRAPH2.STR ':OutOutAssortativity:' BRAPH2.BUG_ERR], ...
    'OutOutAssortativity is not being calculated correctly for BCT.')

%%% ¡test!
%%%% ¡name!
Comparison with standard method for WD graphs
%%%% ¡code!
A = rand(randi(10));
g = GraphWD('B', A);

out_out_assortativity = OutOutAssortativity('G', g).get('M');
known_out_out_assortativity = {assortativity_standard_WD(cell2mat(g.get('A')))}; 

assert(isequal(out_out_assortativity, known_out_out_assortativity), ...
    [BRAPH2.STR ':OutOutAssortativity:' BRAPH2.BUG_ERR], ...
    'OutOutAssortativity is not being calculated correctly for BCT.')

%% Functions to calculate clustering adapted from 2019_03_03_BCT
function stdvalue_BD = assortativity_standard_BD(A)
% directed version
[id,od] = degrees_dir(A);
[i,j] = find(A>0);
K = length(i);
degi = od(i);
degj = od(j);
% compute assortativity
stdvalue_BD = ( sum(degi.*degj)/K - (sum(0.5*(degi+degj))/K)^2 ) / ...
    ( sum(0.5*(degi.^2+degj.^2))/K - (sum(0.5*(degi+degj))/K)^2 );
stdvalue_BD(isnan(stdvalue_BD)) = 0;  % Should return zeros, not NaN
end

function stdvalue_WD = assortativity_standard_WD(A)
% directed version
[is,os] = strengths_dir(A);
[i,j] = find(A>0);
K = length(i);
stri = os(i);
strj = os(j);
% compute assortativity
stdvalue_WD = ( sum(stri.*strj)/K - (sum(0.5*(stri+strj))/K)^2 ) / ...
    ( sum(0.5*(stri.^2+strj.^2))/K - (sum(0.5*(stri+strj))/K)^2 );
stdvalue_WD(isnan(stdvalue_WD)) = 0;  % Should return zeros, not NaN
end

function [id,od,deg] = degrees_dir(A)
id = sum(A,1);    % indegree = column sum of CIJ
od = sum(A,2)';   % outdegree = row sum of CIJ
deg = id+od;        % degree = indegree+outdegree
end

function [is,os,str] = strengths_dir(A)
is = sum(A,1);    % instrength = column sum of CIJ
os = sum(A,2)';   % outstrength = row sum of CIJ
str = is+os;        % strength = instrength+outstrength
end