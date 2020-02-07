function B = remove_diagonal(A, value)
    %  Remove diagonal function (A, varargin)
    %  Returns a matrix with the values of the diagonal removed.
   
    % Author: Mite Mijalkov, Giovanni Volpe & Emiliano Gomez
    % Date: 06/02/2020

    if nargin < 2
        value = 0;
    end

    B = A;
    B(1:length(A)+1:numel(A)) = value;
end