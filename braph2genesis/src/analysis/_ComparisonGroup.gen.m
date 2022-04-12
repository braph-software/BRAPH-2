%% ¡header!
ComparisonGroup < Element (cp, group-based comparison results) contains the results of a group-based comparison.

%%% ¡description!
ComparisonGroup contains the results of a group-based comparison for a given measure.
Specifically, it contains the one-tailed and two-tailed p-values 
and the 95%% confidence interval.

%%% ¡seealso!
CompareGroup, AnalyzeGroup

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based comparison results.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based comparison results.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based comparison results.

%%% ¡prop!
MEASURE (data, string) is the measure class.

%%% ¡prop!
MEASUREPARAM(data, item) provides the measure parameters. 
%%%% ¡settings!
'Measure'

%%% ¡prop!
C (data, item) is the group-based comparison.
%%%% ¡settings!
'CompareGroup'

%%% ¡prop!
DIFF (result, cell) is the group comparison value.
%%%% ¡calculate!
[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
value = diff;
%%%% ¡gui!
pr = PPComparisonGroup_Diff('EL', cp, 'PROP', ComparisonGroup.DIFF, varargin{:});

%%% ¡prop!
P1 (result, cell) is the one-tailed p-value.
%%%% ¡calculate!
[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
value = p1;
%%%% ¡gui__!
% % % pl = PPComparisonGroupDiff('EL', cp, 'PROP', ComparisonGroup.P1, varargin{:});

%%% ¡prop!
P2 (result, cell) is the two-tailed p-value.
%%%% ¡calculate!
[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
value = p2;
%%%% ¡gui__!
% % % pl = PPComparisonGroupDiff('EL', cp, 'PROP', ComparisonGroup.P2, varargin{:});

%%% ¡prop!
CIL (result, cell) is the lower value of the 95%% confidence interval.
%%%% ¡calculate!
[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
value = ci_lower;
%%%% ¡gui__!
% % % pl = PPComparisonGroupDiff('EL', cp, 'PROP', ComparisonGroup.CIL, varargin{:});

%%% ¡prop!
CIU (result, cell) is the upper value of the 95%% confidence interval.
%%%% ¡calculate!
[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
value = ci_upper;
%%%% ¡gui__!
% % % pl = PPComparisonGroupDiff('EL', cp, 'PROP', ComparisonGroup.CIU, varargin{:});

%% ¡methods!
function [diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp)
    %CALCULATE_RESULTS calculates the comparison results.
    %
    % [DIFF, P1, P2, CIL, CIU] = CALCULATE_RESULTS(CP) calcultes the
    %  difference, the one-tailed p-value P1, the two-tailed p-value P2,
    %  the lower bound of the confidence interval CIL, and the the upper
    %  bound of the confidence interval. 
    %  Typically, this method is only called internally.

    measure_class = cp.get('MEASURE');
    if isempty(cp.get('MEASURE'))
        diff = {};
        p1 = {};
        p2 = {};
        ci_lower = {};
        ci_upper = {};
        return
    end
    
	% get parameters from example measure
    core_measure = cp.get('MEASUREPARAM');
    j = 1;
    varargin = {};
    if Measure.getPropNumber() ~= core_measure.getPropNumber()
        for i = Measure.getPropNumber() + 1:core_measure.getPropNumber()
            if ~isa(core_measure.getr(i), 'NoValue')
                varargin{j} = core_measure.getPropTag(i);
                varargin{j + 1} = core_measure.getr(i);
            end
            j = j + 2;
        end
        varargin = varargin(~cellfun('isempty', varargin));
    end
    
    c = cp.get('C');
    if c.get('WAITBAR')
        wb = waitbar(0, 'Comparing group analyses ...', 'Name', BRAPH2.NAME);
        set_braph2icon(wb)
    end    

    % Measure for groups 1 and 2, and their difference
    m1 = c.get('A1').get('G').getMeasure(measure_class, varargin{:}).memorize('M');
    m2 = c.get('A2').get('G').getMeasure(measure_class, varargin{:}).memorize('M');
    diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);

    % Permutations
    P = c.get('P'); %#ok<*PROPLC>

    m1_perms = cell(1, P);
    m2_perms = cell(1, P);
    diff_perms = cell(1, P);

    start = tic;
    for i = 1:1:P
        [a1_perm, a2_perm] = c.getPerm(i, c.get('MEMORIZE'));

        m1_perms{1, i} = a1_perm.memorize('G').getMeasure(measure_class).memorize('M');
        m2_perms{1, i} = a2_perm.memorize('G').getMeasure(measure_class).memorize('M');
        diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);

        if c.get('WAITBAR')
            waitbar(i / P, wb, ['Permutation ' num2str(i) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...']);
        end
        if c.get('VERBOSE')
            disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
        end
        if c.get('INTERRUPTIBLE')
            pause(c.get('INTERRUPTIBLE'))
        end        
    end
    
    if c.get('WAITBAR')
        close(wb)
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