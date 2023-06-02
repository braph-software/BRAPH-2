%% ¡header!
MeasurePF_NU < MeasurePF (pf, panel figure nodal unilayer measure) is the base element to plot a nodal unilayer measure.

%%% ¡description!
MeasurePF_NU manages the basic functionalities to plot of a nodal unilayer measure.

%%% ¡seealso!
Measure

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure nodal unilayer measure.
%%%% ¡default!
'MeasurePF_NU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure nodal unilayer measure.
%%%% ¡default!
'MeasurePF_NU manages the basic functionalities to plot of a nodal unilayer measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure nodal unilayer measure.

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure nodal unilayer measure.
%%%% ¡default!
'MeasurePF_NU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure nodal unilayer measure.
%%%% ¡default!
'MeasurePF_NU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure nodal unilayer measure.
%%%% ¡default!
'MeasurePF_NU notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
x = pf.get('M').get('G').get('ALAYERTICKS');

node = pf.get('NODE');
y = cellfun(@(x) x(node), pf.get('M').get('M'))';

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
    'TXT', [pf.get('M').get('LABEL') ' ' anodelabels{node}], ...
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
NODE (figure, scalar) is the node number of the nodal measure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_NU.PARENT MeasurePF_NU.H MeasurePF_NU.ST_POSITION MeasurePF_NU.ST_AXIS MeasurePF_NU.M MeasurePF_NU.ST_AREA MeasurePF_NU.ST_LINE MeasurePF_NU.ST_TITLE MeasurePF_NU.ST_XLABEL MeasurePF_NU.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_NU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_NU'])