%% ¡header!
NNFeatureImportanceBrainSurfacePF_Measure_BS < NNFeatureImportanceBrainSurfacePF_Measure (pf, panel figure for measure group brain) is a plot of a measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (NNFeatureImportanceBrainSurfacePF_Measure_BS) manages the plot of the measure
 ploted over the brain.  
NNFeatureImportanceBrainSurfacePF_Measure_BS utilizes the surface created from BrainAtlasPF to integrate 
 the meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'NNFeatureImportanceBrainSurfacePF_Measure_BS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (NNFeatureImportanceBrainSurfacePF_Measure_BS) manages the plot of the measure ploted over the brain. NNFeatureImportanceBrainSurfacePF_Measure_BS utilizes the surface created from BrainAtlasPF to integrate the meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'NNFeatureImportanceBrainSurfacePF_Measure_BS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'NNFeatureImportanceBrainSurfacePF_Measure_BS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'NNFeatureImportanceBrainSurfacePF_Measure_BS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'NNFeatureImportanceBrainSurfacePF_Measure_BS notes'

%%% ¡prop!
DRAW (query, logical) draws the figure brain atlas.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, NNFeatureImportanceBrainSurfacePF_Measure_BS.DRAW, varargin{:}); % also warning
if value    
    % trigger setup
    pf.get('SETUP');
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, NNFeatureImportanceBrainSurfacePF_Measure_BS.DELETE, varargin{:}); % also warning
if value
    % do nothing
end

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[NNFeatureImportanceBrainSurfacePF_Measure_BS.PARENT NNFeatureImportanceBrainSurfacePF_Measure_BS.H NNFeatureImportanceBrainSurfacePF_Measure_BS.ST_POSITION NNFeatureImportanceBrainSurfacePF_Measure_BS.ST_AXIS NNFeatureImportanceBrainSurfacePF_Measure_BS.ST_SURFACE NNFeatureImportanceBrainSurfacePF_Measure_BS.ST_AMBIENT NNFeatureImportanceBrainSurfacePF_Measure_BS.FI NNFeatureImportanceBrainSurfacePF_Measure_BS.D]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNFeatureImportanceBrainSurfacePF_Measure_BS'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNFeatureImportanceBrainSurfacePF_Measure_BS'])
