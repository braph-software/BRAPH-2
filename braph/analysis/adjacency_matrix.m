function [A, P] = adjacency_matrix(data, correlation_rule, negative_weight_rule)
    switch (correlation_rule)
        case 'spearman'
            [A, P] = corr(data,'Type','Spearman');
        case 'kendall'
            [A, P] = corr(data,'Type','Kendall');
        case 'partial pearson'
            [A, P] = partialcorr(data,'Type','Pearson');
        case 'partial spearman'
            [A, P] = partialcorr(data,'Type','Spearman');
        otherwise  % pearson default
            [A, P] = corrcoef(data);
    end

    switch (negative_weight_rule)
        case 'zero'
            A(A<0) = 0;
        case 'abs'
            A = abs(A);
        otherwise  % default
    end
end