% test OutStrength

%% Test 1: Calculation GraphWD
A = [
    0   .2  1
    0   0   .8
    1   0   0];

known_out_strength = {[1.2, 0.8, 1]'};

g = GraphWD(A);
out_strength = OutStrength(g);

assert(isequal(out_strength.getValue(), known_out_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'Strength is not being calculated correctly for GraphWD')

%% Test 2: Calculation MultiplexGraphWD
A11 = [
    0   .2  1
    0   0   .8
    1   0   0];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0 1   .6
    1 0   .4
    0 .4  0];
A = {
    A11     A12  
    A21     A22
    };

known_out_strength = {
                     [1.2, 0.8, 1]'
                     [1.6, 1.4, 0.4]'};
                                
g = MultiplexGraphWD(A);
out_strength = OutStrength(g);

assert(isequal(out_strength.getValue(), known_out_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'Strength is not being calculated correctly for MultiplexGraphWD')