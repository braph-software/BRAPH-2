function B = remove_diagonal(A, value)

    if nargin < 2
        value = 0;
    end

    B = A;
    B(1:length(A)+1:numel(A)) = value;
end