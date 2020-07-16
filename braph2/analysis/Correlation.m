classdef Correlation
    % Correlation Correlates a matrix
    % Correlation correlates a matrix with the given correlation rule
    % 
    % Correlation returns an adjacency matrix. Depending on the correlation
    % rule, it uses a different type of correlation function. It also
    % returns the adjacency matrix with modified values depending on the
    % negative rule.
    %
    % Correlation properties (Constant)
    %  Correlation_Rule_List        - pearson, spearman, kendall, partial
    %                                 pearson, partial spearman
    %  Negative_Weight_Rule_List    - zero, abs, none
    %
    % Correlation methods (Static)
    %  getAdjacencyMatrix           - returns an adjacency matrix and p-values
    %
    % See also Analysis, Measurement.   
    
    properties (Constant)
        CORRELATION_RULE_LIST = {'pearson', 'spearman', 'kendall', 'partial pearson', 'partial spearman'};
        NEGATIVE_WEIGHT_RULE_LIST = {'zero', 'abs', 'none'};
    end
    methods (Static)
        function [A, P] = getAdjacencyMatrix(data, correlation_rule, negative_weight_rule)
            % GETADJACENCYMATRIX returns an adjacency matrix
            %
            % [A, P] = GETADJACENCYMATRIX(DATA) returns an adjacency matrix
            % calculated with pearson correlation. May return the p-values
            % correlation matrix P.
            %
            % [A, P] = GETADJACENCYMATRIX(DATA, CORRELATION_RULE) returns an
            % adjacency matrix calculated with the specified correlation rule.
            % May return the p-values correlation matrix P. 
            %
            % [A, ] = GETADJACENCYMATRIX(DATA, CORRELATION_RULE, NEGATIVE_WEIGHT_RULE) 
            % returns an adjacency matrix calculated with the specified correlation rule.
            % It filters the values with the NEGATIVE_WEIGHT_RULE.
            % May return the p-values correlation matrix P.
            %
            % See also Analysis, Measurement.
            
            switch lower(correlation_rule)
                case 'spearman'
                    [A, P] = corr(data, 'Type', 'Spearman');
                case 'kendall'
                    [A, P] = corr(data,'Type','Kendall');
                case 'partial pearson'
                    [A, P] = partialcorr(data,'Type','Pearson');
                case 'partial spearman'
                    [A, P] = partialcorr(data,'Type','Spearman');
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