% Test fdr

%% Test 1: 
pvalues = rand(1, 100);
q = .05;
r = fdr(pvalues, q);