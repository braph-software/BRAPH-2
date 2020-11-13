% test OutInAssortativity

%% Test 1: GraphBD
A = [
    0  1  0  0  0;
    0  0  1  0  0;
    0  0  0  1  0;
    0  1  0  0  1;
    1  0  0  1  0];

known_out_in_assortativity = {(17/7-(11/7)^2)/(19/7-(11/7)^2)};


g = GraphBD(A);
out_in_assortativity = OutInAssortativity(g);

assert(isequal(out_in_assortativity.getValue(), known_out_in_assortativity), ...
    [BRAPH2.STR ':OutInAssortativity:' BRAPH2.BUG_ERR], ...
    'OutInAssortativity is not being calculated correctly for GraphBD.')

%% Test 2: GraphWD
A = [
    0  2  0  0  0;
    0  0  3  0  0;
    0  0  0  1  0;
    0  2  0  0  2;
    1  0  0  2  0];

known_out_in_assortativity = {(17/7-(11/7)^2)/(19/7-(11/7)^2)};

g = GraphWD(A);
out_in_assortativity = OutInAssortativity(g);

assert(isequal(out_in_assortativity.getValue(), known_out_in_assortativity), ...
    [BRAPH2.STR ':OutInAssortativity:' BRAPH2.BUG_ERR], ...
    'OutInAssortativity is not being calculated correctly for GraphWD.')

%% Test 3: MultiplexGraphBD
A11 = [
      0  1  0  0  0;
      0  0  1  0  0;
      0  0  0  1  0;
      0  1  0  0  1;
      1  0  0  1  0];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0  1  0  0  0;
      0  0  1  0  0;
      0  0  0  1  0;
      0  1  0  0  1;
      1  0  0  1  0];
A = {
    A11     A12
    A21     A22
    };

known_out_in_assortativity = {
                    (17/7-(11/7)^2)/(19/7-(11/7)^2)
                    (17/7-(11/7)^2)/(19/7-(11/7)^2)
                    };

g = MultiplexGraphBD(A);
out_in_assortativity = OutInAssortativity(g);

assert(isequal(out_in_assortativity.getValue(), known_out_in_assortativity), ...
    [BRAPH2.STR ':OutInAssortativity:' BRAPH2.BUG_ERR], ...
    'OutInAssortativity is not being calculated correctly for MultiplexGraphBD.')

%% Test 4: MultiplexGraphWD
A11 = [
       0  2  0  0  0;
       0  0  3  0  0;
       0  0  0  1  0;
       0  2  0  0  2;
       1  0  0  2  0];
A12 = eye(5);
A21 = eye(5);
A22 = [
       0  2  0  0  0;
       0  0  3  0  0;
       0  0  0  1  0;
       0  2  0  0  2;
       1  0  0  2  0];

A = {
    A11     A12
    A21     A22
    };

known_out_in_assortativity = {
                    (17/7-(11/7)^2)/(19/7-(11/7)^2)
                    (17/7-(11/7)^2)/(19/7-(11/7)^2)
                    };

g = MultiplexGraphWD(A);
out_in_assortativity = OutInAssortativity(g);

assert(isequal(out_in_assortativity.getValue(), known_out_in_assortativity), ...
    [BRAPH2.STR ':OutInAssortativity:' BRAPH2.BUG_ERR], ...
    'OutInAssortativity is not being calculated correctly for MultiplexGraphWD.')

%% Test 5: Comparison with standard method for BD graphs
A = rand(randi(10));
g = GraphBD(A);

out_in_assortativity = OutInAssortativity(g).getValue();
out_in_assortativity_bct = assortativity_standard_BD(g.getA());

assert(isequal(out_in_assortativity{1}, out_in_assortativity_bct), ...
    [BRAPH2.STR ':OutInAssortativity:' BRAPH2.BUG_ERR], ...
    'OutInAssortativity is not being calculated correctly for BCT.')

%% Test 6: Comparison with standard method for WD graphs
A = rand(randi(10));
g = GraphWD(A);

out_in_assortativity = OutInAssortativity(g).getValue();
out_in_assortativity_bct = assortativity_standard_WD(g.getA());

assert(isequal(out_in_assortativity{1}, out_in_assortativity_bct), ...
    [BRAPH2.STR ':OutInAssortativity:' BRAPH2.BUG_ERR], ...
    'OutInAssortativity is not being calculated correctly for BCT.')

%% Functions to calculate clustering adapted from 2019_03_03_BCT

function stdvalue_BD = assortativity_standard_BD(A)
% directed version
[id,od] = degrees_dir(A);
[i,j] = find(A>0);
K = length(i);
degi = id(i);
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
stri = is(i);
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