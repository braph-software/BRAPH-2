%% ¡header!
NNDataSplit < Element (nnds, data split for neural network) split a dataset into training set and validation set.  

%% ¡description!
This NNDataSplit splits the NN group into two, one for training set, and 
the other for validation set. Feature selection procedure can be implemented. 

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis.

%%% ¡prop!
WAITBAR (metadata, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
GR_TRAIN (result, item) is a group of NN subjects for the training set.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
GR_VAL (result, item) is a group of NN subjects for the validation set.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.

%%% ¡prop!
GR_TRAIN_FS (result, item) is a training group of NN subjects with feature selection analysis.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))

%%% ¡prop!
GR_VAL_FS (result, item) is a validation group of NN subjects with feature selection analysis.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'NNDataSplit'
%%%% ¡postprocessing!
if nnds.prop_set(NNDataSplit.TEMPLATE, varargin{:})
    varargin = {};
    
    parameters = nnds.getProps(Category.PARAMETER);
    for i = 1:1:length(parameters)
        parameter = parameters(i);
        
        if parameter ~= NNDataSplit.TEMPLATE
            varargin{length(varargin) + 1} = parameter;
            varargin{length(varargin) + 1} = Callback('EL', nnds.get('TEMPLATE'), 'PROP', parameter);
        end
    end
    
    nnds.set(varargin{:});
end

%% ¡methods!
function score = mutual_information_analysis(nnds, X, Y, n)
    %MUTUAL_INFORMATION_ANALYSIS computes the mutual information value.
    % 
    % SCORE = MUTUAL_INFORMATION_ANALYSIS(NND, X, Y, n) compute the mutual
    %  information SCORE of two discrete variables X and Y. These two vectors
    %  must have the same length. The higher value of the score, the
    %  closer connection between X and Y.

    x_max = max(X, [], 2);
    x_min = min(X, [], 2);
    x_range = (x_max - x_min) / n;
    if x_max - x_min < 1e-6
        score = 0;
        return;
    end
    if size(Y, 1) ~= 1
        prob_matr = zeros(n, size(Y, 1));
        for i = 1 : size(X,2)
            x_dim = ceil((X(:, i) - x_min) / x_range);
            if x_dim < 1
                x_dim = 1;
            elseif x_dim > n
                x_dim = n;
            end
            y_dim = find(Y(:, i) == 1);
            prob_matr(x_dim, y_dim) = prob_matr(x_dim, y_dim) + 1;
        end
    else
        y_max = max(Y, [], 2);
        y_min = min(Y, [], 2);
        y_range = (y_max - y_min) / n;
        prob_matr = zeros(n, n);
        for i = 1 : size(X, 2)
            x_dim = ceil((X(:, i) - x_min) / x_range);
            if x_dim < 1
                x_dim = 1;
            elseif x_dim > n
                x_dim = n;
            end
            y_dim = ceil((Y(:, i) - y_min) / y_range);
            if y_dim < 1
                y_dim = 1;
            elseif y_dim > n
                y_dim = n;
            end
            prob_matr(x_dim, y_dim) = prob_matr(x_dim, y_dim) + 1;
        end
    end
    p_y = sum(prob_matr, 1) / size(X, 2);
    p_y_x = prob_matr ./ (sum(prob_matr, 2) + 1e-6);
    p_y(p_y == 0) = 1e-6;
    p_y_x(p_y_x == 0) = 1e-6;
    
    score = sum(sum(prob_matr / size(X, 2) .* log(p_y_x))) - sum(p_y .* log(p_y));
end