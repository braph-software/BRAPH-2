% Test fdr

%% Test 1: Basic test
pvalues = rand(1, 100);
q = .05;
r = fdr(pvalues, q);

%% Test 2: Vs known values
sample_array = [0.001, 0.008, 0.039, 0.041, 0.042, 0.060, 0.074, 0.205, 0.212, 0.216, ...
    0.222, 0.251, 0.269, 0.275, 0.34, 0.341, 0.384, 0.569, 0.594, 0.696, 0.762, ...
    0.94, 0.942, 0.975, 0.986];

% Critical value described by Benjamini and Hochberg(1995) is (i/m)Q where
% i is the rank of the test, m the total number of tests and Q the fdr
% treshhold value we choose, in this case will be 0.25 We look for the
% largest P value that is smaller than its critical value: P < (i/m)Q 

fdr_output  = fdr(sample_array, 0.25);

fdr_expected = [0.060]; %#ok<NBRAK>

assert(isequal(fdr_expected, fdr_output), ...
    [BRAPH2.STR ':FDR:' BRAPH2.WRONG_OUTPUT], ...
    'Error in bonferroni calculation')