%% ¡header!
ComparisonEnsembleBrainPF_BB < ComparisonEnsembleBrainPF (pf, panel binodal bilayer ensemble-based comparison figure on brain surface figure) is the base element to plot a binodal bilayer ensemble-based comparison figure on brain surface figure.

%%% ¡description!
ComparisonEnsembleBrainPF_BB manages the basic functionalities to plot of a binodal bilayer ensemble-based comparison figure on brain surface figure.

%%% ¡seealso!
ComparisonEnsemble

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.NODES
%%%% ¡title!
NODES SELECTION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BB.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsembleBrainPF_BB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BB manages the basic functionalities to plot of a binodal bilayer ensemble-based comparison figure on brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡settings!
'ComparisonEnsembleBrainPF_BB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BB notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal group comparison figure on brain surface.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsembleBrainPF_BB.PARENT ComparisonEnsembleBrainPF_BB.H ComparisonEnsembleBrainPF_BB.ST_POSITION ComparisonEnsembleBrainPF_BB.ST_AXIS ComparisonEnsembleBrainPF_BB.ST_AREA ComparisonEnsembleBrainPF_BB.ST_LINE_DIFF ComparisonEnsembleBrainPF_BB.ST_LINE_CIL ComparisonEnsembleBrainPF_BB.ST_LINE_CIU ComparisonEnsembleBrainPF_BB.ST_TITLE ComparisonEnsembleBrainPF_BB.ST_XLABEL ComparisonEnsembleBrainPF_BB.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsembleBrainPF_BB'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsembleBrainPF_BB'])
