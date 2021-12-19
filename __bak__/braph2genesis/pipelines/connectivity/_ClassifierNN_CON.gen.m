%% ¡header!
ClassifierNN_CON < ClassifierNN (nn, classifier with dti data) is a neural network classifier using dti data for classification.

%% ¡description!
This classifier using dti data with neural network and trains neural network for classification of groups.

%% ¡props!
%%% ¡prop!
A_1 (data, item) is the analysis group 1.
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
A_2 (data, item) is the analysis group 2.
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
REPETITION (parameter, scalar) is the number of repetitions
%%%% ¡default!
1

%%% ¡prop!
KFOLD (parameter, scalar) is the number of repetitions
%%%% ¡default!
5

%%% ¡prop!
DENSITY_OF_FEATURE_SELECTION (parameter, scalar) is the number of repetitions
%%%% ¡default!
0.05

%% ¡props_update!
%%% ¡prop!
NEURAL_NETWORK_ANALYSIS (result, cell) is the machine learning analysis.
%%%% ¡calculate!
value = calculate_results(nn)

%% ¡methods!
function value = calculate_results(nn)
    repetition = nn.get('REPETITION');
    KFOLD = nn.get('KFOLD');
    [links1, links2, label1, label2] = nn.preprocess();
    idx = linspace(1, KFOLD, KFOLD);
    if(~isempty(links2) && nn.check_toolbox_installation())
        for r = 1:repetition
            index_kfold_1 = nn.get_indexing_kfold(length(links1), KFOLD);
            index_kfold_2 = nn.get_indexing_kfold(length(links2), KFOLD);
            index_kfold = [index_kfold_1; index_kfold_2];

            for k = 1:KFOLD
                test_idx = (idx == k);
                train_idx = ~test_idx;
                y_train = [label1(cat(2, index_kfold_1{train_idx}));label2(cat(2, index_kfold_2{train_idx}))];
                y_test = [label1(index_kfold_1{test_idx});label2(index_kfold_2{test_idx})];
                x_train = [links1(cat(2, index_kfold_1{train_idx})) links2(cat(2, index_kfold_2{train_idx}))];
                x_test = [links1(index_kfold_1{test_idx}) links2(index_kfold_2{test_idx})];
                [feature_idx, mask] = nn.get_feature_selection_mask(x_train, categorical(y_train), 0.05, i);
                layers = nn.getLayers(length(feature_idx), 2);
                lgraph = layerGraph(layers);
                plot(lgraph)
                options = trainingOptions('adam', ...
                            'MiniBatchSize',8, ...
                            'MaxEpochs',20, ...
                            'Shuffle','every-epoch', ...
                            'Plots','none', ...
                            'Verbose',true);
                x_train = cellfun(@(v)v(feature_idx),x_train,'UniformOutput',false);
                x_train = cat(2, x_train{:});
                x_train = reshape(x_train, [1, 1, size(x_train,1), size(x_train,2)]);
                net = trainNetwork(x_train, categorical(y_train), layers, options);
                trained_nn_binary_form = nn.net_binary_transformer(net);
                value{r,k} = {net, index_kfold_1, index_kfold_2, feature_idx, mask};
            end
        end
    else
        value = {};
    end
end

function [avg, CI] = get_CI(nn, scores)
    score_row =[];
    for i = 1:length(scores)
        score_row = [score_row scores{i}];
    end
    avg = mean(score_row);
    SEM = std(score_row)/sqrt(length(score_row));               % Standard Error
    ts = tinv([0.025  0.975],length(score_row)-1);      % T-Score
    CI = avg + ts*SEM;
end

function get_confusion_matrix_and_scores(nn)
    repetition = nn.get('REPETITION');
    kfold = nn.get('KFOLD');
    nn_result = nn.get('NEURAL_NETWORK_ANALYSIS');
    [links1, links2, label1, label2] = nn.preprocess();
    counter = 0;
    all_label = [];
    all_predict = [];
    idx = linspace(1, kfold, kfold);
    for r = 1:repetition
        for k = 1:kfold
            test_idx = (idx == k);
            index_kfold_1 = nn_result{r,k}{2};
            index_kfold_2 = nn_result{r,k}{3};
            feature_idx = nn_result{r,k}{4};
            y_test = [label1(index_kfold_1{test_idx});label2(index_kfold_2{test_idx})];
            all_label = [all_label; y_test];
            x_test = [links1(index_kfold_1{test_idx}) links2(index_kfold_2{test_idx})];
            x_test = cellfun(@(v)v(feature_idx),x_test,'UniformOutput',false);
            x_test = cat(2, x_test{:});
            x_test = reshape(x_test, [1, 1, size(x_test,1), size(x_test,2)]);
            distinct_classes = unique(y_test);
            net = nn_result{r,k}{1};
            YPred = classify(net,x_test,'ExecutionEnvironment', 'cpu');
            all_predict = [all_predict; YPred];
        end
    end
    label_mark = categories(categorical(all_label));
	[cm, order] = confusionmat(categorical(all_label),all_predict);
	figure
    heatmap(label_mark,label_mark,cm)
    saveas(gcf,'confusion_matrix.svg');
end

function get_ROC_curves(nn)
    intervals= linspace(0, 1, 100);
    mean_curve = 0;
    AUCroc_per_fold = [];
    counter = 0;
    repetition = nn.get('REPETITION');
    kfold = nn.get('KFOLD');
    nn_result = nn.get('NEURAL_NETWORK_ANALYSIS');
    [links1, links2, label1, label2] = nn.preprocess();
    idx = linspace(1, kfold, kfold);
    for r = 1:repetition
        for k = 1:kfold
            counter = counter + 1;
            test_idx = (idx == k);
            index_kfold_1 = nn_result{r,k}{2};
            index_kfold_2 = nn_result{r,k}{3};
            feature_idx = nn_result{r,k}{4};
            y_test = [label1(index_kfold_1{test_idx});label2(index_kfold_2{test_idx})];
            x_test = [links1(index_kfold_1{test_idx}) links2(index_kfold_2{test_idx})];
            x_test = cellfun(@(v)v(feature_idx),x_test,'UniformOutput',false);
            x_test = cat(2, x_test{:});
            x_test = reshape(x_test, [1, 1, size(x_test,1), size(x_test,2)]);
            distinct_classes = unique(y_test);
            net = nn_result{r,k}{1};
            YPred = predict(net,x_test,'ExecutionEnvironment', 'cpu');
            label_single_fold = y_test;
            predict_single_fold = YPred(:,2);
            distinct_classes = unique(y_test);
            [Xroc, Yroc, ~, AUCroc_per_fold(end+1)]= perfcurve(label_single_fold, predict_single_fold, distinct_classes(2)); 
            hline(counter) = plot(Xroc, Yroc,'k-', 'LineWidth', 1.5); 
            hline(counter).Color = [hline(counter).Color 0.05];  % alpha=0.1
            hold on;
            x_adj= nn.adjust_unique_points(Xroc); 
            mean_curve= mean_curve+ (interp1(x_adj, Yroc, intervals))/(repetition*kfold); 
        end
    end
    hline(counter+1) = plot(intervals, mean_curve, 'Color', 'Black', 'LineWidth', 3.0); 
    xlabel('False positive rate'); 
    ylabel('True positive rate');
    title('ROC for Classification');
    legend(hline(counter+1), sprintf('average ROCs (AU-ROC = %.2f)', mean(AUCroc_per_fold)), 'Location','southeast','FontSize',12);
    legend('boxoff');
    saveas(gcf,'roc.svg');
end

function x = adjust_unique_points(nn, Xroc)
    x = zeros(1, length(Xroc));
    aux= 0.00001;
    for i=1: length(Xroc)
        if i~=1
            x(i)= Xroc(i)+aux;
            aux= aux+0.00001;
        end
    end
end

function get_weighted_connection_mask(nn)
    mask_weighted = [];
    repetition = nn.get('REPETITION');
    kfold = nn.get('KFOLD');
    nn_result = nn.get('NEURAL_NETWORK_ANALYSIS');
            top_ratio = nn.get('DENSITY_OF_FEATURE_SELECTION');
    counter = 0;
    auc = nn.get_auc();
    for r = 1:repetition
        for k = 1:kfold
            counter = counter + 1;
            mask_indi = nn_result{r,k}{5};
            [~,idx_all] = sort(mask_indi(:), 'descend');
            num_top_idx = floor(top_ratio*size(mask_indi,1)*size(mask_indi,2));
            mask_indi(idx_all(num_top_idx+1:end)) = 0;
            
            mask_indi(idx_all(1:num_top_idx)) = auc(r,k);
            if(counter == 1)
                mask_weighted = mask_indi;
            else
                mask_weighted = mask_weighted + mask_indi;
            end
        end
    end
    mask_weighted = mask_weighted /  (repetition*kfold);
    figure
    image(mask_weighted,'CDataMapping','scaled')
    colorbar
    saveas(gcf,'weighted_connection_mask.svg');
end

function [links1, links2, label1, label2] = preprocess(nn)
    a_1 = nn.get('A_1');
    a_2 = nn.get('A_2');
    
    a_BUD1_adjs = a_1.get('G_DICT').getItems();
    links1 = {};
    for i = 1:length(a_BUD1_adjs)
        links1{end+1} = cell2mat(a_BUD1_adjs{i}.get('A'));
    end
    
    a_BUD2_adjs = a_2.get('G_DICT').getItems();
    links2 = {};
    for i = 1:length(a_BUD2_adjs)
        links2{end+1} = cell2mat(a_BUD2_adjs{i}.get('A'));
    end
    
    label1 = repmat(string(a_1.get('gr').get('ID')), a_1.get('gr').get('SUB_DICT').length(), 1);
    label2 = repmat(string(a_2.get('gr').get('ID')), a_2.get('gr').get('SUB_DICT').length(), 1);
    
end

function auc = get_auc(nn)
    auc = [];
    repetition = nn.get('REPETITION');
    kfold = nn.get('KFOLD');
    nn_result = nn.get('NEURAL_NETWORK_ANALYSIS');
    [links1, links2, label1, label2] = nn.preprocess();
    idx = linspace(1, kfold, kfold);
    for r = 1:repetition
        for k = 1:kfold
            test_idx = (idx == k);
            index_kfold_1 = nn_result{r,k}{2};
            index_kfold_2 = nn_result{r,k}{3};
            feature_idx = nn_result{r,k}{4};
            y_test = [label1(index_kfold_1{test_idx});label2(index_kfold_2{test_idx})];
            x_test = [links1(index_kfold_1{test_idx}) links2(index_kfold_2{test_idx})];
            x_test = cellfun(@(v)v(feature_idx),x_test,'UniformOutput',false);
            x_test = cat(2, x_test{:});
            x_test = reshape(x_test, [1, 1, size(x_test,1), size(x_test,2)]);
            distinct_classes = unique(y_test);
            net = nn_result{r,k}{1};
            YPred = predict(net,x_test,'ExecutionEnvironment', 'cpu');
            [X,Y,T,auc(r,k)] = perfcurve(y_test,YPred(:,2),distinct_classes(2));
        end
    end
end

function nn_obj_form = nn_binary_to_object(nn, binary_form)
    filename = 'nn.onnx';
    fileID = fopen(filename,'w');
    fwrite(fileID, cell2mat(binary_form));
    fclose(fileID);
    nn_obj_form = importONNXNetwork(filename,'OutputLayerType','classification','Classes',string(nn.class_name));
    delete nn.onnx
end

function [idx, mask] = get_feature_selection_mask(nn, x, y, top_ratio, fold)
    for j = 1:size(x{1},2)
        for k = 1:size(x{1},2)
            data = cellfun(@(v)v(j,k),x);
            label = onehotencode(y,2);
            mask(j,k) = nn.FS_MutualInf(data, label', 5);
        end
    end
    [~,idx_all] = sort(mask(:), 'descend');
    num_top_idx = floor(top_ratio*size(mask,1)*size(mask,2));
    idx = idx_all(1:num_top_idx);
end

function [mutinf] = FS_MutualInf(nn, X, Y, n )
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

function index_kfold = get_indexing_kfold(nn, num_per_class, kfold)
    shuffle_indexes = randperm(num_per_class, num_per_class);
    numFilePerFold = floor(num_per_class/kfold);
    r_times = rem(num_per_class, kfold);
    r = zeros(1,kfold);
    r(randperm(kfold, r_times))=1;
    jend = 0;
    for j = 1:kfold
        jstart = jend+1;
        if j == kfold
            index_kfold{j} = shuffle_indexes(jend+1:end);
        else
            jend = jend+numFilePerFold+r(j);
            index_kfold{j} = shuffle_indexes(jstart:jend);
        end
    end
end

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_WU_NN