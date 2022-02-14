%% ¡header!
NNData < Element (nnd, data of neural network) produces a dataset to train or test a neural netowrk.  

%% ¡description!
This dataset can be used to train or test a neural network. 
Feature selection procedure can be implemented.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis.

%%% ¡prop!
INPUTS (result, cell) is the inputs for training or testing a neural network.

%% ¡methods!
function score = mutual_information_analysis(nnd, X, Y, n)
    %MUTUAL_INFORMATION_ANALYSIS computes the mutual information value.
    % 
    % MUTINF = MUTUAL_INFORMATION_ANALYSIS(NND, X, Y, n) compute the mutual
    %  information MUTINF of two discrete variables X and Y. These two vectors
    %  must have the same length. The higher value of the score, the
    %  closer connection between X and Y.

    xmin = min(X, [], 2);
    xmax = max(X, [], 2);
    xrange = (xmax - xmin) / n;
    if xmax - xmin < 1e-4
        mutinf = 0;
        return;
    end
    if size(Y, 1) ~= 1
        probmatr = zeros(n, size(Y, 1));
        for i = 1 : size(X,2)
            dimx = ceil((X(:, i) - xmin) / xrange);
            if dimx < 1
                dimx = 1;
            elseif dimx > n
                dimx = n;
            end
            dimy = find(Y(:, i) == 1);
            probmatr(dimx, dimy) = probmatr(dimx, dimy) + 1;
        end
    else
        ymin = min(Y, [], 2);
        ymax = max(Y, [], 2);
        yrange = (ymax - ymin) / n;
        probmatr = zeros(n, n);
        for i = 1 : size(X, 2)
            dimx = ceil((X(:, i) - xmin) / xrange);
            if dimx < 1
                dimx = 1;
            elseif dimx > n
                dimx = n;
            end
            dimy = ceil((Y(:, i) - ymin) / yrange);
            if dimy < 1
                dimy = 1;
            elseif dimy > n
                dimy = n;
            end
            probmatr(dimx, dimy) = probmatr(dimx, dimy) + 1;
        end
    end
    p_y = sum(probmatr, 1) / size(X, 2);
    p_y_x = probmatr ./ (sum(probmatr, 2) + 1e-8);
    p_y(p_y == 0) = 1e-8;
    p_y_x(p_y_x == 0) = 1e-8;
    
    score = sum(sum(probmatr / size(X, 2) .* log(p_y_x))) - sum(p_y .* log(p_y));
end