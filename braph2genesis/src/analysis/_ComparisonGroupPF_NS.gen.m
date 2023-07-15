%% ¡header!
ComparisonGroupPF_NS < ComparisonGroupPF (pf, panel figure nodal superglobal measure) is the base element to plot a nodal superglobal measure.

%%% ¡description!
ComparisonGroupPF_NS manages the basic functionalities to plot of a nodal superglobal measure.

%%% ¡seealso!
Measure

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_AREA
%%%% ¡title!
FILLED AREA

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_LINE
%%%% ¡title!
MEASURE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.NODE
%%%% ¡title!
NODE SELECTION

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure nodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_NS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure nodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_NS manages the basic functionalities to plot of a nodal superglobal measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure nodal superglobal measure.
%%%% ¡settings!
'ComparisonGroupPF_NS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure nodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_NS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure nodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_NS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure nodal superglobal measure.
%%%% ¡default!
'ComparisonGroupPF_NS notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODE (figure, scalar) is the node number of the nodal measure.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupPF_NS.PARENT ComparisonGroupPF_NS.H ComparisonGroupPF_NS.ST_POSITION ComparisonGroupPF_NS.ST_AXIS ComparisonGroupPF_NS.ST_AREA ComparisonGroupPF_NS.ST_LINE ComparisonGroupPF_NS.ST_TITLE ComparisonGroupPF_NS.ST_XLABEL ComparisonGroupPF_NS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupPF_NS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupPF_NS'])
