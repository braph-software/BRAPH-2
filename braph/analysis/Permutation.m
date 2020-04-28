classdef Permutation
    properties (Constant)
        PERMUTATION_LONGITUDINAL_RULE_LIST = {false, true};
    end
    methods (Static)
        function [permutation1, permutation2] = getPermutation(longitudinal, subs1, subs2, n_substmp, number_sub1)
            %should be a class.
            if longitudinal
                max = min(numel(subs1), numel(subs2));
                permutation = sign(randn(1, max));
                permutation1 = subs1;
                permutation2 = subs2;
                permutation1(permutation==1) = subs2(permutation==1);
                permutation2(permutation==1) = subs1(permutation==2);
            else
                if nargin < 5
                    permutation1 = sort(randperm(n_substmp, numel(subs1)));
                else
                    permutation1 = sort(randperm(n_substmp, number_sub1));
                end
                permutation2 = [1:1:n_substmp];
                permutation2(permutation1) = 0;
                permutation2 = permutation2(permutation2 > 0);
            end
        end
    end
end
