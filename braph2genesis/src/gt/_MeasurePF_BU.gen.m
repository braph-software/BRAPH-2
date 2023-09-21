%% ¡header!
MeasurePF_BU < MeasurePF (pf, panel figure binodal unilayer measure) is the base element to plot a binodal unilayer measure.

%%% ¡description!
MeasurePF_BU manages the basic functionalities to plot of a binodal unilayer measure.

%%% ¡seealso!
Measure

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.NODES
%%%% ¡title!
NODES SELECTION

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.ST_AREA
%%%% ¡title!
FILLED AREA

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.ST_LINE
%%%% ¡title!
MEASURE LINE

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasurePF_BU.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal unilayer measure.
%%%% ¡default!
'MeasurePF_BU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal unilayer measure.
%%%% ¡default!
'MeasurePF_BU manages the basic functionalities to plot of a binodal unilayer measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal unilayer measure.
%%%% ¡settings!
'MeasurePF_BU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal unilayer measure.
%%%% ¡default!
'MeasurePF_BU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal unilayer measure.
%%%% ¡default!
'MeasurePF_BU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal unilayer measure.
%%%% ¡default!
'MeasurePF_BU notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
x = pf.get('M').get('G').get('ALAYERTICKS');

nodes = pf.get('NODES');
y = cellfun(@(x) x(nodes(1), nodes(2)), pf.get('M').get('M'))';

pf.memorize('ST_LINE').set('X', x, 'Y', y)

if ~isempty(y)
    if isempty(x) 
        pf.memorize('ST_AREA').set('X', [1 1:1:length(y) length(y)], 'Y', [0 y 0])
    else
        pf.memorize('ST_AREA').set('X', [x(1) x x(end)], 'Y', [0 y 0])
    end
end

xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');
anodelabels = pf.get('M').get('G').get('ANODELABELS');
pf.get('ST_TITLE').set( ...
    'TXT', [pf.get('M').get('LABEL') ' ' anodelabels{nodes(1)} ' ' anodelabels{nodes(2)}], ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_XLABEL').set( ...
    'TXT', 'Layer', ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_YLABEL').set( ...
	'TXT', 'Measure Value', ...
    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
    'Y', .5 * (ylim(2) + ylim(1)), ...
    'Z', 0 ...
    )

value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal measure.
%%%% ¡default!
[1 1]
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡gui!
pr = MeasurePF_BxPP_Node('EL', pf, 'PROP', MeasurePF_BU.NODE);

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_BU.PARENT MeasurePF_BU.H MeasurePF_BU.ST_POSITION MeasurePF_BU.ST_AXIS MeasurePF_BU.M MeasurePF_BU.ST_AREA MeasurePF_BU.ST_LINE MeasurePF_BU.ST_TITLE MeasurePF_BU.ST_XLABEL MeasurePF_BU.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_BU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_BU'])
