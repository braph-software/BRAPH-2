%% ¡header!
NNClassifierGATEvaluator < NNClassifierEvaluator (nne, evaluator for a graph attention network classifier) evaluates the performance of a graph attention network classifier with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a graph attention network classifier
in terms of the receiver operating characteristic curve (ROC), the area 
under the ROC curve (AUC), and the confusion matrix.

%% ¡props_update!

%%% ¡prop!
NN (data, item) is a graph attention neural network model that needs to be evaluated.
%%%% ¡settings!
'NNClassifierGAT'
%%%% ¡default!
NNClassifierGAT()

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
if nne.get('GR').get('SUB_DICT').length() == 0
    value = NNGroup();
else
    nn = nne.get('NN');
    gr = nne.get('GR');
    [mbq, ds, numFeatures, numClasses] = nn.reconstruct_dataset(gr);
    net = nn.get('MODEL');
    if isa(net, 'NoValue') || ~BRAPH2.installed('NN', 'msgbox')
        predictions = zeros(gr.get('SUB_DICT').length(), 2);
    else
        numHeads = struct;
        numHeads.attn1 = 3;
        numHeads.attn2 = 3;
        numHeads.attn3 = 5;
        [predictions, attentionScores] = nn.modelPredictions(net, ds, numHeads);
        predictions = double(extractdata(gather(predictions)));
        attention3Scores = double(gather(extractdata(attentionScores.attn3)));
        attention3Scores = squeeze(num2cell(attention3Scores, [1 2]));
    end

    gr_pred = NNGroup( ...
        'SUB_CLASS', gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
        );

    gr_pred.set( ...
        'ID', gr.get('ID'), ...
        'LABEL', gr.get('LABEL'), ...
        'NOTES', gr.get('NOTES') ...
        );

    % add subejcts from all groups
    sub_dict = gr_pred.get('SUB_DICT');
    subs = gr.get('SUB_DICT').getItems();
    for i = 1:1:length(subs)
        sub = subs{i}.deepclone();
        sub.set('PREDICTION', {predictions(i, :)});
        sub.set('FEATURE_MASK', attention3Scores);
        sub_dict.add(sub);
    end
    gr_pred.set('SUB_DICT', sub_dict);

    value = gr_pred;
end