% test InOutAssortativity
A_BD = [
    1 1 0 0 0; 
    0 1 1 0 0;
    0 0 1 1 0;
    0 1 0 1 1;
    1 0 0 1 1];
assortativity_BD = (2-100/49)/(16/7-100/49);

A_WD = [
    1 2 0 0 0;
    0 1 3 0 0;
    0 0 1 1 0;
    0 2 0 1 2;
    1 0 0 2 1];
assortativity_WD_threshold = (2-100/49)/(16/7-100/49);
assortativity_WD_compress = (5.444444/7-(6.333333/7)^2)/(6.444444/7-(6.333333/7)^2);

A_test = rand(randi(20));

%% Test 1: Comparison with known BD graph
g = GraphBD(A_BD);
assortativity_1 = InOutAssortativity(g).getValue();
assortativity_2 = assortativity_BD;
assert(isequal(assortativity_1, assortativity_2), ...
    'BRAPH:InOutAssortativity:Bug', ...
    'InOutAssortativity is not being calculated correctly for GraphBD')

%% Test 2: Comparison with known WD graph - Compress: scaled matrix
g = GraphWD(A_WD, 'StandardizeRule', 'compress');
assortativity_1 = InOutAssortativity(g).getValue();
assortativity_2 = assortativity_WD_compress;
assert(isequal(round(assortativity_1,4), round(assortativity_2,4)), ...
    'BRAPH:InOutAssortativity:Bug', ...
    'InOutAssortativity is not being calculated correctly for GraphWD')

%% Test 3: Comparison with known WD graph - Threshold: default one-rule matrix 
g = GraphWD(A_WD);
assortativity_1 = InOutAssortativity(g).getValue();
assortativity_2 = assortativity_WD_threshold;
assert(isequal(assortativity_1, assortativity_2), ...
    'BRAPH:InOutAssortativity:Bug', ...
    'InOutAssortativity is not being calculated correctly for GraphWU')

%% Test 4: Comparison with standard method for BD graphs
g = GraphBD(A_test);
A_BD = g.getA();
assortativity_1 = InOutAssortativity(g).getValue();
assortativity_2 = assortativity_standard_BD(A_BD);
assert(isequal(assortativity_1, assortativity_2), ...
    'BRAPH:InOutAssortativity:Bug', ...
    'InOutAssortativity is not being calculated correctly for GraphBD')

%% Test 5: Comparison with standard method for WD graphs
g = GraphWD(A_test);
A_WD = g.getA();
assortativity_1 = InOutAssortativity(g).getValue();
assortativity_2 = assortativity_standard_WD(A_WD);
assert(isequal(assortativity_1, assortativity_2), ...
    'BRAPH:InOutAssortativity:Bug', ...
    'InOutAssortativity is not being calculated correctly for GraphWD')

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