classdef Correlation
    properties (Constant)
        CORRELATION_RULE_LIST = {'pearson', 'spearman', 'kendall', 'partial pearson', 'partial spearman'};
        NEGATIVE_WEIGHT_RULE_LIST = {'zero', 'abs', 'none'};
    end
    methods (Static)
        function A = getAdjacencyMatrix(data, correlation_rule, negative_weight_rule)
            
            switch lower(correlation_rule)
                case 'spearman'
                    A = corr(data, 'Type', 'Spearman');
                case 'kendall'
                    A = corr(data,'Type','Kendall');
                case 'partial pearson'
                    A = partialcorr(data,'Type','Pearson');
                case 'partial spearman'
                    A = partialcorr(data,'Type','Spearman');
                otherwise  % 'Pearson' default
                    A = corrcoef(data);
            end
            
            switch lower(negative_weight_rule)
                case 'none'
                    
                case 'abs'
                    A = abs(A);
                otherwise  % 'zero' default
                    A(A < 0) = 0;
            end
        end
        function [A, P] = getAdjacencyMatrixAndPValue(data, correlation_rule, negative_weight_rule)
            
            switch lower(correlation_rule)
                case 'spearman'
                    [A, P] = corr(data, 'Type', 'Spearman');
                case 'kendall'
                    [A, P]= corr(data,'Type','Kendall');
                case 'partial pearson'
                    [A, P] = partialcorr(data,'Type','Pearson');
                case 'partial spearman'
                    [A, P]= partialcorr(data,'Type','Spearman');
                otherwise  % 'Pearson' default
                    [A, P] = corrcoef(data);
            end
            
            switch lower(negative_weight_rule)
                case 'none'
                    
                case 'abs'
                    A = abs(A);
                otherwise  % 'zero' default
                    A(A < 0) = 0;
            end
        end
    end
end