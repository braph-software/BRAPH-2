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

%%% ¡prop!
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡settings!
{'adjacency_matrices' 'graph_measures' 'structural_data'}

%%% ¡prop!
MEASURES (data, classlist) is the graph measures as input to NN.
%%%% ¡settings!
{'Measure'}
%%%% ¡default!
{'DegreeAv', 'Degree'}


%% ¡methods!
function score = mutual_information_analysis(nnd, X, Y, n)
    %MUTUAL_INFORMATION_ANALYSIS computes the mutual information value.
    % 
    % SCORE = MUTUAL_INFORMATION_ANALYSIS(NND, X, Y, n) compute the mutual
    %  information SCORE of two discrete variables X and Y. These two vectors
    %  must have the same length. The higher value of the score, the
    %  closer connection between X and Y.

    xmin = min(X, [], 2);
    xmax = max(X, [], 2);
    xrange = (xmax - xmin) / n;
    if xmax - xmin < 1e-4
        score = 0;
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
function data = data_construction_graph(nnd, g_dict, input_type, measure_class)
    %DATA_CONSTRUCTION_GRAPH constructs the inputs for neural networks.
    % 
    % DATA = DATA_CONSTRUCTION_GRAPH(NN, G_DICT, MASK, INPUT_TYPE, MEASURE_CLASS) 
    %  constructs the input for training or testing neural networks. 
    %  According to INPUT_TYPE the input type, either the adjacency matrices
    %  or the MEASURE_CLASS graph measures will extracted from graph
    %  dict G_DICT. 
    
    data = {};
    
    if string(input_type) == "adjacency_matrices"
        % get the adjacency matrices
        adjs_gr = g_dict.getItems();
        data = {};
        for i = 1:length(adjs_gr)
            data{end+1} = cell2mat(adjs_gr{i}.get('A'));
        end
    else
        % get the graph measures
        adjs_gr = g_dict.getItems();
        data = {};
        for i = 1:length(adjs_gr)
            m = [];
            for j = 1:length(measure_class)
                m = [m; cell2mat(adjs_gr{i}.getMeasure(measure_class{j}).get('M'))];
            end
            data{end+1} = m;
        end
    end
end
function data = data_construction(nnd, gr)
    %DATA_CONSTRUCTION constructs the inputs for neural networks.
    % 
    % DATA = DATA_CONSTRUCTION(NN, GR) constructs the input for training 
    %  or testing neural networks. The features for each subject will be 
    %  extracted from GR the group and construct the DATA.
    
    data = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
    %data = cat(2, data_list{:})';
end