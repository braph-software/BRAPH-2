%% ¡header!
NNFeatureImportanceBrainSurface < ConcreteElement (nnfib, neural network feature importace on brain surface) manages the visuazation of the feature importance on the brain surface within neural network evaluators.

%%% ¡description!
A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) 
 manages the visualization of feature importance within neural network evaluators, particularly on the brain surface.
It handles different types of neural network inputs, including graph data 
 (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures),
 and the subject data (connectivity data or structural data).

%%% ¡seealso!
NNEvaluator, NNDataPoint_Graph_CLA, NNDataPoint_Measure_REG, NNDataPoint_CON_CLA, NNDataPoint_ST_CLA

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceBrainSurface.ID
%%%% ¡title!
Feature Importance Brain Surface ID

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceBrainSurface.LABEL
%%%% ¡title!
Feature Importance Brain Surface LABEL

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceBrainSurface.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceBrainSurface.FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance Score

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface'

%%% ¡prop!
NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'Neural Network Feature Importace on Brain Surface'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) manages the visualization of feature importance within neural network evaluators, particularly on the brain surface. It handles different types of neural network inputs, including graph data (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures), and the subject data (connectivity data or structural data).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡settings!
'NNFeatureImportanceBrainSurface'

%%% ¡prop!
ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface notes'
    
%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
D (data, item) is a NN dataset.
%%%% ¡settings!
'NNDataset'

%%% ¡prop!
FEATURE_IMPORTANCE (data, cell) is the feature importances.
%%%% ¡gui!
input_dataset = nnfib.get('D');
dp_class = input_dataset.get('DP_CLASS');
graph_dp_classes = {NNDataPoint_Graph_CLA().get('NAME'), NNDataPoint_Graph_REG().get('NAME')};
measure_dp_classes = {NNDataPoint_Measure_CLA().get('NAME'), NNDataPoint_Measure_REG().get('NAME')};

if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
    pr = NNFeatureImportanceBrainSurfacePP_Graph('EL', nnfib, 'D', input_dataset, 'PROP', NNFeatureImportanceBrainSurface.FEATURE_IMPORTANCE, varargin{:});
elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
    pr = NNFeatureImportanceBrainSurfacePP_Measure('EL', nnfib, 'D', input_dataset, 'PROP', NNFeatureImportanceBrainSurface.FEATURE_IMPORTANCE, varargin{:});
else % DATA input
    pr = NNFeatureImportanceBrainSurfacePP_Data('EL', nnfib, 'D', input_dataset, 'PROP', NNFeatureImportanceBrainSurface.FEATURE_IMPORTANCE, varargin{:});
end

%%% ¡prop!
RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
%%%% ¡calculate!
cell1 = nnfib.get('FEATURE_IMPORTANCE');
cell2 = nnfib.get('D').get('DP_DICT').get('IT', 1).get('INPUT');
if ~isequal(numel(cell1), numel(cell2)) 
    cell1 = nnfib.get('MAP_TO_CELL', cell2mat(cell1), cell2);
end

value = cell1;

%%% ¡prop!
MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
vector = varargin{1};
cell_template = varargin{2};
mappedCellArray = cell_template;
index = 1;
for i = 1:numel(cell_template)
    cellData = cell_template{i};
    if iscell(cellData)
        % Map the vector to nested cell arrays recursively
        nestedVector = nnfib.get('MAP_TO_CELL', vector(index:end), cellData);
        mappedCellArray{i} = nestedVector;
    else
        % Assign elements from the vector to cells
        numElements = numel(cellData);
        mappedCellArray{i} = reshape(vector(index:index+numElements-1), size(cellData));
        index = index + numElements;
    end
end

value = mappedCellArray;