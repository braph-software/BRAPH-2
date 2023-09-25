%% ¡header!
ComparisonEnsembleBrainPF_GU < ComparisonEnsembleBrainPF (pf, panel global unilayer ensemble-based comparison figure on brain surface figure) is the base element to plot a global unilayer ensemble-based comparison figure on brain surface figure.

%%% ¡description!
ComparisonEnsembleBrainPF_GU manages the basic functionalities to plot of a global unilayer ensemble-based comparison figure on brain surface figure.

%%% ¡seealso!
ComparisonEnsemble

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.NODES
%%%% ¡title!
NODES SELECTION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_GU.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsembleBrainPF_GU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_GU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_GU manages the basic functionalities to plot of a global unilayer ensemble-based comparison figure on brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global unilayer ensemble-based comparison figure on brain surface.
%%%% ¡settings!
'ComparisonEnsembleBrainPF_GU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_GU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_GU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_GU notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the global group comparison figure on brain surface.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!binodal

%%% ¡excluded_props!
[ComparisonEnsembleBrainPF_GU.PARENT ComparisonEnsembleBrainPF_GU.H ComparisonEnsembleBrainPF_GU.ST_POSITION ComparisonEnsembleBrainPF_GU.ST_AXIS ComparisonEnsembleBrainPF_GU.ST_AREA ComparisonEnsembleBrainPF_GU.ST_LINE_DIFF ComparisonEnsembleBrainPF_GU.ST_LINE_CIL ComparisonEnsembleBrainPF_GU.ST_LINE_CIU ComparisonEnsembleBrainPF_GU.ST_TITLE ComparisonEnsembleBrainPF_GU.ST_XLABEL ComparisonEnsembleBrainPF_GU.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsembleBrainPF_GU'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsembleBrainPF_GU'])
