% test Assortativity

%% Test 1: GraphBU
A = [
    1  1  0  0  1;
    1  1  1  1  0;
    0  1  1  1  0;
    0  1  1  1  1;
    1  0  0  1  0];

known_assortativity = {(37/6-(15/6)^2)/(39/6-(15/6)^2)};

g = GraphBU(A);
assortativity = Assortativity(g);

assert(isequal(assortativity.getValue(), known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.BUG_ERR], ...
    'Assortativity is not being calculated correctly for GraphBU.')

%% Test 2: GraphWU
A = [
    1  2  0  0  1;
    2  1  3  2  0;
    0  3  1  1  0;
    0  2  1  1  2;
    1  0  0  2  1];

known_assortativity = {(37/6-(15/6)^2)/(39/6-(15/6)^2)};

g = GraphWU(A);
assortativity = Assortativity(g);

assert(isequal(assortativity.getValue(), known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.BUG_ERR], ...
    'Assortativity is not being calculated correctly for GraphWU.')

%% Test 3: MultiplexGraphBU
A11 = [
      1  1  0  0  1;
      1  1  1  1  0;
      0  1  1  1  0;
      0  1  1  1  1;
      1  0  0  1  0];
A12 = eye(5);
A21 = eye(5);
A22 = [
      1  1  0  0  1;
      1  1  1  1  0;
      0  1  1  1  0;
      0  1  1  1  1;
      1  0  0  1  0];
A = {
    A11     A12
    A21     A22
    };

known_assortativity = {
                    (37/6-(15/6)^2)/(39/6-(15/6)^2)
                    (37/6-(15/6)^2)/(39/6-(15/6)^2)
                    };

g = MultiplexGraphBU(A);
assortativity = Assortativity(g);

assert(isequal(assortativity.getValue(), known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.BUG_ERR], ...
    'Assortativity is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: MultiplexGraphWU
A11 = [
       1  2  0  0  1;
       2  1  3  2  0;
       0  3  1  1  0;
       0  2  1  1  2;
       1  0  0  2  1];
A12 = eye(5);
A21 = eye(5);
A22 = [
       1  2  0  0  1;
       2  1  3  2  0;
       0  3  1  1  0;
       0  2  1  1  2;
       1  0  0  2  1];
A = {
    A11     A12
    A21     A22
    };

known_assortativity = {
                    (37/6-(15/6)^2)/(39/6-(15/6)^2)
                    (37/6-(15/6)^2)/(39/6-(15/6)^2)
                    };

g = MultiplexGraphWU(A);
assortativity = Assortativity(g);

assert(isequal(assortativity.getValue(), known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.BUG_ERR], ...
    'Assortativity is not being calculated correctly for MultiplexGraphWU.')

%% Test 5: Comparison with standard method for BU graphs
A = rand(randi(10));
g = GraphBU(A);

assortativity = Assortativity(g).getValue();
assortativity_bct = assortativity_standard_BU(g.getA());

assert(isequal(assortativity{1}, assortativity_bct), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.BUG_ERR], ...
    'Assortativity is not being calculated correctly for BCT.')

%% Test 6: Comparison with standard method for WU graphs
A = rand(randi(10));
g = GraphWU(A);

assortativity = Assortativity(g).getValue();
assortativity_bct = assortativity_standard_WU(g.getA());

assert(isequal(assortativity{1}, assortativity_bct), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.BUG_ERR], ...
    'Assortativity is not being calculated correctly for BCT.')

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
