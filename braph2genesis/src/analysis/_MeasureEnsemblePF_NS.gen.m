%% ¡header!
MeasureEnsemblePF_NS < MeasureEnsemblePF (pf, panel nodal superglobal group comparison figure) is the base element to plot a nodal superglobal group comparison figure.

%%% ¡description!
MeasureEnsemblePF_NS manages the basic functionalities to plot of a nodal superglobal group comparison figure.

%%% ¡seealso!
MeasureEnsemble

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.NODE
%%%% ¡title!
NODE SELECTION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_LINE_M
%%%% ¡title!
MEASURE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'MeasureEnsemblePF_NS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS manages the basic functionalities to plot of a nodal superglobal group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure nodal superglobal group comparison figure.
%%%% ¡settings!
'MeasureEnsemblePF_NS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODE (figure, scalar) is the node number of the nodal group comparison figure.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsemblePF_NS.PARENT MeasureEnsemblePF_NS.H MeasureEnsemblePF_NS.ST_POSITION MeasureEnsemblePF_NS.ST_AXIS MeasureEnsemblePF_NS.ST_AREA MeasureEnsemblePF_NS.ST_LINE_M MeasureEnsemblePF_NS.ST_TITLE MeasureEnsemblePF_NS.ST_XLABEL MeasureEnsemblePF_NS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsemblePF_NS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsemblePF_NS'])
