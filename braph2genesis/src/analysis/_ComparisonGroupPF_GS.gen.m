%% ¡header!
ComparisonGroupPF_GS < ComparisonGroupPF (pf, panel global superglobal group comparison figure) is the base element to plot a global superglobal group comparison figure.

%%% ¡description!
ComparisonGroupPF_GS manages the basic functionalities to plot of a global superglobal group comparison figure.

%%% ¡seealso!
ComparisonGroup

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GS manages the basic functionalities to plot of a global superglobal group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global superglobal group comparison figure.
%%%% ¡settings!
'ComparisonGroupPF_GS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GS notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupPF_GS.PARENT ComparisonGroupPF_GS.H ComparisonGroupPF_GS.ST_POSITION ComparisonGroupPF_GS.ST_AXIS ComparisonGroupPF_GS.ST_AREA ComparisonGroupPF_GS.ST_LINE_DIFF ComparisonGroupPF_GS.ST_LINE_CIL ComparisonGroupPF_GS.ST_LINE_CIU ComparisonGroupPF_GS.ST_TITLE ComparisonGroupPF_GS.ST_XLABEL ComparisonGroupPF_GS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupPF_GS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupPF_GS'])
