function [A, P] = adjacency_matrix(data, corr_rule, neg_rule)
    switch (corr_rule)
        case 'spearman'
            [A, P] = corr(data,'Type','Spearman');
        case 'kendall'
            [A, P] = corr(data,'Type','Kendall');
        case 'partialpearson'
            [A, P] = partialcorr(data,'Type','Pearson');
        case 'partial spearman'
            [A, P] = partialcorr(data,'Type','Spearman');
        otherwise  % pearson
            [A, P] = corrcoef(data);
    end

    switch (neg_rule)
        case 'zero'
            A(A<0) = 0;
        case 'abs'
            A = abs(A);
        otherwise  % none
    end
end