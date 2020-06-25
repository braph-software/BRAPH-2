% Test fdr

%% Test 1: Basic test
pvalues = rand(1, 100);
q = .05;
r = fdr(pvalues, q);