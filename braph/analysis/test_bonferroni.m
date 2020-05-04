% Test bonferroni

%% Test 1: Basic test
pvalues = rand(1, 100);
p = .05;
r = bonferroni(pvalues, p);