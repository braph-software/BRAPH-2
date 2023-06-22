%% ¡header!
MeasurePF_GB < MeasurePF (pf, panel figure global bilayer measure) is the base element to plot a global bilayer measure.

%%% ¡description!
MeasurePF_GB manages the basic functionalities to plot of a global bilayer measure.

%%% ¡seealso!
Measure

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global bilayer measure.
%%%% ¡default!
'MeasurePF_GB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global bilayer measure.
%%%% ¡default!
'MeasurePF_GB manages the basic functionalities to plot of a global bilayer measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global bilayer measure.
%%%% ¡settings!
'MeasurePF_GB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global bilayer measure.
%%%% ¡default!
'MeasurePF_GB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global bilayer measure.
%%%% ¡default!
'MeasurePF_GB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global bilayer measure.
%%%% ¡default!
'MeasurePF_GB notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_GB.PARENT MeasurePF_GB.H MeasurePF_GB.ST_POSITION MeasurePF_GB.ST_AXIS MeasurePF_GB.ST_AREA MeasurePF_GB.ST_LINE MeasurePF_GB.ST_TITLE MeasurePF_GB.ST_XLABEL MeasurePF_GB.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_GB'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_GB'])
