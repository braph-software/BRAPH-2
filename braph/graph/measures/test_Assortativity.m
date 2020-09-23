% test Assortativity
A_BU = [
    1 1 0 0 1;
    1 1 1 1 0;
    0 1 1 1 0;
    0 1 1 1 1;
    1 0 0 1 0];
assortativity_BU = (37/6-(15/6)^2)/(39/6-(15/6)^2);

A_WU = [
    1 2 0 0 1;
    2 1 3 2 0;
    0 3 1 1 0;
    0 2 1 1 2;
    1 0 0 2 1];
assortativity_WU_threshold = (37/6-(15/6)^2)/(39/6-(15/6)^2);
assortativity_WU_compress = (14.222222/6-(9.333333/6)^2)/(16.111111/6-(9.333333/6)^2);

A_test = rand(randi(10));

%% Test 1: Comparison with known BU graph
g = GraphBU(A_BU);
assortativity_1 = Assortativity(g).getValue();
assortativity_2 = assortativity_BU;
assert(isequal(assortativity_1, assortativity_2), ...
    'BRAPH:Assortativity:Bug', ...
    'Assortativity is not being calculated correctly for GraphBU')

%% Test 2: Comparison with known WU graph - Compress: scaled matrix
g = GraphWU(A_WU, 'StandardizeRule', 'compress');
assortativity_1 = Assortativity(g).getValue();
assortativity_2 = assortativity_WU_compress;
assert(isequal(round(assortativity_1,4), round(assortativity_2,4)), ...
    'BRAPH:Assortativity:Bug', ...
    'Assortativity is not being calculated correctly for GraphWU')

%% Test 2: Comparison with known WU graph - Threshold: default one-rule matrix 
g = GraphWU(A_WU);
assortativity_1 = Assortativity(g).getValue();
assortativity_2 = assortativity_WU_threshold;
assert(isequal(assortativity_1, assortativity_2), ...
    'BRAPH:Assortativity:Bug', ...
    'Assortativity is not being calculated correctly for GraphWU')

%% Test 3: Comparison with standard method for BU graphs
g = GraphBU(A_test);
A_BU = g.getA();
assortativity_1 = Assortativity(g).getValue();
assortativity_2 = assortativity_standard_BU(A_BU);
assert(isequal(assortativity_1, assortativity_2), ...
    'BRAPH:Assortativity:Bug', ...
    'Assortativity is not being calculated correctly for GraphBU')

%% Test 4: Comparison with standard method for WU graphs
g = GraphWU(A_test);
A_WU = g.getA();
assortativity_1 = Assortativity(g).getValue();
assortativity_2 = assortativity_standard_WU(A_WU);
assert(isequal(assortativity_1, assortativity_2), ...
    'BRAPH:Assortativity:Bug', ...
    'Assortativity is not being calculated correctly for GraphWU')

%% Functions to calculate clustering adapted from 2019_03_03_BCT

function stdvalue_BU = assortativity_standard_BU(A)
% undirected version
deg = degrees_und(A);
[i,j] = find(triu(A,1)>0);
K = length(i);
degi = deg(i);
degj = deg(j);
% compute assortativity
stdvalue_BU = ( sum(degi.*degj)/K - (sum(0.5*(degi+degj))/K)^2 ) / ...
    ( sum(0.5*(degi.^2+degj.^2))/K - (sum(0.5*(degi+degj))/K)^2 );
stdvalue_BU(isnan(stdvalue_BU)) = 0;  % Should return zeros, not NaN
end

function stdvalue_WU = assortativity_standard_WU(A)
% undirected version
str = strengths_und(A);
[i,j] = find(triu(A,1)>0);
K = length(i);
stri = str(i);
strj = str(j);
% compute assortativity
stdvalue_WU = ( sum(stri.*strj)/K - (sum(0.5*(stri+strj))/K)^2 ) / ...
    ( sum(0.5*(stri.^2+strj.^2))/K - (sum(0.5*(stri+strj))/K)^2 );
stdvalue_WU(isnan(stdvalue_WU)) = 0;  % Should return zeros, not NaN
end
function [deg] = degrees_und(A)
A = double(A~=0);
deg = sum(A);
end
function [str] = strengths_und(A)
str = sum(A);        % strength
end
