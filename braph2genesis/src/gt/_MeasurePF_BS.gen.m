%% ¡header!
MeasurePF_BS < MeasurePF (pf, panel figure binodal superglobal measure) is the base element to plot a binodal superglobal measure.

%%% ¡description!
MeasurePF_BS manages the basic functionalities to plot of a binodal superglobal measure.

%%% ¡seealso!
Measure

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal superglobal measure.
%%%% ¡default!
'MeasurePF_BS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal superglobal measure.
%%%% ¡default!
'MeasurePF_BS manages the basic functionalities to plot of a binodal superglobal measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal superglobal measure.

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal superglobal measure.
%%%% ¡default!
'MeasurePF_BS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal superglobal measure.
%%%% ¡default!
'MeasurePF_BS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal superglobal measure.
%%%% ¡default!
'MeasurePF_BS notes'

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
[MeasurePF_BS.PARENT MeasurePF_BS.H MeasurePF_BS.ST_POSITION MeasurePF_BS.ST_AXIS MeasurePF_BS.ST_AREA MeasurePF_BS.ST_LINE MeasurePF_BS.ST_TITLE MeasurePF_BS.ST_XLABEL MeasurePF_BS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_BS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_BS'])
