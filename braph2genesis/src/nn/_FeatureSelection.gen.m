%% ¡header!
FeatureSelection < Element (fs, feature selection analysis) produces selected index of features for a dataset.

%% ¡description!
This feature selection analysis perform mutual information analysis to get the most relevant features among all of the input data.

%% ¡props!
%%% ¡prop!
DATASET_PROCESSOR (data, item) is the dataset processor that prepares the dataset for training a neural network model.
%%%% ¡settings!
'DatasetProcessor'

%%% ¡prop!
FEATURE_SELECTION_MASK (result, cell) is index for selected features.
%%%% ¡calculate!
dp = fs.get('DATASET_PROCESSOR');
x_raw = dp.get('X_RAW');
y = dp.get('Y');
for j = 1:size(x_raw{1},2)
    for k = 1:size(x_raw{1},2)
        data = cellfun(@(v)v(j,k),x_raw);
        label = onehotencode(y,2);
        mask(j,k) = .MutualInformationAnalysis(data, label', 5);
    end
end
[~,idx_all] = sort(mask(:), 'descend');
num_top_idx = floor(top_ratio*size(mask,1)*size(mask,2));

value = idx_all(1:num_top_idx);

%% ¡methods!
function [mutinf] = MutualInformationAnalysis(nn, X, Y, n)
    xmin = min(X,[],2);
    xmax = max(X,[],2);
    xrange = (xmax - xmin) / n;
    if xmax - xmin < 1e-4
        mutinf = 0;
        return;
    end
    if size(Y, 1) ~= 1
        probmatr = zeros(n, size(Y, 1));
        for i = 1 : size(X,2)
            dimx = ceil((X(:,i) - xmin) / xrange);
            if dimx < 1
                dimx = 1;
            elseif dimx > n
                dimx = n;
            end
            dimy = find(Y(:,i) == 1);
            probmatr(dimx, dimy) = probmatr(dimx, dimy) + 1;
        end
    else
        ymin = min(Y,[],2);
        ymax = max(Y,[],2);
        yrange = (ymax - ymin) / n;
        probmatr = zeros(n, n);
        for i = 1 : size(X,2)
            dimx = ceil((X(:,i) - xmin) / xrange);
            if dimx < 1
                dimx = 1;
            elseif dimx > n
                dimx = n;
            end
            dimy = ceil((Y(:,i) - ymin) / yrange);
            if dimy < 1
                dimy = 1;
            elseif dimy > n
                dimy = n;
            end
            probmatr(dimx, dimy) = probmatr(dimx, dimy) + 1;
        end
    end
    p_y = sum(probmatr, 1) / size(X,2);
    p_y_x = probmatr ./ (sum(probmatr, 2) + 1e-8);
    p_y(p_y == 0) = 1e-8;
    p_y_x(p_y_x == 0) = 1e-8;
    
    mutinf = sum(sum(probmatr / size(X,2) .* log(p_y_x))) - sum(p_y .* log(p_y));
end