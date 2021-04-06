%% ¡header!
Comparison < Element (c, comparison) is a comparison between two analyses.

%%% ¡description!
Comparison compares two analyses, 
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
'Analysis'
%%%% ¡check_value!
check = isa(value, c.get('A2').getClass());

%%% ¡prop!
A2 (data, item) is the second analysis to compare.
%%%% ¡settings!
'Analysis'
%%%% ¡check_value!
check = isa(value, c.get('A1').getClass());

%%% ¡prop!
A_CLONE (result, item) is a cloned analysis.
%%%% ¡settings!
'Analysis'
%%%% ¡calculate!
a1_clone = c.get('A1').clone();
sub_dict_clone = a1_clone.get('GR').get('SUB_DICT');
sub_dict_clone.remove_all([1:1:sub_dict_clone.length]);
value = a1_clone;

%%% ¡prop!
PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
%%%% ¡calculate!
value = randi(intmax('uint32'), 1, c.get('P'));

%%% ¡prop!
A1_PERM (result, idict) is the list of permuted analyses for the first analysis.
%%%% ¡settings!
'Analysis'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'Analysis', 'IT_KEY', 1);

%%% ¡prop!
A2_PERM (result, idict) is the list of permuted analyses for the second analysis.
%%%% ¡settings!
'Analysis'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'Analysis', 'IT_KEY', 1);

%% ¡methods!
function [a1_perm, a2_perm] = getPerm(c, i)

    seeds = c.get('PERM_SEEDS');
    rng(seeds(i), 'twister')

    if c.get('A1').get('G').is_ensemble()
        subs1 = c.get('A1').get('GR').get('SUB_DICT').get('IT_LIST');
        subs2 = c.get('A2').get('GR').get('SUB_DICT').get('IT_LIST');

        gs1 = c.get('A1').get('G').get('G_DICT').get('IT_LIST');
        gs2 = c.get('A2').get('G').get('G_DICT').get('IT_LIST');

        subs1_gs1 = cellfun(@(x, y) {x, y}, subs1, gs1, 'UniformOutput', false);
        subs2_gs2 = cellfun(@(x, y) {x, y}, subs2, gs2, 'UniformOutput', false);

        [subs1_gs1_perm, subs2_gs2_perm] = permutation(subs1_gs1, subs2_gs2, c.get('LONGITUDINAL'));

        a1_perm = c.memorize('A_CLONE').clone();
        a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs1_gs1_perm))
        a1_perm.get('G').get('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs1_gs1_perm))

        a2_perm = c.memorize('A_CLONE').clone();
        a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs2_gs2_perm))
        a2_perm.get('G').get('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs2_gs2_perm))
    else
        subs1 = c.get('A1').get('GR').get('SUB_DICT').get('IT_LIST');
        subs2 = c.get('A2').get('GR').get('SUB_DICT').get('IT_LIST');

        [subs1_perm, subs2_perm] = permutation(subs1, subs2, c.get('LONGITUDINAL'));

        a1_perm = c.memorize('A_CLONE').clone();
        a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs1_perm)

        a2_perm = c.memorize('A_CLONE').clone();
        a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs2_perm)
    end
end
function [p1, p2] = getComparison(c, measure_code, varargin)

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
    p1 = pvalue1(diff, cellfun(@(x) x, diff_perms));
    p2 = pvalue2(diff, cellfun(@(x) x, diff_perms));
%     p1 = cell(size(diff));
%     p2 =  cell(size(diff));
%     qtl = cell(size(diff));
%     ci_lower = cell(size(diff));
%     ci_upper =  cell(size(diff));
%     for i = 1:1:size(diff, 1)
%         for j = 1:1:size(diff, 1)
% %pvalue1(diff, cellfun(@(x) x, diff_perms))
% %            p1(i, j) = {pvalue1(diff{i, j}, diff_perms(i * j, :))};  % singe tail
% %         p2(i, j) = {pvalue2(difference_mean{i, j}, difference_all_permutations(i*j, :))};  % double tail
% %         qtl(i, j) = {quantiles(difference_all_permutations(i*j, :), 40)};
% %         ci_lower(i, j) = {cellfun(@(x) x(2), qtl{i, j})};
% %         ci_upper(i, j)  = {cellfun(@(x) x(40), qtl{i, j})}; % or 39?
%         end
%     end

% measurements_1 = analysis.getMeasurement(measure_code, group_1, varargin{:});
% value_1 = measurements_1.getMeasureValue();
% 
% measurements_2 = analysis.getMeasurement(measure_code, group_2, varargin{:});
% value_2 = measurements_2.getMeasureValue();
% 
% difference_mean = cellfun(@(x, y) y - x, value_1, value_2, 'UniformOutput', false);
% 
% subjects_1 = group_1.getSubjects();
% subjects_2 = group_2.getSubjects();
% 
% % Permutations
% all_permutations_1 = cell(1, M);
% all_permutations_2 = cell(1, M);
% 
% start = tic;
% for i = 1:1:M
%     if verbose
%         disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
%     end
% 
%     [permutation_subjects_1, permutation_subjects_2] = permutation(subjects_1, subjects_2, is_longitudinal);
% 
%     graph_permutated_1 = analysis.get_graph_for_subjects(permutation_subjects_1, varargin{:});
%     measure_permutated_1 = Measure.getMeasure(measure_code, graph_permutated_1, varargin{:});
%     measure_permutated_value_1 = measure_permutated_1.getValue();
% 
%     graph_permutated_2 = analysis.get_graph_for_subjects(permutation_subjects_2, varargin{:});
%     measure_permutated_2 = Measure.getMeasure(measure_code, graph_permutated_2, varargin{:});
%     measure_permutated_value_2 = measure_permutated_2.getValue();
% 
%     all_permutations_1{1, i} = measure_permutated_value_1;
%     all_permutations_2{1, i} = measure_permutated_value_2;
% 
%     if interruptible
%         pause(interruptible)
%     end
% end
% 
% difference_all_permutations = cell(rows*columns, M);
% p1 = cell(rows, columns);
% p2 =  cell(rows, columns);
% qtl = cell(rows, columns);
% ci_lower = cell(rows, columns);
% ci_upper =  cell(rows, columns);
% 
% for i=1:rows
%     for j=1:columns
%         difference_all_permutations(i*j, :) = cellfun(@(x, y) y{i, j} - x{i, j}, all_permutations_1, all_permutations_2, 'UniformOutput', false);
%         % Statistical analysis
%         p1(i, j) = {pvalue1(difference_mean{i, j}, difference_all_permutations(i*j, :))};  % singe tail,
%         p2(i, j) = {pvalue2(difference_mean{i, j}, difference_all_permutations(i*j, :))};  % double tail
%         qtl(i, j) = {quantiles(difference_all_permutations(i*j, :), 40)};
%         ci_lower(i, j) = {cellfun(@(x) x(2), qtl{i, j})};
%         ci_upper(i, j)  = {cellfun(@(x) x(40), qtl{i, j})}; % or 39?
%     end
% end
            
end