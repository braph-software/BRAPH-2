%% ¡header!
MeasureEnsemblePF_BS < MeasureEnsemblePF (pf, panel binodal superglobal group comparison figure) is the base element to plot a binodal superglobal group comparison figure.

%%% ¡description!
MeasureEnsemblePF_BS manages the basic functionalities to plot of a binodal superglobal group comparison figure.

%%% ¡seealso!
MeasureEnsemble

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.NODES
%%%% ¡title!
NODES SELECTION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.ST_LINE_M
%%%% ¡title!
MEASURE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'MeasureEnsemblePF_BS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BS manages the basic functionalities to plot of a binodal superglobal group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal superglobal group comparison figure.
%%%% ¡settings!
'MeasureEnsemblePF_BS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BS notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal group comparison figure.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsemblePF_BS.PARENT MeasureEnsemblePF_BS.H MeasureEnsemblePF_BS.ST_POSITION MeasureEnsemblePF_BS.ST_AXIS MeasureEnsemblePF_BS.ST_AREA MeasureEnsemblePF_BS.ST_LINE_M MeasureEnsemblePF_BS.ST_TITLE MeasureEnsemblePF_BS.ST_XLABEL MeasureEnsemblePF_BS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsemblePF_BS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsemblePF_BS'])
