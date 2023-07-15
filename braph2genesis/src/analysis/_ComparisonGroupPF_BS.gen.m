%% ¡header!
ComparisonGroupPF_BS < ComparisonGroupPF (pf, panel figure binodal superglobal measure) is the base element to plot a binodal superglobal measure.

%%% ¡description!
ComparisonGroupPF_BS manages the basic functionalities to plot of a binodal superglobal measure.

%%% ¡seealso!
Measure

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.ST_AREA
%%%% ¡title!
FILLED AREA

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.ST_LINE
%%%% ¡title!
MEASURE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_BS.NODES
%%%% ¡title!
NODES SELECTION

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_BS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_BS manages the basic functionalities to plot of a binodal superglobal measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal superglobal measure.
%%%% ¡settings!
'ComparisonGroupPF_BS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_BS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_BS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_BS notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal measure.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupPF_BS.PARENT ComparisonGroupPF_BS.H ComparisonGroupPF_BS.ST_POSITION ComparisonGroupPF_BS.ST_AXIS ComparisonGroupPF_BS.ST_AREA ComparisonGroupPF_BS.ST_LINE ComparisonGroupPF_BS.ST_TITLE ComparisonGroupPF_BS.ST_XLABEL ComparisonGroupPF_BS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupPF_BS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupPF_BS'])
