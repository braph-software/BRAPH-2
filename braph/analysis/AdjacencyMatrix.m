classdef AdjacencyMatrix < handle
    properties
        pearson_adj  % pearson adjacency matrix
        pearson_p  % pearson correlation p matrix
        spearman_adj  % spearman adjacency matrix
        spearman_p  % spearman correlation p matrix
        kendall_adj  % kendall adjacency matrix
        kendall_p  % kendall correlation p matrix
        partial_pearson_adj  % partial pearson adjacency matrix
        partial_pearson_p % partial pearson correlation p matrix
        partial_spearman_adj  % partial spearman adjacency matrix
        partial_spearman_p % partial spearman correlation p matrix
        data  % save data
        negative_weight_rule  % save rule
        correlation_rule  % save rule
    end
    methods
        function adj =  AdjacencyMatrix(data, correlation_rule, negative_weight_rule)
            adj.data = data;
            adj.negative_weight_rule = negative_weight_rule;
            adj.correlation_rule = correlation_rule;
            adj.correlate();
        end
        function [A, P] = getCorrelation(adj, correlation_rule)
            switch lower(correlation_rule)
                case 'spearman'
                    if isempty(adj.spearman_adj)
                        adj.correlation_rule = correlation_rule;
                        adj.correlate();
                    end
                    A = adj.spearman_adj;
                    P = adj.spearman_p;
                case 'kendall'
                    if isempty(adj.kendall_adj)
                        adj.correlation_rule = correlation_rule;
                        adj.correlate();
                    end
                    A = adj.kendall_adj;
                    P = adj.kendall_p;
                case 'partial pearson'
                    if isempty(adj.partial_pearson_adj)
                        adj.correlation_rule = correlation_rule;
                        adj.correlate();
                    end
                    A = adj.partial_pearson_adj;
                    P = adj.partial_pearson_p;
                case 'partial spearman'
                    if isempty(adj.partial_spearman_adj)
                        adj.correlation_rule = correlation_rule;
                        adj.correlate();
                    end
                    A = adj.partial_spearman_adj;
                    P = adj.partial_spearman_p;
                otherwise
                    if isempty(adj.pearson_adj)
                        adj.correlation_rule = correlation_rule;
                        adj.correlate();
                    end
                    A = adj.pearson_adj;
                    P = adj.pearson_p;
            end
        end
    end
    methods 
        function correlate(adj)
            switch lower(adj.correlation_rule)
                case 'spearman'
                    [A, P] = corr(adj.data,'Type','Spearman');
                    switch (adj.negative_weight_rule)
                        case 'zero'
                            A(A < 0) = 0;
                        case 'abs'
                            A = abs(A); 
                        otherwise  % default
                    end
                    adj.spearman_adj = A;
                    adj.spearman_p = P;
                case 'kendall'
                    [A, P] = corr(adj.data,'Type','Kendall');
                    switch (adj.negative_weight_rule)
                        case 'zero'
                            A(A < 0) = 0;
                        case 'abs'
                            A = abs(A);
                        otherwise  % default
                    end
                    adj.kendall_adj = A;
                    adj.kendall_p = P;
                case 'partial pearson'
                    [A, P] = partialcorr(adj.data,'Type','Pearson');
                    switch (adj.negative_weight_rule)
                        case 'zero'
                            A(A < 0) = 0;
                        case 'abs'
                            A = abs(A);
                        otherwise  % default
                    end
                    adj.partial_pearson_adj = A;
                    adj.partial_pearson_p = P;
                case 'partial spearman'
                    [A, P] = partialcorr(adj.data,'Type','Spearman');
                    switch (adj.negative_weight_rule)
                        case 'zero'
                            A(A < 0) = 0;
                        case 'abs'
                            A = abs(A);
                        otherwise  % default
                    end
                    adj.partial_spearman_adj = A;
                    adj.partial_spearman_p = P;
                otherwise  % pearson default
                    [A, P] = corrcoef(adj.data);
                    switch (adj.negative_weight_rule)
                        case 'zero'
                            A(A < 0) = 0;
                        case 'abs'
                            A = abs(A);
                        otherwise  % default
                    end
                    adj.pearson_adj = A;
                    adj.pearson_p = P;
            end
        end
    end
end