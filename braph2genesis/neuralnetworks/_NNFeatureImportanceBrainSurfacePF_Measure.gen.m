%% ¡header!
NNFeatureImportanceBrainSurfacePF_Measure < BrainAtlasPF (pf, panel figure for measure group brain) is a plot of a measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (NNFeatureImportanceBrainSurfacePF_Measure) manages the plot of the measure
 ploted over the brain.  
NNFeatureImportanceBrainSurfacePF_Measure utilizes the surface created from BrainAtlasPF to integrate 
 the meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'NNFeatureImportanceBrainSurfacePF_Measure'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (NNFeatureImportanceBrainSurfacePF_Measure) manages the plot of the measure ploted over the brain. NNFeatureImportanceBrainSurfacePF_Measure utilizes the surface created from BrainAtlasPF to integrate the meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'NNFeatureImportanceBrainSurfacePF_Measure'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'NNFeatureImportanceBrainSurfacePF_Measure ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'NNFeatureImportanceBrainSurfacePF_Measure label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'NNFeatureImportanceBrainSurfacePF_Measure notes'

%%% ¡prop!
DRAW (query, logical) draws the figure brain atlas.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, NNFeatureImportanceBrainSurfacePF_Measure.DRAW, varargin{:}); % also warning
if value    
    % trigger setup
    pf.get('SETUP');
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, NNFeatureImportanceBrainSurfacePF_Measure.DELETE, varargin{:}); % also warning
if value
    % do nothing
end

%% ¡props!

%%% ¡prop!
FI (metadata, cell) is the feature importance value.

%%% ¡prop!
D (metadata, item) is the NN dataset.
%%%% ¡settings!
'NNDataset'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.
%%%% ¡calculate!
value = [];

%% ¡tests!

%%% ¡excluded_props!
[NNFeatureImportanceBrainSurfacePF_Measure.PARENT NNFeatureImportanceBrainSurfacePF_Measure.H NNFeatureImportanceBrainSurfacePF_Measure.ST_POSITION NNFeatureImportanceBrainSurfacePF_Measure.ST_AXIS NNFeatureImportanceBrainSurfacePF_Measure.ST_SURFACE NNFeatureImportanceBrainSurfacePF_Measure.ST_AMBIENT NNFeatureImportanceBrainSurfacePF_Measure.FI NNFeatureImportanceBrainSurfacePF_Measure.D]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNFeatureImportanceBrainSurfacePF_Measure'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNFeatureImportanceBrainSurfacePF_Measure'])
