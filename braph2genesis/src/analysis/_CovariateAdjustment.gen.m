%% ¡header!
CovariateAdjustment < Element (ca, adjustment for covariates) adjusts the target values.

%% ¡description!
The adjustment adjusts the target values by removing the effect of covariates.
It is achieved with regression analysis by means of least squares to 
approximate the effect of covariate. The adjusted values are obtained from
the residuals of the value after removing the effect of covariate.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the evaluator.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the evaluator.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the evaluator.

%%% ¡prop!
CP (data, item) is the ensemble-based comparison.
%%%% ¡settings!
'ComparisonEnsemble'

%%% ¡prop!
M_LIST_ADJUSTED (result, cell) is the adjusted measure result at single layer level.
%%%% ¡calculate!
core_measure = ca.get('CP').get('MEASUREPARAM');
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

measure_class = ca.get('CP').get('MEASURE');
c = ca.get('CP').get('C');
ms1 = cellfun(@(x) x.getMeasure(measure_class, varargin{:}).memorize('M'), c.get('A1').memorize('G_DICT').getItems, 'UniformOutput', false);
ms2 = cellfun(@(x) x.getMeasure(measure_class, varargin{:}).memorize('M'), c.get('A2').memorize('G_DICT').getItems, 'UniformOutput', false);

subj_num1 = size(ms1, 2);
subj_num2 = size(ms2, 2);
subj_num = subj_num1 + subj_num2;
ms = [ms1 ms2];

gr1 = ca.get('CP').get('C').get('A1').get('GR');
gr2 = ca.get('CP').get('C').get('A2').get('GR');

age_list = cellfun(@(x) x.get('age'), gr1.get('SUB_DICT').getItems, 'UniformOutput', false);
age1 = cat(2, age_list{:})';
age_list = cellfun(@(x) x.get('age'), gr2.get('SUB_DICT').getItems, 'UniformOutput', false);
age2 = cat(2, age_list{:})';
age = [age1; age2];

sex_list = cellfun(@(x) x.get('sex'), gr1.get('SUB_DICT').getItems, 'UniformOutput', false);
sex1 = zeros(size(age1));
for i = 1:length(sex_list)
    switch lower(sex_list{i})
        case 'female'
            sex1(i) = 1;
        case 'male'
            sex1(i) = -1;
        otherwise
            sex1(i) = 2; % cannot assign zero otherwise the least square solver will return NaN
    end
end
sex_list = cellfun(@(x) x.get('sex'), gr2.get('SUB_DICT').getItems, 'UniformOutput', false);
sex2 = zeros(size(age2));
for i = 1:length(sex_list)
    switch lower(sex_list{i})
        case 'female'
            sex2(i) = 1;
        case 'male'
            sex2(i) = -1;
        otherwise
            sex2(i) = 2; % cannot assign zero otherwise the least square solver will return NaN
    end
end
sex = [sex1; sex2];

for i = 1:1:size(ms{1}, 1)
    for j = 1:1:size(ms{1}, 2)
        m_ij_list = cellfun(@(x) x{i, j}, ms, 'UniformOutput', false);
        m_list_cat = cat(ndims(m_ij_list{1}) + 1, m_ij_list{:});
        m_list_cat_adjusted = zeros(size(m_list_cat));
        for k = 1:1:size(m_list_cat, 2)
            m_list_unadjusted = reshape(squeeze(m_list_cat(:, k, :)), [], subj_num);
            m_list_cat_adjusted(:, k, :) = ca.adjustment(m_list_unadjusted, [sex age]);
        end
        for k = 1:1:size(m_list_cat, 3)
            m_ij_list_adjusted{k} = m_list_cat_adjusted(:, :, k);
        end
        for k = 1:1:subj_num1 + subj_num2
            ms_adjusted{k}(i, j) = m_ij_list_adjusted(k);
        end
    end
end
ms1_adjusted = ms_adjusted(1:subj_num1);
ms2_adjusted = ms_adjusted(subj_num1 + 1:subj_num);

value = [ms1_adjusted ms2_adjusted];

%% ¡methods!
function adjusted_values = adjustment(ca, values, covariates)
    %ADJUSTMENT adjusts the covariant of data.
    %
    % ADJUSTED_VALUES = ADJUSTMENT(VALUES, COVARIATES) It adjusts the values in
    %  numerical arrays VALUES, so the differences related to COVARIATES are removed.
    %  The effect of covariate is approximated by means of least squares.
    %  The adjusted values are obtained from the residuals of the value 
    %  after removing the approximated effect of covariate.

    Y = values';

    % create the full covariates matrix
    no = length(covariates);
    X = [ones(no, 1) covariates];

    % construct the model Y = XB + E and find the LS estimate of B by using
    % b=(X'X)^{-1}X'Y
    B = inv(X' * X) * X' * Y;

    % get the residuals
    adjusted_values = Y - X * B;
    adjusted_values = adjusted_values';
end