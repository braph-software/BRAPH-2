%% ¡header!
ComparisonGroup < Element (c, group-based comparison) is a comparison between two group-based analyses.

%%% ¡description!
ComparisonGroup compares two group-based analyses, 
which need to be of the same class.

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the comparison.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the comparison.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the comparison.

%%% ¡prop!
P (parameter, scalar) is the permutation number.
%%%% ¡default!
1e+4
%%%% ¡check_prop!
check = value > 0 && value == round(value);

%%% ¡prop!
LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.

%%% ¡prop!
A1 (data, item) is the first analysis to compare.
%%%% ¡settings!
'AnalysisGroup'
%%%% ¡check_value!
check = isa(value, c.get('A2').getClass());

%%% ¡prop!
A2 (data, item) is the second analysis to compare.
%%%% ¡settings!
'AnalysisGroup'
%%%% ¡check_value!
check = isa(value, c.get('A1').getClass());

%%% ¡prop!
PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
%%%% ¡calculate!
value = randi(intmax('uint32'), 1, c.get('P'));

%%% ¡prop!
A1_PERM (result, idict) is the list of permuted analyses for the first analysis.
%%%% ¡settings!
'AnalysisGroup'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'AnalysisGroup', 'IT_KEY', 1);

%%% ¡prop!
A2_PERM (result, idict) is the list of permuted analyses for the second analysis.
%%%% ¡settings!
'AnalysisGroup'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'AnalysisGroup', 'IT_KEY', 1);

%% ¡methods!
function [a1_perm, a2_perm] = getPerm(c, i)

    seeds = c.get('PERM_SEEDS');
    rng(seeds(i), 'twister')
    
    subs1 = c.get('A1').get('GR').get('SUB_DICT').get('IT_LIST');
    subs2 = c.get('A2').get('GR').get('SUB_DICT').get('IT_LIST');

    [subs1_perm, subs2_perm] = permutation(subs1, subs2, c.get('LONGITUDINAL'));

    a1_perm = c.get('A1').clone();
    a1_perm.set('GR', c.get('A1').get('GR').clone())
    a1_perm.get('GR').set('SUB_DICT', c.get('A1').get('GR').get('SUB_DICT').clone())
    a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs1_perm)

    a2_perm = c.get('A2').clone();
    a2_perm.set('GR', c.get('A2').get('GR').clone())
    a2_perm.get('GR').set('SUB_DICT', c.get('A2').get('GR').get('SUB_DICT').clone())
    a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs2_perm)
end
function [p1, p2, ci_lower, ci_upper, m1, m2, diff, m1_perms, m2_perms, diff_perms] = getComparison(c, measure_code, varargin)

    verbose = get_from_varargin(false, 'Verbose', varargin{:});
    interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});

    % Measure for groups 1 and 2, and their difference
    m1 = c.get('A1').get('G').getMeasure(measure_code).get('M');
    m2 = c.get('A2').get('G').getMeasure(measure_code).get('M');
    diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);

    % Permutations
    P = c.get('P'); %#ok<*PROPLC>

    m1_perms = cell(1, P);
    m2_perms = cell(1, P);
    diff_perms = cell(1, P);

    start = tic;
    for i = 1:1:P
        if verbose
            disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
        end

        [a1_perm, a2_perm] = c.getPerm(i);

        m1_perms{1, i} = a1_perm.get('G').getMeasure(measure_code).get('M');
        m2_perms{1, i} = a2_perm.get('G').getMeasure(measure_code).get('M');
        diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);

        if interruptible
            pause(interruptible)
        end
    end

    % Statistical analysis
    p1 = cell(size(diff));
    p2 = cell(size(diff));
    ci_lower = cell(size(diff));
    ci_upper = cell(size(diff));
    for i = 1:1:size(diff, 1)
        for j = 1:1:size(diff, 2)
            p1(i, j) = pvalue1(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
            p2(i, j) = pvalue1(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
            qtl = quantiles(cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false), 40);
            ci_lower(i, j) = {cellfun(@(x) x(2), qtl)};
            ci_upper(i, j) = {cellfun(@(x) x(40), qtl)};
        end
    end
    
end