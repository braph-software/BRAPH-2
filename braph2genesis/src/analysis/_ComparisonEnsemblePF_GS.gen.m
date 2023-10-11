%% ¡header!
ComparisonEnsemblePF_GS < ComparisonEnsemblePF (pf, panel global superglobal group comparison figure) is the base element to plot a global superglobal group comparison figure.

%%% ¡description!
ComparisonEnsemblePF_GS manages the basic functionalities to plot of a global superglobal group comparison figure.

%%% ¡seealso!
ComparisonEnsemble

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsemblePF_GS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GS manages the basic functionalities to plot of a global superglobal group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global superglobal group comparison figure.
%%%% ¡settings!
'ComparisonEnsemblePF_GS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GS notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsemblePF_GS.PARENT ComparisonEnsemblePF_GS.H ComparisonEnsemblePF_GS.ST_POSITION ComparisonEnsemblePF_GS.ST_AXIS ComparisonEnsemblePF_GS.ST_AREA ComparisonEnsemblePF_GS.ST_LINE_DIFF ComparisonEnsemblePF_GS.ST_LINE_CIL ComparisonEnsemblePF_GS.ST_LINE_CIU ComparisonEnsemblePF_GS.ST_TITLE ComparisonEnsemblePF_GS.ST_XLABEL ComparisonEnsemblePF_GS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsemblePF_GS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsemblePF_GS'])
