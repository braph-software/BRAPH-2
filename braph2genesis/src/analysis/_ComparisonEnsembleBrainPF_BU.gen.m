%% ¡header!
ComparisonEnsembleBrainPF_BU < ComparisonEnsembleBrainPF (pf, panel binodal unilayer ensemble-based comparison figure on brain surface figure) is the base element to plot a binodal unilayer ensemble-based comparison figure on brain surface figure.

%%% ¡description!
ComparisonEnsembleBrainPF_BU manages the basic functionalities to plot of a binodal unilayer ensemble-based comparison figure on brain surface figure.

%%% ¡seealso!
ComparisonEnsemble

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.NODES
%%%% ¡title!
NODES SELECTION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF_BU.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsembleBrainPF_BU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BU manages the basic functionalities to plot of a binodal unilayer ensemble-based comparison figure on brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal unilayer ensemble-based comparison figure on brain surface.
%%%% ¡settings!
'ComparisonEnsembleBrainPF_BU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal unilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BU notes'

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
[ComparisonEnsembleBrainPF_BU.PARENT ComparisonEnsembleBrainPF_BU.H ComparisonEnsembleBrainPF_BU.ST_POSITION ComparisonEnsembleBrainPF_BU.ST_AXIS ComparisonEnsembleBrainPF_BU.ST_AREA ComparisonEnsembleBrainPF_BU.ST_LINE_DIFF ComparisonEnsembleBrainPF_BU.ST_LINE_CIL ComparisonEnsembleBrainPF_BU.ST_LINE_CIU ComparisonEnsembleBrainPF_BU.ST_TITLE ComparisonEnsembleBrainPF_BU.ST_XLABEL ComparisonEnsembleBrainPF_BU.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsembleBrainPF_BU'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsembleBrainPF_BU'])
