% Test bonferroni

%% Test 1: Basic test
pvalues = rand(1, 100);
p = .05;
r = bonferroni(pvalues, p);

%% Test 2: Vs known values
p_value = 0.05;  %  significant value of P < 0.0005 
n = 25;  % number of samples or number of tests
% Bonferroni Correction is defined as a the level of significance / number
% of tests, i.e., in this example is 0.05 / 25
bonferroni_expected = 0.002;  % expected bonferroni
bonferroni = bonferroni(cell(25, 1), p_value);

assert(isequal(bonferroni_expected, bonferroni), ...
    [BRAPH2.STR ':Bonferroni:' BRAPH2.WRONG_OUTPUT], ...
    'Error in bonferroni calculation')